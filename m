Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578A3A88CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfIDO3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 10:29:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46048 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfIDO3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:29:15 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so27134062iog.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2019 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86LLseH/t09g4NPnOuPe4jSXsf4yEGfetaMdrOp9+RM=;
        b=Tjv0OcYMRCSImG27PgxeYJD0ZBCaXOwtnomOLj1jdVZtBarve9VCP2d7er8DqKlAMh
         Ndh+ZhoJwGwJeGREJ22Uqdbc85mnVioVYqrp17wu1AluZWZuNcFY3+Hoa1TQIVLGjIgG
         CcBg1IsCi8FMqljIdXjfdQZkbcUoB6YQEYbAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86LLseH/t09g4NPnOuPe4jSXsf4yEGfetaMdrOp9+RM=;
        b=IV2xDlmdq4KwTcdzAYq8ZblGCZddZQ0b0eq4cSJaX9kYrKNlT9RN8xX7Y+6xZpWR80
         9pm3FL6CO6HwSdyAFtbj0WguUWI1QqDUV1h1xA64Jb+GKV/KXG+FAMBXu8j6vYEXaRpF
         DA5dPCvUAcgO7kHf7SrEyW4MPS1AHrUqiDLJ4PWYUDerEPyRw7mWcOEkS5HmMdXnqnZw
         iRQqDrHQuzxlEgopVZSF9AvETaH2rttqQUjK7ztK+/KFXtPUoMF4xAk+Ij+NynejwbNo
         4GVKXNcSG5/gXkP5lJpsGXwNWA9CTWkeS7CfvtXO0SpD5+XhqMTHL0u8zWO+pBKj1tUl
         8r9A==
X-Gm-Message-State: APjAAAVFgofLJ4OKaCsg4kg+r8uqE+o0DdvMWRyX1NknsCL5njLPhdQH
        YH7SocLhC1AzJOESWFPcyJF0x88YeYrUwTLrMH9gIeiA
X-Google-Smtp-Source: APXvYqx3Ha9D6n/Vktk91NeREgHLVCn3Ymh/BQUNUrX9uIYCqkuLIbgstgCc+hRqlMhKLJRazrmnOQl4UCf6G7kvL1Y=
X-Received: by 2002:a05:6602:24ca:: with SMTP id h10mr18428791ioe.63.1567607354499;
 Wed, 04 Sep 2019 07:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008d8eac05906691ac@google.com> <20190822233529.4176-1-ebiggers@kernel.org>
 <CAJfpegvHgcZGFi-Ydyo2j89zQxqAtZ1Lh0+vC6vWeU-aEFZkYQ@mail.gmail.com> <20190903133910.GA5144@zzz.localdomain>
In-Reply-To: <20190903133910.GA5144@zzz.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Sep 2019 16:29:03 +0200
Message-ID: <CAJfpegtrkxAYq4_rXVNEhe=6SFCfXGgpNVtaiuyfSdh+kthazA@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable irqs for fuse_iqueue::waitq.lock
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio <linux-aio@kvack.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 3, 2019 at 3:39 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Sep 03, 2019 at 09:31:29AM +0200, Miklos Szeredi wrote:
> > On Fri, Aug 23, 2019 at 1:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > When IOCB_CMD_POLL is used on the FUSE device, aio_poll() disables IRQs
> > > and takes kioctx::ctx_lock, then fuse_iqueue::waitq.lock.
> >
> > Not in -linus.
> >
> > Which tree was this reproduced with?
> >
> > Thanks,
> > Miklos
>
> Linus's tree.  Here's the full symbolized output on v5.3-rc7:

Okay.

TBH, I find the fix disgusting. It's confusing to sprinke code that
has absolutely nothing to do with interrupts with spin_lock_irq()
calls.

I think the lock/unlock calls should at least be done with a helper
with a comment explaining why disabling interrupts is needed (though I
have not managed to understand why aio needs to actually mess with the
waitq lock...)

Probably a better fix would be to just use a separate spinlock to
avoid the need to disable interrupts in cases where it's not
necessary.

Thanks,
Miklos
