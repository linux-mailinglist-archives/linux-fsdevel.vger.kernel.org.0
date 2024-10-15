Return-Path: <linux-fsdevel+bounces-31999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD2F99EEA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C0285918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99811B21B7;
	Tue, 15 Oct 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piIauhHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9F1AF0C7;
	Tue, 15 Oct 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000969; cv=none; b=B0r/N9KG/vpFcZ/GR9g09jIF1T5rHd1vLAREDMhF1fZYvhqNuwE5Y+eLa5pA/MN+oKCa/jJmi2TyuA/muQdmz6m1SrZ5HLG+veyjNscXjg9HHkodgeM2tqYaNitwWgOhN29Q777VZj+jEluYYipIN3L/6BbIB2DGNNASKwrBeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000969; c=relaxed/simple;
	bh=VOPRsFCcHP3X4Pbl31ecirEAIYmkUpxu3sZJdwIwleI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdAluKGeK4iOWbNkaZIY1h61msi0QDdMWLWN4HOckvh2e5OKe9NjeUDd/CDHbBIzoYRvwN5D6OfPoYVDvzceTPZjzeilZmzHIgyBseccdq1a5WK457awXMcBHm9d0EPrOI+9x+FYE0ECi5Bi3DYSLbUEe2mHYEPNjRYuTdLA6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piIauhHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BA3C4CEC6;
	Tue, 15 Oct 2024 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000968;
	bh=VOPRsFCcHP3X4Pbl31ecirEAIYmkUpxu3sZJdwIwleI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piIauhHhux1D1CgO1fWb+zaRBaHCj6G7sNmbv6U22DFNoPFNkrECwVKBUDBf3OQ3x
	 gSETwc1SCGMcZjmGhxpElT4tpJqr7L99Nqnn56TJeQnR4xHTksBjnlI+MnyKtJEhT7
	 o2maGizjj5VcYSIgTre+GJePQg4qZnPpqD5Gds4rGUlfhQkteprcsKT59JpUGC39dE
	 Z5gHbRXYrZvpjVA088T6Uh1r8njiUpqEcCl91MJlWw0gDT6OXWSxPvzci5J9MgYlki
	 m1ZbprzipB0DWuNj4yinCHZI/iln6F1G1taCk5pe0SRmFR7Ca9hQYi0Ay1mZ9XpoFD
	 lHikpJ8tNpXCg==
Date: Tue, 15 Oct 2024 16:02:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, jack@suse.cz, kees@kernel.org, 
	j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v3 -next 10/15] fs: drop_caches: move sysctl to
 fs/drop_caches.c
Message-ID: <20241015-vielzahl-tonleiter-70f712519227@brauner>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
 <20241010152215.3025842-11-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010152215.3025842-11-yukaixiong@huawei.com>

On Thu, Oct 10, 2024 at 11:22:10PM +0800, Kaixiong Yu wrote:
> The sysctl_drop_caches to fs/drop_caches.c, move it to
> fs/drop_caches.c from /kernel/sysctl.c. And remove the
> useless extern variable declaration from include/linux/mm.h
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

