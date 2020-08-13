Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B38E243EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 20:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHMSav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 14:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHMSau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:30:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7EC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 11:30:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z14so7291526ljm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GV8PPFk7zdOcXDLc5senY34tNbe4FyS6paqA9vC9SgI=;
        b=ZlFbecV91/u8T9JH4QjchtrSUp/D+5RzWlnOcjWxIhMZVrauL50IEurTkxPZybNqVq
         muJF6+ynwzbq4VhMrC/4zqXHWxrXmTD/ueZoaui8k7VDfeGDiynPu06k1IsXzHtCAavF
         /cliRz4z5ayMIf33a+qICg/16DNxR5A/992oJN/Vgtudi10j7LrTY9OWoJqSsCM2bvFz
         5b0OhPEW3FV6bjXB6FIKGozXUkCx3fUj64f/MvW4HKUouRjE2QurPOImOLypp5cnXd14
         ppvtMSz4m4ZfcE5z43B1y8S7micexY9qI9mIL5c9MXuKEcPsa+kAl+tldG8uEu1TnB/h
         yjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GV8PPFk7zdOcXDLc5senY34tNbe4FyS6paqA9vC9SgI=;
        b=VOefcwyaEDDcErINz7Lf+e7h5E1VKlcUfU+Vkr+28co9cw851w0gTxiqwcZK/jBP49
         XHPAZyG5gzXgLNyXA2apGPI7J6D8OYvy4lH/FZXWtKVlTFnFJEVEEwUVmzrOylhjzcBG
         17LdvJTjPuKSj45fMlmHj6jja7XlzcIYDOjv9FTWOfjVfdUIPcDpesIMNPF2py5Bn0m5
         U4ENRvc7IB/DHQJjOj35a73JF8uxRP05kZdxzZ9zXJdAMBvdA/yTnsu1AqOMzRvdY3UF
         0rUx8huV3ZxDpx9a12nO9dx4yR4j4Ikkbvhl//+y1XWmW+PFyrbqzcwvyrh3NhUYFcGm
         gUNQ==
X-Gm-Message-State: AOAM532ryMbHSS05zjnO6SFfHMmPRhYSGUd4SoPEaYwTUhjCS6v2RAZR
        UEuC+hxmXLr4+QeYH+aRinNsLsTwBi8eWITijJOpgQ==
X-Google-Smtp-Source: ABdhPJz7F3C957Xw9OwvGKIUufX2YxHq8yni5Jpew4l1KXqkCq7wu1v6OCIlEMwaE69mpCvgZDH7R5GzOj0eWVhp7Ng=
X-Received: by 2002:a05:651c:543:: with SMTP id q3mr2575722ljp.145.1597343447834;
 Thu, 13 Aug 2020 11:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200812161452.3086303-1-balsini@android.com> <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com>
In-Reply-To: <20200813132809.GA3414542@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Aug 2020 20:30:21 +0200
Message-ID: <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
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

On Thu, Aug 13, 2020 at 3:28 PM Alessio Balsini <balsini@android.com> wrote:
> On Wed, Aug 12, 2020 at 08:29:58PM +0200, 'Jann Horn' via kernel-team wrote:
[...]
> > On Wed, Aug 12, 2020 at 6:15 PM Alessio Balsini <balsini@android.com> wrote:
> > > Add support for filesystem passthrough read/write of files when enabled in
> > > userspace through the option FUSE_PASSTHROUGH.
[...]
> > Unfortunately, this step isn't really compatible with how the current
> > FUSE API works. Essentially, the current FUSE API is reached via
> > operations like the write() syscall, and reaches FUSE through either
> > ->write_iter or ->splice_write in fuse_dev_operations. In that
> > context, operations like fget_raw() that operate on the calling
> > process are unsafe.
> >
> > The reason why operations like fget() are unsafe in this context is
> > that the security model of Linux fundamentally assumes that if you get
> > a file descriptor from an untrusted process, and you write stuff into
> > it, anything that happens will be limited to things that the process
> > that gave you the file descriptor would've been able to do on its own.
> > Or in other words, an attacker shouldn't be able to gain anything by
> > convincing a privileged process to write attacker-controlled data into
> > an attacker-supplied file descriptor. With the current design, an
> > attacker may be able to trick a privileged process into installing one
> > of its FDs as a passthrough FD into an attacker-controlled FUSE
> > instance (while the privileged process thinks that it's just writing
> > some opaque data into some file), and thereby make it possible for an
> > attacker to indirectly gain the ability to read/write that FD.
> >
>
> This is a great explanation.
>
> I've been thinking about this before posting the patch and my final thought
> was that being the FUSE daemon already responsible for handling file ops
> coming from untrusted processes, and the privileges of these ops are anyway
> escalated to the daemon's, if the FUSE daemon has vulnerabilities to
> exploit,

