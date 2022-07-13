Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA7572A60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 02:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGMAs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGMAs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD12D1DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 17:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B2461883
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 00:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F205C3411C;
        Wed, 13 Jul 2022 00:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657673333;
        bh=CYVIyYvKLZ/qFdN5hm0X79nNmr2ZiWdEmkrQcRlWixI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAOTRoq3kFz5h81OctmxZzLMlT19HsuTHKZiS0E5aeVKiuOl2lmD8DEp4b0HbP/A2
         U1xe4dTjtsMMlVsBGZbmkzq+gzzEGsFO63PysS7nn4zuPp6O4FOA4jk1abBQUL0ZWq
         pqoDIEeAy0thDjuT0uDXg++EOCI7aAhHnyN2rVo+55Cix8NG0ZkcoQpwOb2JULW5bx
         OETYddQlaAFo3vd+ltitpZsMmRweBOAfMGQxJycB/08JXjo1EFU2g+uapmIlb81wYW
         j9TiMNQNNkI6hvXxYk+gPi+NHS6vOeX2w1ZN7UF9fqdyMkmXqsKTeD3IaXz0uamNB3
         D/y23HHYp5ZOA==
Date:   Tue, 12 Jul 2022 17:48:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Message-ID: <Ys4WdKSUTcvktuEl@magnolia>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 01:48:18PM -0700, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 1:04 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Yeah I'm fine with removing the inode_permission(), I just want to make sure
> > we're consistent across all of our IO related operations.  It looks like at the
> > very least we're getting security_*_permission on things like
> > read/write/fallocate, so perhaps switch to that here and call it good enough?
> 
> remap_verify_area() already does that, afaik.
> 
> The more I look at the remap_range stuff, the more I feel it is very
> ad-hoc and nobody really thought deeply about it.
> 
> What about an append-only destination? Is that kind of write supposed
> to be ok because it's just REMAP_FILE_DEDUP? The open side should
> already have checked for IS_IMMUTABLE, but O_APPEND is a thing?

This whole area of dedupe preconditions is a giant mess that makes my
head hurt every time I think about it, so I don't really think about it.
I hoisted all of it from btrfs to reuse the system call entry point
without breaking existing userspace.

Were I designing this from scratch for XFS, I would've required either
CAP_SYS_ADMIN; or FMODE_READ on the src, and FMODE_READ|WRITE on the
dest, and left it at that.  Neither file can be IMMUTABLE because,
frankly, I don't see much point in having such a flag if its behavior is
the same as chmod 0000; I'll come back to this.  Deduping between
readable O_APPEND files would be fine because we're not writing to
either file.

