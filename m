Return-Path: <linux-fsdevel+bounces-70200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28BC936C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 03:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58BA234419F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C641DED57;
	Sat, 29 Nov 2025 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PWKrg9CI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC636D4FD;
	Sat, 29 Nov 2025 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764383673; cv=none; b=HEMBI/+l/mC0KTUB+VmhL7fYTS/Q3EpQg5w3N+JfLw2GvjOEsNaGHx+BX49LS7Paw74PvLafPU/jKcxlUhu8VCDFLyyz53hEEWKSn67VH2hKfe6HYHzwINoZ3s06h0OKqewIKqhRwUFyJb4z+AFj/0/owilz5HSk1cGW+bQoRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764383673; c=relaxed/simple;
	bh=4WlnOtMFBNXSbsHbe0c9o/PK2XZ+5DjPw5kWfI8fwBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4Ak1GRwgkY2oiRz1YDIT3AHgWqJ71JlDocPWGX6kGcopR3JvItKEBmb6nCt5JWgUaMHR8bMcAo1NAs25+l/ki7z8hQp/gRgXbD4u/6i7onfN/FrPqB+LWnHD9JlE6jbAEzthd8LKCyMnsVkwpqYWiNYmaE610E8WyXFahRQBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PWKrg9CI; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6xJNkDPeFZ3mqQ8f1vIw6iwLF+t+AtPw3ITe29YVPNE=;
	b=PWKrg9CIIKX20SkXni2m0WgDvyVF7rPTKkM8q3Ou9evSEb47iF2go4uoiLhBwVVwEUmGd+R3o
	sAmidTA+oP96b6qoyCWa2bWw1iJaN9or7npTp+ATi/v2O5Oxn4KZsWal7NWsybJOWATLZia+yNY
	f5pn9OY24M3ZZ1JMdsvYTaw=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dJDj11ptjz1cyQk;
	Sat, 29 Nov 2025 10:32:37 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E5421800B2;
	Sat, 29 Nov 2025 10:34:27 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 10:34:26 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>
CC: <akpm@linux-foundation.org>, <arnd@arndb.de>, <brauner@kernel.org>,
	<david.laight@runbox.com>, <hch@lst.de>, <jack@suse.com>,
	<kuninori.morimoto.gx@renesas.com>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux@armlinux.org.uk>, <lorenzo.stoakes@oracle.com>,
	<marc.zyngier@arm.com>, <nico@fluxnic.net>, <pangliyuan1@huawei.com>,
	<pfalcato@suse.de>, <punitagrawal@gmail.com>, <rjw@rjwysocki.net>,
	<rmk+kernel@armlinux.org.uk>, <rppt@kernel.org>, <tony@atomide.com>,
	<vbabka@suse.cz>, <viro@zeniv.linux.org.uk>, <wangkefeng.wang@huawei.com>,
	<will@kernel.org>, <wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH v2 1/2] ARM/mm/fault: always goto bad_area when handling with page faults of kernel address
Date: Sat, 29 Nov 2025 10:33:23 +0800
Message-ID: <20251129023323.11612-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128120359.Xc09qn1W@linutronix.de>
References: <20251128120359.Xc09qn1W@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Fri, 28 Nov 2025 13:03:59 +0100, Sebastian Andrzej Siewior wrote:
> what about this:
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index ad58c1e22a5f9..b6b3cd893c808 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -282,10 +282,10 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	}
>
>  	/*
> -	 * If we're in an interrupt or have no user
> -	 * context, we must not take the fault..
> +	 * If we're in an interrupt or have no user context, we must not take
> +	 * the fault. Kernel addresses are handled in do_translation_fault().
> 	 */
> -	if (faulthandler_disabled() || !mm)
> +	if (faulthandler_disabled() || !mm || addr >= TASK_SIZE)
>  		goto no_context;
>
>  	if (user_mode(regs))
>
> We shouldn't be getting here. Above TASK_SIZE there are just fix
> mappings which don't fault and the VMALLOC array which should be handled
> by do_translation_fault(). So this should be only the exception table.
>
> This should also not clash with the previous patches. Would that work
> for everyone?

When it is user_mode(), it should be goto __do_user_fault(), but
no_context goto __do_kernel_fault(). So I think it is not ok.

> Sebastian

Xie Yuanbin

