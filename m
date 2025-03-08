Return-Path: <linux-fsdevel+bounces-43510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E359A5787B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 06:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26C31748F5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 05:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E717A31F;
	Sat,  8 Mar 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ciKEGUSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4625569
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741412077; cv=none; b=p4hjekIxOC4A7Bx2W+W2QkaRzL26hlyUWT7JaRiO7teiGXPC2Yks13v0lHumrghBvJiNbTy2zrjy9qvq9z6iVdblPbMpffizohv1ZG1nL4BxHZiYYW5KoxPArSnP1Qq2fkDq3NLBvEXDYNjcluO7VvmoHk0KUIVj4mhI3NRhY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741412077; c=relaxed/simple;
	bh=SAXAuYbXMMFMJLoTsuBBs6OSLgFBbT+9RfXfIOtNu+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDigsRwCkUiIB2YStYcE9NY+Iv45WGI85uctPZ049LKCqITSulzqW86LlYRHmQSTHK5VwzwJ1qvEx2MEfJbDn1kVH+TR6ctE9zmI5mycxDvkHg+VwvNytXxQ1Q6tHeqmH7yXKweT5fUyy9c6b3ZHSoWdmAVqi+ucAnUi8lk206s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ciKEGUSW; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741412070; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HTIcER/dyIswpMrv6blznZFW77d+UzEIvHyZ7/F+fAM=;
	b=ciKEGUSWshNO+IncrIsiy0v5euVuKNgvR48S/WwNnt4CsGNrNamiZ1JDAGLqfxuc9G19ynY3L8Z42EE3albwvWkJ6MKBpulgO8EGJF1DtFL+rOVtF1cPyqCa8J+WdxqwcIHcCgD3oleke6hanzS8oUzc7FHY4vxr4gV66Eo7i0U=
Received: from 30.221.80.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQu4qrn_1741412069 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Mar 2025 13:34:30 +0800
Message-ID: <315f4426-0ed0-4ce6-8b12-ca4e79ee00ee@linux.alibaba.com>
Date: Sat, 8 Mar 2025 13:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] mm: Remove swap_writepage() and shmem_writepage()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org, intel-gfx@lists.freedesktop.org
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-11-willy@infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250307135414.2987755-11-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/7 21:54, Matthew Wilcox (Oracle) wrote:
> Call swap_writeout() and shmem_writeout() from pageout() instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I tested shmem swap-out and swap-in with your patch set, and works well. 
So feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

