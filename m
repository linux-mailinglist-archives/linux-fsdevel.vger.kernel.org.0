Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1384351AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhDASCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236541AbhDAR57 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:57:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E0276120A;
        Thu,  1 Apr 2021 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617282767;
        bh=9U9lp8FhKV0djkeNKa6S0sMX48F4dpbMPR2JL6GNpdk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e5iEhqikF7dQHQ5BM5Y5pZ9Onvy4CTDOw53W7NTE+iABvFkg9uW7eT84W0FImRnj9
         e9CeREKA56uHRzX/3tHWAB1zDGOG/8n9Z9FXS49BB6HlsRWgTZSDzJNbfz065N8T1Y
         da6KmbbZKe1sPY14roRNwm+dDUBJz3wRpHlALR4CV6fdBw0188ytIgi7+iApzPRbiX
         Qt7813QmRdBoQavMSIPasj9C3zoLNPPEm0P50F9XZB+fVQbj/iOsRIHGMLItxj2tDw
         ShPw2kjSE21MQsI7rJIsdOSoWOTyg7egTvNHkdFel80IupxKO99ZzILThFUZb8YQLe
         V55yPRE6/OaXg==
Message-ID: <8533145423b08e36a80b27e949f322ae42eeeacc.camel@kernel.org>
Subject: Re: [RFC PATCH v5 20/19] ceph: make ceph_get_name decrypt filenames
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 01 Apr 2021 09:12:45 -0400
In-Reply-To: <YGXFH7XJW4H94xZu@suse.de>
References: <20210326173227.96363-1-jlayton@kernel.org>
         <20210331203520.65916-1-jlayton@kernel.org> <YGWrKxYOdWgrhOPp@suse.de>
         <8df5d18a65be8385f915dd7f3655db90d905b7c7.camel@kernel.org>
         <YGXFH7XJW4H94xZu@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-04-01 at 14:05 +0100, Luis Henriques wrote:
> On Thu, Apr 01, 2021 at 08:15:51AM -0400, Jeff Layton wrote:
> > On Thu, 2021-04-01 at 12:14 +0100, Luis Henriques wrote:
> > > On Wed, Mar 31, 2021 at 04:35:20PM -0400, Jeff Layton wrote:
> > > > When we do a lookupino to the MDS, we get a filename in the trace.
> > > > ceph_get_name uses that name directly, so we must properly decrypt
> > > > it before copying it to the name buffer.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/ceph/export.c | 42 +++++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 31 insertions(+), 11 deletions(-)
> > > > 
> > > > This patch is what's needed to fix the "busy inodes after umount"
> > > > issue I was seeing with xfstest generic/477, and also makes that
> > > > test pass reliably with mounts using -o test_dummy_encryption.
> > > 
> > > You mentioned this issue the other day on IRC but I couldn't reproduce.
> > > 
> > > On the other hand, I'm seeing another issue.  Here's a way to reproduce:
> > > 
> > > - create an encrypted dir 'd' and create a file 'f'
> > > - umount and mount the filesystem
> > > - unlock dir 'd'
> > > - cat d/f
> > >   cat: d/2: No such file or directory
> > 
> > I assume the message really says "cat: d/f: No such file or directory"
> 
> Yes, of course :)
> 
> > > 
> > > It happens _almost_ every time I do the umount+mount+unlock+cat.  Looks
> > > like ceph_atomic_open() fails to see that directory as encrypted.  I don't
> > > think the problem is on this open itself, but in the unlock because a
> > > simple 'ls' also fails to show the decrypted names.  (On the other end, if
> > > you do an 'ls' _before_ the unlock, everything seems to work fine.)
> > > 
> > > I didn't had time to dig deeper into this yet, but I don't remember seeing
> > > this behaviour in previous versions of the patchset.
> > > 
> > > Cheers,
> > > --
> > > Luís
> > > 
> > 
> > I've tried several times to reproduce this, but I haven't seen it happen
> > at all. It may be dependent on something in your environment (MDS
> > version, perhaps?). I'll try some more, but let me know if you track
> > down the cause.
> 
> Hmm... it could be indeed.  I'm running a vstart.sh cluster with pacific
> (HEAD in eb5d7a868c96 ("Merge PR #40473 into pacific")).  It's trivial to
> reproduce here, so I now wonder if I'm really missing something on the MDS
> side.  I had a disaster recently (a disk died) and I had to recreate my
> test environment.  I don't think I had anything extra to run fscrypt
> tests, but I can't really remember.
> 
> Anyway, I'll let you know if I get something.
> 

