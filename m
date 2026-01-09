Return-Path: <linux-fsdevel+bounces-72995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565FD0744C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 06:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF08301EC5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4644288CA6;
	Fri,  9 Jan 2026 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N2A2KVbn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F986280312;
	Fri,  9 Jan 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938184; cv=none; b=DGgiqhtPgFCeuCpcPkkxTNdM+NX9Yfg77xmBZ7Gy1TeU96WhE5NQ3/vylfYEKS2EpjkGa8dBM7qxrrdiwFMOfWUFoR6gv0g40N/gHxG5G3jofv4o16GHs/IwUc+t0GmPSAmD2HRbPdPGDq1Ln0S7t1WvCQlgCrNfRhfziLXpc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938184; c=relaxed/simple;
	bh=hyYX25MCWDg6rxTIAbrKlXz090v3lNti7+PlNrqkL98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBMRdSPkMy3nbjUdIwpjgtV/eBF63chVg9q/2ILTEwxgnNsf2Puqar9QjEMATC9QdGEG/xd6mto1uzGjtMSqfGthD+YhCD8mXShRJmRXULdsckVUGU4BmyTmdv9YqHiktm86+8IXwC9r79tGytMV2j0UngnJcYwKu6+cKzTsD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N2A2KVbn; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767938180; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=htMczdh8oSn3FZWxwjQi/ljmic3LiX154yV0o2PuC4w=;
	b=N2A2KVbnTqWBWAWg8Q8ejCIYpwE3n6K5I3h5VCvx/xNUMGg0cc4KJck1sAeWHYqU1PA9T217OtEkjfOy80vMEib5TTrAPIg0AVowPEe2AmbE88o1/NKuvBAZIK4h0EryXW5dmF1b0vr8beAEL1UBg/ciYDPx3l/Gdqxfd5Ntw8A=
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwf6bI-_1767938178 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 13:56:19 +0800
Message-ID: <97a97322-cf80-428b-a59c-d83080d16800@linux.alibaba.com>
Date: Fri, 9 Jan 2026 13:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109030140.594936-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/9 11:01, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

