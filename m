Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB5122E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfLQOUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:20:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLQOUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:20:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so686012wrw.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zd9XqEVITJl7NicppRYYVZvvU2qzosIMEgK8+lPq/OY=;
        b=kBWNJoAm6N47rKuYc9rIETDOQG4LIK2YRCGCc7bqgpKEL0tondWroYitV3BPsPOROj
         NotqOxwEJrwdzifT4aKdZADtXRbiLRAkeqjDDxLrdeKM5TehVhTKlsQ7vLnjhruTcSDR
         YNMEKILGQWQD8WyrVqBzvjhICOQH6eImP9tCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zd9XqEVITJl7NicppRYYVZvvU2qzosIMEgK8+lPq/OY=;
        b=hC1vAkwbkkvyFq2jMVFw1D1kPhYCxXHU3wMhzVNhIi5KjDs7uX8WRHwXnDLMld3SrR
         MltvSF3ry2xIWdkm3BxnJLIgjUE/fjt2FNUh6imZ0i4gQGFCLRl6+W7LLj+GY9SgDPKI
         C5CEcrhFuesAr+162K1S+XwBEYpLrt2i8aPE+xXKZxnKSSSRhjK7VYnIiSOy4Xu2QiIT
         kaifpgMZb9E7hVqG/VXOCqTNa7xySXySmhtgV2j/JVN7E8qY6QtSmvj4WrBTVHbPlxWE
         GCB4x+DFUZOt6YWyVCEjPp/a8CZiVJ/nPEuQukUzcMjyNCEQWN/fsmRSijwj5gNulRVL
         icLQ==
X-Gm-Message-State: APjAAAU7q7qACJU1VGUkINuGF2BFatCqjURkyN/8mzwNH+aEsQN9vXAY
        osxMuKzjZSflQbOHFlknWTjCnA==
X-Google-Smtp-Source: APXvYqzTBPMKh43go7uEB5IPUMjHc9fvAViBNgrd6jMxWTtTC2/yJcFnjq2HTr6DOUsFiXuROLHVaQ==
X-Received: by 2002:adf:f311:: with SMTP id i17mr37072816wro.81.1576592452171;
        Tue, 17 Dec 2019 06:20:52 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id i16sm3227756wmb.36.2019.12.17.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:20:51 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:20:50 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm, memcg: reset memcg's memory.{min, low} for
 reclaiming itself
Message-ID: <20191217142050.GA131030@chrisdown.name>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <1576582159-5198-4-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1576582159-5198-4-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yafang,

Yafang Shao writes:
>memory.{emin, elow} are set in mem_cgroup_protected(), and the values of
>them won't be changed until next recalculation in this function. After
>either or both of them are set, the next reclaimer to relcaim this memcg
>may be a different reclaimer, e.g. this memcg is also the root memcg of
>the new reclaimer, and then in mem_cgroup_protection() in get_scan_count()
>the old values of them will be used to calculate scan count, that is not
>proper. We should reset them to zero in this case.

If the memcg in question is passed as "root" to mem_cgroup_protected with a 
child as the new "memcg" argument, then I still don't see what is wrong. 
mem_cgroup_protected must be called top-down from the root of the hierarchy in 
order to work already, which we already do in shrink_node_memcgs. This will 
already update the tree's cached effective protections properly, as far as I 
can see.

As such I'm not sure I understand what you mean in the changelog or in the 
patch. emin/elow as a mechanism is already intended to be racy/best-effort, 
since by the time we get to doing work it's always possible that reclaim 
eligibility state changed, and callers have to consider that.

Could you please explain further the situation you're trying to guard against? 
Thanks.

>Cc: Chris Down <chris@chrisdown.name>
>Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>---
> mm/memcontrol.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index f35fcca..234370c 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -6287,8 +6287,17 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>
> 	if (!root)
> 		root = root_mem_cgroup;
>-	if (memcg == root)
>+	if (memcg == root) {
>+		/*
>+		 * Reset memory.(emin, elow) for reclaiming the memcg
>+		 * itself.
>+		 */
>+		if (memcg != root_mem_cgroup) {
>+			memcg->memory.emin = 0;
>+			memcg->memory.emin = 0;
>+		}
> 		return MEMCG_PROT_NONE;
>+	}
>
> 	usage = page_counter_read(&memcg->memory);
> 	if (!usage)
>-- 
>1.8.3.1
>
