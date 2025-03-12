Return-Path: <linux-fsdevel+bounces-43843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC895A5E691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22401652A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CDC1F03CD;
	Wed, 12 Mar 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt2CCD6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF571EFFAC;
	Wed, 12 Mar 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814618; cv=none; b=UV6Dua6sddwUcLbO7O9fd3a6nC4AuCU8a7/OCUSmDn8t3mzjEoWd5hR0wTO6x6f04ZctqDQ/BNnPYEVw2brBblXudyCv1j16IAdqgrZvVFugd3Hq/G0OTywJcFpyklJAFX0tnWUaXxTqJdZv4O6jMXv308amejjBB/NZqJB0gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814618; c=relaxed/simple;
	bh=fnzHkBsN0HcTbIHtBC4wnKkC1gwS9OR6BwvSv99xNqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2HSyK744Qzlx8gQ3TbXn8Qb8NzuiexpVFrYIlxevgHm3jqNA63q2MnpPD7CHVUOxncdQJouNH5pnvR9qbtNEAi5oL3JpDptIctPumkuGTiO8YZhYJZ2QU9kpYGvdvrZX2s+BHx3Q0DaEJKmBQ8eQHVBYKsGPHq/KM52VrXkQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt2CCD6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EAEC4CEDD;
	Wed, 12 Mar 2025 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814618;
	bh=fnzHkBsN0HcTbIHtBC4wnKkC1gwS9OR6BwvSv99xNqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt2CCD6Flcn0afa/+HYxP6IApYG+Cov1Bs6IRV/pNdc6F9eGb/0YmY3JQ3n1GjIPQ
	 lNFIDH6BU8bHhMbLsYJi+kitFXOgi2qGjTCKb70lZ9e5fUemU8HIxrHH7pqK15iAf9
	 oyHE0gKxbzV6VOibjd0AtJC/H85LQaGuu7uCsONMBWdxTYeNlBe7LbdPPOavCAZU4i
	 X6+TmWJSHnEJ3bo7/SsikLcJqU9mNDqIAwMJ9w0mT8ELoRiuWu6dLgN2NAo+WD9lXo
	 Nkkr+xaKuJ4cJHjsszzOvmTIRZFkD2DffHuzWpgTQccYXlI4BLVhmf22HwJoHXAMfz
	 0sEJdrfRLEv+w==
Date: Wed, 12 Mar 2025 22:23:32 +0100
From: Joel Granados <joel.granados@kernel.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: Kees Cook <kees@kernel.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] sysctl: expose sysctl_check_table for unit testing
 and use it
Message-ID: <se2nci5ftb2s53or6ysbgvtgcvvqwudxxzg3lbrxjm3y5mpo5o@y7k77ck3rz3k>
References: <202501182003.Gfi63jzH-lkp@intel.com>
 <20250121213354.3775644-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121213354.3775644-1-jsperbeck@google.com>

On Tue, Jan 21, 2025 at 01:33:53PM -0800, John Sperbeck wrote:
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
> ---
> 
> The Change from v3 to v4 is to make sure sysctl_check_table_test_helper_sz()
> is defined in the unusual case that the sysctl kunit test is enabled, but 
> CONFIG_SYSCTL is disabled.
> 
>  fs/proc/proc_sysctl.c  | 22 +++++++++++++++++-----
>  include/linux/sysctl.h | 17 +++++++++++++++++
>  kernel/sysctl-test.c   |  9 ++++++---
>  3 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 27a283d85a6e..2d3272826cc2 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1137,11 +1137,12 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
>  	return err;
>  }
>  
> -static int sysctl_check_table(const char *path, struct ctl_table_header *header)
> +static int sysctl_check_table(const char *path, const struct ctl_table *table,
> +			      size_t table_size)
>  {
> -	const struct ctl_table *entry;
> +	const struct ctl_table *entry = table;
>  	int err = 0;
> -	list_for_each_table_entry(entry, header) {
> +	for (size_t i = 0 ; i < table_size; ++i, entry++) {
This should be avoided as the traversal of the ctl_table should be
handled in one place (the list_for_each_table_entry macro)

>  		if (!entry->procname)
>  			err |= sysctl_err(path, entry, "procname is null");
>  		if ((entry->proc_handler == proc_dostring) ||
> @@ -1173,6 +1174,16 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
>  	return err;
>  }
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int sysctl_check_table_test_helper_sz(const char *path,
> +				      const struct ctl_table *table,
> +				      size_t table_size)
> +{
> +	return sysctl_check_table(path, table, table_size);
> +}
> +EXPORT_SYMBOL(sysctl_check_table_test_helper_sz);
> +#endif /* CONFIG_KUNIT */
> +
>  static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_header *head)
>  {
>  	struct ctl_table *link_table, *link;
> @@ -1372,6 +1383,9 @@ struct ctl_table_header *__register_sysctl_table(
>  	struct ctl_dir *dir;
>  	struct ctl_node *node;
>  
> +	if (sysctl_check_table(path, table, table_size))
> +		return NULL;
> +
>  	header = kzalloc(sizeof(struct ctl_table_header) +
>  			 sizeof(struct ctl_node)*table_size, GFP_KERNEL_ACCOUNT);
>  	if (!header)
> @@ -1379,8 +1393,6 @@ struct ctl_table_header *__register_sysctl_table(
>  
>  	node = (struct ctl_node *)(header + 1);
>  	init_header(header, root, set, node, table, table_size);
> -	if (sysctl_check_table(path, header))
> -		goto fail;
>  
>  	spin_lock(&sysctl_lock);
>  	dir = &set->dir;
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 40a6ac6c9713..02acd3670bd2 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -288,4 +288,21 @@ static inline bool sysctl_is_alias(char *param)
>  int sysctl_max_threads(const struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +#define sysctl_check_table_test_helper(path, table)	\
> +	sysctl_check_table_test_helper_sz(path, table, ARRAY_SIZE(table))
> +#ifdef CONFIG_SYSCTL
> +int sysctl_check_table_test_helper_sz(const char *path,
> +				      const struct ctl_table *table,
> +				      size_t table_size);
> +#else /* CONFIG_SYSCTL */
> +static inline int sysctl_check_table_test_helper_sz(const char *path,
> +				      const struct ctl_table *table,
> +				      size_t table_size)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SYSCTL */
> +#endif /* CONFIG_KUNIT */
> +
>  #endif /* _LINUX_SYSCTL_H */
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 3ac98bb7fb82..247dd8536fc7 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -410,9 +410,12 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
>  		},
>  	};
>  
> -	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
> -	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
> -	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
> +	KUNIT_EXPECT_EQ(test, -EINVAL,
> +			sysctl_check_table_test_helper("foo", table_foo));
> +	KUNIT_EXPECT_EQ(test, -EINVAL,
> +			sysctl_check_table_test_helper("foo", table_bar));
> +	KUNIT_EXPECT_EQ(test, 0,
> +			sysctl_check_table_test_helper("foo", table_qux));

This should all be in lib/tests_sysctl.c. We should remove all this
function from the kunit and add an equivalent one to lib/tests_sysctl.c

Best
>  }
>  
>  static struct kunit_case sysctl_test_cases[] = {
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 

-- 

Joel Granados