(But that's my own fantasyland.)

AFAICT, the reason why dedupe does all the weird checks it does is
because apparently some of the dedupe tools expect that they can do
weird things like dedupe into a file that they own but haven't opened
for writes or could open for writes.  Change those bits, and you break
userspace.

Given that you can already mmap the write-only file and read data from
the mapping, I don't see what the leak is.  If someone really wants to
break userspace on these grounds, they can own all the howling that
results.

> I'm getting the feeling that somebody really needs to think about what
> the semantics should be.
> 
> In the meantime, I think that requiring the block size alignment is
> the important part here. The "check read permissions" is kind of a
> non-issue, since we already have that mmap() case.
> 
> Strangely, it *does* check that the position is aligned for remapping
> in .generic_remap_checks(). And not at all for dedupe.

The dedupe implementations /do/ check file blocksize, it's under
generic_remap_file_range_prep.  The reason this exploit program works on
the 7-byte file is that we stop comparing at EOF, which means that there
are fewer bytes to guess.  But.  You can already read the file anyway.

> And even for remapping, the size alignment is a bit strange. It takes
> the "source EOF" into account, but what if the destination file is big
> enough that that's not the end?

generic_remap_check_len is supposed to catch those.

> And the inode_permission() check is wrong, but at least it does have
> the important check there (ie that FMODE_WRITE one). So doing the
> inode_permissions() check at worst just makes it fail too often, but
> since it's all a "optimistically dedupe" anyway, that kind of "fail in
> odd situations" doesn't really matter.
> 
> So for allow_file_dedupe(), I'd suggest:
> 
>  (a) remove the inode_permission() check in allow_file_dedupe()
> 
>  (b) remove the uid_eq() check for the same reason (if you didn't open
> the destination for write, you have no business deduping anything,
> even if you're the owner)

So we're going to break userspace?
https://github.com/markfasheh/duperemove/issues/129

>  (c) add a "can't do it for APPEND_ONLY" (but let the CAP_SYS_ADMIN override it)
> 
> AND I'd add a "make sure it's all block-aligned" check for both the
> source and each destination chunk.

...and we're going to break deduping the EOF block again?

> Something like the attached, IOW. Entirely untested, this is not meant
> to be applied as-is, this is meant to be the basis of discussion.
> 
> Btw, the generic_remap_file_range_prep() IS_IMMUTABLE check seems
> bogus too. How could it possibly be immutable if we've opened the
> target for writing?

What /is/ the meaning of S_IMMUTABLE?  Documentation/ only says that the
fsverity author thinks it means "read-only contents".  If it's the same
as "chmod 0000" in that anyone with a writable fd can still modify the
supposedly immutable file, then what was the point?

The manual page for the getflags/setflags ioctls (~2017) say this:

"FS_IMMUTABLE_FL 'i'
              The file is immutable: no changes are permitted to the
              file contents or metadata (permissions, timestamps,
              ownership, link count, and so on).  (This restriction
              applies even to the superuser.)  Only a privileged process
              (CAP_LINUX_IMMUTABLE) can set or clear this attribute."

https://man7.org/linux/man-pages/man2/ioctl_iflags.2.html

Going back to e2fsprogs 1.02 in 1997, the manual page for chattr says
this:

"      i      A file with the 'i' attribute cannot be modified: it
              cannot be deleted or renamed, no link can be created to
              this file, most of the file's metadata can not be
              modified, and the file can not be opened in write mode.
              Only the superuser or a process possessing the
              CAP_LINUX_IMMUTABLE capability can set or clear this
              attribute."

https://man7.org/linux/man-pages/man1/chattr.1.html

To me, that sounds like you shouldn't be able to change the contents of
an immutable file, full stop, and that's what the authors of the
clone/dedupe/copy_file_range calls have all gone with.

True, you can write() to such a file if you have a writable fd, but
that's not what I would have expected from the documentation.  ISTR Ted
or someone muttering that the current behavior seems much more like a
historical accident than planned out semantics.

> So all of this seems a bit confused. It really smells like "filesystem
> people wrote this with low-level filesystem rules in mind, rather than
> any kind of high-level understanding or conceptual rules"

Frankly, I don't know what all the high level conceptual rules are for
Linux filesystems.  They don't seem to be written down in Documentation/
and this has made writing fstests very difficult for me when I want to
wire up XFS to some syscall or another, and what documentation there is
doesn't seem to be consistent with what the kernel actually does.

--D

> Hmm?
> 
>                  Linus

>  fs/remap_range.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index e112b5424cdb..ba71ceb8dde3 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -409,17 +409,12 @@ EXPORT_SYMBOL(vfs_clone_file_range);
>  /* Check whether we are allowed to dedupe the destination file */
>  static bool allow_file_dedupe(struct file *file)
>  {
> -	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
> -	struct inode *inode = file_inode(file);
> -
>  	if (capable(CAP_SYS_ADMIN))
>  		return true;
> +	if (file->f_flags & O_APPEND)
> +		return false;
>  	if (file->f_mode & FMODE_WRITE)
>  		return true;
> -	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
> -		return true;
> -	if (!inode_permission(mnt_userns, inode, MAY_WRITE))
> -		return true;
>  	return false;
>  }
>  
> @@ -428,6 +423,8 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  				 loff_t len, unsigned int remap_flags)
>  {
>  	loff_t ret;
> +	struct inode *dst;
> +	unsigned long blocksize;
>  
>  	WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
>  				     REMAP_FILE_CAN_SHORTEN));
> @@ -457,10 +454,17 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  		goto out_drop_write;
>  
>  	ret = -EISDIR;
> -	if (S_ISDIR(file_inode(dst_file)->i_mode))
> +	dst = file_inode(dst_file);
> +	if (S_ISDIR(dst->i_mode))
>  		goto out_drop_write;
>  
>  	ret = -EINVAL;
> +	blocksize = 1ul << dst->i_blkbits;
> +	if (dst_pos & (blocksize-1))
> +		goto out_drop_write;
> +	if (len & (blocksize-1))
> +		goto out_drop_write;
> +
>  	if (!dst_file->f_op->remap_file_range)
>  		goto out_drop_write;
>  
> @@ -488,6 +492,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  	int ret;
>  	u16 count = same->dest_count;
>  	loff_t deduped;
> +	unsigned long blocksize;
>  
>  	if (!(file->f_mode & FMODE_READ))
>  		return -EINVAL;
> @@ -507,6 +512,12 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
>  	if (!file->f_op->remap_file_range)
>  		return -EOPNOTSUPP;
>  
> +	blocksize = 1ul << src->i_blkbits;
> +	if (off & (blocksize-1))
> +		return -EINVAL;
> +	if (len & (blocksize-1))
> +		return -EINVAL;
> +
>  	ret = remap_verify_area(file, off, len, false);
>  	if (ret < 0)
>  		return ret;

