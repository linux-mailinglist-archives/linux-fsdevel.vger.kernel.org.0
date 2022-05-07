Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D051E5BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbiEGIzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 04:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiEGIzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 04:55:15 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E23F325
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 01:51:30 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ec42eae76bso102519187b3.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFH4kYV82gQV4fQ5y42PvDRv0zFNZF59BW0f/xZ+SYk=;
        b=EJilAcPwp6zXSgtrGqaWvnX3Z22lmbwiDlFnLKDoZ+dMvIZFBQK6liggfwfNWTRV+h
         BWbOPTZ5P51i/EzW3XItanqbMPuDIuKzkuE6rL/XNsvHmKh+0Nl+1FwLG8hQnu3fCLEo
         r4SLs5mdhASUS09joQFWeBdMJ7tq5excuoqMkq3vN+6dzg4A79TTUTFrLKGV7sbFFsIa
         4jYUBiLQ6q14/4BeX+TYvv/nfa9gI2Iu71wLNlIcQ/hBJrm28Ni9ge0rAimufVBal1vX
         WdIIJsiXYF2KkMldu+Sr2nncSEHp7mZ1jjUy/A6wMph/PwIF9VhegFKM0NbXak2uI4TM
         G4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFH4kYV82gQV4fQ5y42PvDRv0zFNZF59BW0f/xZ+SYk=;
        b=tj7a3p4cDihomGQ4f171pIJagPqtA30IkPKfDbjWf6+8tmRcybWhFOSBEJVJEy894Z
         3zScmCamm8n62n1iq8ri769oD38kS2HHaUPjFWHtZ+0lzMT7NdogRqHA5jzhqynBwU/Y
         NyaXloT8zF+iWitJ5/Rqy09pUpvZS2kDpUo2a4f8oCLPuaJYHVTasoQFweHlsb9ptKc0
         ilYY76zAhjEMuv9S/rQETdL30+Zl1Su8ugfoac7UPnG71YzM6ide49D4EjMOMfi5YkYo
         JCQIK0zWYxtQmWDO/3AtCqJm3aDlq/Z4ZpBZs+sEX5SsDoXeTZsNiFmVW0BJpSOkwmzK
         9yoQ==
X-Gm-Message-State: AOAM5323SNHjELsyIypK9pBIY2lo2BsRENu3+T5H2+Lpyw6WpqsKZhWG
        MLKtXWfAQS/jRsoNg2tABwWopiLiMm3w+iPv38I5oI8KtqY=
X-Google-Smtp-Source: ABdhPJy2n+G+KVLZiLa+ZDKS2RVLaKfakxi3me2v4PmjS27u55fD8wo/YIOlbYaF2qPmexBrDBxAd+3IPZm8Qjx8nJo=
X-Received: by 2002:a81:7109:0:b0:2f8:1542:cca5 with SMTP id
 m9-20020a817109000000b002f81542cca5mr5834954ywc.506.1651913489277; Sat, 07
 May 2022 01:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220507041033.9588-1-lchen@localhost.localdomain> <20220507042829.GN1949718@dread.disaster.area>
In-Reply-To: <20220507042829.GN1949718@dread.disaster.area>
From:   Liang Chen <liangchen.linux@gmail.com>
Date:   Sat, 7 May 2022 16:51:17 +0800
Message-ID: <CAKhg4tKFhc4UL-Ag2edT3yOWt=+W5MzoQJAAMFLG27Vce_rCTg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Fix page cache inconsistency when mixing buffered
 and AIO DIO for bdev
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, jmoyer@redhat.com,
        jack@suse.cz, lczerner@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 7, 2022 at 12:28 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, May 07, 2022 at 12:10:33PM +0800, Liang Chen wrote:
> > From: Liang Chen <liangchen.linux@gmail.com>
> >
> > As pointed out in commit 332391a, mixing buffered reads and asynchronous
> > direct writes risks ending up with a situation where stale data is left
> > in page cache while new data is already written to disk. The same problem
> > hits block dev fs too. A similar approach needs to be taken here.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> > V2: declare blkdev_sb_init_dio_done_wq static
> > ---
> >  block/fops.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
>
> Rather than copying functionality from the two other generic DIO
> paths (which we really want to get down to 1!) into this cut down,
> less functional DIO path, shouldn't we be spending the effort to
> convert the blkdev device to use one of the other generic DIO paths
> that already solves this problem and likely gets a lot more test
> coverage?

Yeah, that would be better for sure. In fact I just realized the patch
introduces
a performance drawback compared to the two other DIO paths. Making use of
the well tested code path would avoid such a mistake. I will take a look on
converting blkdev device to use __blockdev_direct_IO (seems requiring less
effort).
