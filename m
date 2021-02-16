Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819E531CB50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 14:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhBPNj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 08:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBPNjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:39:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17726C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 05:38:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g3so9656845edb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVdO5Suny8ndHlIrRpoBrmqIPx4CWmlNbuYupKr2Cqc=;
        b=mx72lufRdfc46M4ag+yiDlWAEO4kn8+gbsl3jWz0aFqVijhPbgaHfBEQpRr24bWoo3
         Kzcg5/Qv0MqwuyCOWfV1DbKnZu075rzPranwK6vD4iech5drvH3efYd5mAeEH9goRzIa
         WVW3u5QveHXn/Yw7x4byE6AG/TaLuDBAt4Gb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVdO5Suny8ndHlIrRpoBrmqIPx4CWmlNbuYupKr2Cqc=;
        b=NGSjYs0aKmkUZgKo07IKRUSuEZyZgR8UpAesunn81g9tM6Fwk94EvCt09dkbXjpRFW
         Bsfin4tMx/sN27QwnS8dQoK4nquvzUhIlKpNzkkorQxt4eHxrC5t5FF9pgVB52j11x14
         sxe1orIodjrE30bSJmE5RMfEHOTpkRfiD5VH0YCR/qt2SoLFU2NOqpw6vfNHJIwGlWuM
         QA6BxdXygyvPJSPkJ6cqjPzpQePqah2dp3xp1l1F/tBpk214HhUiV5Ty9M9DZ035Ew3T
         77QyNBYz2r+k6rGt715aPAbNa3pN+AYTyxJbb0pECVeh2YwVC+dBv+4Z45/f/beA7PGj
         AiXg==
X-Gm-Message-State: AOAM5300o1fLYTtGBiNYFMLsHNbvMN4fdC6Oa7AyH1KUNiyuExyw8Ob7
        CF5daV1ThvgFWMt0TyPeUATNTQ==
X-Google-Smtp-Source: ABdhPJzpPnxzHatNnDsBqyQ+8F5czdeOrvKXZriPXHaF1qmKcbRlVfIHYJBPmwi07+8O5GcHXWnEEw==
X-Received: by 2002:a50:fe02:: with SMTP id f2mr938391edt.173.1613482721746;
        Tue, 16 Feb 2021 05:38:41 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id i21sm13620839edy.9.2021.02.16.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 05:38:41 -0800 (PST)
Date:   Tue, 16 Feb 2021 13:38:40 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, felipe.franciosi@nutanix.com
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YCvK4EPg30ocI8gP@chrisdown.name>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eiichi,

I agree with Michal's points, and I think there are also some other design 
questions which don't quite make sense to me. Perhaps you can clear them up?  
:-)

Eiichi Tsukata writes:
>diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>index 4bdb58ab14cb..e2d57200fd00 100644
>--- a/mm/hugetlb.c
>+++ b/mm/hugetlb.c
>@@ -1726,8 +1726,8 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  * balanced over allowed nodes.
>  * Called with hugetlb_lock locked.
>  */
>-static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>-							 bool acct_surplus)
>+int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>+			bool acct_surplus)
> {
> 	int nr_nodes, node;
> 	int ret = 0;

The immediate red flag to me is that we're investing further mm knowledge into 
hugetlb. For the vast majority of intents and purposes, hugetlb exists outside 
of the typical memory management lifecycle, and historic behaviour has been to 
treat a separate reserve that we don't touch. We expect that hugetlb is a 
reserve which is by and large explicitly managed by the system administrator, 
not by us, and this seems to violate that.

Shoehorning in shrink-on-OOM support to it seems a little suspicious to me, 
because we already have a modernised system for huge pages that handles not 
only this, but many other memory management situations: THP. THP not only has 
support for this particular case, but so many other features which are 
necessary to coherently manage it as part of the mm lifecycle. For that reason, 
I'm not convinced that those composes to a sensible interface.

As some example questions which appear unresolved to me: if hugetlb pages are 
lost, what mechanisms will we provide to tell automation or the system 
administrator what to do in that scenario? How should the interface for 
resolving hugepage starvation due to repeated OOMs look? By what metrics will 
you decide if releasing the hugepage is worse for the system than selecting a 
victim for OOM? Why can't the system use the existing THP mechanisms to resolve 
this ahead of time?

Thanks,

Chris
