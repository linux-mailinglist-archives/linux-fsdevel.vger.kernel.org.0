Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD5F3319DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 22:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhCHV5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 16:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhCHV5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:57:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C4C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 13:57:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f1so23547900lfu.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khP6ZcxYFVDRWDYG0T+rbHb6YKkL+/NsAq7MfcJL/3k=;
        b=DAuY2SnkTq4kpznO/OR8hpixQWW/2Z9iRHBq2QFf3hMnIXGIFb03qdLXNtJxwrhNGd
         3izsTWnjGrT67Huo9kgm3bJSkk8jBNm2Fy0lQccrE8yEp3sGHlzxuKdoGe5B8gypbEZs
         PgguuAqFFpsJwemWMW9ZYiC9flS1cdAsb3YWVwmNyGTU294MM+n0e6SASQ1RL8zKeMHY
         TBbz6GmWAzgwRIUeOJxS9jx/lNMJUfQa6EstM5U8eWNqc7ZqRvIE35Qovzzfc7LtQX3+
         zCB6QbIYWpKRmOg5SrsCB84iOf99jFLmgmRJhgG5ndhSLC5ILGtzRAvNz8eBtux+l04v
         vpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khP6ZcxYFVDRWDYG0T+rbHb6YKkL+/NsAq7MfcJL/3k=;
        b=nr2tASnGEasY9SbnnU5RBxRMYPrdyfoL7dA5BgeITeaqJzxLBnVQbfF64itBp8fSvH
         kfKfJ5w6wo+COtpYxtdfQiZBPw+6h0lKJsASmpXZX8CWhUKsInMt8+43tWaGVf92et8x
         r5I1a/uuCr2oyyw86XU7L0ErdOyrPxX3NQ/Ziibv+6+mAKiwhZaS2OYnDBxPnN2VLolS
         sFTjNMXhhXiTzbOpVuSYGFuRA0p/cAnEE5Xie9ZS8IEZk/pJlPTI9Dlm5RiVFSny20h+
         m7vyOCwYi3rRUt7B5mUyinhgVkDSQTHSr0XP11SFw92RstSl5bJbpfYxbLXXlJjMWqE0
         P7/g==
X-Gm-Message-State: AOAM5322qa4IBPz9RKofWZJuUd9t4Do1342ORvKMONsZnGc5+E8xZgk9
        MnL6M00hAzxKhrTUIxU01RjMhl5+0bEdQf+7I+Ujhw==
X-Google-Smtp-Source: ABdhPJwJKP9j6TADl4BG8Z3lqly76Sb5BltQAcueClPCVCtYYwOA6NDC7q4ME8VtgpxXEhBkyFAjORyMMciln0a+Tmo=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr5587045lfb.299.1615240640883;
 Mon, 08 Mar 2021 13:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-12-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-12-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 8 Mar 2021 13:57:06 -0800
Message-ID: <CALvZod7Cg9x4x8Jmgu6z9LAn0y-1OosnHSUCL_=DcCfgbGThJg@mail.gmail.com>
Subject: Re: [v8 PATCH 11/13] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> allocate shrinker->nr_deferred for such shrinkers anymore.
>
> The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> This makes the implementation of this patch simpler.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
