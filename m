Return-Path: <linux-fsdevel+bounces-56146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4855B140C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D472118C1C11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F3274B52;
	Mon, 28 Jul 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKTrzBoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D019AD70;
	Mon, 28 Jul 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721753; cv=none; b=Hju0SdnPuC3eAw34ndczOw7oX1XXoe0oSlE6VZbeLcopJH0r7oifFfjc/x3bzhgbc4CjfnQNuytJrHYFqcBPCEkffbOgTiN4euvuDRW7BCmrigWdyKPIzZSQS2zzHDZJY8IxqPq/i9OgL89jbUxvpU+Luxc0g0QY6459YniUvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721753; c=relaxed/simple;
	bh=NQFaFtTN7N6BCj6w0IBTYBXcpqLFYEKBc4izu1Pcojo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHFIPRODj1PC+8lZ/FRlKV2xTFJb2S2TdmjJ1iZ9CtBP8pDudwzjhD/LtjEs6yg1zpfhCDBYQUf8XzZf4S9xxwgcYc8e4G8bIvIRxiIqHuw6JHC5QuI5K+eawQuu8z6yjWmb63K3Vrtj3JHme/U+L4U2y+UFuXAK9J9CQFPmEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKTrzBoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8146DC4CEE7;
	Mon, 28 Jul 2025 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721752;
	bh=NQFaFtTN7N6BCj6w0IBTYBXcpqLFYEKBc4izu1Pcojo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKTrzBoG5SYEOWdZuwKRnsIaC3w6XuxfTZaFJLGqJ35KqvCGFbFKbP/Zw6QrXTMjh
	 pGlx/nuMebKFFIX+3EJxaX5FTM5wRXtSIwYxipv9GK53Vc4oIfF18F3kEqOM6mBb7K
	 8IaBXa/vJx5IhcWufXsj2TINNTL3q0dC244iiZS8li6hGUgs4ZPN5jinPNlEcDVhvd
	 EuMLqKdNgIr5tUtL9RVJbaQIohQmDM9A3lSECcFV6At8+rRoRfFYLiZdqm1qGyuzHF
	 NxTWzk4f4VY94O4I1a72SpeVP5Gx8lgWFAUoze8SO1S+rS/loRr6bfmMVwXgmjU6fr
	 VoQrdZZkIR8Tg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 5/5] selftests: prctl: introduce tests for disabling THPs except for madvise
Date: Mon, 28 Jul 2025 09:55:49 -0700
Message-Id: <20250728165549.62546-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725162258.1043176-6-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 17:22:44 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> The test will set the global system THP setting to always and
> the 2M setting to inherit before it starts (and reset to original
> at teardown)
> 
> This tests if the process can:
> - successfully set and get the policy to disable THPs expect for madvise.

s/expect/except/

> - get hugepages only on MADV_HUGE and MADV_COLLAPSE after policy is set.
> - successfully reset the policy of the process.
> - get hugepages always after reset.
> - repeat the above tests in a forked process to make sure  the policy is
>   carried across forks.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  .../testing/selftests/mm/prctl_thp_disable.c  | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
> index 52f7e6659b1f..288d5ad6ffbb 100644
> --- a/tools/testing/selftests/mm/prctl_thp_disable.c
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -65,6 +65,101 @@ static int test_mmap_thp(enum madvise_buffer madvise_buf, size_t pmdsize)
>  	munmap(buffer, buf_size);
>  	return ret;
>  }
> +
> +FIXTURE(prctl_thp_disable_except_madvise)
> +{
> +	struct thp_settings settings;
> +	size_t pmdsize;
> +};
> +
> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
> +{
> +	if (!thp_is_enabled())
> +		SKIP(return, "Transparent Hugepages not available\n");

As David also pointed out on the other patch, the message and the function name
would better to be consistent.

> +
> +	self->pmdsize = read_pmd_pagesize();
> +	if (!self->pmdsize)
> +		SKIP(return, "Unable to read PMD size\n");
> +
> +	thp_read_settings(&self->settings);
> +	self->settings.thp_enabled = THP_ALWAYS;
> +	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
> +	thp_save_settings();
> +	thp_push_settings(&self->settings);
> +

Unnecessary empty line?

> +}
> +
> +FIXTURE_TEARDOWN(prctl_thp_disable_except_madvise)
> +{
> +	thp_restore_settings();
> +}
> +
> +/* prctl_thp_disable_except_madvise fixture sets system THP setting to always */
> +static void prctl_thp_disable_except_madvise(struct __test_metadata *const _metadata,
> +					     size_t pmdsize)
> +{
> +	int res = 0;
> +
> +	res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
> +	ASSERT_EQ(res, 3);
> +
> +	/* global = always, process = madvise, we shouldn't get HPs without madvise */
> +	res = test_mmap_thp(NONE, pmdsize);
> +	ASSERT_EQ(res, 0);
> +
> +	res = test_mmap_thp(HUGE, pmdsize);
> +	ASSERT_EQ(res, 1);
> +
> +	res = test_mmap_thp(COLLAPSE, pmdsize);
> +	ASSERT_EQ(res, 1);
> +
> +	/* Reset to system policy */
> +	res =  prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL);
> +	ASSERT_EQ(res, 0);
> +
> +	/* global = always, hence we should get HPs without madvise */
> +	res = test_mmap_thp(NONE, pmdsize);
> +	ASSERT_EQ(res, 1);
> +
> +	res = test_mmap_thp(HUGE, pmdsize);
> +	ASSERT_EQ(res, 1);
> +
> +	res = test_mmap_thp(COLLAPSE, pmdsize);
> +	ASSERT_EQ(res, 1);

Seems res is not being used other than saving the return value for assertions.
Why don't you do the assertion at once, e.g., ASSERT_EQ(test_mmap_thp(...), 1)?
No strong opinion, but I think that could make code shorter and easier to read.

> +}
> +
> +TEST_F(prctl_thp_disable_except_madvise, nofork)
> +{
> +	int res = 0;
> +
> +	res = prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL);
> +	ASSERT_EQ(res, 0);

Again, I think 'res' can be removed.

> +	prctl_thp_disable_except_madvise(_metadata, self->pmdsize);
> +}
> +
> +TEST_F(prctl_thp_disable_except_madvise, fork)
> +{
> +	int res = 0, ret = 0;
> +	pid_t pid;
> +
> +	res = prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL);
> +	ASSERT_EQ(res, 0);

Ditto.

> +
> +	/* Make sure prctl changes are carried across fork */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (!pid)
> +		prctl_thp_disable_except_madvise(_metadata, self->pmdsize);
> +
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +	ASSERT_EQ(ret, 0);
> +}
> +
>  FIXTURE(prctl_thp_disable_completely)
>  {
>  	struct thp_settings settings;
> -- 
> 2.47.3


Thanks,
SJ

