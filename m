Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA4403671
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbhIHI5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348212AbhIHI5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:57:50 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C0C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 01:56:43 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id p14so1377731vsm.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhNWqgJd04pkj6y98xtQ9IKquD+6bk2am8RX8AV3lRs=;
        b=EaQyi5DuFSdJfn3K6WJlgaLY2u4If+bVOKw8DGveYMJtwx1wqLirl/OktzudueVTxt
         WwB5yVTazqwUwTbuHchrCR8UuRkDycqND/BrKtGFa1HwWtwruTuhAXyRelRfiL7QncKo
         pQ/xVBv73Bho4TtdwEAKz+w1Xts/ihCgpbT7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhNWqgJd04pkj6y98xtQ9IKquD+6bk2am8RX8AV3lRs=;
        b=LK5Cp40+8ly2REV4vSqIJdmLDs5TWEePj7xP4rF22w4bU6o8U2kJx/2caeT3lS5czB
         4ZeQOgkPFRBV8w/W38niymfglVXCi1D2Z4MG5mfrT6lzszNum054npgyBHXrBml253w2
         ckvWBMfh/92vWeYUp/gJV6jf9ukHUiP4fwHCYd2/7rvVEUuNotWg6jyQpmq4fXiYVj8W
         zyztv5GsnrUfjRUrq/jzBhSxWirfm3hbUwzbU/FcptYt9mLndKzFx5HgDRIyumVpNUKK
         SAZ0sNpEHpuoSHOHoIEZAEDDdIQrrWptxEHjLHvalu/s780hDcxWan+FAX7k2te3vsaG
         Ab/Q==
X-Gm-Message-State: AOAM533Qva1oca2Q+M/fCtbs7NJMGpiaWMWpfw4M+mvjwJ75P+r73Y5p
        neJxcm79PRwCT7eu8eeEKlsq+ffYPFKLlD/cgwd2uw==
X-Google-Smtp-Source: ABdhPJwBxeBSBz70JZLFD01xbKaJkPi9NH3eB0TmiWRIzwqGkgMpr7WV0JpoyCqWjv1xkqWAZKrHVcDCJoE1MrVSP7E=
X-Received: by 2002:a05:6102:c4b:: with SMTP id y11mr1286931vss.24.1631091402493;
 Wed, 08 Sep 2021 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210908083828.47995-1-flyingpeng@tencent.com>
In-Reply-To: <20210908083828.47995-1-flyingpeng@tencent.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 Sep 2021 10:56:31 +0200
Message-ID: <CAJfpeguusE00Jr+qes=dwTBSxdFJVgpsr=UOqqX7pSNTq1kvBA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Use kmap_local_page()
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Sept 2021 at 10:38, Peng Hao <flyingpenghao@gmail.com> wrote:
>
> Due to the introduction of kmap_local_*, the storage of slots
> used for short-term mapping has changed from per-CPU to per-thread.
> kmap_atomic() disable preemption, while kmap_local_*() only disable
> migration.
> There is no need to disable preemption in several kamp_atomic
> places used in fuse.
> The detailed introduction of kmap_local_*d can be found here:
> https://lwn.net/Articles/836144/
>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Thanks, applied.

Miklos
