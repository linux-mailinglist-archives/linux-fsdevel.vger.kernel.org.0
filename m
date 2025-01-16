Return-Path: <linux-fsdevel+bounces-39388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E25A13739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D671663B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D51D95A3;
	Thu, 16 Jan 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4luNzha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A81991CF;
	Thu, 16 Jan 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021692; cv=none; b=WgHI5JDmZfkYSCHEMXMwTVuI85iEABUKSGZw4Hm0eoc3KLJruVqT2V0rhv36FYFsDdTo9j5ftEH3d3+OFpZ5YAzQUgrbaharo0ZZ0gWOjEB5Q+LWVKt+7SA93nT+Q46MueW3XOzLlt4TsQB6e1feYnj6GBf7/L4C5ZpJ+iiMS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021692; c=relaxed/simple;
	bh=uHJxnVkR0XMhpyc2MHk+WPdhdAn0JRF/U/DuczIAzgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHh8liu5G0FG/wUvD49S6y5KObZ8xhwnkX5zA4t3jVH/0ew6/2xqurm9wQQvirPjgiSjbFNZVxHeiy7arlucO7fgJO6gx79NAN5aJUWTmMzydFRAX/iedFBuV4lE89dO6JsaIt0wUlGoWmDTstyS/CUHWk3Ojo/46XERADYEV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4luNzha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0801BC4CED6;
	Thu, 16 Jan 2025 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737021691;
	bh=uHJxnVkR0XMhpyc2MHk+WPdhdAn0JRF/U/DuczIAzgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4luNzha1a7CNzf9WDf7yHdvttxFmEruq1yU2oH0V6UmP/awY2T04GSIWQ06bhfWy
	 A7h9KKrq58Ej1OKpMj0hyaIqqiE544h3UKDtPVNTuedvpKMhBTRY4ObY2tNlQTrXpV
	 zLesrIDFNOeMzs79cgiNgUxbK/LLMv/CgvaH2H3fiqoVCCAkU+UW5inoNTe8EYhoxv
	 IfzC8XWGKvjmIhemYkiw05E86v6xCR//Ch9yOH2PgsPni4PNPmDW4YbWlBl1Gp3DmN
	 XtMErcZwMqiwFx5Bvukj+iFurrAV4u24Yh7irFFJSDwbiHUJcr6JPkeT2ozG2RMkNG
	 MO1hDGcAnI8Ww==
Date: Thu, 16 Jan 2025 11:01:26 +0100
From: Joel Granados <joel.granados@kernel.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: Kees Cook <kees@kernel.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] sysctl: expose sysctl_check_table for unit testing
 and use it
Message-ID: <ryrgmipmo3h4724jszbvd2oilm5tavvjuojyrw2sz2ec6nmt7m@ijiguteitm67>
References: <20250112215013.2386009-1-jsperbeck@google.com>
 <20250113070001.143690-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113070001.143690-1-jsperbeck@google.com>

On Sun, Jan 12, 2025 at 11:00:01PM -0800, John Sperbeck wrote:
> In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
> of u8 to sysctl_check_table_array"), a kunit test was added that
> registers a sysctl table.  If the test is run as a module, then a
> lingering reference to the module is left behind, and a 'sysctl -a'
> leads to a panic.
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
> Instead of fully registering a sysctl table, expose the underlying
> checking function and use it in the unit test.
> 
> Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
You have received a error from the bot. please address it to move
forward.

Best
> ---
>  fs/proc/proc_sysctl.c  | 22 +++++++++++++++++-----
>  include/linux/sysctl.h |  8 ++++++++
>  kernel/sysctl-test.c   |  9 ++++++---
>  3 files changed, 31 insertions(+), 8 deletions(-)
> 
...
>  
>  static struct kunit_case sysctl_test_cases[] = {
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

-- 

Joel Granados

