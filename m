Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544B348474D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiADR6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiADR6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:58:30 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67296C061784
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 09:58:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i3so95854851ybh.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKYugI14weLPX72dba0R8OyZDrnFDsVWJDf+XD0rZGo=;
        b=dXgIwxD8i4PoqUe119pPc/sEWYIzl+sLHg+NEe1rLa9tFyMlJVpl1FG86uMmlsnyHB
         2DYJn8udr6JTTYCX02TKcjSakwE+4wAaa9EjA0r1ZH/MngxxT/liU9sT6JBmVJyWXQCu
         2l44McQXoBdQqaaAOc1Z7f26GR6+7BK8FCxQcn1Qu+bouDGzvKelWFqx7ZGzymc6cma7
         I5N/UJmEu8QkA/ADb+T61W1rIzfc1Al7mVC/eIF/mmztF8l+XpV0newj5oGye1ENG3B6
         t0Br0D9QGpFk22n8QaHtipwIicjdMLmXVmBBwFbnrkeiMAuG8WEjIRAYu5ODAys7emo9
         Lm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKYugI14weLPX72dba0R8OyZDrnFDsVWJDf+XD0rZGo=;
        b=jvi90chKNFXrCXbjw7PwHGeGHeBuE5qbVF8VszEOC6SeJALiafpqfdhlw5xPt8xnTl
         Bb8Qb3mqw7v8HupO8DKGWEIAr/OcHvpfqidYPA4uI6m62svljr5eLLU/NcsrOiQgcC6k
         SJFEAR3WR3O6DD9jg4VgUFHD7VB7P2wwMZ7st8/qanKusbt/WG4J6urvGSM3Vr78Us2v
         35fUfuwvQafOiEd6OyVGGOa6bVV6Hhq5DhWk0MGr40n7CsUG95FQJ6Chen2ArwJE/kC3
         PNcOWpkQkNuSDEvZ/ECWTEsOMtsYdNw85EW66wd5l06DFZWt6Xi1i1/umWZyEtpRfCJo
         Xg2A==
X-Gm-Message-State: AOAM533W81gvyZQUGGdXHU5XiBy69B9v1LQzxqBCXhstR+7f9G8g/KYr
        2czbUvrOWlIaQ/CpsmmN7zA3qk9tmfFb4kCo3GNxWQ==
X-Google-Smtp-Source: ABdhPJx7iE9F4XiDdZX0VcwtfzkIvbL155r3HPzcjPWDmI4J3EegNVpdjVjYfIHTFYaDTjlFY8z/HCRg04KPU3IVCxM=
X-Received: by 2002:a25:2786:: with SMTP id n128mr27908830ybn.491.1641319109224;
 Tue, 04 Jan 2022 09:58:29 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com> <048124e2-8436-62e3-6205-f122ec386763@linux.alibaba.com>
In-Reply-To: <048124e2-8436-62e3-6205-f122ec386763@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 4 Jan 2022 09:58:18 -0800
Message-ID: <CABk29Ntcq-ou=2JPBRs4HhOUcOcsL-hdG5ns55-TTHCOePhnZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Forced idle time accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 3, 2022 at 11:15 PM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
> Ping.
> Accounting forced idle time for per cpu can help us measure the cost of
> enabling core scheduling from a global perspective. Mind having a look
> at it?

Sorry, just got back from vacation. I'll have a look at the patches
later today, but the idea sounds reasonable.

Best,
Josh
