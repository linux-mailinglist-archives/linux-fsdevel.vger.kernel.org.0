Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC1430AFA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 19:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhBASmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 13:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233082AbhBASmk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:42:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ECDE64E2E;
        Mon,  1 Feb 2021 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612204920;
        bh=69cyJhfV0g/b80psHE1hMu/HLzqH+eYN+aOqwwit1qw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=um3X1oWmo7HdwRXnoleQkOdc/CEsdpBFhIvi2LRl0JbBapmHvfKxKm30etEupj05r
         zJaInsvZD0no5OwHJOMnhmxzoUDSAv5iE7J/a8hBGjH564IzLPXTyTmyGlGwhqEGjV
         xuvDQwQRr3Edix8mYwTcSYgbtQsqWzqIzfY50JwHg8yyfmxgv56++Zqk3utMBngKf7
         dFLg+KeKtCAMiiKNo1BxTG149jiBhKcNDUv2FCX5zQJmhrzSx3+HG3YX7+0FZLcjpd
         iYL6W+75hUQbTeC8cvYe8RPWN3bKYANXqjvGrCCVgY5wEBHxbXWNoiGHBjN84n57Sd
         UHZXxVH4SAPzQ==
Message-ID: <6afe55b64fc517082f708a83cf2748b59f8548dc.camel@kernel.org>
Subject: Re: [RFC PATCH v4 15/17] ceph: make d_revalidate call fscrypt
 revalidator for encrypted dentries
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Feb 2021 13:41:58 -0500
In-Reply-To: <87zh0nyaeo.fsf@suse.de>
References: <20210120182847.644850-1-jlayton@kernel.org>
         <20210120182847.644850-16-jlayton@kernel.org> <87zh0nyaeo.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-02-01 at 17:18 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > If we have a dentry which represents a no-key name, then we need to test
> > whether the parent directory's encryption key has since been added.  Do
> > that before we test anything else about the dentry.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/dir.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 236c381ab6bd..cb7ff91a243a 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1726,6 +1726,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
> >  	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
> >  	     dentry, inode, ceph_dentry(dentry)->offset);
> >  
> > 
> > +	valid = fscrypt_d_revalidate(dentry, flags);
> > +	if (valid <= 0)
> > +		return valid;
> > +
> 
> This one took me a while to figure out, but eventually got there.
> Initially I was seeing this error:
> 
> crypt: ceph: 1 inode(s) still busy after removing key with identifier f019f4a1c5d5665675218f89fccfa3c7, including ino 1099511627791
> 
> and, when umounting the filesystem I would get the warning in
> fs/dcache.c:1623.
> 
> Anyway, the patch below should fix it.
> 
> Unfortunately I didn't had a lot of time to look into the -experimental
> branch yet.  On my TODO list for the next few days.
> 
> Cheers,

Well spotted! I think the better fix though is to just move the
fscrypt_d_revalidate call up before the point where we take the parent
reference. I'll fix that up in my tree. Thanks for tracking that down!
-- 
Jeff Layton <jlayton@kernel.org>

