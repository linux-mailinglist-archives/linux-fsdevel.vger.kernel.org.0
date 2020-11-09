Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7452AC5E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 21:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgKIUY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 15:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKIUY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:24:26 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D201C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 12:24:25 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x11so5701031vsx.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUe6St4e112YPrcwx/bHzV1CZPra+32RU4VD8kX7rTA=;
        b=Y/Gf37WY5oe59YcUlJfCoH8cHuLia92ZRNE4gH8Mez2WvU5TfDl4STaOCDGPtxUzxd
         6FpwuAzGIp0YilKcfIfS476bONNqmBYS/WrTfgGHLuDsFDh/Sm5dPmSaGos44IEKwsyR
         tEryLHvUTS6l9XnRLsnny9HKOCOj3FDZquM/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUe6St4e112YPrcwx/bHzV1CZPra+32RU4VD8kX7rTA=;
        b=bGO6f5ctKlSkVyl+2tk4VQXDHObC8tfdmSaz6u4FPkvOdvoLoH9KFPsko0BcKMNYWf
         fwFdHiHgKRQ64o3N4QxECEWF9c8XbDcOF2S/MX0JmKviAlR8mbwX2hOXItZzBLELS59i
         5CRc01nNbQJfELADVmMmPDD2TYDGel0Au1C/438kahDY4E4VqS38NkKyZZP7Pt44W2wW
         2GUAhBNEV8sa/U6xurGW1gZBlyFDIb5SwawFpca8rHC8xRSWSnH09E3v7XRDocgs/5OC
         ULcdQvBJstdhMfdL5PsbyqhnJQjZ3NZRO8whAPggYqnIuVQHmXRueOEYwlXi0QC6ioKg
         2PlQ==
X-Gm-Message-State: AOAM532CkUAGABi5QZzyfnzoKFZJg0lnis1O0n+/AD7I792rKEhPXJBR
        NuVdA33tiiKbNv/fB39I7fVVWUXyEXFXdYOKxKnkbQ==
X-Google-Smtp-Source: ABdhPJxhq/4EAEw3hG/B6CZBQ5cq1D7Ug+KtSE5AouE+lrzzcHSP938/0/uAtq8SJML/XZGgDPXkRQXlhfHV0Xuzcok=
X-Received: by 2002:a67:1442:: with SMTP id 63mr9140605vsu.0.1604953464346;
 Mon, 09 Nov 2020 12:24:24 -0800 (PST)
MIME-Version: 1.0
References: <1e796f9e008fb78fb96358ff74f39bd4865a7c88.1604926010.git.gladkov.alexey@gmail.com>
 <CAJfpegua_ahmNa4p0me6R10wtcPpQVKNiKQOVKjuNW67RHFOOA@mail.gmail.com> <87v9ee2wer.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9ee2wer.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Nov 2020 21:24:13 +0100
Message-ID: <CAJfpegugWh7r=h9T+fbb7FKrz2JpWtA==ck2iYq1DYJ25_-WyA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] fuse: Abort waiting for a response if the
 daemon receives a fatal signal
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 7:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Mon, Nov 9, 2020 at 1:48 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> >>
> >> This patch removes one kind of the deadlocks inside the fuse daemon. The
> >> problem appear when the fuse daemon itself makes a file operation on its
> >> filesystem and receives a fatal signal.
> >>
> >> This deadlock can be interrupted via fusectl filesystem. But if you have
> >> many fuse mountpoints, it will be difficult to figure out which
> >> connection to break.
> >>
> >> This patch aborts the connection if the fuse server receives a fatal
> >> signal.
> >
> > The patch itself might be acceptable, but I have some questions.
> >
> > To logic of this patch says:
> >
> > "If a task having the fuse device open in it's fd table receives
> > SIGKILL (and filesystem was initially mounted in a non-init user
> > namespace), then abort the filesystem operation"
> >
> > You just say "server" instead of "task having the fuse device open in
> > it's fd table" which is sloppy to say the least.  It might also lead
> > to regressions, although I agree that it's unlikely.
> >
> > Also how is this solving any security issue?   Just create the request
> > loop using two fuse filesystems and the deadlock avoidance has just
> > been circumvented.   So AFAICS "selling" this as a CVE fix is not
> > appropriate.
>
> The original report came in with a CVE on it.  So referencing that CVE
> seems reasonable.  Even if the issue isn't particularly serious.  It is
> very annoying not to be able to kill processes with SIGKILL or the OOM
> killer.
>
> You have a good point about the looping issue.  I wonder if there is a
> way to enhance this comparatively simple approach to prevent the more
> complex scenario you mention.

Let's take a concrete example:

- task A is "server" for fuse fs a
- task B is "server" for fuse fs b
- task C: chmod(/a/x, ...)
- task A: read UNLINK request
- task A: chmod(/b/x, ...)
- task B: read UNLINK request
- task B: chmod (/a/x, ...)

Now B is blocking on i_mutex on x , A is waiting for reply from B, C
is holding i_mutex on x and waiting for reply from A.

At this point B is truly uninterruptible (and I'm not betting large
sums on Al accepting killable VFS locks patches), so killing B is out.

Killing A with this patch does nothing, since A does not have b's dev
fd in its fdtable.

Killing C again does nothing, since it has no fuse dev fd at all.

> Does tweaking the code to close every connection represented by a fuse
> file descriptor after a SIGKILL has been delevered create any problems?

In the above example are you suggesting that SIGKILL on A would abort
"a" from fs b's code?   Yeah, that would work, I guess.  Poking into
another instance this way sounds pretty horrid, though.

> > What's the reason for making this user-ns only?  If we drop the
> > security aspect, then I don't see any reason not to do this
> > unconditionally.
>
>
> > Also note, there's a proper solution for making fuse requests always
> > killable, and that is to introduce a shadow locking that ensures
> > correct fs operation in the face of requests that have returned and
> > released their respective VFS locks.   Now this would be a much more
> > complex solution, but also a much more correct one, not having issues
> > with correctly defining what a server is (which is not a solvable
> > problem).
>
> Is this the solution that was removed at some point from fuse,
> or are you talking about something else?
>
> I think you are talking about adding a set of fuse specific locks
> so fuse does not need to rely on the vfs locks.  I don't quite have
> enough insight to see that bigger problem so if you can expand in more
> detail I would appreciate it.

Okay, so the problem with making the wait_event() at the end of
request_wait_answer() killable is that it would allow compromising the
server's integrity by unlocking the VFS level lock (which protects the
fs) while the server hasn't yet finished the request.

The way this would be solvable is to add a fuse level lock for each
VFS level lock.   That lock would be taken before the request is sent
to userspace and would be released when the answer is received.
Normally there would be zero contention on these shadow locks, but if
a request is forcibly killed, then the VFS lock is released and the
shadow lock now protects the filesystem.

This wouldn't solve the case where a fuse fs is deadlocked on a VFS
lock (e.g. task B), but would allow tasks blocked directly on a fuse
filesystem to be killed (e.g. task A or C, both of which would unwind
the deadlock).

Thanks,
Miklos
