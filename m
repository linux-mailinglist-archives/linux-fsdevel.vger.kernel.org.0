Return-Path: <linux-fsdevel+bounces-24079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789779390D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3B1C211FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591B16DC1D;
	Mon, 22 Jul 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIemd3Kw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273216C6B8;
	Mon, 22 Jul 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659288; cv=none; b=juqYteaiXzLiPlQd6Q712zSy0kmk8E0CpmkKGEf6Eziv0kd5SXKvd0pOEqApLAuVoEADS7OKgJ+9s0AF82GRJ/1vxEaCHr48BF1lFacGhfjvdQTQGsX148pu6qIALr1lQGefIzfIsBZXAt1qWKUC4F3/XMMcsHBlrdiGDPcuhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659288; c=relaxed/simple;
	bh=zT/d4EzGgPVkMeU++ZavEy4AZLZrrIkwCrPWwgHvFj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDyzzgfqacNm07VoD4WXsmiP5/9OpaVT72I7x7UqxeVLy1s1KIsvK7x5fYWHoux5ameasp9+d0XBtjF0+FVMrMaKL+0Ja8Ftb6Qk6S0g6JCE62DEQoFXczT1yfOP9CG0FnlUZukjkazjtW3L3kfWXeCXxxN+NwJCJcBYo1zcCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIemd3Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189D7C116B1;
	Mon, 22 Jul 2024 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659287;
	bh=zT/d4EzGgPVkMeU++ZavEy4AZLZrrIkwCrPWwgHvFj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIemd3KwYy0YgddRwXx03axTOfrGVrNfsbVEZkm9B+Os5agC5uMKLh9S2dLK+mdG0
	 TfQGKXFMcDiiSryjwm5Sd9Z4pFypVMp43Rd7E+964j50KnI65VjRnluYgf9yUN6wpb
	 B009sMnDCReg62Cb6Kn6ec6MuvxJW0BxCXP1CaZzXiDXjgb/7L2bKC4a6+tirdiyX9
	 0uYLDvTZiHCII45Ezw9EPDqu1NJmxVVwMemW4pqUEbOQXUvHkZHtLt3bZHKGafqMz7
	 Ad+lN4Mx5CvMlLY9CxvnplxujyGEEyf/rUGHuQSUV/s9vFa6HZu/L3Vqq8+cdXF+PP
	 1TI5X4m/Aadgg==
Date: Mon, 22 Jul 2024 16:41:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] tty: tty_io: fix race between tty_fops and
 hung_up_tty_fops
Message-ID: <20240722-gehminuten-fichtenwald-9dd5a7e45bc5@brauner>
References: <a11e31ab-6ffc-453f-ba6a-b7f6e512c55e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a11e31ab-6ffc-453f-ba6a-b7f6e512c55e@I-love.SAKURA.ne.jp>

On Fri, Jul 19, 2024 at 10:37:47PM GMT, Tetsuo Handa wrote:
> syzbot is reporting data race between __tty_hangup() and __fput(), and
> Dmitry Vyukov mentioned that this race has possibility of NULL pointer
> dereference, for tty_fops implements e.g. splice_read callback whereas
> hung_up_tty_fops does not.
> 
>   CPU0                                  CPU1
>   ----                                  ----
>   do_splice_read() {
>                                         __tty_hangup() {
>     // f_op->splice_read was copy_splice_read
>     if (unlikely(!in->f_op->splice_read))
>       return warn_unsupported(in, "read");
>                                           filp->f_op = &hung_up_tty_fops;
>     // f_op->splice_read is now NULL
>     return in->f_op->splice_read(in, ppos, pipe, len, flags);
>                                         }
>   }
> 
> Fix possibility of NULL pointer dereference by implementing missing
> callbacks, and suppress KCSAN messages by adding __data_racy qualifier
> to "struct file"->f_op .

This f_op replacing without synchronization seems really iffy imho.
Why can't the hangup just be recorded in tty_file_private and then
checked in the corresponding f_op->$method()?

And if that's not possible for some reason I'd be willing to sacrifice
one of the FMODE_* bits I recently freed up and add e.g.,
FMODE_TTY_HANGUP instead of this f_op raciness (Why wasn't this using
replace_fops anyway so it'd be easy to grep for it?).

Something like the completely untested below:

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bc9aebcb873f..219bf6391fed 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -583,6 +583,26 @@ static struct file *tty_release_redirect(struct tty_struct *tty)
        return f;
 }

+static noinline void noinline tty_mark_hungup(struct file *file)
+{
+       fmode_t fmode = READ_ONCE(file->f_mode);
+
+       do {
+               if (fmode & FMODE_TTY_HUNGUP)
+                       break;
+       } while (!try_cmpxchg(&file->f_mode, &fmode, fmode | FMODE_TTY_HUNGUP));
+}
+
+static noinline void noinline tty_clear_hungup(struct file *file)
+{
+       fmode_t fmode = READ_ONCE(file->f_mode);
+
+       do {
+               if (!(fmode & FMODE_TTY_HUNGUP))
+                       break;
+       } while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_TTY_HUNGUP));
+}
+
 /**
  * __tty_hangup - actual handler for hangup events
  * @tty: tty device
@@ -652,7 +672,7 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
                        continue;
                closecount++;
                __tty_fasync(-1, filp, 0);      /* can't block */
