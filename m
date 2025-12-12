Return-Path: <linux-fsdevel+bounces-71191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28893CB8914
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 11:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA0AF301895A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51A2DA76D;
	Fri, 12 Dec 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ufpEyrQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C31624DF;
	Fri, 12 Dec 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533721; cv=none; b=f0GEonqQ81rQ0fP2VTEmTp4dRbTR8ypNwGJb6YbmAzLFz9qX6xuOxQzXW5CYx+3MHdWDWroWCWi6pgPteARRNsBIxf99mvzuYyY8RGt6rs4G+MfaR/wROTVFAGkvLBrn8+IaQ8gZfd2RHXJpLV2hfthwisg3ZbEPVGiDujM8GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533721; c=relaxed/simple;
	bh=lZf8xGs8SFWp/5d0SQ4aRAm65v6QuadpUf11bbgHK5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpIoe82QnGuUx+HJqxUpVPjlt48TBAVPKEbqL/P8Gx/2/Wqb5Ufkq80GZWv5EkaJqMT2Bf2LHAVuqdUK2hezs5u2/fHYC+HP1fzGZnXAF3ezBR090YHlBhpq8wEkaS4Au2iAzzVzggBUCVVZp0JiBjB3ujiP6/IAulE2rTkUUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ufpEyrQ8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765533715; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=axgu2pAVQE5lYbVxyd4Veeg8w0FPCA1ZdjvHN9a5KEg=;
	b=ufpEyrQ8LuhcSQ0RObH9PVX633bT53PUn/81SLGv+yBSaHpIR2n4epcv/xOXEjeCjWZ3bcDta3+CDU/zEYVkzFo87yXJtWSXm0QxjkkD2Fwn4QuZE9iugLMQYkxnrlkuqfn82cuHA0VZ3AIpIc22reXhbJ9NYTLIQsz7tXPzsyk=
Received: from 30.246.163.93(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WudueoQ_1765533713 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Dec 2025 18:01:54 +0800
Message-ID: <038af1cc-a0f1-46a6-8382-5bca44161aee@linux.alibaba.com>
Date: Fri, 12 Dec 2025 18:01:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] file: Call security_file_alloc() after initializing the
 filp
To: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
 <dpuld3qyyl6kan2jsigftmuhrqee2htjfmlytvnr55x37wy3eb@jkutc2k4zkfm>
Content-Language: en-US
From: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <dpuld3qyyl6kan2jsigftmuhrqee2htjfmlytvnr55x37wy3eb@jkutc2k4zkfm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/9/25 4:22 PM, Mateusz Guzik wrote:
> On Tue, Dec 09, 2025 at 03:53:47PM +0800, Tianjia Zhang wrote:
>> When developing a dedicated LSM module, we need to operate on the
>> file object within the LSM function, such as retrieving the path.
>> However, in `security_file_alloc()`, the passed-in `filp` is
>> only a valid pointer; the content of `filp` is completely
>> uninitialized and entirely random, which confuses the LSM function.
>>
> 
> I take it you have some underlying routine called by other hooks as well
> which ends up looking at ->f_path.
> 
> Given that f_path *is not valid* to begin with, memsetted or not, your
> file_alloc_security hoook should not be looking at it to begin with.
> 
> So I don't think this patch has merit.
> 

The scenario is as follows: I have hooked all LSM functions and
abstracted struct file into an object using higher-level logic. In my
handler functions, I need to print the file path of this object for
debugging purposes. However, doing so will cause a crash unless I
explicitly know that handler in the file_alloc_security context—which,
in my case, I don't.

Of course, obtaining the path isn't strictly required; I understand that
in certain situations—such as during initialization—there may be no
valid path at all. Even so, it would be acceptable if I could reliably
determine from filp->f_path that fetching the path is inappropriate. The
problem is that, without knowing whether I'm in the file_alloc_security
context, I have no reliable way to decide whether it's safe to attempt
retrieving the path.

