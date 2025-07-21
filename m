Return-Path: <linux-fsdevel+bounces-55616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30DCB0CB08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 21:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D654E6409
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B9230D0E;
	Mon, 21 Jul 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6aBBL1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015D221F06;
	Mon, 21 Jul 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126563; cv=none; b=NKQudh7VYW5ccRdTtmHu3zOflqhq163yXO1JwSKY2p2j2S4x8ev6b4kDMcjZfHJ803sUi8ioiydqqeV6QKTZyME7JXiyYEjtGUBotJO8yvgRvihthk5e6SzJKFc+4ExGfwYTKhPQu3xQrVp3HvsJxUTQ1yegLXUyZeUXCDZJm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126563; c=relaxed/simple;
	bh=TB7rn67MajC8Jyg5Da1lj9LyQ2ZybUzjBr843rmIh84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjsES9xM7wg8jktjTEcPzjOqclBKHNtU+edo0uNfx4TS/j6urDuRjWgGmSrvFRG1nZYnox8vah3hkIMf+9lmQRfxEHOi9TTUxAs4wwsNArjqdcl84qGbjK/RIUoCVA4MBBFL6EtgHGhkoiijpsAe0p0LJaJAEL7233ius0Jz6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6aBBL1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBD3C4CEED;
	Mon, 21 Jul 2025 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753126562;
	bh=TB7rn67MajC8Jyg5Da1lj9LyQ2ZybUzjBr843rmIh84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6aBBL1v+Jac/gTJPVwUGLOuSxcdUoTjM2CZ0uHsM6v9ZtbEbYxfIYf3qgS8fVdUZ
	 jjoin8kV/LPRelW8iVxYtHZ1GWxY8bRcxOX4IoqWoMZ25zTcAEAyuG+y3Q6WwJpGuK
	 dDOWrQVmRWMH3+eFy80/am9w0icD0VsV2fsCXK79EiOmYEfVRrSjAnmeztcZe7ahg8
	 Rwq84sT6xhO598gnhxIGq9EIQSJdzhdPQdX8NbO0H4Mcax2rh46R80iAY2gZWVT6qW
	 rXIUTfbsa+ti4Wor7QjDIVUWVPClj0iVQVyordX1wm2QctV3JrhWCl8CTyidLs2YfC
	 wyID6ZM3jpR8g==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
Date: Mon, 21 Jul 2025 12:35:59 -0700
Message-Id: <20250721193559.11503-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <4a8b70b1-7ba0-4d60-a3a0-04ac896a672d@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 18:27:38 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

[...]
> >From ee9004e7d34511a79726ee1314aec0503e6351d4 Mon Sep 17 00:00:00 2001
> From: Usama Arif <usamaarif642@gmail.com>
> Date: Thu, 15 May 2025 14:33:33 +0100
> Subject: [PATCH] selftests: prctl: introduce tests for
>  PR_THP_DISABLE_EXCEPT_ADVISED
> 
> The test is limited to 2M PMD THPs. It does not modify the system
> settings in order to not disturb other process running in the system.
> It checks if the PMD size is 2M, if the 2M policy is set to inherit
> and if the system global THP policy is set to "always", so that
> the change in behaviour due to PR_THP_DISABLE_EXCEPT_ADVISED can
> be seen.
> 
> This tests if:
> - the process can successfully set the policy
> - carry it over to the new process with fork
> - if no hugepage is gotten when the process doesn't MADV_HUGEPAGE
> - if hugepage is gotten when the process does MADV_HUGEPAGE
> - the process can successfully reset the policy to PR_THP_POLICY_SYSTEM
> - if hugepage is gotten after the policy reset

Nice!  I added a few trivial comments below, though.

> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: SeongJae Park <sj@kernel.org>

> ---
>  tools/testing/selftests/prctl/Makefile      |   2 +-
>  tools/testing/selftests/prctl/thp_disable.c | 207 ++++++++++++++++++++

