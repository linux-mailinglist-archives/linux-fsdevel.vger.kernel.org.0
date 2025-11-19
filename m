Return-Path: <linux-fsdevel+bounces-69051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEBC6CE2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 07:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E3F472D091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208530EF91;
	Wed, 19 Nov 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LwUxrE4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DA25BEF8;
	Wed, 19 Nov 2025 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533036; cv=none; b=t4kRVSYmcSlENQE7lbfTDX6C2jaieZYzFu2kceWLY04VV0ZDQaRvMnE0FkoeaSkoeogcPJx66T/7pHvPP6ZJ3GloOMA2RT24UHS5C4Zmkfeu2UDtv0zZ9LkdHLay4BWA4ExXqb1OLqeMj9018iLRzCPrs5C039HWfgw9XxGTf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533036; c=relaxed/simple;
	bh=/dZgyzuLUkuILxW1pDzr6u+owNzlVAntyNq6QMOAT38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV1wiVOvnVZjRMRBH8AZ93g1MaXwSXXM1TiAKhTzP/m48EYNVzVDkkpddzsvK2a00I/A9SDqJoR7vgKjTFg//4Y+C5Inh6NQKiz9iJzbeO0bZDwsuY7EDImc5UPXF/jrRBv8VCmALx2ubwlbEK/FGDjG+k9JgRkZReZspn67KW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LwUxrE4x; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763533029; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kJM2+txK39zSBZAW6+j8p6tvdTb3h7gwyHWV6tLX5Pw=;
	b=LwUxrE4xUjxxXLufHFzUA5nBMoIgGTSqT+KKq1p9GTIMK2rfk60+KJ652r6aPFrxJdMNfJO7vmmj93YnM8cxME9yfNYzqK2ow7DOz6+W8WIG59Q71rbDitLJdvFzEKBcQju+9jNVqeK3Wpa0JfFQg6XQbkxtto20Y29jMK9spcA=
Received: from 30.221.131.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsnTUov_1763533027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 14:17:08 +0800
Message-ID: <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
Date: Wed, 19 Nov 2025 14:17:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
 <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
 <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
 <20251119054946.GA20142@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251119054946.GA20142@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2025/11/19 13:49, Christoph Hellwig wrote:
> On Tue, Nov 18, 2025 at 03:35:45PM +0800, Gao Xiang wrote:
>> (... try to add Christoph..)
> 
> What are you asking me for?

Sorry about the confusion.

Hongbo didn't Cc you on this thread (I think he just added
recipients according to MAINTAINERS), but I know you played
a key role in iomap development, so I think you should be
in the loop about the iomap change too.

Could you give some comments (maybe review) on this patch
if possible?  My own opinion is that if the first two
patches can be applied in the next cycle (6.19) (I understand
it will be too late for the whole feature into 6.19) , it
would be very helpful to us so at least the vfs iomap branch
won't be coupled anymore if the first two patch can be landed
in advance.

Thanks,
Gao Xiang

