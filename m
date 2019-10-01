Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D1C39A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbfJAP6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 11:58:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37738 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfJAP6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:58:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so22249698qtr.4;
        Tue, 01 Oct 2019 08:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOSJCMXkn6+n8RHqpUdKI466CjMeIh5mDOaAgCCmVlg=;
        b=loI2JWR5h5tZIOWBn0DgIw42qDFg7O+mKC6pn7BgO+rP/1pJc57bJEKQf7p7UTi5sU
         qMOSeXvnRi0NEl1BXjtYRsWkPUxDampw0o0/F2dlpDkudngz4pgVsRw6V3JHGnfLPOeX
         dVHDlE3aNgQXDjop8kCd44C2hD2kzfy0/G7gbfshX01K2gugBcB5cVwWUQAtzyVd+9qc
         CKPwy0WnkDd6jyC0IpyK1N/CZttDfs6gG4fTyusRDKtTS7IuSlF61Q0x0uTGQfOkpTVC
         jtjnFgeCwT0aEYSDvGyZfRfYxl8p+htQSX1pD6+LTgpoTwA8qrh16sB/b8DbSJuZlxlu
         zr2w==
X-Gm-Message-State: APjAAAWAMafiW0ZHmntpM+0OTcKT5htfiUltnCJRTBb9bIjtgICkl0cR
        5nfMOTz4LfEo0vmPgI8UJCJztkX/5A1S7RruBms=
X-Google-Smtp-Source: APXvYqxDQhvqeIreS0WTIiG2aM/W3oAbsLqBVTy4w3yhOpMo0LHRRJJRgTxpU/lGmDQuUe1Zu70sAjxTPS5wJsH3rvk=
X-Received: by 2002:a0c:d084:: with SMTP id z4mr25699088qvg.63.1569945479216;
 Tue, 01 Oct 2019 08:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190930202055.1748710-1-arnd@arndb.de> <8d5d34da-e1f0-1ab5-461e-f3145e52c48a@kernel.dk>
 <623e1d27-d3b1-3241-bfd4-eb94ce70da14@kernel.dk> <CAK8P3a3AAFXNmpQwuirzM+jgEQGj9tMC_5oaSs4CfiEVGmTkZg@mail.gmail.com>
 <ca0a5bbe-c20e-d5be-110e-942c604ad2d7@kernel.dk>
In-Reply-To: <ca0a5bbe-c20e-d5be-110e-942c604ad2d7@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 17:57:42 +0200
Message-ID: <CAK8P3a19TDk0uo1eu4CcaKHvQCPUJGMjBV8Txtpgvg1ifAgW_A@mail.gmail.com>
Subject: Re: [PATCH] io_uring: use __kernel_timespec in timeout ABI
To:     Jens Axboe <axboe@kernel.dk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Stefan_B=C3=BChler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:52 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 10/1/19 9:49 AM, Arnd Bergmann wrote:
> > On Tue, Oct 1, 2019 at 5:38 PM Jens Axboe <axboe@kernel.dk> wrote:

> > What's wrong with using __kernel_timespec? Just the name?
> > I suppose liburing could add a macro to give it a different name
> > for its users.
>
> Just that it seems I need to make it available through liburing on
> systems that don't have it yet. Not a big deal, though.

Ah, right. I t would not cover the case of building against kernel
headers earlier than linux-5.1 but running on a 5.4+ kernel.

I assumed that that you would require new kernel headers anyway,
but if you have a copy of the io_uring header, that is not necessary.

> One thing that struck me about this approach - we then lose the ability to
> differentiate between "don't want a timed timeout" with ts == NULL, vs
> tv_sec and tv_nsec both being 0.

You could always define a special constant such as
'#define IO_URING_TIMEOUT_NEVER -1ull' if you want to
support for 'never wait if it's not already done' and 'wait indefinitely'.

> I think I'll stuck with that you had and just use __kernel_timespec in
> liburing.

Ok.

       Arnd
