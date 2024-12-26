Return-Path: <linux-fsdevel+bounces-38136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FF9FCACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 12:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9551882E33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EF1D461B;
	Thu, 26 Dec 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BSmQEceJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571F1D279C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735214337; cv=none; b=rKnr/x7bCYJGQVigv9CboFNr78PAt9AJuk+GfV2Qe4rSbOwQXaF7549L6/OgtJjwflV6Y3RhqwMfQx2dptTKZfxOnGqlSGx5iR7Hn/Kh4ba83RjGDos8E4FcSGUq9ZAkfnoev5ZMSbf1Vr1G8biolmo/N/KrBvtE4gNeAhlXqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735214337; c=relaxed/simple;
	bh=HkLO7HSvsgbjWkp9INFrhjHDn7uOFJ5uST5n7CVvTIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPRn2AomZACng6jBaZAvnhKbYzjbszd/WsBZYNMUHQH6cMqT1J6KwFeSLBXcRfZTal/xUIq5C1cfppUhPSGaMTWgRxjIzRPhtMRDNlbN7yUWv1xILDyWXeiqobYXwmJzVzcSx7kYOLghSdvk9YCZFjWpXG7OiBCe7vX+XoSWKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BSmQEceJ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <18333234-0211-4b86-abd8-a61bcefde39d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735214332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH1OrBelFbg5T3rVzJGEaTWs6JQnmpXRdg09/mh41i0=;
	b=BSmQEceJufxpwn/GiBFz7qbDaQIhHgEa0nC+XmA0zwDPpmDWMDZHVbJlb4VICaAoy50bIN
	BQvvICTIdDdAsminF1f77YfWvE3PJATSkbyZn3Lc3LcpkBQeZIylUuRgLx8V9TSDFNqDMP
	yKBKy/K2S5TeBw8cv7EsnvCdMF51PYE=
Date: Thu, 26 Dec 2024 19:58:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sysctl: unregister sysctl table after testing
To: John Sperbeck <jsperbeck@google.com>,
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20241224171124.3676538-1-jsperbeck@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20241224171124.3676538-1-jsperbeck@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Good catch, thanks.

Reviewed-by: Wen Yang <wen.yang@linux.dev>


--
Best wishes,
Wen


On 2024/12/25 01:11, John Sperbeck wrote:
> In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
> of u8 to sysctl_check_table_array"), a kunit test was added that
> registers a sysctl table.  If the test is run as a module, then a
> lingering reference to the module is left behind, and a 'sysctl -a'
> leads to a panic.
> 
> This can be reproduced with these kernel config settings:
> 
>      CONFIG_KUNIT=y
>      CONFIG_SYSCTL_KUNIT_TEST=m
> 
> Then run these commands:
> 
>      modprobe sysctl-test
>      rmmod sysctl-test
>      sysctl -a
> 
> The panic varies but generally looks something like this:
> 
>      BUG: unable to handle page fault for address: ffffa4571c0c7db4
>      #PF: supervisor read access in kernel mode
>      #PF: error_code(0x0000) - not-present page
>      PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
>      Oops: Oops: 0000 [#1] SMP NOPTI
>      ... ... ...
>      RIP: 0010:proc_sys_readdir+0x166/0x2c0
>      ... ... ...
>      Call Trace:
>       <TASK>
>       iterate_dir+0x6e/0x140
>       __se_sys_getdents+0x6e/0x100
>       do_syscall_64+0x70/0x150
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> If we unregister the test sysctl table, then the failure is gone.
> 
> Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>   kernel/sysctl-test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 3ac98bb7fb82..2184c1813b1d 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -373,6 +373,7 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
>   static void sysctl_test_register_sysctl_sz_invalid_extra_value(
>   		struct kunit *test)
>   {
> +	struct ctl_table_header *hdr;
>   	unsigned char data = 0;
>   	struct ctl_table table_foo[] = {
>   		{
> @@ -412,7 +413,9 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
>   
>   	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
>   	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
> -	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
> +	hdr = register_sysctl("foo", table_qux);
> +	KUNIT_EXPECT_NOT_NULL(test, hdr);
> +	unregister_sysctl_table(hdr);
>   }
>   
>   static struct kunit_case sysctl_test_cases[] = {

