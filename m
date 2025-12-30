Return-Path: <linux-fsdevel+bounces-72242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFEACE998E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 12:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2A2302A39C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085102EAB64;
	Tue, 30 Dec 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pQRWhyGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B32E9ED8;
	Tue, 30 Dec 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095895; cv=none; b=rA2Hbj2IyeM//IF9mqL0Gk9AM7vYSToYPGsfitJiv3M/F71ylVFfPGtDbnky4DcY0rK1Xp+sMCB14rLogtNI8/iNaMGJNYwGiPEEc69HLaVCjeBXU5yxnM2rZHLQb0ZrLaRWm1jH0UFm1u1USjJOq5XmPzOHbVXojcGyv0n8uXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095895; c=relaxed/simple;
	bh=mr/Q+VTMuwV7EaBdzj5WQutfyv55Z/+HNuZvrCj6qq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWQ+lxFVGWEhiT0ujy7gTbWDwhm6+KOvf6/txEP/CwNjkGiH8dd2RcEk00RD8ilFwtbODmVU6UbnN+Mkf2UYrMyBmeixnQqdsP4M4xnxR3qbx1hr25tQWTd7G8um7yUmDbdCHqnUDhikDlsFfiSAh9BUa8YK8B/9RUaxk82z64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pQRWhyGB; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767095887; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QfMKwMmGeZ3yyKKgMIczxqqr3B1VObqB4AH1thpey40=;
	b=pQRWhyGBiWapDJyTYG9r1iLpMnfmYSA0imordR6kUH4ZpHyqGW+nF0+ub/2Fi5Gp5CGqvFioDJO76gvfXjkli5tEp1ZTQ2CCyrM5bGj7NVgZXSwmwFOqVREMklGKa+2UJ/ZHHkFel1FluenTGtktJBPNRtlljihRzC1nNXET4Uw=
Received: from 30.221.148.103(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WvzvQTu_1767095886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 19:58:06 +0800
Message-ID: <cc37fe4a-8e03-41c7-bec5-00e946928feb@linux.alibaba.com>
Date: Tue, 30 Dec 2025 19:58:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/2] fuse: compound commands
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>, syzbot@syzkaller.appspotmail.com
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <be2abea2-3834-4029-ba76-e8b338e83415@linux.alibaba.com>
 <aVON2GgM7KK4oBb_@fedora.fritz.box>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <aVON2GgM7KK4oBb_@fedora.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/30/25 4:36 PM, Horst Birthelmer wrote:
> On Mon, Dec 29, 2025 at 02:03:02PM +0800, Jingbo Xu wrote:
>> Hi Horst & Bernd,
>>
>> On 12/24/25 6:13 AM, Horst Birthelmer wrote:
>>> In the discussion about open+getattr here [1] Bernd and Miklos talked
>>> about the need for a compound command in fuse that could send multiple
>>> commands to a fuse server.
>>>     
>>> Here's a propsal for exactly that compound command with an example
>>> (the mentioned open+getattr).
>>>     
>>> [1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
>>>
>>
>> To achieve close-to-open, why not just invalidate the cached attr on
>> open so that the following access to the attr would trigger a new
>> FUSE_GETATTR request to fetch the latest attr from server?
>>
> 
> Hi Jingbo,
> 
> you are probably right, that it can be achieved that way. I thas some consequences that can be avoided, like having to wait at a later moment for the attributes to be fetched.
> 
> The main goal of this patch however was not close-to-open, even though it was discussed in that context.
> 
> We can do a lot more with the compounds than just fix close-to-open consistency. As Bernd mentioned, I am very close to havin implemented the fuse_atomic_open() call with compounds, namely the atomic combination of lookup+create.
> And there are some more ideas out there.
> 
> open+getattr was just the low hanging fruit in this case.


Got it. Thanks.

-- 
Thanks,
Jingbo


