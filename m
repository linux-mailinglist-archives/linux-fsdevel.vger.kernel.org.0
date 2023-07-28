Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF50766EF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjG1OAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjG1OAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE22D67;
        Fri, 28 Jul 2023 07:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753C76214D;
        Fri, 28 Jul 2023 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74BAC433C7;
        Fri, 28 Jul 2023 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690552814;
        bh=dIDs9VaKmXyd5CQQamII2fuzaJZZ/rrGjIB/Vv1ZMXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O23HruYPvglX9Lor/OifmLyxNBpV31d6BJgAkrsV1VPXHjVv5A7vPvAoEendMTxeD
         TX6WfgGyw8wBQiG/jPaec3cBN12XZrz8Ic9Di4PQAFeln29v9kGHGJ7O2E+EykHsDl
         BlRIyGfMUZeLFx9RRwB6aP70oAaHCH5eLqITi7FmXYGbDZ04EXwifq2TnavSeBevqQ
         Z+lyRdUuv4pQCP9utJml9KJVcuor6At63T04IIJXw8IjTqrxUiynWTsqUXD7CKl0/3
         Q0bs/hbrHIHrhv+i6nT71djGmPlqt9EaklPYdojV9K22wvQ2kIAPNZ3i6loOekXsLS
         mM0mlzaZoLFYw==
Date:   Fri, 28 Jul 2023 16:00:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, ebiggers@kernel.org,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 1/7] fs: Expose name under lookup to d_revalidate hook
Message-ID: <20230728-unrentabel-volumen-1500701f2524@brauner>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727172843.20542-2-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727172843.20542-2-krisman@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:28:37PM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Negative dentries support on case-insensitive ext4/f2fs will require
> access to the name under lookup to ensure it matches the dentry.  This
> adds an optional new flavor of cached dentry revalidation hook to expose
> this extra parameter.
> 
> I'm fine with extending d_revalidate instead of adding a new hook, if
> it is considered cleaner and the approach is accepted.  I wrote a new
> hook to simplify reviewing.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v2:
>   - Document d_revalidate_name hook. (Eric)
> ---
>  Documentation/filesystems/locking.rst |  3 +++
>  Documentation/filesystems/vfs.rst     | 12 ++++++++++++
>  fs/dcache.c                           |  2 +-
>  fs/namei.c                            | 23 ++++++++++++++---------
>  include/linux/dcache.h                |  1 +
>  5 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index ed148919e11a..d68997ba6584 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -18,6 +18,8 @@ dentry_operations
>  prototypes::
>  
>  	int (*d_revalidate)(struct dentry *, unsigned int);
> +	int (*d_revalidate_name)(struct dentry *, const struct qstr *,
> +				 unsigned int);

I think we should just extend d_revalidate(). You can't reasonably
implement d_revalidate() and d_revalidate_name() and then have the VFS
call both. That's just weird. Imho, it belongs into d_revalidate()
proper. Documentation should come with the same warning about handling
d_inode in so far as under some condition d_name can change under the
caller.

