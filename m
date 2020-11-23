Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81C02C18DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 23:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgKWWwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 17:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbgKWWvr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:47 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F86C20715;
        Mon, 23 Nov 2020 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171906;
        bh=ZXc9vIM5l13483UKyWWsubayfXoDDXtja33VNeTcUhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsDDuDnWK5GUaGQVbz8/5EO0/9DSdVrAPwZxZyKsgRZfSg/kyAN/ExsfMf6vCCBrg
         Bxpxd6KXI7WTvuvsYFKMGz2q2Z3jn+8IqNQnKyAF+mOclvnBsqJVUQI0a8ZsKfitu0
         oI21w81HVsopyq5JuVAM+2IYVC2aMkThQZlQxCTY=
Date:   Mon, 23 Nov 2020 14:51:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/3] fscrypt: Have filesystems handle their d_ops
Message-ID: <X7w9AO0x8vG85JQU@sol.localdomain>
References: <20201119060904.463807-1-drosen@google.com>
 <20201119060904.463807-3-drosen@google.com>
 <20201122051218.GA2717478@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122051218.GA2717478@xiangao.remote.csb>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 22, 2020 at 01:12:18PM +0800, Gao Xiang wrote:
> Hi all,
> 
> On Thu, Nov 19, 2020 at 06:09:03AM +0000, Daniel Rosenberg wrote:
> > This shifts the responsibility of setting up dentry operations from
> > fscrypt to the individual filesystems, allowing them to have their own
> > operations while still setting fscrypt's d_revalidate as appropriate.
> > 
> > Most filesystems can just use generic_set_encrypted_ci_d_ops, unless
> > they have their own specific dentry operations as well. That operation
> > will set the minimal d_ops required under the circumstances.
> > 
> > Since the fscrypt d_ops are set later on, we must set all d_ops there,
> > since we cannot adjust those later on. This should not result in any
> > change in behavior.
> > 
> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > Acked-by: Eric Biggers <ebiggers@google.com>
> > ---
> 
> ...
> 
> >  extern const struct file_operations ext4_dir_operations;
> >  
> > -#ifdef CONFIG_UNICODE
> > -extern const struct dentry_operations ext4_dentry_ops;
> > -#endif
> > -
> >  /* file.c */
> >  extern const struct inode_operations ext4_file_inode_operations;
> >  extern const struct file_operations ext4_file_operations;
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 33509266f5a0..12a417ff5648 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -1614,6 +1614,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
> >  	struct buffer_head *bh;
> >  
> >  	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
> > +	generic_set_encrypted_ci_d_ops(dentry);
> 
> One thing might be worth noticing is that currently overlayfs might
> not work properly when dentry->d_sb->s_encoding is set even only some
> subdirs are CI-enabled but the others not, see generic_set_encrypted_ci_d_ops(),
> ovl_mount_dir_noesc => ovl_dentry_weird()
> 
> For more details, see:
> https://android-review.googlesource.com/c/device/linaro/hikey/+/1483316/2#message-2e1f6ab0010a3e35e7d8effea73f60341f84ee4d
> 
> Just found it by chance (and not sure if it's vital for now), and
> a kind reminder about this.
> 

Yes, overlayfs doesn't work on ext4 or f2fs filesystems that have the casefold
feature enabled, regardless of which directories are actually using casefolding.
This is an existing limitation which was previously discussed, e.g. at
https://lkml.kernel.org/linux-ext4/CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com/T/#u
and
https://lkml.kernel.org/linux-ext4/20191203051049.44573-1-drosen@google.com/T/#u.

Gabriel and Daniel, is one of you still looking into fixing this?  IIUC, the
current thinking is that when the casefolding flag is set on a directory, it's
too late to assign dentry_operations at that point.  But what if all child
dentries (which must be negative) are invalidated first, and also the filesystem
forbids setting the casefold flag on encrypted directories that are accessed via
a no-key name (so that fscrypt_d_revalidate isn't needed -- i.e. the directory
would only go from "no d_ops" to "generic_ci_dentry_ops", not from
"generic_encrypted_dentry_ops" to "generic_encrypted_ci_dentry_ops")?

- Eric
