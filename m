Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A352499D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHSKEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHSKEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:04:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C325C061342
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 03:04:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so24753921ljd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1niIf/MqQWc6bAfTtuV3k6Nrfl2OWXNtlUs8RYFXVdE=;
        b=AB90QQii8Ij+/CBEOTVzTrdaTMVJms1zOTu2PfcfFIOmNnkgrsLW0ZMLVk2CNPcwBB
         q9niatB73SIW1xiYLodNxRhmHJM6VV11pP64sGeg9WelEwPC/aFsvcXBHhJsmMRfGHaG
         3CzRU+XBFkiWOktBdbycNZcSC+L73SZ6F+E1Foko4ohD5UKEuaqC/LDsMsBTMWPMQyyl
         rbb4KQX4Le6m1EbWyarsHom1+7lIQYzL/UMjpnhUiU/uJvA0h4OUiuM+AwX1JSeL0+G4
         aXH84yIg104+CFQrpRWDGS0k9ODM0f7H7FC6ClzgSlL6i6d6KbyBO9EgpYL+ypESi/RJ
         1Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1niIf/MqQWc6bAfTtuV3k6Nrfl2OWXNtlUs8RYFXVdE=;
        b=MZ03XtAuHEloxTg+v1Tj2cJW8n8oqtYKYsgCshnylTceVr697psFh73YIce4RK/b5S
         IIrJfc2I3T95qquD1k7YzsjCEHGtklCEEeLFKOi+l9YFmoKPU46L358pahrGAgDrLn7q
         fhOx10ONU07Q8xw/BZ55C7HgRflOQFWD/oUmfNrICBenFomzyGUKXBCds2wBl5I/YU8z
         xL4mWAu6GkmoNFdJRUc1Jav/9VXaJ5A7jbDSqhT/84u0Da7mqjDzp9pDL5URHXIjEFCF
         bHHr42/37kmVfoJ+OhFaNZV/l1Qbvy0BS3qdPagyypL7GJuqy3RjTbVWat1SmFiAeusJ
         90Tg==
X-Gm-Message-State: AOAM530vv6w9GwoRWpvLXp7Wr+6rAsIfMQRBGvX3AOTvKNeoclerx/BT
        iBNFeUEuP9qjw0VSN+XYQhigsOKtFFvXkBM0F2F2zQ==
X-Google-Smtp-Source: ABdhPJy7f4HpFLAdaqu86xR7dmqF7ZaNS2kvzcdk2LOCAYZOORjCQ9d0VT6KrWWbjqEQZ3deDRqzsQlH2SNjVPno2Hc=
X-Received: by 2002:a05:651c:543:: with SMTP id q3mr11532208ljp.145.1597831469926;
 Wed, 19 Aug 2020 03:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200812161452.3086303-1-balsini@android.com> <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com> <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
 <20200818135313.GA3074431@google.com>
In-Reply-To: <20200818135313.GA3074431@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Aug 2020 12:04:03 +0200
Message-ID: <CAG48ez3ZX8R9kRAQhung2_e3wjowu5cPh7WL3U866mkga-kftQ@mail.gmail.com>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
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

On Tue, Aug 18, 2020 at 3:53 PM Alessio Balsini <balsini@android.com> wrote:
> Thank you both for the important feedback,
>
> I tried to consolidate all your suggestions in the new version of the
> patch, shared below.
>
> As you both recommended, that tricky ki_filp swapping has been removed,
> taking overlayfs as a reference for the management of asynchronous
> requests.
> The V7 below went again through some testing with fio (sync and libaio
> engines with several jobs in randrw), fsstress, and a bunch of kernel
> builds to trigger both the sync and async paths. Gladly everything worked
> as expected.
>
> What I didn't get from overlayfs are the temporary cred switchings, as I
> think that in the FUSE use case it is still the FUSE daemon that should
> take care of identifying if the requesting process has the right
> permissions before allowing the passthrough feature.

FYI, rw_verify_area() annoyingly calls security_file_permission(),
which is hooked by some stuff like SELinux. This doesn't really fit
well into the normal Linux security model, and it means that when a
userspace process tries to read from a FUSE file with passthrough
enabled, SELinux will actually perform access checks against *both*
the FUSE file itself and the backing file. That's kinda stupid, but
SELinux does it. If this ends up being a problem, switching
credentials would help. (Changing rw_verify_area() to not call
security_file_permission() would also help, but some of the LSM folks
might disagree with my opinion that that check is silly and should be
removed.)

But for now, I guess it might be fine to leave things as-is and not do
the extra credential switching.

