Return-Path: <linux-fsdevel+bounces-20160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0189A8CF1E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 00:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A011C20C16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E82AE75;
	Sat, 25 May 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h3RBZvGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F93C2F;
	Sat, 25 May 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716677323; cv=none; b=a83Njqz1Gt0tlpp80tqf5CNHAw90XqFk9rVBGTFBmYnZ/2xuvbol6aTLktC3+LoYYvZI1Us6uu3BkC+tfgnkay/oWvEYmmYCGTpVd5hySkpctmqJctPKf5QZJxF9X5EWTYuj5zev2gldKkzmDS5rmDCwgIO8CNpGjTvFp0F/PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716677323; c=relaxed/simple;
	bh=bU60JQgRd/tuoDM+gJv6YuOl4Y5f0VnZBakOse0yr1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGAG2H6SCYJJBTPxzEHXXvpjulVl42xdjesJlE0Icw0mmbFrXwUP6vJTC2g/vpwXhMn/MRkVztsgvQnrZXchjOxwKKMLENOOe0VYqQCTiAnm1LSull9afvwITzuz/LYDNZZc0cyDT2zB4jubTHNqF4gwAdea9mRibcN2M8zZlv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h3RBZvGx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8lAoVZ8mQNYe9p5Dgp8ZJOm7ROPj+HYjtW41t2VJmDY=; b=h3RBZvGxa36Uo8yOxL+A5TPGuf
	YIDYuYp01+m9hBfEdl3eSEST8194KsMV0jYfUAzeWWuP3D9QsUQ/+GA4h0c66Jec7NfdaPEMvho4/
	sn6AogKrNbcB/ZZE5M44ZVa44S6RtH3mxdOHZIO1/Oj5v3rKbpqCa4juZpsUE8rOB0QtdKy+UDQnJ
	hdcf5MGrqEOSOQpD6mV6qYs0Ad9aS4R+ZDWhw3tjePAqlhvXKJ1InhBPWc9pvKkuGDn1bQkvcFpin
	SkQX6vzvIOBMUQS8ByvaJWip2JzBklACrfirPpUFnCbkdapg/3aw19rhSsp5MJwhp2Ut1vJWtaCtX
	766/OK8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sB0Bg-008I4a-1o;
	Sat, 25 May 2024 22:48:28 +0000
Date: Sat, 25 May 2024 23:48:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Cc: brauner@kernel.org, jack@suse.cz, arnd@arndb.de, gregkh@suse.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libfs: fix implicitly cast in simple_attr_write_xsigned()
Message-ID: <20240525224828.GX2118490@ZenIV>
References: <BL0PR03MB41610A9302ADA6A5022A306BADF62@BL0PR03MB4161.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR03MB41610A9302ADA6A5022A306BADF62@BL0PR03MB4161.namprd03.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 25, 2024 at 07:55:52PM +0000, Jiasheng Jiang wrote:
> > On Wed, May 15, 2024 at 03:17:25PM +0000, Jiasheng Jiang wrote:
> >> Return 0 to indicate failure and return "len" to indicate success.
> >> It was hard to distinguish success or failure if "len" equals the error
> >> code after the implicit cast.
> >> Moreover, eliminating implicit cast is a better practice.
> > 
> > According to whom?
> > 
> 
> Programmers can easily overlook implicit casts, leading to unknown
> behavior (e.g., this bug).

Which bug is "this" in the above refering to?

> Converting implicit casts to explicit casts can help prevent future
> errors.
> 
> > Merits of your ex cathedra claims aside, you do realize that functions
> > have calling conventions because they are, well, called, right?
> > And changing the value returned in such and such case should be
> > accompanied with the corresponding change in the _callers_.
> > 
> > Al, wondering if somebody had decided to play with LLM...
> 
> As the comment shows that "ret = len; /* on success, claim we got the
> whole input */", the return value should be checked to determine whether
> it equals "len".
> 
> Moreover, if "len" is 0, the previous copy_from_user() will fail and
> return an error.
> Therefore, 0 is an illegal value for "len". Besides, in the linux kernel,
> all the callers of simple_attr_write_xsigned() return the return value of
> simple_attr_write_xsigned().

