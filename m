Return-Path: <linux-fsdevel+bounces-36718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBC9E8918
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 03:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C01657F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 02:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA725777;
	Mon,  9 Dec 2024 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IhpvrTqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C219ED
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733709758; cv=none; b=XEiOT1bybY9XFcgE6fEILHD7Au2EaQngridXK+pVr1ETqPLe5Bv6g6Xa7nIODXbG5oV3+M9VYTu2RgNx74eDJ7Df8qUKe9IK00UKQqncHIu3+z7biShZqSn5IYjuAZLQUUYt1j1rKKQxVbGfLvexCL9pF8RJPdFED2U3JNtsywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733709758; c=relaxed/simple;
	bh=ILNotJMB5YXF7BvbO9G9CHDrqrG8VL0cPmNloAezf0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvDYe4mD5nnk5W7f5elIy82eLjmyXY8rQE1Pd2zyNcEOM4kzQgvwJLSNe54ehRAxpjef/1k5MstdACxzlK/F7SSDCUEJH0sHCUJIkf1PQgRtCc1MznixtVul7zI0P/ev2pzPYPE3D6ZjTGo5DvR7eyTakQEo0lzD3nsdprfOzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IhpvrTqd; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733709747; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/cczKR0K4MpPpeDeA8HU2PnWHfInvz1P3gQ3ALA6BNU=;
	b=IhpvrTqdL+ohUEOR0v9foMc6r7Ul/q4Fes4sVy40PhoRWjzA+BrIv0c2rgXB7XCrMEsBQoodeEq9JMnTueGnFlAZ9/oQqt6YPGosuKH7ZuehnhCVw+f8yuxF73/SQrFEyNLUx654BgYLkmGmW7XMvBKz0BrmcqVkz9O4KIai1eQ=
Received: from 30.221.147.247(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WL1X9wA_1733709428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 09:57:09 +0800
Message-ID: <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
Date: Mon, 9 Dec 2024 09:57:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: silent data corruption in fuse in rc1
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Malte

On 12/9/24 6:32 AM, Malte Schröder wrote:
> On 08/12/2024 21:02, Malte Schröder wrote:
>> On 08/12/2024 02:23, Matthew Wilcox wrote:
>>> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>>>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>>>> me.     
>>> That's a merge commit ... does the problem reproduce if you run
>>> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
>>> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
>>> between those two.
>>>
>>> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
>>> of an interaction to debug ;-(
>> I spent half a day compiling kernels, but bisect was non-conclusive.
>> There are some steps where the failure mode changes slightly, so this is
>> hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
>> the nfsd-6.13 merge ...
>>
>> d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
>>
>> /Malte
>>
> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
> with 3b97c3652d91 as the culprit.

Would you mind checking if [1] fixes the issue?  It is a fix for
3b97c3652d91, though the initial report shows 3b97c3652d91 will cause
null-ptr-deref.


[1]
https://lore.kernel.org/all/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com/

-- 
Thanks,
Jingbo

