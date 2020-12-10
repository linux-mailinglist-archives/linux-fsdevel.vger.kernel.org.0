Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7D2D6131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392305AbgLJQHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 11:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392282AbgLJQHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:07:13 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D1C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 08:06:20 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t16so6033513wra.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EEM0AX878xSa8V2cvUDpTLDczQ0IGzyz0LRReW9tzA=;
        b=dG3nDfcSFKcJqfMUlDBawK6U+/17xUIuG5w7oEcJKBYdW1zerFAMxTR27Vw3ED9rWV
         aZ5xpsrUl1k/73I4w1FR6llyHh342rQEBBSuerrIpeeWaTwd0YgiGKLpWIRVtTWvd0Vr
         OvEPfWDYhl0k31LxHGSu2Y79gbq2+C/UQRm4+nfafn5ylsnB1sL/jMp6VoQ1CSC8wFkX
         TGklkiZNfuDYk9kbL+3VXuWSYYQ0/jsni1x+f55I0oy0LfaTM5ZgzIiw6+vZ2IaGg5TV
         VkN2qdkxGVbKvtdqLvrMGA2oN0cFpRSU6eGeFz2VAY046PYj+H8zuJcV2RZuDHBwQt/o
         VW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EEM0AX878xSa8V2cvUDpTLDczQ0IGzyz0LRReW9tzA=;
        b=sAywn4iDXXFuNZafLMds3v3q3nSg4NB65FyiWF77D5wuMYWMrBFtbfByeM0frDK+je
         QMgHBpF1bjgPAH4FVmOrAZLuHQWs8yoYdIG9k0v3FsSt8Bxmso2iqaYRquGVg/wsnpPQ
         dzkjAEwJWvd9zJ7dgFonFyJub1D8UuDQxVnfYMtnf1wabpl72uF7x1An0zk4SlawZFOW
         JJELqNU0S0ItkILACo8tPpqc8xhJOxpCW+f41jxm/+9lp6zhd+EizZu6NBSpmDqJSXZr
         YZbvLBd5BNYoTU+U835mCH9sCsz9DFSzkyt1kzrVc8ssQYGx6gfIjayirMjKjtfrY1L8
         VXZg==
X-Gm-Message-State: AOAM533c5dwey6H/QramvZPcamz/Q47e7UYaSQMTIPPA5g0dXvO5cus7
        EEACPrYF4A8IdFlRyRlcNFDLJg==
X-Google-Smtp-Source: ABdhPJwbsAebsVatgwJVP7G/BlySZfheiXSb2ekaT+aAULkzlUatfjHBeww5kzznvVZDMQ8OamZaBw==
X-Received: by 2002:adf:9124:: with SMTP id j33mr8598967wrj.376.1607616379710;
        Thu, 10 Dec 2020 08:06:19 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id x7sm2719625wmi.11.2020.12.10.08.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:06:19 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:04:13 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v2 01/12] mm: memcontrol: fix NR_ANON_THPS account
Message-ID: <20201210160413.GH264602@cmpxchg.org>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206101451.14706-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 06, 2020 at 06:14:40PM +0800, Muchun Song wrote:
> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.
> 
> Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

But please change the subject to

	'mm: memcontrol: fix NR_ANON_THPS accounting in charge moving'
