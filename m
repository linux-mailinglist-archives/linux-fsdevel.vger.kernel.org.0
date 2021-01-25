Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77422301FAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 01:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAYAIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbhAYAH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 19:07:26 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBEC061786
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 16:06:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n25so7788656pgb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Jan 2021 16:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lJAlWsxHbl8p3VKZjZPTI5PoyuI0xzJ3qlZ40HECelI=;
        b=sSZCCC1Kl7/xkG5bjekS3mF2Id9siUna4XWqSxx9E3gjnH1n78FC3bXiv7+Zmr6bqf
         x19qmrxqdt8IyP7aZzmZY5QAfybRuILE5gfp0RzZ7bUiSqeocAaI3U83eEciulKcJSPv
         hMHkK7d3sLKGt20HprUuHS0E/5LMWtkIyVhdPDJ/rVNs7tsi8x+I192TUOp6IN7Hofys
         QXd7ty1ThgdOgAerm1Xa/wRoK150fYvP/iq3cUN3L1wlYSkqDeq3oY0BapKgNdcNkuBh
         9M/JgN8wyWNYHzxSDeOWmC1yiYYj4rE/ogBZ8HrhhNHqEZyv9BwsEmjgqB61o21ByrAu
         mgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lJAlWsxHbl8p3VKZjZPTI5PoyuI0xzJ3qlZ40HECelI=;
        b=XMYuh0XqmFbk4tZ8di8BpC+JfaBLiCV7YA7Y8SeNgTtB9Js6NouPcxsnH96avLnXQU
         0BdOknBLlI+rn5/bQGlB3IdkQvKP3PvZ5W2DZxPjGd6Q4SLYKO/VwzjluQt0+7IG+8c8
         eKJuBmEUB1Ooetmvrnzvn1EdQ41bNQnCJXIO0+cchS96LXfLUH8QMNiSZSkvufPKprbU
         DdF0/UISCcJCRkj6AanFz0U+6P99icNS6aaAq/RsPhcOXcxddAvAosP7B/tuVIkvx9CS
         EaSlBY9X/g5Az+U9HVmXH45MROc5fsCHZasMuB7j2WxBbNRBjFbhiMaOHq4N+oZf0UtE
         0tMA==
X-Gm-Message-State: AOAM531qOCKXulYyp7GIN08aICVd/70f1UfCJbodUtu3cROFhu3b+WYX
        AuJmk75uR0DZi+XhixCaeOax1w==
X-Google-Smtp-Source: ABdhPJzU7elejkU9dKdelvpxBIdm/wMQK6qPXW83kLCYhFsKznYIgbA1Dya8jGqRTCjGICyRt2WiHA==
X-Received: by 2002:a65:5884:: with SMTP id d4mr1500656pgu.303.1611533176201;
        Sun, 24 Jan 2021 16:06:16 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e20sm1056397pgr.48.2021.01.24.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 16:06:15 -0800 (PST)
Date:   Sun, 24 Jan 2021 16:06:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, willy@infradead.org, osalvador@suse.de,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 06/12] mm: hugetlb: set the PageHWPoison to the raw
 error page
In-Reply-To: <20210117151053.24600-7-songmuchun@bytedance.com>
Message-ID: <88a384ba-8487-c66b-e7b-eb6055e3775@google.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com> <20210117151053.24600-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 17 Jan 2021, Muchun Song wrote:

> Because we reuse the first tail vmemmap page frame and remap it
> with read-only, we cannot set the PageHWPosion on a tail page.
> So we can use the head[4].private to record the real error page
> index and set the raw error page PageHWPoison later.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
