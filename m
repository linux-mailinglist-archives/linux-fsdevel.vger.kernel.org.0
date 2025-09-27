Return-Path: <linux-fsdevel+bounces-62922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF43FBA5891
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 05:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70DB3271F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 03:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5341E832A;
	Sat, 27 Sep 2025 03:23:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D519047A;
	Sat, 27 Sep 2025 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758943381; cv=none; b=bbsJZIneZc0nX9xgxtF56HG8K0zjSCNcJUNCzTkntuo+xXOvJDqWKuSzJ1wmAy4KU1qGPkKPqqpFv4IHnLnqTMZiqrAdGk7no2ch/s2s7GanwE1SSrdncMqLnXHS+mMuKipQ9smwU1/xfgqq0rljzcKMmRAE9klASIWNzZu9m+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758943381; c=relaxed/simple;
	bh=kg1d0MTY71zfQLb6meJ6ncRhMBIMtCldbRRgQF/Fyog=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hKCfXvO/QbMa2/4kVmXDV6NFMRBkKIxy07MeLSFwpJYgtT+cynHE0Z9sWoyt6C4ce7Rf+gTt3x1ge3Ig5Na4Tb+cr6rNA8cxA6wor+XEbEnfItlr/TochBhXdikUI8TcZzhm4zuuu3ZtOuEs8y7D/yIjvZxbR23uaAwaUmtufmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cYXn04fPVztTZc;
	Sat, 27 Sep 2025 11:21:56 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EE906140121;
	Sat, 27 Sep 2025 11:22:48 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Sep 2025 11:22:47 +0800
Subject: Re: [PATCH v3 01/14] ACPI: APEI: Remove redundant
 rcu_read_lock/unlock() in spin_lock
To: pengdonglin <dolinux.peng@gmail.com>, <tj@kernel.org>,
	<tony.luck@intel.com>, <jani.nikula@linux.intel.com>, <ap420073@gmail.com>,
	<jv@jvosburgh.net>, <freude@linux.ibm.com>, <bcrl@kvack.org>,
	<trondmy@kernel.org>, <longman@redhat.com>, <kees@kernel.org>
CC: <bigeasy@linutronix.de>, <hdanton@sina.com>, <paulmck@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
	<linux-wireless@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <cgroups@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-2-dolinux.peng@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <03ad08d9-4510-19fb-bbad-652159308119@huawei.com>
Date: Sat, 27 Sep 2025 11:22:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250916044735.2316171-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/9/16 12:47, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
>   drivers/acpi/apei/ghes.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a0d54993edb3..97ee19f2cae0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
>   	int ret = NOTIFY_DONE;
>   
>   	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
> -	rcu_read_lock();
>   	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
>   		if (!ghes_proc(ghes))
>   			ret = NOTIFY_OK;
>   	}
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
>   
>   	return ret;

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

