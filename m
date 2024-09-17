Return-Path: <linux-fsdevel+bounces-29563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACE797AC96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97DFBB29083
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC615697B;
	Tue, 17 Sep 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MvkUBde5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D0152E0C;
	Tue, 17 Sep 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560524; cv=none; b=m+hUWRS5pORmQ9C5s/+fidm4hbPF3aK3ZySALI1eGQ65tmPXsPfiiveP9lL+3Z2RzPgC9+drep5SyW39JYWzwUhLbYaoXfjj/gnS3EAmYM0QwPlGhe6agyx9j895QJD85IbRPwdkcF1t0X/gC1kkUtQBTPbGTyuI2K21o/7bjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560524; c=relaxed/simple;
	bh=f4Ch4NcQn4tmNn08i8cfN0ybAqWfXzIaika3s6Ft/ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf0zn5Ux6y7vgdiBLI+S0KKj7jiN5iNo7QXY0NC9XKs+Bh2A37axiFB/z2gyEzFTWOxhi7DVueEvZckK3GyZXlloR0KzCqgoGH1rgJNY3c6rQDmJMoIBmIAg3vOQ0rZyXY5/vAh4QnfnghdmeXnH543pvHtsqI+lORZQf3yOKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MvkUBde5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726560509; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I8eWoKaw2PNnTTn7YsG5l65WbNKRB5CSK40+WOhrwfs=;
	b=MvkUBde52WXuB19AJKQNO3vGm9kww5tKJqlUra79SA+G2TBeAddd9AT/8y6Tps+E1sDBog4hDYthIHTYeCKLGiRYlFMMNs4AJE8vxmBUWIkboglSxyYETqSsr0Ok8Lcuujk0ufN5kVFljVqy6AdYyCRbasOgcXhzq0H4kW9focA=
Received: from 30.244.95.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFARatd_1726560507)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 16:08:29 +0800
Message-ID: <8871d954-4e6d-4e2d-9080-c5950e7ac2c6@linux.alibaba.com>
Date: Tue, 17 Sep 2024 16:08:26 +0800
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
 <20240917073149.GD3107530@ZenIV> <20240917074429.GE3107530@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240917074429.GE3107530@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/17 15:44, Al Viro wrote:
> On Tue, Sep 17, 2024 at 08:31:49AM +0100, Al Viro wrote:
> 
>>> After d_splice_alias() and d_add(), rename() could change d_name.  So
>>> either we take d_lock or with rcu_read_lock() to take a snapshot of
>>> d_name in the RCU walk path.  That is my overall understanding.
>>
>> No, it's more complicated than that, sadly.  ->d_name and ->d_parent are
>> the trickiest parts of dentry field stability.
>>
>>> But for EROFS, since we don't have rename, so it doesn't matter.
>>
>> See above.  IF we could guarantee that all filesystem images are valid
>> and will remain so, life would be much simpler.
> 
> In any case, currently it is safe - d_splice_alias() is the last thing
> done by erofs_lookup().  Just don't assume that names can't change in
> there - and the fewer places in filesystem touch ->d_name, the better.
> 
> In practice, for ->lookup() you are safe until after d_splice_alias()
> and for directory-modifying operations you are safe unless you start
> playing insane games with unlocking and relocking the parent directories
> (apparmorfs does; the locking is really obnoxious there).  That covers
> the majority of ->d_name and ->d_parent accesses in filesystem code.
> 
> ->d_hash() and ->d_compare() are separate story; I've posted a text on
> that last year (or this winter - not sure, will check once I get some
> sleep).
> 
> d_path() et.al. are taking care to do the right thing; those (and %pd
> format) can be used safely.
> 
> Anyway, I'm half-asleep at the moment and I'd rather leave writing these
> rules up until tomorrow.  Sorry...

Agreed, thanks for writing so many words on this!

Thanks,
Gao Xiang



