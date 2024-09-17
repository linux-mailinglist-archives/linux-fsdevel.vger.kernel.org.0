Return-Path: <linux-fsdevel+bounces-29562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A897AC91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D1F1F2181A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3914D45E;
	Tue, 17 Sep 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lniaXijO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E512F399;
	Tue, 17 Sep 2024 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560431; cv=none; b=RD7hG/WO2xFKB/CYMRMpNaJ4csw7AnMVVxqMDvPs29USve2FNxd86urtzVZkphaD9qZnMOanhejGwKo7kCY69ovrVpncaknWYR92gapvrLX49OH4erN25TjokEdOPGSaO7oyFa7URVzSIk0IXsMo/zFPDCsGBXlLiejWMRyXXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560431; c=relaxed/simple;
	bh=tqJo6nTksgHuGMYt5OCVWCVWQ61LgmqMjoGYJo/l1Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDXZZwKqqvQjyZBtEQdxtCAaaQQS1pZAW6xGTycNW3BIZuDscXBvAgZkGfcA1Z+wpF7HLjYXSx1ntOKqOwjKs99T3tU39x55dduxLNCbVOucbvBt/MCrQziDzIbGwgoeuIk342/ZJHh12Ta5kqYIPeByyfRAE9kvz9JTvtEIyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lniaXijO; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726560420; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zD8A7S8NSOoYTS0UIC1YFPPNS2TblfcXM5xymSmNV04=;
	b=lniaXijOp+SP5SOHzvc81qVzN3WCkHEsaj0ZFM+JZqFz3y4h2+Vh5sunmdEjwr9ajQ3M8YrSzcXaIOxBbj+gkoG3Xm4QeJAaqu92qGmKCb5izSdl296nwgGBifhcxLyW9RNqVxLtl0OreZXngfIyN5c/UIOA3Grz6bXxb/2wp/I=
Received: from 30.244.95.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFARaTY_1726560417)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 16:06:59 +0800
Message-ID: <b39d430d-3ecb-4537-8d9c-9f0c50cefdf0@linux.alibaba.com>
Date: Tue, 17 Sep 2024 16:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/24] erofs: introduce namei alternative to C
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-20-toolmanp@tlmp.cc> <20240916170801.GO2825852@ZenIV>
 <ocmc6tmkyl6fnlijx4r3ztrmjfv5eep6q6dvbtfja4v43ujtqx@y43boqba3p5f>
 <1edf9fe3-5e39-463b-8825-67b4d1ad01be@linux.alibaba.com>
 <20240917073149.GD3107530@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240917073149.GD3107530@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/17 15:31, Al Viro wrote:
> On Tue, Sep 17, 2024 at 03:14:58PM +0800, Gao Xiang wrote:
> 
>>> Sorry for my ignorance.
>>> I mean i just borrowed the code from the fs/erofs/namei.c and i directly
>>> translated that into Rust code. That might be a problem that also
>>> exists in original working C code.
>>
>> As for EROFS (an immutable fs), I think after d_splice_alias(), d_name is
>> still stable (since we don't have rename semantics likewise for now).
> 
> Even on corrupted images?  If you have two directories with entries that
> act as hardlinks to the same subdirectory, and keep hitting them on lookups,
> it will have to transplant the subtree between the parents.

Oh, I missed unexpected directory hardlink corrupted cases.

> 
>> But as the generic filesystem POV, d_name access is actually tricky under
>> RCU walk path indeed.
> 
> ->lookup() is never called in RCU mode.

I know, I just said d_name access is tricky in RCU walk.

->lookup() is for real lookup, not search dcache as fast cached lookup
in the RCU context.

Thanks,
Gao Xiang


