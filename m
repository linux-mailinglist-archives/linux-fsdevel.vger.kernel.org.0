Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE3242E84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLSa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLSa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:30:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D3C061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 11:30:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so3337820ljc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn+p0Ikngp0kPP7pEi7wUQwvV2xttUEp4eoF5aAPjek=;
        b=VVteZdR0VUZLHetXVZq8kgdTqk47Jgm93A47BoiV8ttOWeXYc6Ihulq7eyUpsago8e
         RsfhNEfsPUOxmYv60gfshnIdlkGcoqdvl1j1ht4OPkJltULDMeBxl7lXA5EkWXS2fnbX
         V4J0ajD3NSoI6/fJMAKbQe+G4+9a3mZQ520mORTi9olD76UVV1GEnJkPL6DUdarPMyUb
         ngKUKLMtmcCveNzIblqYx7YKEUcr9OJMXyU8taQS2dbSV/cM7V43TcQJ7a1OaT4nB3yD
         6IxFYBpcTyrXCfz4INIUheC8xhtx7IXp+Bmhi8f/zgENblnQ4PA0mG7M2JL05wNIc0Eg
         oTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn+p0Ikngp0kPP7pEi7wUQwvV2xttUEp4eoF5aAPjek=;
        b=NXt5k03vIzVmdAXvmo5ha81+hs+GVztH3FMM9/oAxBx/wpP3Fdqlr2GPrSuxqS1rnM
         EaCkLEO2X/NSSLOu2gR6nb/g+N34sTOQlnwysH8Sa7HzEhz2t1qrFbuYEAWF9Jf3cWKj
         ycOB5EXJt2/rZCPM5F+7AR0oxn1Ygf9MsJpDgLVGNiXFbZZnAl3RA/SmoErctX7P2OwR
         b+i3KBiWV8RDKtSSswd1fgmoau+4t7gLi7biAP4pQq6840IRu13RKpJ5Cq94qsnvQO2G
         p/S2+YRlzniMgQf0aPtZFXNYUM3PAk8weXmHLrHdSKexzEZoLaxJDFUFbDCTdkQ2ECe+
         TSiw==
X-Gm-Message-State: AOAM533I7kSs5tZkhVmJNwu1S1FaPvIyw6LGpy9TNa42KJ5pbd4GcxjI
        5yG+/D5iwODMJDrcmVCepkH4qI0rOxzD0/YLAOVOiA==
X-Google-Smtp-Source: ABdhPJxFQ1n2xSInXvQ8yIWZK2WycZIbBi4d/NuE+ZNpcirlFx231MuWVclJwIK2mRpEP9aJr2OyW5+WOmHqfidn8bE=
X-Received: by 2002:a2e:302:: with SMTP id 2mr224798ljd.156.1597257024334;
 Wed, 12 Aug 2020 11:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200812161452.3086303-1-balsini@android.com>
In-Reply-To: <20200812161452.3086303-1-balsini@android.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 12 Aug 2020 20:29:58 +0200
Message-ID: <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Jens: can you have a look at that ->ki_filp switcheroo in
fuse_passthrough_read_write_iter() and help figure out whether that's
fine? This seems like your area of expertise.]

On Wed, Aug 12, 2020 at 6:15 PM Alessio Balsini <balsini@android.com> wrote:
> Add support for filesystem passthrough read/write of files when enabled in
> userspace through the option FUSE_PASSTHROUGH.

Oh, I remember this old series... v5 was from 2016? Nice to see
someone picking this up again, I liked the idea quite a bit.

