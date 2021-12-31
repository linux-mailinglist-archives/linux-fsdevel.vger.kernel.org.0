Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14B48259A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhLaTPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 14:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLaTPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:15:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6833C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:15:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f5so111476024edq.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRhip54+JnwF8oKsLs20EY47pxmh2riYZm3Qc8IBRcM=;
        b=V7WaTtf3U2sm9T7zwDPV1eYMgoM0U1SemKSgiUC1NGMfC0pOm+NL58I/hVlSHS2kuP
         nH+9Fjukx33me0dTQKe90FOa9nT9rVcfx4lUU4XO5OR1f4ZQOxOT0O+VQ7baOGx4MnGw
         YgS3srfJCUf1l5EREBzfqYvFTwBO8Ho+bG7iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRhip54+JnwF8oKsLs20EY47pxmh2riYZm3Qc8IBRcM=;
        b=BAySB+vHJp8M6vgVfCUsSYQzFQG7dDhIp+LQ6NyrZu2hv+yurIzzWSD/90PxN3bZuL
         RuqdK3XSSFDfhiboQGZJfll9iULQnpAgoulm+dobZDyUt0e8h+dJlzt+lx2rFF2EH4LQ
         ll+ebKxWasAlxkKrl23+lAYr+ZSAgFxQUWK+9TfPSwv/X699RBtIDvtn3dFRxrvNdLPv
         owwEViH8ahMk8DjY00xFxbbttN1NG5cuVg2rh291Ssd7Ni1Kv7Vat/XJVizOz8x5dVIV
         PRJFosJE0om9xSq8+snOLHsTR3Gnn0JhhZRP39M+J1iiAc7fWZm6gx7Z+G1OSAo5gHk5
         MHMQ==
X-Gm-Message-State: AOAM531KU4BXWMJWkn82Gh6/qMLKjRu6/YhBktHBrm4YieEV6wKZo6d0
        j3UzpsWQO558tc3wqLQWSthDgibu2mv/P7qa
X-Google-Smtp-Source: ABdhPJz9hst4gbIfp7AmnroreUQj3zhNvtqDwtW83JljltNrPomZknsmwKK3fQAIuon7C9lWnRF8Zg==
X-Received: by 2002:a05:6402:3584:: with SMTP id y4mr35707215edc.119.1640978112378;
        Fri, 31 Dec 2021 11:15:12 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a18sm11092400eds.42.2021.12.31.11.15.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 11:15:10 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id s1so57423678wrg.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:15:09 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr29861213wrx.193.1640978109225;
 Fri, 31 Dec 2021 11:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info> <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info>
In-Reply-To: <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Dec 2021 11:14:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
Message-ID: <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021 at 6:24 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> If we get it into rc8 (which is still possible, even if a bit hard due
> to the new year festivities), it will get at least one week of testing.

I took it with Hugh's ack from his reply to this, so it should be in rc8.

I'm not sure how much testing a week in rc8 will actually get, but
next week is likely to be at least a _bit_ more active than the
current week has been. And it's been tested by the people reporting it
(and apparently Hugh too).

                   Linus