Thanks. FWIW, I'm on a cephadm built cluster using a pacific(-ish) build
from about 2 weeks ago:

$ sudo ./cephadm version
Using recent ceph image docker.io/ceph/daemon-base@sha256:765d8c56160753aa4a92757a2e007f5821f8c0ec70b5fc998faf334a2b127df2
ceph version 17.0.0-1983-g6a19e303 (6a19e303187c2defceb9c785284ca401a4309c47) quincy (dev)


> Cheers,
> --
> Luís
> 
> 
> > Thanks,
> > Jeff
> > 
> > > > 
> > > > diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> > > > index 17d8c8f4ec89..f4e3a17ffc01 100644
> > > > --- a/fs/ceph/export.c
> > > > +++ b/fs/ceph/export.c
> > > > @@ -7,6 +7,7 @@
> > > >  
> > > >  #include "super.h"
> > > >  #include "mds_client.h"
> > > > +#include "crypto.h"
> > > >  
> > > >  /*
> > > >   * Basic fh
> > > > @@ -516,7 +517,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
> > > >  {
> > > >  	struct ceph_mds_client *mdsc;
> > > >  	struct ceph_mds_request *req;
> > > > +	struct inode *dir = d_inode(parent);
> > > >  	struct inode *inode = d_inode(child);
> > > > +	struct ceph_mds_reply_info_parsed *rinfo;
> > > >  	int err;
> > > >  
> > > >  	if (ceph_snap(inode) != CEPH_NOSNAP)
> > > > @@ -528,29 +531,46 @@ static int ceph_get_name(struct dentry *parent, char *name,
> > > >  	if (IS_ERR(req))
> > > >  		return PTR_ERR(req);
> > > >  
> > > > -	inode_lock(d_inode(parent));
> > > > -
> > > > +	inode_lock(dir);
> > > >  	req->r_inode = inode;
> > > >  	ihold(inode);
> > > >  	req->r_ino2 = ceph_vino(d_inode(parent));
> > > > -	req->r_parent = d_inode(parent);
> > > > +	req->r_parent = dir;
> > > >  	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> > > >  	req->r_num_caps = 2;
> > > >  	err = ceph_mdsc_do_request(mdsc, NULL, req);
> > > > +	inode_unlock(dir);
> > > >  
> > > > -	inode_unlock(d_inode(parent));
> > > > +	if (err)
> > > > +		goto out;
> > > >  
> > > > -	if (!err) {
> > > > -		struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
> > > > +	rinfo = &req->r_reply_info;
> > > > +	if (!IS_ENCRYPTED(dir)) {
> > > >  		memcpy(name, rinfo->dname, rinfo->dname_len);
> > > >  		name[rinfo->dname_len] = 0;
> > > > -		dout("get_name %p ino %llx.%llx name %s\n",
> > > > -		     child, ceph_vinop(inode), name);
> > > >  	} else {
> > > > -		dout("get_name %p ino %llx.%llx err %d\n",
> > > > -		     child, ceph_vinop(inode), err);
> > > > -	}
> > > > +		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
> > > > +		struct ceph_fname fname = { .dir	= dir,
> > > > +					    .name	= rinfo->dname,
> > > > +					    .ctext	= rinfo->altname,
> > > > +					    .name_len	= rinfo->dname_len,
> > > > +					    .ctext_len	= rinfo->altname_len };
> > > > +
> > > > +		err = ceph_fname_alloc_buffer(dir, &oname);
> > > > +		if (err < 0)
> > > > +			goto out;
> > > >  
> > > > +		err = ceph_fname_to_usr(&fname, NULL, &oname, NULL);
> > > > +		if (!err) {
> > > > +			memcpy(name, oname.name, oname.len);
> > > > +			name[oname.len] = 0;
> > > > +		}
> > > > +		ceph_fname_free_buffer(dir, &oname);
> > > > +	}
> > > > +out:
> > > > +	dout("get_name %p ino %llx.%llx err %d %s%s\n",
> > > > +		     child, ceph_vinop(inode), err,
> > > > +		     err ? "" : "name ", err ? "" : name);
> > > >  	ceph_mdsc_put_request(req);
> > > >  	return err;
> > > >  }
> > > > -- 
> > > > 2.30.2
> > > > 
> > 
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> > 
> 

-- 
Jeff Layton <jlayton@kernel.org>

