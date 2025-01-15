Return-Path: <linux-fsdevel+bounces-39263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA852A11E8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A73F3AE758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA041F9A9F;
	Wed, 15 Jan 2025 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r6g704jJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C924816D;
	Wed, 15 Jan 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934581; cv=none; b=D9X+rdmoS7CFKq9479jo43eCH6wGpvgiV5pCn8+DUycP46QJ15eXjWhiEYmaR3rBCU5p4Ub/cOGqWTC26sTFVnrBz6PINFB0+ZlpV5kbTi0UrPV1QbKzvOkDr2jI5K1/0vqUQZX4ggk7SR/t038e+xsL6Oi+26eK6WbaFdhsqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934581; c=relaxed/simple;
	bh=aP/jyLm67IBTt8+C+kox9ul5wBpAnUnLPZmm0zKs5o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVniudQU1ejiEzJfbEPJt2B9kUw1VMUDTQiNjBaUPkKvB31XmwF2gpm+GKV7As3MigGMrZLP596bnLaFsbpm7sH4PZeZH/OKJdWuARqLBrfD+Lj7LrZlkh4At82aCz2rs2DZ2efTQwogpE2vtU0TFQ7tQiWTubNsFqwqRzynR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r6g704jJ; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736934571; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aP/jyLm67IBTt8+C+kox9ul5wBpAnUnLPZmm0zKs5o4=;
	b=r6g704jJwKx4NPoW+r/oSpCQ5TC3jtc/MuVhanlF0isGvCb2c8fAcUNXgCpdlvQ7py29xwD3vHS+H/UvVMsz3AgIHOaxO/fQTFmRsr68Og7RJJhicjiMIG89Dp8jsyRwRJaTfDxQUI452zE+LJeyf5bpjrW8+ZrXQZPdvj0No3M=
Received: from 30.221.130.98(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNi52po_1736934569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 17:49:30 +0800
Message-ID: <cfdaa8ac-07f6-4474-94fd-a22426a7047c@linux.alibaba.com>
Date: Wed, 15 Jan 2025 17:49:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] erofs: use lockref_init for pcl->lockref
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-8-hch@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250115094702.504610-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/15 17:46, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

