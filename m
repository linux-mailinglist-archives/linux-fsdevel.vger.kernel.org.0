Return-Path: <linux-fsdevel+bounces-17357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95D8ABAD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308211F2187B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFE17BCB;
	Sat, 20 Apr 2024 09:50:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5371175A6;
	Sat, 20 Apr 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713606628; cv=none; b=P8k1Mlyj/+1ealg+3wVToNbQqDkWpTyMIYMo3bqxlQxD/ciOCUzOiBeeUVXAcB1+yAAlY0FrOE/xFv2sSnJCvdF5jzL0g4lnhomJTqFmiJzfDdjlP1+U8WMv0tuZXpw4/Tlm6MNL006sFiX/vUE7eDdhYWOYEiD7y/y0NnRfHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713606628; c=relaxed/simple;
	bh=AMP+HOz12eu4e02b64VUoOditPc8EeZAygZmBenspqA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ueUzLL14ryYzpIwBJsLH1/6VA+IRrc/nn52byPMf9RpQtGEQdc9uJ7RMSwAvBfCx3ILN9LqcCvl6p1DqyhKq74jKDbvGUXIvkRNY5j2rpnX3n9x2PR7MR1brCua5gGNKcX6EZt74eT+XpebKTvVouDjw98wDReTNwbZT375lRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VM6DH626wzSjGK;
	Sat, 20 Apr 2024 17:49:19 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C833180A9C;
	Sat, 20 Apr 2024 17:50:22 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 20 Apr 2024 17:50:22 +0800
Message-ID: <90f306e2-dd37-4dea-d57e-7ddae22b1889@huawei.com>
Date: Sat, 20 Apr 2024 17:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cgroup: Introduce css_is_online() helper
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeel.butt@linux.dev>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>
References: <20240420093837.1028410-1-xiujianfeng@huawei.com>
In-Reply-To: <20240420093837.1028410-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)

sorry, ignore this one, the tag should be [PATCH -next]

On 2024/4/20 17:38, Xiu Jianfeng wrote:
> Introduce css_is_online() helper to test if whether the specified
> css is online, avoid testing css.flags with CSS_ONLINE directly
> outside of cgroup.c.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  fs/fs-writeback.c               | 2 +-
>  include/linux/cgroup.h          | 9 +++++++++
>  include/linux/memcontrol.h      | 2 +-
>  kernel/cgroup/cgroup-internal.h | 2 +-
>  mm/memcontrol.c                 | 2 +-
>  mm/page_owner.c                 | 2 +-
>  6 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 92a5b8283528..bb84c6a2fa8e 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -916,7 +916,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
>  	folio = page_folio(page);
>  	css = mem_cgroup_css_from_folio(folio);
>  	/* dead cgroups shouldn't contribute to inode ownership arbitration */
> -	if (!(css->flags & CSS_ONLINE))
> +	if (!css_is_online(css))
>  		return;
>  
>  	id = css->id;
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2150ca60394b..e6b6f3418da8 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -346,6 +346,15 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
>  	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
>  }
>  
> +/*
> + * css_is_online - test whether the specified css is online
> + * @css: target css
> + */
> +static inline bool css_is_online(struct cgroup_subsys_state *css)
> +{
> +	return !!(css->flags & CSS_ONLINE);
> +}
> +
>  static inline void cgroup_get(struct cgroup *cgrp)
>  {
>  	css_get(&cgrp->self);
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 8f332b4ae84c..cd6b3bfd070f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -939,7 +939,7 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
>  {
>  	if (mem_cgroup_disabled())
>  		return true;
> -	return !!(memcg->css.flags & CSS_ONLINE);
> +	return css_is_online(&memcg->css);
>  }
>  
>  void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 520b90dd97ec..feeaf172844d 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -183,7 +183,7 @@ extern struct list_head cgroup_roots;
>  
>  static inline bool cgroup_is_dead(const struct cgroup *cgrp)
>  {
> -	return !(cgrp->self.flags & CSS_ONLINE);
> +	return !css_is_online(&cgrp->self);
>  }
>  
>  static inline bool notify_on_release(const struct cgroup *cgrp)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7703ced535a3..e77e9e1911e6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -405,7 +405,7 @@ ino_t page_cgroup_ino(struct page *page)
>  	/* page_folio() is racy here, but the entire function is racy anyway */
>  	memcg = folio_memcg_check(page_folio(page));
>  
> -	while (memcg && !(memcg->css.flags & CSS_ONLINE))
> +	while (memcg && !css_is_online(&memcg->css))
>  		memcg = parent_mem_cgroup(memcg);
>  	if (memcg)
>  		ino = cgroup_ino(memcg->css.cgroup);
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 75c23302868a..7accb25e6fe6 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -523,7 +523,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
>  	if (!memcg)
>  		goto out_unlock;
>  
> -	online = (memcg->css.flags & CSS_ONLINE);
> +	online = css_is_online(&memcg->css);
>  	cgroup_name(memcg->css.cgroup, name, sizeof(name));
>  	ret += scnprintf(kbuf + ret, count - ret,
>  			"Charged %sto %smemcg %s\n",

