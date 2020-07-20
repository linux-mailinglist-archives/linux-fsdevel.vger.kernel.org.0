Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE0225DFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 13:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGTL6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTL6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:58:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993AEC061794;
        Mon, 20 Jul 2020 04:58:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u64so1671314qka.12;
        Mon, 20 Jul 2020 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyadEz0eZwOz4veMiu/99Xwk84Lj2bAOI1P6STGAbTM=;
        b=pzO5UY59E2I78nkbHVVchIb8xSq5dpsUcOpNS7Gkxof5sNSjCEODEhGzsvVVjAfJyl
         VSwzSp6U1Zs9krrRKUF/u2Bk2AkyMb7A4vyZNN5lBySozBpWv75kuuSymSQ75I0lOQIq
         /aNfumnu9UNKeQqzNIgsFnNCRnWlLEXCl5HKsdcBqoLY2AX4WupdTDUkutMtkReFDd/p
         7rLcMb8CsQvVO2aMkGCvC0cISIr9opF8PILSUSavYLWpTTSmyGJ8atrT4DsGICF1czPS
         GjukeM8re+7Is53uuqLc1gz9fVVpsyasqxmhyXdVNJb4jwNSaNcNEMbvPaz5r/mI8alC
         KLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyadEz0eZwOz4veMiu/99Xwk84Lj2bAOI1P6STGAbTM=;
        b=Y4CledokJc6GI0n6XJUpXO1Iy42iDV40Vm+i5Wi3eBacq6KYNoq2KmB/n0j0qQjhPG
         WdxK8emySDybueGcv3LByUrKFevz9aAbJ/3IxzNipfzWfhxsTq/T+SksofUineYlu54L
         Pslw2GWv1VqlEgN8FK37XazhuIGKVOy3u8npCkdODWcOyRdUKdXTnbwOYSUi/XirioQc
         CzZe6vlB7aGJ4VWVbqEx9odqL4KpN3xZuv/zoqIftUimPxwH5jVOE+UwVbL1WH5Ww6ls
         zQ9ZAj3mgWe6KuuupeV7V71IxbsiZCbsC/+GL4NsejI1C0mo7PbieQGG3ElJeq22e8h1
         Psgw==
X-Gm-Message-State: AOAM532q4BcFDn1SQcD5gmDldO30sN4yaHsco2aHqOARwywJsH+20skt
        49xWIm1A2aRCQiYZixu2lANPEEGq6GbwUMqIGsw=
X-Google-Smtp-Source: ABdhPJxZvpi5p/rGIGspu/X0VuST2fAly2yyAucRwLGlbJciYxHfYOGN4y9O3LRxtfeMHSSpDlexGGV5rTPgQNTp1kc=
X-Received: by 2002:a37:9147:: with SMTP id t68mr20753351qkd.34.1595246313907;
 Mon, 20 Jul 2020 04:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200720075148.172156-1-hch@lst.de> <20200720075148.172156-5-hch@lst.de>
In-Reply-To: <20200720075148.172156-5-hch@lst.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 20 Jul 2020 13:58:22 +0200
Message-ID: <CAFLxGvxNHGEOrj6nKTtDeiU+Rx4xv_6asjSQYcFWXhk5m=1cBA@mail.gmail.com>
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        device-mapper development <dm-devel@redhat.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, cgroups mailinglist <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Chrstoph,

On Mon, Jul 20, 2020 at 9:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Set up a readahead size by default.  This changes behavior for mtd,
> ubifs, and vboxsf to actually enabled readahead, the lack of which
> very much looks like an oversight.

UBIFS doesn't enable readahead on purpose, please see:
http://www.linux-mtd.infradead.org/doc/ubifs.html#L_readahead

-- 
Thanks,
//richard
