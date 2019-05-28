Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD92C789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfE1NMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 09:12:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50591 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1NMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 09:12:40 -0400
Received: by mail-it1-f193.google.com with SMTP id a186so4246686itg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2019 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PBWVpvs5zsVPksdRd82VhWoZuAjjPAZwTYUziFX9L0=;
        b=N69BTVSC6YnymeRCK9lb7AvPzOIjo75EyxRxEAL4HXHueFN03hlkFeg/CWSfNOH8n1
         lXcBIPtrZr8vEN+dQXwD/pI2Myqgp7VsiouEb79ifTCryZCTa9sRO+AvLSNwG4CwI7Ru
         Gl7HvVZZU/XPn5rpxcwOgr6T1sckqA91GYmjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PBWVpvs5zsVPksdRd82VhWoZuAjjPAZwTYUziFX9L0=;
        b=JMcXyBs9cjs0RZF7v+l6/R+/l05j4ndJeTao8Owf/RAT/zslMsfxPQxO1Oba1KnNyE
         kYFH5abIfn6naelkDq0HBT46wa3BxregBxW97tYziuob31SRkw1kTQ+Y49A927la0ltj
         jqtqlka85RqvzK+l/fZUQDyKXgJE1CB34rFrg/6l3NN8nmdm7aY6CnnitCkyQRllfH8k
         EjmOz99AztDlg5anBtwdcFwmXATdopn1wT6VsKHnJmvTD6H3T6MjZSMkyFKsAL5QmW9L
         kmYihvHsZRbIknxXy6Bx22QfnnJPUVSW2HlbZivmRCxCYjluKN2hUnOVFhcWEf5cS8Au
         /83w==
X-Gm-Message-State: APjAAAWbfa1ziNR1fIvTxpaMnoJF5khdB2c0F6mPc8vH4wDPdfjgNIm1
        Z5L+fhURXGWQ5+Ka9MBf+yriWsLT67zFiV53iJ77tg==
X-Google-Smtp-Source: APXvYqybI445wT/dpv9HVNdOXgU5rVwu/tu9Ysr4Dg2+TRmgkEUvNjd8Wse1lnB0uAcP4+8qf2I6ygYxfptUrv7pFHg=
X-Received: by 2002:a24:4dd4:: with SMTP id l203mr2622243itb.118.1559049159427;
 Tue, 28 May 2019 06:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <1546163027.3036.2.camel@domdv.de> <CAJfpegvBvY2hLUc010hgi3JwWPyvT1CK1X2GD3qUe-dBDtoBbA@mail.gmail.com>
 <388f911ccba16dee350bb2534b67d601b44f3a92.camel@domdv.de>
In-Reply-To: <388f911ccba16dee350bb2534b67d601b44f3a92.camel@domdv.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 28 May 2019 15:12:28 +0200
Message-ID: <CAJfpegtQ11yRhg3+h+dCJ_juc6KGKBLLwB_Vco8+KDACpBmY5w@mail.gmail.com>
Subject: Re: [PATCH] Fix cuse ENOMEM ioctl breakage in 4.20.0
To:     Andreas Steinmetz <ast@domdv.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 3:58 PM Andreas Steinmetz <ast@domdv.de> wrote:

> > On Sun, Dec 30, 2018 at 10:52 AM Andreas Steinmetz <ast@domdv.de> wrote:
> > > This must have happened somewhen after 4.17.2 and I did find it in
> > > 4.20.0:
> > >
> > > cuse_process_init_reply() doesn't initialize fc->max_pages and thus all
> > > cuse bases ioctls fail with ENOMEM.
> > >
> > > Patch which fixes this is attached.
> >
> > Thanks.  Pushed a slightly different patch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=for-next&id=666a40e87038221d45d47aa160b26410fd67c1d2
> >

> It got broken again, ENONEM.
> I do presume that commit 5da784cce4308ae10a79e3c8c41b13fb9568e4e0 is the
> culprit. Could you please fix this and, please, could somebody do a cuse
> regression test after changes to fuse?

Hi,

Can you please tell us which kernel is broken?

Thanks,
Miklos

>
> On Mon, 2019-01-14 at 10:58 +0100, Miklos Szeredi wrote:
