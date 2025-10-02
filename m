Return-Path: <linux-fsdevel+bounces-63203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CACBB22A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 02:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519761C6AFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 00:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC78F5B;
	Thu,  2 Oct 2025 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZE4B32Aj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582F4C83
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759365980; cv=none; b=TMfjF68k0gmDZ9fVnQU9SjLhHx6rV/PQTRkbvnlEmohYBnfP1DgpsS0HBGpQA4L9m2OVcq4eaoMsUhkjszhNH+iJ1puygBIQV3k4jfKbiD3DMoqDFvrM63yraJwRZNHnbUEpNCUVTOBeUMBeHrDVFpcT50osiNc6TAVf1u4yzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759365980; c=relaxed/simple;
	bh=iknqd0eCp2IpeMIo/D430dcU7Bg9EpRrkJmCzOFmSRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsuriqqNkxU/ii2tMev4aWwHCO/3qkmpcmDs9UY7En+rDMSjH0cH5cuN1IsM8U++PBUx5uUbOZe8qWANDYge2GtM6k4lH4HaCt1NH7YgTglNfu5VucvTO/cIFfQfBGye0mgg54Dx5Tettf/XPaE0RNLg1z5pGOnmh3YPNsfJBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZE4B32Aj; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759365969; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WuWkMQGeT7UWcs46AL/wq1raG7ZzuHJ8c8y6eoG2uhs=;
	b=ZE4B32AjbNyCMie7Z0FMXMIDGjlYfoRK4WacHd1kbLznDFahHoA0DrHGhZQnUOFfJ78VpTJb3yGuzVBAQyyS50FZwBX9KiZ/7mv+y/4eF8AbM9VoOjRrSO83MhNCCQQrY1Vztfn6xDLCar69jX5/my9nIKfoau+pvCKgFA1dnok=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpGDiat_1759365968 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 08:46:08 +0800
Message-ID: <f8384ff9-d609-4510-aecc-7aa38d9fd9f4@linux.alibaba.com>
Date: Thu, 2 Oct 2025 08:46:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dax: skip read lock assertion for read-only
 filesystems
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: dan.j.williams@intel.com, Friendy Su <friendy.su@sony.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20250930054256.2461984-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250930054256.2461984-2-Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/30 13:42, Yuezhang Mo wrote:
> The commit 168316db3583("dax: assert that i_rwsem is held
> exclusive for writes") added lock assertions to ensure proper
> locking in DAX operations. However, these assertions trigger
> false-positive lockdep warnings since read lock is unnecessary
> on read-only filesystems(e.g., erofs).
> 
> This patch skips the read lock assertion for read-only filesystems,
> eliminating the spurious warnings while maintaining the integrity
> checks for writable filesystems.
> 
> Fixes: 168316db3583 ("dax: assert that i_rwsem is held exclusive for writes")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

It should also fix:
https://lore.kernel.org/r/68ddc2f9.a00a0220.102ee.006e.GAE@google.com

Hi Christian and Christoph,
if it looks good to you, could we apply to the vfs tree
for this lockdep warning?

Thanks,
Gao Xiang