> There are filesystems based on FUSE that are intended to enforce special
> policies or trigger complicate decision makings at the file operations
> level.  Android, for example, uses FUSE to enforce fine-grained access
> policies that also depend on the file contents.
> Sometimes it happens that at open or create time a file is identified as
> not requiring additional checks for consequent reads/writes, thus FUSE
> would simply act as a passive bridge between the process accessing the FUSE
> filesystem and the lower filesystem. Splicing and caching help reducing the
> FUSE overhead, but there are still read/write operations forwarded to the
> userspace FUSE daemon that could be avoided.
>
> When the FUSE_PASSTHROUGH capability is enabled the FUSE daemon may decide
> while handling the open or create operations if the given file can be
> accessed in passthrough mode, meaning that all the further read and write
> operations would be forwarded by the kernel directly to the lower
> filesystem rather than to the FUSE daemon. All requests that are not reads
> or writes are still handled by the userspace FUSE daemon.
> This allows for improved performance on reads and writes. Benchmarks show
> improved performance that is close to native filesystem access when doing
> massive manipulations on a single opened file, especially in the case of
> random reads, for which the bandwidth increased by almost 2X or sequential
> writes for which the improvement is close to 3X.
>
> The creation of this direct connection (passthrough) between FUSE file
> objects and file objects in the lower filesystem happens in a way that
> reminds of passing file descriptors via sockets:
> - a process opens a file handled by FUSE, so the kernel forwards the
>   request to the FUSE daemon;
> - the FUSE daemon opens the target file in the lower filesystem, getting
>   its file descriptor;
> - the file descriptor is passed to the kernel via /dev/fuse;
> - the kernel gets the file pointer navigating through the opened files of
>   the "current" process and stores it in an additional field in the
>   fuse_file owned by the process accessing the FUSE filesystem.

Unfortunately, this step isn't really compatible with how the current
FUSE API works. Essentially, the current FUSE API is reached via
operations like the write() syscall, and reaches FUSE through either
->write_iter or ->splice_write in fuse_dev_operations. In that
context, operations like fget_raw() that operate on the calling
process are unsafe.

The reason why operations like fget() are unsafe in this context is
that the security model of Linux fundamentally assumes that if you get
a file descriptor from an untrusted process, and you write stuff into
it, anything that happens will be limited to things that the process
that gave you the file descriptor would've been able to do on its own.
Or in other words, an attacker shouldn't be able to gain anything by
convincing a privileged process to write attacker-controlled data into
an attacker-supplied file descriptor. With the current design, an
attacker may be able to trick a privileged process into installing one
of its FDs as a passthrough FD into an attacker-controlled FUSE
instance (while the privileged process thinks that it's just writing
some opaque data into some file), and thereby make it possible for an
attacker to indirectly gain the ability to read/write that FD.

The only way I see to fix this somewhat cleanly would be to add a new
command to fuse_dev_ioctl() that can be used to submit replies as an
alternative to the write()-based interface. (That should probably be a
separate patch in this patch series.) Then, you could have a flag
argument to fuse_dev_do_write() that tells it whether the ioctl
interface was used, and use that information to decide whether
fuse_setup_passthrough() is allowed.
(An alternative approach would be to require userspace to set some
flag on the write operation that says "I am intentionally performing
an operation that depends on caller identity" and pass that through -
e.g. by using pwritev2()'s flags argument. But I think historically
the stance has been that stuff like write() simply should not be
looking at the calling process.)

> From now all the read/write operations performed by that process will be
> redirected to the file pointer pointing at the lower filesystem's file.
[...]
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
[...]
> +void fuse_setup_passthrough(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +       struct super_block *passthrough_sb;
> +       struct inode *passthrough_inode;
> +       struct fuse_open_out *open_out;
> +       struct file *passthrough_filp;
> +       unsigned short open_out_index;
> +       int fs_stack_depth;
> +
> +       req->passthrough_filp = NULL;
> +
> +       if (!fc->passthrough)
> +               return;
> +
> +       if (!(req->in.h.opcode == FUSE_OPEN && req->args->out_numargs == 1) &&
> +           !(req->in.h.opcode == FUSE_CREATE && req->args->out_numargs == 2))
> +               return;
> +
> +       open_out_index = req->args->out_numargs - 1;
> +
> +       if (req->args->out_args[open_out_index].size != sizeof(*open_out))
> +               return;
> +
> +       open_out = req->args->out_args[open_out_index].value;
> +
> +       if (!(open_out->open_flags & FOPEN_PASSTHROUGH))
> +               return;
> +
> +       if (open_out->fd < 0)
> +               return;

What is the intent here? fget() will fail anyway if the fd is invalid.

> +       passthrough_filp = fget_raw(open_out->fd);

This should probably be a normal fget()? fget_raw() is just necessary
if you want to permit using O_PATH file descriptors, and read/write
operations don't work on those.

> +       if (!passthrough_filp)
> +               return;

This error path can only be reached if the caller supplied invalid
data. IMO this should bail out with an error.

> +       passthrough_inode = file_inode(passthrough_filp);
> +       passthrough_sb = passthrough_inode->i_sb;
> +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;
> +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> +               fput(passthrough_filp);
> +               return;
> +       }