> On Thu, Aug 13, 2020 at 08:30:21PM +0200, 'Jann Horn' via kernel-team wrote:
> > On Thu, Aug 13, 2020 at 3:28 PM Alessio Balsini <balsini@android.com> wrote:
> > [...]
> >
> > My point is that you can use this security issue to steal file
> > descriptors from processes that are _not_ supposed to act as FUSE
> > daemons. For example, let's say there is some setuid root executable
> > that opens /etc/shadow and then writes a message to stdout. If I
> > invoke this setuid root executable with stdout pointing to a FUSE
> > device fd, and I can arrange for the message written by the setuid
> > process to look like a FUSE message, I can trick the setuid process to
> > install its /etc/shadow fd as a passthrough fd on a FUSE file, and
> > then, through the FUSE filesystem, mess with /etc/shadow.
> >
> > Also, for context: While on Android, access to /dev/fuse is
> > restricted, desktop Linux systems allow unprivileged users to use
> > FUSE.
> > [...]
> > The new fuse_dev_ioctl() command would behave just like
> > fuse_dev_write(), except that the ioctl-based interface would permit
> > OPEN/CREATE replies with FOPEN_PASSTHROUGH, while the write()-based
> > interface would reject them.
> > [...]
> > I can't think of any checks that you could do there to make it safe,
> > because fundamentally what you have to figure out is _userspace's
> > intent_, and you can't figure out what that is if userspace just calls
> > write().
> > [...]
> > In this case, an error indicates that the userspace programmer made a
> > mistake. So even if the userspace programmer is not looking at kernel
> > logs, we should indicate to them that they messed up - and we can do
> > that by returning an error code from the syscall. So I think we should
> > ideally abort the operation in this case.
>
> I've been thinking about the security issue you mentioned, but I'm thinking
> that besides the extra Android restrictions, it shouldn't be that easy to
> play with /dev/fuse, also for a privileged process in Linux.
> In order for a process to successfully send commands to /dev/fuse, the
> command has to match a pending request coming from the FUSE filesystem,
> meaning that the same privileged process should have mounted the FUSE
> filesystem, actually becoming a FUSE daemon itself.
> Is this still an eventually exploitable scenario?

There are setuid root binaries that will print attacker-controlled
data to stdout, or stuff like that. An attacker could set up a normal
FUSE filesystem, read an OPEN request from the /dev/fuse file
descriptor, construct a reply that would install a passthrough fd (but
NOT actually send it), and then invoke a setuid root binary with the
/dev/fuse fd as stderr and with some arguments that trick it into
writing the attacker-constructed reply to stderr. For example, you can
make "su" write a string starting with attacker-controlled data like
this:

$ cat blah.c
#include <unistd.h>
#include <err.h>
int main(void) {
  execlp("su", "ATTACKER-CONTROLLED STRING", "-BLAH", NULL);
  err(1, "execlp");
}
$ gcc -o blah blah.c
$ ./blah
ATTACKER-CONTROLLED STRING: invalid option -- 'B'
Try 'ATTACKER-CONTROLLED STRING --help' for more information.
$

And yes, sure, I know, you can't write nullbytes with this specific
example; but in principle, you have to assume that a privileged victim
process might be writing arbitrary attacker-controlled data to
attacker-supplied file descriptors.

