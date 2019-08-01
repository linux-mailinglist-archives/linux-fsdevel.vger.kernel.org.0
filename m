Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE47D971
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfHAKfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 06:35:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37435 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfHAKfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:35:15 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so23396037iog.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF0do9wY3cyTRjOGDYpGmka2aPziK/+CZ1VE8F7DUC8=;
        b=TenVpUmM6bUvbexacfk8sJuh56uipvsMM7q+VxUe4DOkUPtEq5koFfaUOR7qA0FfWn
         EcT4YoOE6QFL/YfxbO1LnjjdwJz05Nq3KdpwW9H3TwROFJM31myL+qjzXZrMmlz7GWHv
         kWikwnNZcRuYgeTxVtM9ntxnThgbwZ4m2FmVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF0do9wY3cyTRjOGDYpGmka2aPziK/+CZ1VE8F7DUC8=;
        b=pvYV2boPiK7cTjHLQfKaF31JP6eDuWMI1kWHPXOXXG+O7nPyMbIovnwys85PQWmpdH
         1QSg6aU411qpyttk5Vc6JBHM1t7yeyQCFqNNkVSqildMwPBVoUb1K2PU7Lx3i9tiwf51
         f2dxoYG9lkv8pR1Ps3GIaG2dRomtlL56VcZh+Hs/TPspeOFcNJniRJYUCyDFkKapgEKx
         wQ7IATGUnPyQ/mVrhqha21F4Cq5XVlGHd9JXEUCKYrbjvB11UOKp25jXZeK3RgtzygFG
         OV2BQTR45noJKrbipKUxm48EDp9KEWjU276JOKmAxQPmjbbvRd4/D8n82lMdKv+OrBNY
         WD7g==
X-Gm-Message-State: APjAAAU0IgYJUtWm+RZZeaXXJZT/IFfpHObcspAh30P7rSWr3CGllSG6
        /M4X8P2d6IwfLvAVSs7GOLpMrUvQKDSBs5RSnso=
X-Google-Smtp-Source: APXvYqxj0yaxuEmTXKenSnXaY/8xd4RXWC9zZFQtW0TVFTjoaY1r4goJ0orqWVClOITHQZ7OVVV7sUBj8YCoLSgOZIE=
X-Received: by 2002:a6b:ba88:: with SMTP id k130mr2923170iof.212.1564655714393;
 Thu, 01 Aug 2019 03:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190724094556.GA19383@deco.navytux.spb.ru>
In-Reply-To: <20190724094556.GA19383@deco.navytux.spb.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Aug 2019 12:35:03 +0200
Message-ID: <CAJfpegscn7B+TrD5hckXkpHEb_62m6O9-kFOOehWyC89CPFunw@mail.gmail.com>
Subject: Re: [PATCH, RESEND3] fuse: require /dev/fuse reads to have enough
 buffer capacity (take 2)
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, gluster-devel@gluster.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:46 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Miklos,
>
> I was sending this patch for ~1.5 month without any feedback from you[1,2,3].
> The patch was tested by Sander Eikelenboom (original GlusterFS problem
> reporter)[4], and you said that it will be ok to retry for next
> cycle[5]. I was hoping for this patch to be picked up for 5.3 and queued
> to Linus's tree, but in despite several resends from me (the same patch;
> just reminders) nothing is happening. v5.3-rc1 came out on last Sunday,
> which, in my understanding, denotes the close of 5.3 merge window. What
> is going on? Could you please pick up the patch and handle it?

Applied.

Thanks,
Miklos
