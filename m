Return-Path: <linux-fsdevel+bounces-74185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE7D338D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E17330268E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843D42DF12F;
	Fri, 16 Jan 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MFI8GmJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4257275AF5;
	Fri, 16 Jan 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581822; cv=none; b=m7GphpND3Ff+dGdhlec29YfOVPKbx/NsShqY/XO73ct1geDrVMwYzswGbDA0ZMXN0LzDPoGUEH9QohP7fBO72mc0GRZ2jBQpd00GgnqfB9mO5Tc05hUMuvR+In0wSNugEHH/7g+aKjKWJHUNwh8cP54sWqLltPnoH6NR8mlEZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581822; c=relaxed/simple;
	bh=1qH9xccdgRcSbc3RaEmgCpJMFt/NEQC0AgdcgiC81K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXI+QXZwjlELi/J1SQa4sHvQn8aEAT5uABo2k7HsEu8nGx+BezaXFKGOZy/YIg4AUtrNro75IYnKidDIqUmnAj0xX6Fw5fLDo2sN1kdl71aR0qyn7EOD7FGQDUoueyw3fiQyhxFLIgDU7VomfuiA9KMdhn6ecSXqovDRO2BNohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MFI8GmJI; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768581817; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CqdOrZ2fLYyllUFgm+eEnv6iIUPlCxvHxAAq4fRi+uk=;
	b=MFI8GmJIcybJ2q2Ti09U6oUWDEe3o8HVqbZkOjxDCPnDQzGtaaMKvAeqvgpzr0plKM4QmYKSLFIwkI3VnFcGiIQBl4kb3VAuQfvksv+aATOjRXlxQvsoQenZ54b1AujFTTcbhZznG5oE6hxIoWC1z36XmTsMlUT7qxLmb34kzUU=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxAj92w_1768581815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 00:43:36 +0800
Message-ID: <e8a5f615-b527-4530-bc3d-0adc4b0b05d6@linux.alibaba.com>
Date: Sat, 17 Jan 2026 00:43:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116153656.GA21174@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116153656.GA21174@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/16 23:36, Christoph Hellwig wrote:

> 
> Also do you have a git tree for the whole feature?

I prepared a test tree for Hongbo but it's v14:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/pagecache-share

I think v15 is almost close to the final status,
I hope Hongbo addresses your comment and I will
review the remaining parts too and apply to
linux-next at the beginning of next week.

Thanks,
Gao Xiang

