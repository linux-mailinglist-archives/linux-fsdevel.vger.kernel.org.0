Return-Path: <linux-fsdevel+bounces-62482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADAB94A13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F176483562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328F30F93D;
	Tue, 23 Sep 2025 06:56:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3428A73A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610601; cv=none; b=OW4rd9GYIhGOZHVTfoz2qnUUSvUXiCG8/vyyQbgPNKOz0z4Q2O1rTWghmOQcpSe9sHLBISyn6nB1B/r7iEUiv85CYkuROkNdCqiE83oGuIEkuVU9Iayn4t6OQf/wXrvOTU/ka9WoAVjqg6AYEdSY2hh27iyta8sEOc7f0yrWgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610601; c=relaxed/simple;
	bh=I/IiTTCON7MAqe+2a6FJZkGnwUwBcCmWQ/ix20O2tnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGvtjMPfX0D5GBf71KfPlTmy0B5gBi1uvom7v5fhhEBSZZKw3mJ9UfjT4Q1imDnn7aK+jmGvBKhbgr9AIqZ7euQ1FGQkOr5/2N0ZHPc+Gk2fi5V+zkcZhDWBxvjzg0BJmVLXRLRDkKn64Qb2HVB4bedxMZ9qQm+2GJExkf7M2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6EF6497;
	Mon, 22 Sep 2025 23:56:23 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0205B3F66E;
	Mon, 22 Sep 2025 23:56:29 -0700 (PDT)
Message-ID: <57ecacfc-dfbe-44f6-947b-39ab98aa07ef@arm.com>
Date: Tue, 23 Sep 2025 12:26:27 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cramfs: Fix incorrect physical page address calculation
To: Alistair Popple <apopple@nvidia.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org
Cc: Haiyue Wang <haiyuewa@163.com>, David Hildenbrand <david@redhat.com>,
 Nicolas Pitre <nico@fluxnic.net>
References: <20250923005333.3165032-1-apopple@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250923005333.3165032-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 23/09/25 6:23 am, Alistair Popple wrote:
> Commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
> incorrectly replaced the pfn with the physical address when calling
> vmf_insert_mixed(). Instead the phys_to_pfn_t() call should have been
> replaced with PHYS_PFN().
>
> Found by inspection after a similar issue was noted in fuse virtio_fs.
>
> Fixes: 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>
> Cc: Haiyue Wang <haiyuewa@163.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> ---
>   
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