This is not about vulnerabilities in the FUSE daemon.

> there's not much we can do to avoid an attacker to mess with files
> at the same permission level as the FUSE daemon. And this is true also
> without this patch, right?
> IOW, the feature introduced here is something that I agree should be
> handled with care, but is there something that can go wrong if the FUSE
> daemon is written properly? If we cannot trust the FUSE daemon, then we
> should also not trust what it would be able to access, so isn't it enough
> to prove that an attacker wouldn't be able to get more privileges than the
> FUSE daemon? Sorry if I missed something.

My point is that you can use this security issue to steal file
descriptors from processes that are _not_ supposed to act as FUSE
daemons. For example, let's say there is some setuid root executable
that opens /etc/shadow and then writes a message to stdout. If I
invoke this setuid root executable with stdout pointing to a FUSE
device fd, and I can arrange for the message written by the setuid
process to look like a FUSE message, I can trick the setuid process to
install its /etc/shadow fd as a passthrough fd on a FUSE file, and
then, through the FUSE filesystem, mess with /etc/shadow.

Also, for context: While on Android, access to /dev/fuse is
restricted, desktop Linux systems allow unprivileged users to use
FUSE.

> > The only way I see to fix this somewhat cleanly would be to add a new
> > command to fuse_dev_ioctl() that can be used to submit replies as an
> > alternative to the write()-based interface. (That should probably be a
> > separate patch in this patch series.) Then, you could have a flag
> > argument to fuse_dev_do_write() that tells it whether the ioctl
> > interface was used, and use that information to decide whether
> > fuse_setup_passthrough() is allowed.
> > (An alternative approach would be to require userspace to set some
> > flag on the write operation that says "I am intentionally performing
> > an operation that depends on caller identity" and pass that through -
> > e.g. by using pwritev2()'s flags argument. But I think historically
> > the stance has been that stuff like write() simply should not be
> > looking at the calling process.)
> >
>
> I'm not sure I got it right. Could you please elaborate on what is the
> purpose of the new fuse_dev_ioctl() command?
> Do you mean letting the kernel decide whether a FUSE daemon is allowed to
> run fuse_setup_passthrough() or to decide if passthrough should be allowed
> on a specific file?

The new fuse_dev_ioctl() command would behave just like
fuse_dev_write(), except that the ioctl-based interface would permit
OPEN/CREATE replies with FOPEN_PASSTHROUGH, while the write()-based
interface would reject them.

> In general, I prefer to avoid as much as I can API changes, let's see if
> there is a way to leave them untouched. :)
> What do you think about adding some extra checkings in
> fuse_setup_passthrough() to let the kernel decide if passthrough is doable?
> Do you think this would make things better regarding what you mentioned?

I can't think of any checks that you could do there to make it safe,
because fundamentally what you have to figure out is _userspace's
intent_, and you can't figure out what that is if userspace just calls
write().