> > No, call_write_iter() doesn't do any of the required checking and
> > setup and notification steps, it just calls into the file's
> > ->write_iter handler:
> >
> > static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
> >       struct iov_iter *iter)
> > {
> >         return file->f_op->write_iter(kio, iter);
> > }
> >
> > Did you confuse call_write_iter() with vfs_iocb_iter_write(), or
> > something like that?
>
> Ops, you are right, I was referring to vfs_iocb_iter_write(), that was
> actually part of my first design, but ended up simplifying in favor of
> call_write_iter().
>
> > Requests can complete asynchronously. That means call_write_iter() can
> > return more or less immediately, while the request is processed in the
> > background, and at some point, a callback is invoked. That's what that
> > -EIOCBQUEUED return value is about. In that case, the current code
> > will change ->ki_filp while the request is still being handled in the
> > background.
> >
> > I recommend looking at ovl_write_iter() in overlayfs to see how
> > they're dealing with this case.
>
> That was a great suggestion, I hopefully picked the right things from
> overlayfs, without overlooking some security aspects.
[...]
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
[...]
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file,
> +                         bool write)
> +{
> +       struct inode *dst = file_inode(dst_file);
> +       struct inode *src = file_inode(src_file);
> +
> +       fsstack_copy_attr_times(dst, src);
> +       if (write)
> +               fsstack_copy_inode_size(dst, src);
> +}
[...]
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> +                                  struct iov_iter *iter)
> +{
> +       struct file *fuse_filp = iocb_fuse->ki_filp;
> +       struct fuse_file *ff = fuse_filp->private_data;
> +       struct file *passthrough_filp = ff->passthrough_filp;
> +       ssize_t ret;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       if (is_sync_kiocb(iocb_fuse)) {
> +               struct kiocb iocb;
> +
> +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> +               ret = call_read_iter(passthrough_filp, &iocb, iter);
> +               iocb_fuse->ki_pos = iocb.ki_pos;
> +       } else {
> +               struct fuse_aio_req *aio_req;
> +
> +               aio_req =
> +                       kmem_cache_zalloc(fuse_aio_request_cachep, GFP_KERNEL);
> +               if (!aio_req)
> +                       return -ENOMEM;
> +
> +               aio_req->iocb_fuse = iocb_fuse;
> +               kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
> +               aio_req->iocb.ki_complete = fuse_aio_rw_complete;
> +               ret = vfs_iocb_iter_read(passthrough_filp, &aio_req->iocb,
> +                                        iter);
> +               if (ret != -EIOCBQUEUED)
> +                       fuse_aio_cleanup_handler(aio_req);
> +       }
> +
> +       fuse_copyattr(fuse_filp, passthrough_filp, false);

This copies timestamps from the passthrough_filp to the fuse_filp
without any locking I can see - which means that depending on the
architecture and the compiler's decisions, the copied timestamps can
end up getting corrupted to some degree. On 64-bit platforms, in
practice, you might e.g. end up with a timestamp where the tv_nsec
part is from an older timestamp while tv_sec is from a newer one,
yielding an overall timestamp that might e.g. be almost a second in
the future; and on 32-bit platforms, the results could even be much
worse. In theory, this is a data race, which should generally be
avoided.

The same thing applies to some of the other places where
fuse_copyattr() is used.

From a higher-level perspective, are you sure that you even want to do
this timestamp-copying at all, given that the userspace fuse daemon
will also be supplying its own timestamps? Especially considering that
the timestamps are at the inode level while the passthrough logic is
at the file level, that seems pretty wonky.

> +       return ret;
> +}
[...]
> +int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_req *req)
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
> +               return 0;
> +
> +       if (!(req->in.h.opcode == FUSE_OPEN && req->args->out_numargs == 1) &&
> +           !(req->in.h.opcode == FUSE_CREATE && req->args->out_numargs == 2))
> +               return 0;
> +
> +       open_out_index = req->args->out_numargs - 1;
> +
> +       if (req->args->out_args[open_out_index].size != sizeof(*open_out))
> +               return 0;

Can this ever legitimately happen, or would that indicate a kernel
bug? If it indicates a kernel bug, please write WARN_ON() around the
condition, like this: "if
(WARN_ON(req->args->out_args[open_out_index].size !=
sizeof(*open_out)))".

> +       open_out = req->args->out_args[open_out_index].value;
> +
> +       if (!(open_out->open_flags & FOPEN_PASSTHROUGH))
> +               return 0;
> +
> +       passthrough_filp = fget(open_out->fd);
> +       if (!passthrough_filp) {
> +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> +               return -1;
> +       }
> +
> +       if (!passthrough_filp->f_op->read_iter ||
> +           !passthrough_filp->f_op->write_iter) {
> +               pr_err("FUSE: passthrough file misses file operations.\n");
> +               fput(passthrough_filp);
> +               return -1;
> +       }

(Just as a non-actionable comment: This means that passthrough files
won't work with files that use ->read and ->write handlers instead of
->read_iter and ->write_iter. But that's probably actually a good
thing - ->read and ->write are mostly used by weird pseudo-files, and
I don't see any legitimate reason why anyone would want to use those
things with FUSE passthrough.)

> +       passthrough_inode = file_inode(passthrough_filp);
> +       passthrough_sb = passthrough_inode->i_sb;
> +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;
> +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> +               fput(passthrough_filp);
> +               return -1;
> +       }
> +
> +       req->passthrough_filp = passthrough_filp;
> +       return 0;
> +}
[...]
> +int __init fuse_passthrough_aio_request_cache_init(void)
> +{
> +       fuse_aio_request_cachep =
> +               kmem_cache_create("fuse_aio_req", sizeof(struct fuse_aio_req),
> +                                 0, SLAB_HWCACHE_ALIGN, NULL);
> +       if (!fuse_aio_request_cachep)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +void fuse_passthrough_aio_request_cache_destroy(void)
> +{
> +       kmem_cache_destroy(fuse_aio_request_cachep);
> +}

I think you don't have to make your own slab cache for this; it should
be fine to just use kmalloc() instead. Using a dedicated cache will be
more space-efficient if you have tons of allocations, but you won't
have a huge number of these allocations existing simultaneously, so
that shouldn't matter much. And if you only have a very small number
of allocations, you'll probably actually end up using more memory.