I once thought this might better fit on selftests/mm/, but I found we already
have selftests/prctl/set-anon-vma-name-tests.c, no no strong opinion from my
side.

>  2 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/prctl/thp_disable.c
> 
> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
> index 01dc90fbb509..a3cf76585c48 100644
> --- a/tools/testing/selftests/prctl/Makefile
> +++ b/tools/testing/selftests/prctl/Makefile
> @@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
>  ifeq ($(ARCH),x86)
>  TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
> -		disable-tsc-test set-anon-vma-name-test set-process-name
> +		disable-tsc-test set-anon-vma-name-test set-process-name thp_disable
>  all: $(TEST_PROGS)
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/prctl/thp_disable.c b/tools/testing/selftests/prctl/thp_disable.c
> new file mode 100644
> index 000000000000..e524723b3313
> --- /dev/null
> +++ b/tools/testing/selftests/prctl/thp_disable.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This test covers the PR_GET/SET_THP_DISABLE functionality of prctl calls
> + * for PR_THP_DISABLE_EXCEPT_ADVISED
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +
> +#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
> +#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
> +#endif
> +
> +#define CONTENT_SIZE 256
> +#define BUF_SIZE (12 * 2 * 1024 * 1024) // 12 x 2MB pages
> +
> +enum system_policy {
> +	SYSTEM_POLICY_ALWAYS,
> +	SYSTEM_POLICY_MADVISE,
> +	SYSTEM_POLICY_NEVER,
> +};
> +
> +int system_thp_policy;
> +
> +/* check if the sysfs file contains the expected substring */
> +static int check_file_content(const char *file_path, const char *expected_substring)
> +{
> +	FILE *file = fopen(file_path, "r");
> +	char buffer[CONTENT_SIZE];
> +
> +	if (!file) {
> +		perror("Failed to open file");
> +		return -1;
> +	}
> +	if (fgets(buffer, CONTENT_SIZE, file) == NULL) {
> +		perror("Failed to read file");
> +		fclose(file);
> +		return -1;
> +	}
> +	fclose(file);
> +	// Remove newline character from the buffer

Nit.  I'd suggest using "/* */" consisetntly.

> +	buffer[strcspn(buffer, "\n")] = '\0';
> +	if (strstr(buffer, expected_substring))
> +		return 0;
> +	else
> +		return 1;
> +}
> +
> +/*
> + * The test is designed for 2M hugepages only.
> + * Check if hugepage size is 2M, if 2M size inherits from global
> + * setting, and if the global setting is always.
> + */
> +static int sysfs_check(void)
> +{
> +	int res = 0;
> +
> +	res = check_file_content("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "2097152");
> +	if (res) {
> +		printf("hpage_pmd_size is not set to 2MB. Skipping test.\n");
> +		return -1;

Nit.  Skipping is done by the caller, right?  I think it is more natural to say
"Skipping test" from the caller.

> +	}
> +	res |= check_file_content("/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled",
> +				  "[inherit]");

Nit.  I think we can drop '|' and just do 'res = '.

> +	if (res) {
> +		printf("hugepages-2048kB does not inherit global setting. Skipping test.\n");
> +		return -1;
> +	}
> +
> +	res = check_file_content("/sys/kernel/mm/transparent_hugepage/enabled", "[always]");
> +	if (!res) {

Seems 'res' is being used for only checking whether it is zero.  Maybe doing
'if (check_file_content(...))' and removing 'res' can make code simpler?

> +		system_thp_policy = SYSTEM_POLICY_ALWAYS;
> +		return 0;
> +	}

Also, system_thp_policy is set only here, so we know 'system_thp_policy ==
SYSTEM_POLICY_ALWAYS' if sysfs_check() returned zero.  Maybe system_thp_policy
is not really required?

> +	printf("Global THP policy not set to always. Skipping test.\n");
> +	return -1;
> +}
> +
> +static int check_smaps_for_huge(void)
> +{
> +	FILE *file = fopen("/proc/self/smaps", "r");
> +	int is_anonhuge = 0;
> +	char line[256];
> +
> +	if (!file) {
> +		perror("fopen");
> +		return -1;
> +	}
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		if (strstr(line, "AnonHugePages:") && strstr(line, "24576 kB")) {
> +			is_anonhuge = 1;
> +			break;
> +		}
> +	}
> +	fclose(file);
> +	return is_anonhuge;
> +}
> +
> +static int test_mmap_thp(int madvise_buffer)
> +{
> +	int is_anonhuge;
> +
> +	char *buffer = (char *)mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
> +				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (buffer == MAP_FAILED) {
> +		perror("mmap");
> +		return -1;
> +	}
> +	if (madvise_buffer)
> +		madvise(buffer, BUF_SIZE, MADV_HUGEPAGE);
> +
> +	// set memory to ensure it's allocated

'/* */' for consistency?

> +	memset(buffer, 0, BUF_SIZE);
> +	is_anonhuge = check_smaps_for_huge();
> +	munmap(buffer, BUF_SIZE);
> +	return is_anonhuge;
> +}
> +
> +/* Global policy is always, process is changed to "madvise only" */
> +static int test_global_always_process_madvise(void)
> +{
> +	int is_anonhuge = 0, res = 0, status = 0;
> +	pid_t pid;
> +
> +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL) != 0) {

Nit.  '!= 0' can be dropped.

> +		perror("prctl failed to set policy to madvise");
> +		return -1;
> +	}
> +
> +	/* Make sure prctl changes are carried across fork */
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
> +	if (res != 3) {
> +		printf("prctl PR_GET_THP_POLICY returned %d pid %d\n", res, pid);
> +		goto err_out;
> +	}
> +
> +	/* global = always, process = madvise, we shouldn't get HPs without madvise */
> +	is_anonhuge = test_mmap_thp(0);
> +	if (is_anonhuge) {
> +		printf(
> +		"PR_THP_POLICY_DEFAULT_NOHUGE set but still got hugepages without MADV_HUGEPAGE\n");
> +		goto err_out;
> +	}
> +
> +	is_anonhuge = test_mmap_thp(1);
> +	if (!is_anonhuge) {
> +		printf(
> +		"PR_THP_POLICY_DEFAULT_NOHUGE set but did't get hugepages with MADV_HUGEPAGE\n");
> +		goto err_out;
> +	}
> +
> +	/* Reset to system policy */
> +	if (prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL) != 0) {
> +		perror("prctl failed to set policy to system");
> +		goto err_out;
> +	}
> +
> +	is_anonhuge = test_mmap_thp(0);
> +	if (!is_anonhuge) {
> +		printf("global policy is always but we still didn't get hugepages\n");
> +		goto err_out;
> +	}
> +
> +	is_anonhuge = test_mmap_thp(1);
> +	if (!is_anonhuge) {
> +		printf("global policy is always but we still didn't get hugepages\n");
> +		goto err_out;
> +	}

Seems is_anonhugepage is used for only whether it is zero or not, just after
being assigned from test_mmap_thp().  How about removing the variable?

> +	printf("PASS\n");
> +
> +	if (pid == 0) {
> +		exit(EXIT_SUCCESS);
> +	} else {
> +		wait(&status);
> +		if (WIFEXITED(status))
> +			return 0;
> +		else
> +			return -1;
> +	}
> +
> +err_out:
> +	if (pid == 0)
> +		exit(EXIT_FAILURE);
> +	else
> +		return -1;
> +}
> +
> +int main(void)
> +{
> +	if (sysfs_check())
> +		return 0;

May better to return KSFT_SKIP insted of 0?

> +
> +	if (system_thp_policy == SYSTEM_POLICY_ALWAYS)

This should be always true, since sysfs_check() returned zero, right?  I think
we can remove this check.

> +		return test_global_always_process_madvise();
> +

Nit.  Unnecessary blank line.

> +}
> -- 
> 2.47.1
> 
> 
> 


Thanks,
SJ

