Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3AC351452
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhDALLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhDALLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:11:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD417C0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 04:11:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so2297937ejs.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7Ks/Z1/15BVenCmAbBTO0uUaD3ULivGFXWIuCr3cbw=;
        b=jcMeG3dJTx++QQlbtOVZAFV7IHCOPQaPwnTZN1xmnNftwZfA9Y1X053DR0bnHc3zaH
         xjNDaRhPr5OfRPxeDC9qD++q0YceSuj/8hMA2iUDzXVP+Wy9t3n2FDh9BzN87yF30ida
         2gW31J/vIrPmtsTKoX4MFbmwGE6NqWp8xiZ6Wapl9iOVSi7Mrg6IJOXM6qICDwDoTwyb
         7ivhYZEjZWNXVeS8+Rlsxavczk1Wt1chpTfEFuMMuzsmGX9Wuxz09cAXuMPRsrWXm9Jo
         olZ26jQ5QAu77yZZxk2Yx7Vjxk6POO0wTB5eDWjXgL6ayNMq3JhvUZaj9hgI5u+wufec
         FtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7Ks/Z1/15BVenCmAbBTO0uUaD3ULivGFXWIuCr3cbw=;
        b=eR3cQH9GpWjhl3EqFjHpJU9EFqOFDiwnhqMuvzOd5FkzB2PIauInidH3qw6XfUPrl9
         u2gqcnF7WTZ1BUriz10CwJj8viIjAHjaUdmsmJH/YzBMh+8lpGK8k8urv0yOjpWcp/fe
         Fi7q2mQQPmj2BEY1BbsU5AflDHx9tmepF2sGrCcMfpeZgZKqOBvrsbgBhebXxMLoEG0x
         ywMrt39OCFbrkAiaN4NqGM5sZ/uFjw3k/sOlSPmhCDdMi2rsNvcjjKRvPjmdQ186dcdo
         x648Dz7S1p/NEKvMbNNJNIAZoj1cQE3VwVuK9AR5Nvr41ydjdNeajaqlO3T3H51GkhoS
         QsgA==
X-Gm-Message-State: AOAM532Pq2WUzvRDxLCbn8MWAJVKnxKMHocel6rpDY1enZTghqqRjH7b
        lWBj5/9xZ+iBp1YfAhmr5hXLylLjFxT9EpialHQj
X-Google-Smtp-Source: ABdhPJzYPJj8TMVxBnPcoH06lXyByIvGxOspPt79banZ7a9arHvTkwRZZo0qeXOdE4SXbpvj1d7OcmSB0jjbGdjEBTw=
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr8549413eje.247.1617275498569;
 Thu, 01 Apr 2021 04:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210401090932.121-1-xieyongji@bytedance.com> <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com> <20210401104034.52qaaoea27htkpbh@wittgenstein>
In-Reply-To: <20210401104034.52qaaoea27htkpbh@wittgenstein>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 1 Apr 2021 19:11:27 +0800
Message-ID: <CACycT3v3b7sfswm5Og9Pk-Q=FTD_RabTudv3TkHqo8fdSQvsXA@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        hridya@google.com, surenb@google.com, viro@zeniv.linux.org.uk,
        sargun@sargun.me, keescook@chromium.org,
        Jason Wang <jasowang@redhat.com>, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 6:40 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Apr 01, 2021 at 11:54:45AM +0200, Greg KH wrote:
> > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > Use receive_fd() to receive file from another process instead of
> > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > the logic and also makes sure we don't miss any security stuff.
> >
> > But no logic is simplified here, and nothing is "missed", so I do not
> > understand this change at all.
> >
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/android/binder.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index c119736ca56a..080bcab7d632 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -3728,7 +3728,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
> > >     int ret = 0;
> > >
> > >     list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
> > > -           int fd = get_unused_fd_flags(O_CLOEXEC);
> > > +           int fd  = receive_fd(fixup->file, O_CLOEXEC);
> >
> > Why 2 spaces?
> >
> > >
> > >             if (fd < 0) {
> > >                     binder_debug(BINDER_DEBUG_TRANSACTION,
> > > @@ -3741,7 +3741,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
> > >                          "fd fixup txn %d fd %d\n",
> > >                          t->debug_id, fd);
> > >             trace_binder_transaction_fd_recv(t, fd, fixup->offset);
> > > -           fd_install(fd, fixup->file);
> > > +           fput(fixup->file);
> >
> > Are you sure this is the same???
> >
> > I d onot understand the need for this change at all, what is wrong with
> > the existing code here?
>
> I suggested something like this.
> Some time back we added receive_fd() for seccomp and SCM_RIGHTS to have
> a unified way of installing file descriptors including taking care of
> handling sockets and running security hooks. The helper also encompasses
> the whole get_unused_fd() + fd_install dance.
> My suggestion was to look at all the places were we currently open-code
> this in drivers/:
>

Sorry for not following your suggestion. Yes, I looked at those
places. But I found that we will add security_file_receive()
implicitly if we replace get_unused_fd() + fd_install() with
receive_fd() for most drivers. Not sure if there will be some
regression. So I only do that where I think security_file_receive() is
needed, that is this patch. Although it looks like this is not a good
idea now...

Thanks,
Yongji
