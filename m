Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC5A302A53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 19:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhAYScx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 13:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbhAYScl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:32:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A4A322B3F;
        Mon, 25 Jan 2021 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611599520;
        bh=w1qFqT0Aa2HlrOrboI7cNoJeqGfCywLrnNoy6sZLk3M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TVwdE3KpDXdY5Aesx0FVadUwcrBRMWgQAH0NOsmcg6UUibI2PrCNAkVBgp0igGCz2
         d2rZUr15RMn16dgRb9rCSXxdifYk4dxCz673YUddWQF39yoF/R9181yPWLLe3aTxg0
         6FjCwaaQhTF5g9TinOEjxWNpVQCzN4NyJB1PKstkocYatpe9b0msAzzjUiDxRVd+qw
         49ZcaSxcybH1UVd9ehTkfP5HHLpPo50Da9lj7hSoEmBGzuLnalzSjtJA2F+5tSC9co
         Jl98v4wq6EBVYyJJDkljdONqChok7X9GHJYCYHYhTpA7+x7dvWK/ZNjpAhMISzIe1W
         FUpGwHd/7kHKQ==
Message-ID: <07d886e24308119c672f705f000a0a44f8ffe0e8.camel@kernel.org>
Subject: Re: [RFC PATCH v4 16/17] ceph: create symlinks with encrypted and
 base64-encoded targets
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 25 Jan 2021 13:31:58 -0500
In-Reply-To: <87bldd57hc.fsf@suse.de>
References: <20210120182847.644850-1-jlayton@kernel.org>
         <20210120182847.644850-17-jlayton@kernel.org> <87bldd57hc.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-01-25 at 16:03 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > When creating symlinks in encrypted directories, encrypt and
> > base64-encode the target with the new inode's key before sending to the
> > MDS.
> > 
> > When filling a symlinked inode, base64-decode it into a buffer that
> > we'll keep in ci->i_symlink. When get_link is called, decrypt the buffer
> > into a new one that will hang off i_link.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/dir.c   | 50 +++++++++++++++++++++++---
> >  fs/ceph/inode.c | 95 ++++++++++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 128 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index cb7ff91a243a..1721b70118b9 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -924,6 +924,40 @@ static int ceph_create(struct inode *dir, struct dentry *dentry, umode_t mode,
> >  	return ceph_mknod(dir, dentry, mode, 0);
> >  }
> >  
> > 
> > 
> > 
> > +#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> > +static int prep_encrypted_symlink_target(struct ceph_mds_request *req, const char *dest)
> > +{
> > +	int err;
> > +	int len = strlen(dest);
> > +	struct fscrypt_str osd_link = FSTR_INIT(NULL, 0);
> > +
> > +	err = fscrypt_prepare_symlink(req->r_parent, dest, len, PATH_MAX, &osd_link);
> > +	if (err)
> > +		goto out;
> > +
> > +	err = fscrypt_encrypt_symlink(req->r_new_inode, dest, len, &osd_link);
> > +	if (err)
> > +		goto out;
> > +
> > +	req->r_path2 = kmalloc(FSCRYPT_BASE64_CHARS(osd_link.len), GFP_KERNEL);
> > +	if (!req->r_path2) {
> > +		err = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	len = fscrypt_base64_encode(osd_link.name, osd_link.len, req->r_path2);
> > +	req->r_path2[len] = '\0';
> > +out:
> > +	fscrypt_fname_free_buffer(&osd_link);
> > +	return err;
> > +}
> > +#else
> > +static int prep_encrypted_symlink_target(struct ceph_mds_request *req, const char *dest)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> >  static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> >  			    const char *dest)
> >  {
> > @@ -955,12 +989,18 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> >  		goto out_req;
> >  	}
> >  
> > 
> > 
> > 
> > -	req->r_path2 = kstrdup(dest, GFP_KERNEL);
> > -	if (!req->r_path2) {
> > -		err = -ENOMEM;
> > -		goto out_req;
> > -	}
> >  	req->r_parent = dir;
> > +
> > +	if (IS_ENCRYPTED(req->r_new_inode)) {
> > +		err = prep_encrypted_symlink_target(req, dest);
> 
> nit: missing the error handling for this branch.
> 

Thanks! I'll fix this right up.


-- 
Jeff Layton <jlayton@kernel.org>

