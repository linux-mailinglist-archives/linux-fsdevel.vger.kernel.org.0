Return-Path: <linux-fsdevel+bounces-56707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D6B1AC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193153B7EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDC1A9B24;
	Tue,  5 Aug 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sg+HJsZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65F288DB;
	Tue,  5 Aug 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358596; cv=none; b=Ed8HnJFmUP7OsUwz3N30r8mp5/fSeOSWflqGkCkWlehehLrCqlAjclWIp6VEmEkPQOBryZoJyYnOsJL9QnV60Se9r8uegb99oiOUmZhXENQ6qy0kw6c0/E/5cJRfz1hUgG6wpdh4KBPerALEI1rXeM37RtlZIQj/BSsGeF3STwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358596; c=relaxed/simple;
	bh=uPhfCt+Gk+6ssNFj+WuNt3PKXTNzfrVOwR/OpC8K+9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZumZ1+CmY+brjNCd8LJNSsl/9RJPWyw/BGWM3O57hJ2LxLdtQov6SEWItklG8q7Sk/t7z4KFRL71IpVaULQGpzyAKFuNd4pjPjHBphWXUfUXRsxfl5uN/75OEMZWFAwKMR4ArZI9QkXpsu1YGkkVbZfQBwF32uQbvPaDJaJsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sg+HJsZE; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754358591; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Rh+PmBHA1gbb8whqL0XrewPPTjKcvEmBiru3WFTQ8U0=;
	b=sg+HJsZEGDnljQqrHWN9dC74GL7rGx/Zhz0B9oBjeRvGNPC6iYtFOdW2BC4AGhBU0VZiHrP+ku8VUztYYAANQ3JyJG2Cpqys5WgZ1PanxdnhAskODH4PygN9hPg/FFemvF1e6bX69pH+wcJ26R/P/Fb1P4DL55yo8YfPnHlZ5Lg=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wl3-EKr_1754358588 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 09:49:49 +0800
Message-ID: <ebbac3ee-df43-4a39-95b2-53f9cdd34e16@linux.alibaba.com>
Date: Tue, 5 Aug 2025 09:49:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm/huge_memory: respect MADV_COLLAPSE with
 PR_THP_DISABLE_EXCEPT_ADVISED
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, npache@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-4-usamaarif642@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250804154317.1648084-4-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/4 23:40, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Let's allow for making MADV_COLLAPSE succeed on areas that neither have
> VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
> unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).
> 
> MADV_COLLAPSE is a clear advice that we want to collapse.
> 
> Note that we still respect the VM_NOHUGEPAGE flag, just like
> MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
> refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED,
> including for shmem.
> 
> Co-developed-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