Lovely.  "Callers are expected to check somewhere; immediate callers just
return it as-is to their callers, therefore we are done".  So where would
those checks be?  Deeper in the call chain?  Let's look at the call chains,
then...

; git grep -n -w simple_attr_write_xsigned
fs/libfs.c:1341:static ssize_t simple_attr_write_xsigned(struct file *file, const char __user *buf,
fs/libfs.c:1380:        return simple_attr_write_xsigned(file, buf, len, ppos, false);
fs/libfs.c:1387:        return simple_attr_write_xsigned(file, buf, len, ppos, true);
;

Two callers, one of them being
ssize_t simple_attr_write(struct file *file, const char __user *buf,
                          size_t len, loff_t *ppos)
{
	return simple_attr_write_xsigned(file, buf, len, ppos, false);
}

and another
ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
                          size_t len, loff_t *ppos)
{
	return simple_attr_write_xsigned(file, buf, len, ppos, true);
}

All right, who calls those?

; git grep -n -w simple_attr_write
arch/powerpc/platforms/cell/spufs/file.c:455:   .write = simple_attr_write,
drivers/gpu/drm/imagination/pvr_params.c:123:           .write = simple_attr_write,                \
fs/debugfs/file.c:485:          ret = simple_attr_write(file, buf, len, ppos);
fs/libfs.c:1377:ssize_t simple_attr_write(struct file *file, const char __user *buf,
fs/libfs.c:1382:EXPORT_SYMBOL_GPL(simple_attr_write);
include/linux/fs.h:3501:        .write   = (__is_signed) ? simple_attr_write_signed : simple_attr_write,        \
include/linux/fs.h:3523:ssize_t simple_attr_write(struct file *file, const char __user *buf,
virt/kvm/kvm_main.c:6117:       .write = simple_attr_write,
;

In addition to one direct caller it is used as ->write method instances.
What in?

static const struct file_operations spufs_cntl_fops = {
        .open = spufs_cntl_open,
        .release = spufs_cntl_release,
        .read = simple_attr_read,
        .write = simple_attr_write,
        .llseek = no_llseek,
        .mmap = spufs_cntl_mmap,
};

static struct {
#define X(type_, name_, value_, desc_, mode_, update_) \
        const struct file_operations name_;
        PVR_DEVICE_PARAMS
#undef X
} pvr_device_param_debugfs_fops = {
#define X(type_, name_, value_, desc_, mode_, update_)     \
        .name_ = {                                         \
                .owner = THIS_MODULE,                      \
                .open = __pvr_device_param_##name_##_open, \
                .release = simple_attr_release,            \
                .read = simple_attr_read,                  \
                .write = simple_attr_write,                \
                .llseek = generic_file_llseek,             \
        },   
        PVR_DEVICE_PARAMS
#undef X
};

static const struct file_operations __fops = {                          \
        .owner   = THIS_MODULE,                                         \
        .open    = __fops ## _open,                                     \
        .release = simple_attr_release,                                 \
        .read    = simple_attr_read,                                    \
        .write   = (__is_signed) ? simple_attr_write_signed : simple_attr_write,        \
        .llseek  = generic_file_llseek,                                 \
}

static const struct file_operations stat_fops_per_vm = {
        .owner = THIS_MODULE,
        .open = kvm_stat_data_open,
        .release = kvm_debugfs_release,
        .read = simple_attr_read,   
        .write = simple_attr_write,
        .llseek = no_llseek,
};

So all of those are file_operations::write instances.  The caller?

static ssize_t debugfs_attr_write_xsigned(struct file *file, const char __user *buf,
                         size_t len, loff_t *ppos, bool is_signed)
{
        struct dentry *dentry = F_DENTRY(file);
        ssize_t ret;

        ret = debugfs_file_get(dentry);
        if (unlikely(ret))
                return ret;
        if (is_signed)
                ret = simple_attr_write_signed(file, buf, len, ppos);
        else
                ret = simple_attr_write(file, buf, len, ppos);
        debugfs_file_put(dentry);
        return ret;
}

itself called in

ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
                         size_t len, loff_t *ppos)
{
        return debugfs_attr_write_xsigned(file, buf, len, ppos, false);
}

and

ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
                         size_t len, loff_t *ppos)
{
        return debugfs_attr_write_xsigned(file, buf, len, ppos, true);
}

