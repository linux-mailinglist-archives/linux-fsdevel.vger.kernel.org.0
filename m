Return-Path: <linux-fsdevel+bounces-73645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6BD1D5DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA34B3015A46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30C37F8D7;
	Wed, 14 Jan 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cJPEWGwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD22F3C1F;
	Wed, 14 Jan 2026 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381456; cv=none; b=ZpZJOAVe2iMEq0icRBFxrq4zF55OE7vePEUnUXO4ssAyTQeqidqYxLxtlYAzMGSUpRLL0CDlCVVjaFz0/cH1QmkgySL67PjBZUw+oZo67xOL6CPvjdMIdPWIRgXiF0xN9vgCKLywe0Cj8+dFmzblWWXViHl4BXYg7nsBhBgAobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381456; c=relaxed/simple;
	bh=3Q2djyw0+83tHkn1mgUhs56Zsc2naEiYB5jQCuZoVE8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dMTEMEs96kd6Sr8wmw0zxENFzfBlG+BM7IVEAXrh9jiQePWO74hrhbJGP44HQa4VFRT1F4F5ukOzfzmdjRUn6gDc0D3xBvCMdAEj/JwA5+vxL9rs0PfR9eMKOVlrvKuJio0s5o8vidw36TbhxPsxOvL066RhuPcNR/rHW8Jw83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cJPEWGwr; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768381445; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=vru4qqvd6vfkmW4oSPBAf9d+FtbuJeRtBfOkzZOk7JA=;
	b=cJPEWGwrgEMEw9PjqKeGvJdlNqxgU9XBG6NL07G5OENWYBdtepbWQ9mC8ONNWER6rS+LOYkqyNo9ztAYLsrCdNd0YKwWAUXvKlbDqPiKaBWamCRW4bHjck7WMvlQJ5ci8CESyUMLXHo7IFlzHne9lO4fbph4hBfdsljDb93t7TQ=
Received: from 30.221.147.158(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx1kx4v_1768381444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 17:04:04 +0800
Message-ID: <70969f64-1e67-4993-b980-3e38c59196a6@linux.alibaba.com>
Date: Wed, 14 Jan 2026 17:04:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ak: fuse: fix premature writetrhough request for large
 folio
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260114055615.17903-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20260114055615.17903-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 1:56 PM, Jingbo Xu wrote:
> When large folio is enabled and the initial folio offset exceeds
> PAGE_SIZE, e.g. the position resides in the second page of a large
> folio, after the folio copying the offset (in the page) won't be updated
> to 0 even though the expected range is successfully copied until the end
> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
> before the request has reached the max_write/max_pages limit.
> 
> Fix this by eliminating page offset entirely and use folio offset
> instead.
> 
> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---

Sorry I will drop the incorrect prefix of the subject line later in v2
leaving some time for more feedbacks.

-- 
Thanks,
Jingbo


