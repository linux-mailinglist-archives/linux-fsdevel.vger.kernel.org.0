Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB27A1A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfG3HMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 03:12:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46087 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfG3HMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:12:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so61977774qtn.13;
        Tue, 30 Jul 2019 00:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JR6rIq7i3T4m22hMN9xlWoNn6AwKQHA1u/FXd7l8LjY=;
        b=V3hWleR57E++no1HTUHeeB0kd4F4lCE70TXFSj7eqhJaVR+mQr1XW3cVV67CUz6jkK
         yeaFR9ifAwrTaKIX8wLZTHU+iGEN8BUF49yHLnf4mIJc9soVS+Xsrx70Eag/ld7+amyD
         oKpRmKPAME2jcBDeCDbfGL9FtAgmCQ2u056rJSCfQ99ff/z8QWy4ukYkuflEBoQFnHjL
         zVvDA1l5p5s2EPi04B7l/1AtCbU76EQ8Sos/1pleNK9C+M83DNYTKdNxzlX/2Pue4IGa
         wD9Jsp1O/9UgSynCoCPBK3P74NRX8ugcmKOgkZfaK4bgnMznX9Zb28YRBQ3xmCYZuYYr
         ceIg==
X-Gm-Message-State: APjAAAUV/fP1Ym3cYORRMEVkddu0hMM3lyn4fll1x3T6eCJGPPISWFm8
        0iE5AqW+TBbp3t5hvX4n+x5cfIIaIa0luCPMoI5cQAQsRzQ=
X-Google-Smtp-Source: APXvYqxsyCN2D5CCgTkLcthivbJ4WOTUous4iUpRFXdxYWUPuQ4EZKVPPsMc2c0vVxRxvWndvcgZa6lxBIeMSx0ffjw=
X-Received: by 2002:aed:3363:: with SMTP id u90mr80015452qtd.7.1564470728332;
 Tue, 30 Jul 2019 00:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <1564451504-27906-1-git-send-email-yi.zhang@huawei.com>
In-Reply-To: <1564451504-27906-1-git-send-email-yi.zhang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 09:11:49 +0200
Message-ID: <CAK8P3a233_UbX4roe-1Zr7d+3tn9me6hnBoqXsZcLToE_s_dag@mail.gmail.com>
Subject: Re: [PATCH v2] aio: add timeout validity check for io_[p]getevents
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-aio <linux-aio@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:46 AM zhangyi (F) <yi.zhang@huawei.com> wrote:

>  {
> -       ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
> -       struct kioctx *ioctx = lookup_ioctx(ctx_id);
> +       ktime_t until = KTIME_MAX;
> +       struct kioctx *ioctx = NULL;
>         long ret = -EINVAL;
>
> +       if (ts) {
> +               if (!timespec64_valid(ts))
> +                       return ret;
> +               until = timespec64_to_ktime(*ts);
> +       }

The man page should probably get updated as well to reflect that this
will now return -EINVAL for a negative timeout or malformed
nanoseconds.

      Arnd