>  	int (*d_weak_revalidate)(struct dentry *, unsigned int);
>  	int (*d_hash)(const struct dentry *, struct qstr *);
>  	int (*d_compare)(const struct dentry *,
> @@ -37,6 +39,7 @@ locking rules:
>  ops		   rename_lock	->d_lock	may block	rcu-walk
>  ================== ===========	========	==============	========
>  d_revalidate:	   no		no		yes (ref-walk)	maybe
> +d_revalidate_name: no		no		yes (ref-walk)	maybe
>  d_weak_revalidate: no		no		yes	 	no
>  d_hash		   no		no		no		maybe
>  d_compare:	   yes		no		no		maybe
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index cb2a97e49872..34c842bd7cb2 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1252,6 +1252,8 @@ defined:
>  
>  	struct dentry_operations {
>  		int (*d_revalidate)(struct dentry *, unsigned int);
> +		int (*d_revalidate_name)(struct dentry *, const struct qstr *,
> +					 unsigned int);
>  		int (*d_weak_revalidate)(struct dentry *, unsigned int);
>  		int (*d_hash)(const struct dentry *, struct qstr *);
>  		int (*d_compare)(const struct dentry *,
> @@ -1288,6 +1290,16 @@ defined:
>  	return
>  	-ECHILD and it will be called again in ref-walk mode.
>  
> +``d_revalidate_name``
> +	Variant of d_revalidate that also provides the name under look-up.  Most
> +	filesystems will keep it as NULL, unless there are particular semantics
> +	for filenames encoding that need to be handled during dentry
> +	revalidation.
> +
> +	When available, it is called in lieu of d_revalidate and has the same
> +	locking rules and return semantics.  Refer to d_revalidate for more
> +	information.
> +
>  ``d_weak_revalidate``
>  	called when the VFS needs to revalidate a "jumped" dentry.  This
>  	is called when a path-walk ends at dentry that was not acquired
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 52e6d5fdab6b..98521862e58a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1928,7 +1928,7 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
>  		dentry->d_flags |= DCACHE_OP_HASH;
>  	if (op->d_compare)
>  		dentry->d_flags |= DCACHE_OP_COMPARE;
> -	if (op->d_revalidate)
> +	if (op->d_revalidate || op->d_revalidate_name)
>  		dentry->d_flags |= DCACHE_OP_REVALIDATE;
>  	if (op->d_weak_revalidate)
>  		dentry->d_flags |= DCACHE_OP_WEAK_REVALIDATE;
> diff --git a/fs/namei.c b/fs/namei.c
> index e56ff39a79bc..84df0ddd20db 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -853,11 +853,16 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
>  	return false;
>  }
>  
> -static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
> +static inline int d_revalidate(struct dentry *dentry,
> +			       const struct qstr *name,
> +			       unsigned int flags)
>  {
> -	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> +
> +	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE)) {
> +		if (dentry->d_op->d_revalidate_name)
> +			return dentry->d_op->d_revalidate_name(dentry, name, flags);
>  		return dentry->d_op->d_revalidate(dentry, flags);

This whole sequence got me thinking.

If you create an ext4 filesystem with casefolding like:

mkfs.ext4 -F -E encoding=utf8 /dev/sdb

and then

mount -t ext4 /dev/sdb /mnt
mkdir /mnt/casefold
chattr +F /mnt/casefold

then you can mount overlayfs on the non-casefolded root dentry at /mnt:

(1) mount -t overlay overlay -o upperdir=/upper,workdir=/work,lowerdir=/mnt /opt

but you cannot mount overlayfs on the casefolded root dentry at
/mnt/casefolded:

(2) mount -t overlay overlay -o upperdir=/upper,workdir=/work,lowerdir=/mnt/casefold /opt

because overlayfs rejects the dentry in ovl_dentry_weird() because the
dentry will have DCACHE_OP_HASH set because casefold libfs helpers rely
on a custom dentry hash function.

In any case (1) shouldn't a problem per se as overlayfs will return
EREMOTE from lookup because ovl_dentry_weird() will also be called by
overlayfs during lookup. So it should be safe though I haven't spent a
lot of mental effort to figure out whether this can somehow be otherwise
used to trigger nonsensical behavior or potential bugs.

But this logic is predicated on DCACHE_OP_HASH. So if for some crazy
reason a filesystem were to implement ->d_revalidate_name() but didn't
also implement ->d_hash() we'd be hosed because overlayfs calls
->d_revalidate() directly.

And then there's ecryptfs which is happily mountable over casefolding
directories:

ubuntu@imp1-vm:~$ sudo mount -t ecryptfs /mnt/test/casefold-dir /opt
ubuntu@imp1-vm:/opt$ findmnt | grep opt
└─/opt  /mnt/test/casefold-dir ecryptfs rw,relatime,ecryptfs_sig=8567ee2ae5880f2d,ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_unlink_sigs

So it doesn't even seem to care if the underlying filesytem uses a
custom dentry hash function which seems problematic (So unrelated to
this change someone should likely explain why that doesn't matter.).

Afaict with your series this will be even more broken because ecryptfs
and overlayfs call ->d_revalidate() directly.

So this suggests that really you want to extend ->d_revalidate() and we
should at least similar to overlayfs make ecryptfs reject being mounted
on casefolding directories and refuse lookup requests for casefolding
directories.

Ideally we'd explicitly reject by having such fses detect casefolding
unless it's really enough to reject based on DCACHE_OP_HASH.