-               filp->f_op = &hung_up_tty_fops;
+               tty_mark_hungup(filp);
        }
        spin_unlock(&tty->files_lock);

@@ -776,7 +796,7 @@ void tty_vhangup_session(struct tty_struct *tty)
  */
 int tty_hung_up_p(struct file *filp)
 {
-       return (filp && filp->f_op == &hung_up_tty_fops);
+       return (filp && (READ_ONCE(filp->f_mode) & FMODE_TTY_HUNGUP));
 }
 EXPORT_SYMBOL(tty_hung_up_p);

@@ -2204,7 +2224,7 @@ static int tty_open(struct inode *inode, struct file *filp)
                 * Need to reset f_op in case a hangup happened.
                 */
                if (tty_hung_up_p(filp))
-                       filp->f_op = &tty_fops;
+                       tty_clear_hungup(filp);
                goto retry_open;
        }
        clear_bit(TTY_HUPPED, &tty->flags);
@@ -2718,6 +2738,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
        int retval;
        struct tty_ldisc *ld;

+       /* Check whether the tty hung up. */
+       if (tty_hung_up_p(file))
+               return hung_up_tty_ioctl(file, cmd, arg);
+
        if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
                return -EINVAL;

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ea3df718c53e..e96b86bab356 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -128,7 +128,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports atomic writes */
 #define FMODE_CAN_ATOMIC_WRITE ((__force fmode_t)(1 << 7))

-/* FMODE_* bit 8 */
+/* File driver hung up (tty specific)  */
+#define FMODE_TTY_HUNGUP       ((__force fmode_t)(1 << 8))

 /* 32bit hashes as llseek() offset (for directories) */
 #define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))


> 
> Reported-by: syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This patch has been tested using linux-next tree via my tomoyo tree since 20240611,
> and there was no response on
>   [fs] Are you OK with updating "struct file"->f_op value dynamically?
> at https://lkml.kernel.org/r/b221d2cf-7dc0-4624-a040-85c131ed72a1@I-love.SAKURA.ne.jp .
> Thus, I guess we can go with this approach.
> 
>  drivers/tty/tty_io.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/fs.h   |  2 +-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 407b0d87b7c1..bc9aebcb873f 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -430,6 +430,24 @@ static ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
>  	return -EIO;
>  }
>  
> +static ssize_t hung_up_copy_splice_read(struct file *in, loff_t *ppos,
> +					struct pipe_inode_info *pipe,
> +					size_t len, unsigned int flags)
> +{
> +	return -EINVAL;
> +}
> +
> +static ssize_t hung_up_iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
> +					      loff_t *ppos, size_t len, unsigned int flags)
> +{
> +	return -EINVAL;
> +}
> +
> +static int hung_up_no_open(struct inode *inode, struct file *file)
> +{
> +	return -ENXIO;
> +}
> +
>  /* No kernel lock held - none needed ;) */
>  static __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
>  {
> @@ -462,6 +480,12 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
>  }
>  
>  static const struct file_operations tty_fops = {
> +	/*
> +	 * WARNING: You must implement all callbacks defined in tty_fops in
> +	 * hung_up_tty_fops, for tty_fops and hung_up_tty_fops are toggled
> +	 * after "struct file" is published. Failure to synchronize has a risk
> +	 * of NULL pointer dereference bug.
> +	 */
>  	.llseek		= no_llseek,
>  	.read_iter	= tty_read,
>  	.write_iter	= tty_write,
> @@ -491,14 +515,24 @@ static const struct file_operations console_fops = {
>  };
>  
>  static const struct file_operations hung_up_tty_fops = {
> +	/*
> +	 * WARNING: You must implement all callbacks defined in hung_up_tty_fops
> +	 * in tty_fops, for tty_fops and hung_up_tty_fops are toggled after
> +	 * "struct file" is published. Failure to synchronize has a risk of
> +	 * NULL pointer dereference bug.
> +	 */
>  	.llseek		= no_llseek,
>  	.read_iter	= hung_up_tty_read,
>  	.write_iter	= hung_up_tty_write,
> +	.splice_read    = hung_up_copy_splice_read,
> +	.splice_write   = hung_up_iter_file_splice_write,
>  	.poll		= hung_up_tty_poll,
>  	.unlocked_ioctl	= hung_up_tty_ioctl,
>  	.compat_ioctl	= hung_up_tty_compat_ioctl,
> +	.open           = hung_up_no_open,
>  	.release	= tty_release,
>  	.fasync		= hung_up_tty_fasync,
> +	.show_fdinfo    = tty_show_fdinfo,
>  };
>  
>  static DEFINE_SPINLOCK(redirect_lock);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..636bcc59a3f5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1008,7 +1008,7 @@ struct file {
>  	struct file_ra_state	f_ra;
>  	struct path		f_path;
>  	struct inode		*f_inode;	/* cached value */
> -	const struct file_operations	*f_op;
> +	const struct file_operations	*__data_racy f_op;
>  
>  	u64			f_version;
>  #ifdef CONFIG_SECURITY
> -- 
> 2.43.5
> 