This is an error path that silently ignores the error and continues to
open the file normally as if FOPEN_PASSTHROUGH hadn't been set. Is
this an intentional fallback? If so, maybe you could add a comment on
top of fuse_setup_passthrough() like: "If setting up passthrough fails
due to incompatibility, we ignore the error and continue setting up
the file as normal."

> +       req->passthrough_filp = passthrough_filp;
> +}
> +
> +static inline ssize_t fuse_passthrough_read_write_iter(struct kiocb *iocb,
> +                                                      struct iov_iter *iter,
> +                                                      bool write)
> +{
> +       struct file *fuse_filp = iocb->ki_filp;
> +       struct fuse_file *ff = fuse_filp->private_data;
> +       struct file *passthrough_filp = ff->passthrough_filp;
> +       struct inode *passthrough_inode;
> +       struct inode *fuse_inode;
> +       ssize_t ret = -EIO;
> +
> +       fuse_inode = fuse_filp->f_path.dentry->d_inode;

I think this could just use file_inode(fuse_filp)?


> +       passthrough_inode = file_inode(passthrough_filp);
> +
> +       iocb->ki_filp = passthrough_filp;

Hmm... so we're temporarily switching out the iocb's ->ki_filp here? I
wonder whether it is possible for some other code to look at ->ki_filp
concurrently... maybe Jens Axboe knows whether that could plausibly
happen?

Second question about this switcheroo below...

> +       if (write) {
> +               if (!passthrough_filp->f_op->write_iter)
> +                       goto out;
> +
> +               ret = call_write_iter(passthrough_filp, iocb, iter);

Hmm, I don't think we can just invoke
call_write_iter()/call_read_iter() like this. If you look at something
like vfs_writev(), you can see that normally, there are a bunch of
other things that happen:

 - file_start_write() before the write
 - check whether the file's ->f_mode permits writing with FMODE_WRITE
and FMODE_CAN_WRITE
 - rw_verify_area() for stuff like mandatory locking and LSM security
checks (although admittedly this LSM security check is pretty useless)
 - fsnotify_modify() to trigger inotify watches and such that notify
userspace of file modifications
 - file_end_write() after the write

You should probably try to use vfs_iocb_iter_write() here, and figure
out how to properly add file_start_write()/file_end_write() calls
around this. Perhaps ovl_write_iter() from fs/overlayfs/file.c can
help with this? Note that you can't always just call file_end_write()
synchronously, since the request may complete asynchronously.

> +               if (ret >= 0 || ret == -EIOCBQUEUED) {
> +                       fsstack_copy_inode_size(fuse_inode, passthrough_inode);
> +                       fsstack_copy_attr_times(fuse_inode, passthrough_inode);
> +               }
> +       } else {
> +               if (!passthrough_filp->f_op->read_iter)
> +                       goto out;
> +
> +               ret = call_read_iter(passthrough_filp, iocb, iter);
> +               if (ret >= 0 || ret == -EIOCBQUEUED)
> +                       fsstack_copy_attr_atime(fuse_inode, passthrough_inode);
> +       }
> +
> +out:
> +       iocb->ki_filp = fuse_filp;

Also a question that I hope Jens can help with: If this is an
asynchronous request, would something bad happen if the request
completes before we reach that last ->ki_filp write (if that is even
possible)? Or could an asynchronous request blow up because this
->ki_filp write happens before the request has completed?

> +       return ret;
> +}

Overall, I wonder whether it would be better to copy overlayfs'
approach of creating a new iocb instead of trying to switch out parts
of the existing iocb (see ovl_write_iter()). That would simplify this
weirdness a lot, at the cost of having to allocate slab memory to
store the copied iocb.
