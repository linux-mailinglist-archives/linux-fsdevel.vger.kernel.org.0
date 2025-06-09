Return-Path: <linux-fsdevel+bounces-51011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66218AD1C14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C83A493E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B6254867;
	Mon,  9 Jun 2025 11:02:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EC49625;
	Mon,  9 Jun 2025 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466964; cv=none; b=DZr9PXWWtN1N2zSuaWWhEAs8ofCH2Vhq8VaXbKcumQijN+OuIQXUGS+w71r3JEkhq6l/VkDAxIQUZLhdL8k3TxnHY5m45WUMvxv9ibQHOUo7AsG1mkfYYMAg9Y7xgzulvD6EJg/0l0/njsOWB1j+mUB3HvjuICr5VWEeYmn+hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466964; c=relaxed/simple;
	bh=jx7hLp3tvLBH/1SEAlmcqZmnyK/DYmmzfMarvdWgi04=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flLRARb6U2/Ud0+YJS8jrZbNDY68yQ/NBKihjfDZAlORynFialA2lh+7l4U2eR2081OP279BGqTYmsV7l0Q32T+wTJRLNdfPlbrOQfSbau4bdcblVKY+IYMpURiqk3k+oeERv7RFdo2JmJAHGXGURWYueLGTjnExuPCOPHWX8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG86W59Lzz6L59Z;
	Mon,  9 Jun 2025 18:58:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 716C514038F;
	Mon,  9 Jun 2025 19:02:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 13:02:38 +0200
Date: Mon, 9 Jun 2025 12:02:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	"Benjamin Cheatham" <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 2/7] cxl/core: Remove CONFIG_CXL_SUSPEND and always
 build suspend.o
Message-ID: <20250609120237.00002eef@huawei.com>
In-Reply-To: <20250603221949.53272-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
	<20250603221949.53272-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 22:19:44 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> In preparation for soft-reserved resource handling, make the suspend
> infrastructure always available by removing the CONFIG_CXL_SUSPEND
> Kconfig option.
> 
> This ensures cxl_mem_active_inc()/dec() and cxl_mem_active() are
> unconditionally available, enabling coordination between cxl_pci and
> cxl_mem drivers during region setup and hotplug operations.

If these are no longer just being used for suspend, given there
is nothing else in the file, maybe move them to somewhere else?


> 
> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/Kconfig        | 4 ----
>  drivers/cxl/core/Makefile  | 2 +-
>  drivers/cxl/core/suspend.c | 5 ++++-
>  drivers/cxl/cxlmem.h       | 9 ---------
>  include/linux/pm.h         | 7 -------
>  5 files changed, 5 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index cf1ba673b8c2..d09144c2002e 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -118,10 +118,6 @@ config CXL_PORT
>  	default CXL_BUS
>  	tristate
>  
> -config CXL_SUSPEND
> -	def_bool y
> -	depends on SUSPEND && CXL_MEM
> -
>  config CXL_REGION
>  	bool "CXL: Region Support"
>  	default CXL_BUS
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 086df97a0fcf..035864db8a32 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_SUSPEND) += suspend.o
> +obj-y += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
>  CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
> diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
> index 29aa5cc5e565..5ba4b4de0e33 100644
> --- a/drivers/cxl/core/suspend.c
> +++ b/drivers/cxl/core/suspend.c
> @@ -8,7 +8,10 @@ static atomic_t mem_active;
>  
>  bool cxl_mem_active(void)
>  {
> -	return atomic_read(&mem_active) != 0;
> +	if (IS_ENABLED(CONFIG_CXL_MEM))
> +		return atomic_read(&mem_active) != 0;
> +
> +	return false;
>  }
>  
>  void cxl_mem_active_inc(void)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ec6b906371b..1bd1e88c4cc0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,17 +853,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> -#ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> -#else
> -static inline void cxl_mem_active_inc(void)
> -{
> -}
> -static inline void cxl_mem_active_dec(void)
> -{
> -}
> -#endif
>  
>  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>  
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2..415928e0b6ca 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -35,14 +35,7 @@ static inline void pm_vt_switch_unregister(struct device *dev)
>  }
>  #endif /* CONFIG_VT_CONSOLE_SLEEP */
>  
> -#ifdef CONFIG_CXL_SUSPEND
>  bool cxl_mem_active(void);
> -#else
> -static inline bool cxl_mem_active(void)
> -{
> -	return false;
> -}
> -#endif
>  
>  /*
>   * Device power management


