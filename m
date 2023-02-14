Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C639E69683E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 16:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBNPjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBNPjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:39:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1A62943B
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 07:39:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eq11so17975603edb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 07:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZmPo9Q6Z4RUvjG621OuZzJYIrsFcDWjerwh051FXoA=;
        b=FAZSGVM05LiY4aBSpZ5WadxilW/R17zFfxlNey9X70rWvVUa3MG9VyAKd8htvJEXnC
         wooRzSazMoXgO15zXzpSBVYlNPU8O7UVynukN5MqkrpiRmvAso7+Y+0dBcDZTsksGwzz
         4mt/KJrc3UWd/KnLPbAbYCAVmbppctdW70IPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZmPo9Q6Z4RUvjG621OuZzJYIrsFcDWjerwh051FXoA=;
        b=wOP3Ab9jaFBaHVZVcbZFrF5UP/S/KYRdWqoCUgiIpQDy5hpamaSbnVzd9N8+qsEq1W
         Jm/lEDIaLWLYpLHn6sXBa5LpcNK+7UJ8/+6L+Q2vQLcE/94aVJXJskUIEgaUi8vZq/eo
         rBuOyqVw3V1JqWMBSwB9FI4vYz0r+0Bju40CCNwRWUcQ3/fjXjRs3xWwdgulVlqn6wEZ
         9IMD/HdGYZ667aglZDeauZneqvL2+xiTCokbf6FCWxBsnns4jU55XRm7t/9JDeMG7+Fm
         K5gaiSQI/a1xKyEGLXDq3Zesy/rq0sj45M/8F9KhHwz6swlg6+lKjrirDkudM7+8cloo
         85HA==
X-Gm-Message-State: AO0yUKW7a1yRhM6oe674bFO0owVWhpz4WSOygGhNxl0WA0r2nbECJU06
        HomUp02cGeFaL7gcq5l0Y+O58ZVnJLFIhhi8BpreQg==
X-Google-Smtp-Source: AK7set+LFMwnBwC1msVbCl4zOk4kMAfWh+Y8EdW51624/1+QCBEmVGc3gYPzRWOo9U81Q8EYcBz3QTdfSUKg/pIn3fw=
X-Received: by 2002:a50:d656:0:b0:4ab:4b7d:5f76 with SMTP id
 c22-20020a50d656000000b004ab4b7d5f76mr1404574edj.8.1676389152127; Tue, 14 Feb
 2023 07:39:12 -0800 (PST)
MIME-Version: 1.0
References: <20230210153212.733006-1-ming.lei@redhat.com> <20230210153212.733006-2-ming.lei@redhat.com>
 <Y+e3b+Myg/30hlYk@T590> <CAHk-=wgTzLjvhzx-XGkgEQmXH6t=8OTFdQyhDgafGdC2n5gOfg@mail.gmail.com>
 <Y+hDQ1vL6AMFri1E@T590> <CAHk-=wgJsi7t7YYpuo6ewXGnHz2nmj67iWR6KPGoz5TBu34mWQ@mail.gmail.com>
 <CAJfpegtOetw46DvR1PeuX5L9-fe7Qk75mq5L4tGwpS_wuEz=1g@mail.gmail.com> <Y+ucLFG/ap8uqwPG@T590>
In-Reply-To: <Y+ucLFG/ap8uqwPG@T590>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Feb 2023 16:39:01 +0100
Message-ID: <CAJfpeguGayE2fS2m9U7=Up4Eqa_89oTeR4xW-WbcfjJBRaYqHA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/splice: enhance direct pipe & splice for moving
 pages in kernel
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Feb 2023 at 15:35, Ming Lei <ming.lei@redhat.com> wrote:

> I understand it isn't one issue from block device driver viewpoint at
> least, since the WRITE to buffer in sink end can be thought as DMA
> to buffer from device, and it is the upper layer(FS)'s responsibility
> for updating page flag. And block driver needn't to handle page
> status update.

The block device still needs to know when the DMA is finished, right?

Thanks,
Miklos
