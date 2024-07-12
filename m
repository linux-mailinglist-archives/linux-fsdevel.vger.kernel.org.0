Return-Path: <linux-fsdevel+bounces-23624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC993018C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179BC1F22A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FAB4965E;
	Fri, 12 Jul 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEHnYT68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A41224EA;
	Fri, 12 Jul 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819421; cv=none; b=EEjedPCW0gZvpeNmr6pbRF1GKXJKX3KKWk5V9yhog/r0zJHoDRwe3tBAAuJ6oxqVQVPxl15tZ9gUE6MgMLv9RKHjoOR2LkOpqhtJ0e4xC5CKSrrg9TzII7kL25jIPdmJIppULBHMngKWg7JXR2CfrLXqe6h71KZcNjMjGktp6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819421; c=relaxed/simple;
	bh=H1Gy57KzCc3eyUgQrW961qMwxBDKdGrxcrwV7mZ3ATc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPgYeLsvQVwY0djbRmD+t9CfuxfafafnD22hXvgLReV+oMtWxOVL3rjzSNwjP6QEBt2KAVsxzgwTrPt6VFJ42lDBNsSwXerPrpWItzMw+wfETrZkrS4+JvH+s2uJfQJm2ju7ZKSLTG77u18QtRE17rmELDnhEVQbTNpPdTCkWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEHnYT68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518C1C32782;
	Fri, 12 Jul 2024 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720819421;
	bh=H1Gy57KzCc3eyUgQrW961qMwxBDKdGrxcrwV7mZ3ATc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OEHnYT687xB2lLXSA8JO080M++w9JlX4rQJROadXzckPsmY879R67LOENSXyoP5yR
	 fdYI+OLtpyx+6mllVilQK8Liqb4+X1WiXHHSbzrZiTfcgMwvUJgNEVWwMKOLdnHALm
	 4Yl1Uwxot0lxLXBvGvVMaw9KG2Vsut6sHGuly2wEv/kEOOzR5ilyRkStEhx9uzbFzz
	 FTY5V6BaJfJnbXTXsy3SNG1WRp0etG9jC0ydE58saotaeTRiVRFjC3N/T68lgj6xro
	 JAJ6HuJTkVT0tFhsbnOY+ipDusxLH7q/e49DuUkTiSz9EBPhkuJhIdc8Wp/MqDfhtV
	 NVmRSCR8XZPJQ==
Message-ID: <e71f73d5-4dbc-4194-9409-6daf807cb27e@kernel.org>
Date: Fri, 12 Jul 2024 23:23:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible circular dependency between i_data_sem and folio lock in
 ext4 filesystem
Content-Language: en-US
To: Byungchul Park <byungchul@sk.com>, Theodore Ts'o <tytso@mit.edu>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 max.byungchul.park@sk.com, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 kernel_team@skhynix.com
References: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>
 <20240711153846.GG10452@mit.edu> <20240712044420.GA62198@system.software.com>
 <20240712053150.GA68384@system.software.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240712053150.GA68384@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/24 7:31 AM, Byungchul Park wrote:
> On Fri, Jul 12, 2024 at 01:44:20PM +0900, Byungchul Park wrote:
>> 
>> What a funny guy...  He did neither 1) insisting it's a bug in your code
>> nor 3) insisting DEPT is a great tool, but just asking if there's any
>> locking rules based on the *different acqusition order* between folio
>> lock and i_data_sem that he observed anyway.
>> 
>> I don't think you are a guy who introduces bugs, but the thing is it's
>> hard to find a *document* describing locking rules.  Anyone could get
>> fairly curious about the different acquisition order.  It's an open
>> source project.  You are responsible for appropriate document as well.
>> 
>> I don't understand why you act to DEPT like that by the way.  You don't
>> have to becasue:
>> 
>>    1. I added the *EXPERIMENTAL* tag in Kconfig as you suggested, which
>>       will prevent autotesting until it's considered stable.  However,
>>       the report from DEPT can be a good hint to someone.
>> 
>>    2. DEPT can locate code where needs to be documented even if it's not
>>       a real bug.  It could even help better documentation.
>> 
>> DEPT hurts neither code nor performance unless enabling it.

enabling means building with CONFIG_DEPT right?

>> > If you want to add lock annotations into the struct page or even
>> > struct folio, I cordially invite you to try running that by the mm
>> > developers, who will probably tell you why that is a terrible idea
>> > since it bloats a critical data structure.

I doubt anyone will object making struct page larger for a non-production
debugging config option, which AFAIU DEPT is, i.e. in the same area as
LOCKDEP or KASAN etc... I can see at least KMSAN already adds some fields to
struct page already.

>> I already said several times.  Doesn't consume struct page.
> 
> Sorry for that.  I've changed the code so the current version consumes
> it by about two words if enabled.  I can place it to page_ext as before
> if needed.

page_ext is useful if you have a debugging feature that can be compiled in
but adds no overhead (memory, nor cpu thanks to static keys) unless enabled
on boot time, i.e. page_owner... so for DEPT it seems it would be an
unnecessary complication.

> 	Byungchul
> 