[...]
> > > +       if (!passthrough_filp)
> > > +               return;
> >
> > This error path can only be reached if the caller supplied invalid
> > data. IMO this should bail out with an error.
>
> As you can see I switched from the BUG_ON() approach of the previous patch
> to the extreme opposite of transparent, graceful error handling.
> Do you think we should abort the whole open operation, or adding a few
> warning messages may suffice?

In this case, an error indicates that the userspace programmer made a
mistake. So even if the userspace programmer is not looking at kernel
logs, we should indicate to them that they messed up - and we can do
that by returning an error code from the syscall. So I think we should
ideally abort the operation in this case.

[...]
> > > +       passthrough_inode = file_inode(passthrough_filp);
> > > +
> > > +       iocb->ki_filp = passthrough_filp;
> >
> > Hmm... so we're temporarily switching out the iocb's ->ki_filp here? I
> > wonder whether it is possible for some other code to look at ->ki_filp
> > concurrently... maybe Jens Axboe knows whether that could plausibly
> > happen?
> >
> > Second question about this switcheroo below...
> >
> > > +       if (write) {
> > > +               if (!passthrough_filp->f_op->write_iter)
> > > +                       goto out;
> > > +
> > > +               ret = call_write_iter(passthrough_filp, iocb, iter);
> >
> > Hmm, I don't think we can just invoke
> > call_write_iter()/call_read_iter() like this. If you look at something
> > like vfs_writev(), you can see that normally, there are a bunch of
> > other things that happen:
> >
> >  - file_start_write() before the write
> >  - check whether the file's ->f_mode permits writing with FMODE_WRITE
> > and FMODE_CAN_WRITE
> >  - rw_verify_area() for stuff like mandatory locking and LSM security
> > checks (although admittedly this LSM security check is pretty useless)
> >  - fsnotify_modify() to trigger inotify watches and such that notify
> > userspace of file modifications
> >  - file_end_write() after the write
> >
> > You should probably try to use vfs_iocb_iter_write() here, and figure
> > out how to properly add file_start_write()/file_end_write() calls
> > around this. Perhaps ovl_write_iter() from fs/overlayfs/file.c can
> > help with this? Note that you can't always just call file_end_write()
> > synchronously, since the request may complete asynchronously.
>
> Answering here both the two previous questions, that are strictly related.
> I couldn't find any racy path for a specific iocp->ki_filp. Glad to be
> proven wrong, let's see if Jens can bring some light here.
>
> Jumping back to vfs with call_{read,write}_iter(), this looked to me as the
> most elegant solution, and I find it handy that they also perform extra
> checks on the target file.

No, call_write_iter() doesn't do any of the required checking and
setup and notification steps, it just calls into the file's
->write_iter handler:

static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
      struct iov_iter *iter)
{
        return file->f_op->write_iter(kio, iter);
}

Did you confuse call_write_iter() with vfs_iocb_iter_write(), or
something like that?

> I was worried at the beginning about this vfs
> nesting weirdness, but the nesting unrolls just fine, and with visual
> inspection I couldn't spot any dangerous situations.
> Are you just worried about write operations or reads as well? Maybe Jens
> can give some extra advice here too.
>
> > > +out:
> > > +       iocb->ki_filp = fuse_filp;
> >
> > Also a question that I hope Jens can help with: If this is an
> > asynchronous request, would something bad happen if the request
> > completes before we reach that last ->ki_filp write (if that is even
> > possible)? Or could an asynchronous request blow up because this
> > ->ki_filp write happens before the request has completed?
>
> I cannot think of a scenario where we don't complete the request before
> restoring the original ki_filp. Jens again to prove me wrong.

Requests can complete asynchronously. That means call_write_iter() can
return more or less immediately, while the request is processed in the
background, and at some point, a callback is invoked. That's what that
-EIOCBQUEUED return value is about. In that case, the current code
will change ->ki_filp while the request is still being handled in the
background.

I recommend looking at ovl_write_iter() in overlayfs to see how
they're dealing with this case.
