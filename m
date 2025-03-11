Return-Path: <linux-fsdevel+bounces-43704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB7A5BFB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A601C188B762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A2254872;
	Tue, 11 Mar 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chWHYSeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED114F6C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693764; cv=none; b=oUD9ds7+PXWkstaIboLHv6lIhDUsmq6lgF7FESW6nBmw1U4aohIJKsLl5ZvlOtTUzGnajZVnal4mR0LTAU7/xvDOiXUDwQgoS97jvq8Z09pFEBYzwGILb4SqecUczX9ezABvchESEddCk68JYWHhakBA/FUqW1CBM0ohHXEoStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693764; c=relaxed/simple;
	bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IizBoIW1Gzxu1cib02keYk9yESRrqj89QIVdDBVjnr5um/Oy+dYps1mIR1RcCMZ43UWKuOC2TSXjdh/yLmp6yUQbKYlxkPJzNdudgIOqhE+rPQDXhFMfbmwp6frL5IGAYE9ESBD9PwbimlYfqq6rv/q/Gshm+TqZKPv+KXut27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chWHYSeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D4AC4CEEC;
	Tue, 11 Mar 2025 11:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693763;
	bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=chWHYSeoYN7DxCjeFmSNIxTZyecfSPiPv1WZ1L46vIVia4h6q/c7NUp+RzR2ej/z2
	 q80vj4HBsRTxrF4C10sZMZY6RrMWg+KTxQLdmfd3zFO3LFjaAVWlNlIpZYkKVMr7Aq
	 zAVaotKqssGj4PcJrkATS+Ci/2B3wE29k4APunWMeZjf6uFosxrce7MyDpElbQOYeC
	 PS9fE1g9b6Uj7hMJzUAhjswjuU3iNxcLIuKCoVFy8B0UiVAAp3RSDU4XSalAlNVitX
	 18qK/ndr4AmkSsqBD13fv7ezf70avEWxMPImoYgaR9PlPFkLM/kddLedXBxtnm0AqU
	 TThGUwWj965ng==
Message-ID: <254201ba-fd55-428f-9bdd-431f51e3aca4@kernel.org>
Date: Tue, 11 Mar 2025 19:49:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] f2fs: Remove f2fs_write_node_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <20250307182151.3397003-5-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250307182151.3397003-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 02:21, Matthew Wilcox (Oracle) wrote:
> Mappings which implement writepages should not implement writepage
> as it can only harm writeback patterns.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