Both of those are used only in
static const struct file_operations __fops = {                          \
        .owner   = THIS_MODULE,                                         \
        .open    = __fops ## _open,                                     \
        .release = simple_attr_release,                                 \
        .read    = debugfs_attr_read,                                   \
        .write   = (__is_signed) ? debugfs_attr_write_signed : debugfs_attr_write,      \
        .llseek  = no_llseek,                                           \
}
in expansion of DEFINE_DEBUGFS_ATTRIBUTE_XSIGNED().


In other words, all call chains go through some ->write() method call,
with return value ending up that of ->write() instance.

Now, looking for the places where file_operations ->write() can be called
is a bit more tedious, but one would expect to see at least some near write(2).
Which lives in fs/read_write.c, where we see this:

ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
{
        ssize_t ret;

        if (!(file->f_mode & FMODE_WRITE))
                return -EBADF;
        if (!(file->f_mode & FMODE_CAN_WRITE))
                return -EINVAL;
        if (unlikely(!access_ok(buf, count)))
                return -EFAULT;

        ret = rw_verify_area(WRITE, file, pos, count);
        if (ret)
                return ret;
        if (count > MAX_RW_COUNT)
                count =  MAX_RW_COUNT;
        file_start_write(file);
        if (file->f_op->write)
                ret = file->f_op->write(file, buf, count, pos);
        else if (file->f_op->write_iter)
                ret = new_sync_write(file, buf, count, pos);
        else   
                ret = -EINVAL;
        if (ret > 0) {
                fsnotify_modify(file);
                add_wchar(current, ret);
        }
        inc_syscw(current);
        file_end_write(file);
        return ret;
}
and from there it's very close to write(2):

ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
{
        struct fd f = fdget_pos(fd);
        ssize_t ret = -EBADF;

        if (f.file) {
                loff_t pos, *ppos = file_ppos(f.file);
                if (ppos) {
                        pos = *ppos;
                        ppos = &pos;
                }
                ret = vfs_write(f.file, buf, count, ppos);
                if (ret >= 0 && ppos)
                        f.file->f_pos = pos;
                fdput_pos(f);
        }

        return ret;
}

and finally
SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
                size_t, count)
{
        return ksys_write(fd, buf, count);
}

So here's at least one call chain where return value is propagated
all the way back to userland, without *ANY* alleged comparisons with
the length argument (which, again, comes directly from write(2) in
this particular callchain).

So before your change write(2) called with arguments that stepped onto
that returned -EACCES; with that change on the same arguments it returns
0.

In libc that translates into "return -1, set errno to EACCES" and "return 0"
respectively.

I hope the above is sufficient to explain the problem with the reasoning in
your patch.

_ANYTHING_ that changes calling conventions of a function must either
verify that all callers are fine with the change, or adjust them accordingly.
If your change alters the calling conventions of those callers, the same
applies to them, etc.

What's more, your change is very clearly losing information - the current
calling conventions for ->write() are "return the number of bytes written
(possibly less than demanded) or, in case of error with no bytes written,
a small negative number representing that error (negated errno.h constants)"
and with your change you get no way to report _which_ error has occured.
You can't adjust for that at any point of call chain - and pretty soon
you run into the userland boundary anyway, at which point the calling
conventions are cast in stone.

Please note that reading comments does _not_ replace checking what's
really going on, especially when the comment is vague enough to be
misinterpreted.  It doesn't say that callers will check that return value
will be compared to len argument - it says that on success this instance
of ->write() will claim to have consumed the entire buffer passed to it.
Further look into how it parses the input shows that it will e.g. treat
"12" and "12\n" identically, reporting 2 and 3 bytes resp. having been
written, even though the final newline is ignored in the latter case.
In other words, it claims (correctly) that it won't result in short
writes.  It does not promise anything about the checks to be made
by callers.

NAK.

