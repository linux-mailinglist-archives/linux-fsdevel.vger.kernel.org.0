Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3B4386C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfFMPFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:05:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40282 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbfFMON2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:13:28 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so17181076ioc.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehkJYWC1p94ZapNpY1eAcwZHNv2DdSb1jRkL6CQmSXc=;
        b=XzV9xpChVBAa9jqtcQ66PwrzgArnW79YoNikn4QKmOORtfYCNARNhku1YV8k8pRd0+
         TpBceZrFLMj5ZWbnm89SpTimND8ZZ/i1NpGKPvDFFV7+kY5PhvA3deJRh1t1MviBz8d6
         2WgvYrKsRmPboQ59Dsf3w67lwDKzEGbhgPQXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehkJYWC1p94ZapNpY1eAcwZHNv2DdSb1jRkL6CQmSXc=;
        b=t4keGdVRDsIq05MrDHv6B3RYK8uzBPg9rsy5WsKX+1jT6+0ad/3sNIX9fl7o18rysu
         xbOlsAS+2IVHoQLUi1kpD7apRJ+GibmfcITv9MGEdPRsb0Hf6lkyMPnDBqqUO6wC/dm1
         jnKT8BYovhv/5PATjtH74+Be2zhNpwlCHh6IIXhxVT/mw/C5ieweh/maqAJ0ScsBvYHr
         saNUw+VhuIgunN2LLelrbSoS3Q/5fIqxh9wnxa8fKwhGppH9QyLO1L/Kbn7XIp4tHSu0
         0opa9UbgYR3Uurbo76IoiPFsulCviUNlp/Wpju2f6rgyBwzJKXhiP/JfFTr9kK0+dk70
         jwzA==
X-Gm-Message-State: APjAAAUc/x54BgqR0hHWlbKXRo4zOESNLj1Ej1RUjBD3EoLTNzTcW/nh
        n5ILivPo76v7xvQ/wQLkwioaIFq2L2Cc6SgMHBxMTQ==
X-Google-Smtp-Source: APXvYqy6WRYvdHLq+gy5VPmn46gTLcUDrorQB67zOqyoIHFBd6FWkOmz9cXztOtlGThbC8W7OtdrbIjOIR3xeRUcdgc=
X-Received: by 2002:a5e:8618:: with SMTP id z24mr54385645ioj.174.1560435207415;
 Thu, 13 Jun 2019 07:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190612172408.22671-1-amir73il@gmail.com> <20190612183156.GA27576@fieldses.org>
In-Reply-To: <20190612183156.GA27576@fieldses.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Jun 2019 16:13:15 +0200
Message-ID: <CAJfpegvj0NHQrPcHFd=b47M-uz2CY6Hnamk_dJvcrUtwW65xBw@mail.gmail.com>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write lease
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 8:31 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> How do opens for execute work?  I guess they create a struct file with
> FMODE_EXEC and FMODE_RDONLY set and they decrement i_writecount.  Do
> they also increment i_readcount?  Reading do_open_execat and alloc_file,
> looks like it does, so, good, they should conflict with write leases,
> which sounds right.

Right, but then why this:

> > +     /* Eliminate deny writes from actual writers count */
> > +     if (wcount < 0)
> > +             wcount = 0;

It's basically a no-op, as you say.  And it doesn't make any sense
logically, since denying writes *should* deny write leases as well...

Thanks,
Miklos
