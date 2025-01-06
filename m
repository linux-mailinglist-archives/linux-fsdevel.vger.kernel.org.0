Return-Path: <linux-fsdevel+bounces-38432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B078A0279C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B334918828BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF741DE8B3;
	Mon,  6 Jan 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEyjzDPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E71DE3AB;
	Mon,  6 Jan 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172919; cv=none; b=VPQUs62quw322M6XkTECVEW7P8mbD1y6kJ23zaAphm60CceS3/ZytqTxLOdG8f0wnPamMJmIVu8Atar0KyAyYpJJ8hVPMn6psRkCg4+Dnam649NV66FTxLEkOXzaLXTuiSkaQx2Ancu7AuS5tLtXd3zf9vIwbV1USxlfO/G8C/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172919; c=relaxed/simple;
	bh=nbewPDtJD8+VxOPT187nds5ZyY17h2C6lmFjtPAL4FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3fszgH05iqh9kNER2/Dtxj9GkxKh7Mvv20ExaEEKc5Q/P7zDrwClFczRJErVpMKPoz68nMznLwcD8SIuYOWDvNBUkDSS0qKKcJRc3+3sFx37e/9reqYoEsuuuq6ncDUMdcF5zsJe9kg06N8kd+PhtvBsRw7MD+ADG7suZrS/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEyjzDPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6139EC4CED2;
	Mon,  6 Jan 2025 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736172918;
	bh=nbewPDtJD8+VxOPT187nds5ZyY17h2C6lmFjtPAL4FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEyjzDPLg93pwMtP4Gc7P/XC7Ak8LZoJbiCgbko35zJAKE7ZDB2CtEx1faxSoGv5L
	 IEisGC8ZXGv8sTp1ppTh97OWdSeSdPzp0XY47ziw7TiI+APDR4PU/TxS2ZbEy7jiOE
	 6Pu/B28hOm1zTd6QxO8TLY6jjZ/sM1S46UlxWLc6sD/b4B1zzMu/SLbX1gz6lDlp5D
	 D0aj+g8DpJwGkPqHx2ZnipUYgOYBCi/8JP7idl0iiHRoBhsbX+PAXVtrOIaiELy5eA
	 m2qBEhXHWjkueMpgMPrKCoLb4uxpJen2RLlSBH/R9tV93nRjmQbbUmqzFkFc24Tvwo
	 TRUJP5F7eGQhw==
Date: Mon, 6 Jan 2025 15:15:13 +0100
From: Joel Granados <joel.granados@kernel.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: Kees Cook <kees@kernel.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: unregister sysctl table after testing
Message-ID: <jedmwyiggspxnr76ugyax73zwotbnrwpccy7gafdeq6vyweb6z@4c3ivqegpgkd>
References: <20241224171124.3676538-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224171124.3676538-1-jsperbeck@google.com>


On Tue, Dec 24, 2024 at 09:11:24AM -0800, John Sperbeck wrote:
> In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
> of u8 to sysctl_check_table_array"), a kunit test was added that
> registers a sysctl table.  If the test is run as a module, then a
> lingering reference to the module is left behind, and a 'sysctl -a'
> leads to a panic.

Very good catch indeed!!!.
> 
> This can be reproduced with these kernel config settings:
> 
>     CONFIG_KUNIT=y
>     CONFIG_SYSCTL_KUNIT_TEST=m
> 
> Then run these commands:
> 
>     modprobe sysctl-test
>     rmmod sysctl-test
>     sysctl -a
> 
> The panic varies but generally looks something like this:
> 
>     BUG: unable to handle page fault for address: ffffa4571c0c7db4
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
>     Oops: Oops: 0000 [#1] SMP NOPTI
>     ... ... ...
>     RIP: 0010:proc_sys_readdir+0x166/0x2c0
>     ... ... ...
>     Call Trace:
>      <TASK>
>      iterate_dir+0x6e/0x140
>      __se_sys_getdents+0x6e/0x100
>      do_syscall_64+0x70/0x150
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> If we unregister the test sysctl table, then the failure is gone.
> 
> Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>  kernel/sysctl-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 3ac98bb7fb82..2184c1813b1d 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -373,6 +373,7 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
>  static void sysctl_test_register_sysctl_sz_invalid_extra_value(
>  		struct kunit *test)
>  {
> +	struct ctl_table_header *hdr;
>  	unsigned char data = 0;
>  	struct ctl_table table_foo[] = {
>  		{
> @@ -412,7 +413,9 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
>  
>  	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
>  	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
> -	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
> +	hdr = register_sysctl("foo", table_qux);
> +	KUNIT_EXPECT_NOT_NULL(test, hdr);
> +	unregister_sysctl_table(hdr);
This indeed fixes the behaviour, but it is not what should be done
and this is why:
1. sysctl-test.c is part of the unit tests for sysctl and actually
   trying to execute a register here does not really make sense.
2. The file that actually does the regression testing is
   lib/test_sysctl.c

If you are up for it this is what needs to be done:
1. change what is in sysctl-test.c to call sysctl_check_table_array
   directly and not worry about keeping track of the registration.
2. Add a similar regression test in lib/test_sysctl.c where we actually
   check for the error.

Please tell me if you are up for it (if not I can add it to my todos)

Best

>  }
>  
>  static struct kunit_case sysctl_test_cases[] = {
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

-- 

Joel Granados

