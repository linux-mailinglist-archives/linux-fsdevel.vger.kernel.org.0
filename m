Return-Path: <linux-fsdevel+bounces-58071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24947B28AEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 08:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F40F2A0A6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B9F207DF7;
	Sat, 16 Aug 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eFFcWNgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E43176F0;
	Sat, 16 Aug 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755324951; cv=none; b=TAD0OLtaRlx/86emMw8psJiJFEvVVSOKm+SZu+CUVLovIIlpIpIwNfzRbNGSlDGuTHBQakcRAULStVyhjWNuK0dTfkl2eEk2b8FV680emmesqymd1GPu2fkOYihKiH95LNBH1wg+s1cnuSoB63XRJqLBlr1THnehrPa411ZO2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755324951; c=relaxed/simple;
	bh=jheQbrl6mo7J2mKnNzaTKtMrCR9vMP2nmVKMbKRV5Ik=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bt/Uiai9qgWTU8Jn5Vwlt3ygsUFXpuABG/LNMs+r2dm+J3GjdGygPy1OxL2gM/zSs7DxgGZcnMVDUUtQMxqNYnb7BcJZpV80c1KbIhTbpM9JucfraFG9pUS5QiWBOmNs0aHzqsFrmgZGFv5utmHHQfNlEEoRX2JHbRdZy09RX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eFFcWNgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7758C4CEEF;
	Sat, 16 Aug 2025 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755324950;
	bh=jheQbrl6mo7J2mKnNzaTKtMrCR9vMP2nmVKMbKRV5Ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eFFcWNgiGcxyOJzwvTV+O8epT32CN6pMMrHQrTBnK47ltJ3kaFTY0YfDu8vbZ5l0E
	 Wo+IYTPEnoW9T0YtNcGyuIV5s85/amVROP+WqbjMtBCJpaF9eQycl9gpzK6QxUykxC
	 bWBY0jYi35xQg8n2VLrVqTZNqGDs6/nZDfBts/Kg=
Date: Fri, 15 Aug 2025 23:15:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: david@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 corbet@lwn.net, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
 riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v5 5/7] selftest/mm: Extract sz2ord function into
 vm_util.h
Message-Id: <20250815231549.1d7ef74fc13149e07471f335@linux-foundation.org>
In-Reply-To: <20250815135549.130506-6-usamaarif642@gmail.com>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
	<20250815135549.130506-6-usamaarif642@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 14:54:57 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> The function already has 2 uses and will have a 3rd one
> in prctl selftests. The pagesize argument is added into
> the function, as it's not a global variable anymore.
> No functional change intended with this patch.
> 

https://lkml.kernel.org/r/20250816040113.760010-5-aboorvad@linux.ibm.com
jut did this, but didn't add the extra arg. 
tools/testing/selftests/mm/split_huge_page_test.c needed updating.

--- a/tools/testing/selftests/mm/cow.c~selftest-mm-extract-sz2ord-function-into-vm_utilh
+++ a/tools/testing/selftests/mm/cow.c
@@ -52,7 +52,7 @@ static int detect_thp_sizes(size_t sizes
 	if (!pmdsize)
 		return 0;
 
-	orders = 1UL << sz2ord(pmdsize);
+	orders = 1UL << sz2ord(pmdsize, pagesize);
 	orders |= thp_supported_orders();
 
 	for (i = 0; orders && count < max; i++) {
@@ -1211,8 +1211,8 @@ static void run_anon_test_case(struct te
 		size_t size = thpsizes[i];
 		struct thp_settings settings = *thp_current_settings();
 
-		settings.hugepages[sz2ord(pmdsize)].enabled = THP_NEVER;
-		settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
+		settings.hugepages[sz2ord(pmdsize, pagesize)].enabled = THP_NEVER;
+		settings.hugepages[sz2ord(size, pagesize)].enabled = THP_ALWAYS;
 		thp_push_settings(&settings);
 
 		if (size == pmdsize) {
@@ -1863,7 +1863,7 @@ int main(void)
 	if (pmdsize) {
 		/* Only if THP is supported. */
 		thp_read_settings(&default_settings);
-		default_settings.hugepages[sz2ord(pmdsize)].enabled = THP_INHERIT;
+		default_settings.hugepages[sz2ord(pmdsize, pagesize)].enabled = THP_INHERIT;
 		thp_save_settings();
 		thp_push_settings(&default_settings);
 
--- a/tools/testing/selftests/mm/uffd-wp-mremap.c~selftest-mm-extract-sz2ord-function-into-vm_utilh
+++ a/tools/testing/selftests/mm/uffd-wp-mremap.c
@@ -82,9 +82,9 @@ static void *alloc_one_folio(size_t size
 		struct thp_settings settings = *thp_current_settings();
 
 		if (private)
-			settings.hugepages[sz2ord(size)].enabled = THP_ALWAYS;
+			settings.hugepages[sz2ord(size, pagesize)].enabled = THP_ALWAYS;
 		else
-			settings.shmem_hugepages[sz2ord(size)].enabled = SHMEM_ALWAYS;
+			settings.shmem_hugepages[sz2ord(size, pagesize)].enabled = SHMEM_ALWAYS;
 
 		thp_push_settings(&settings);
 
--- a/tools/testing/selftests/mm/vm_util.h~selftest-mm-extract-sz2ord-function-into-vm_utilh
+++ a/tools/testing/selftests/mm/vm_util.h
@@ -127,9 +127,9 @@ static inline void log_test_result(int r
 	ksft_test_result_report(result, "%s\n", test_name);
 }
 
-static inline int sz2ord(size_t size)
+static inline int sz2ord(size_t size, size_t pagesize)
 {
-	return __builtin_ctzll(size / getpagesize());
+	return __builtin_ctzll(size / pagesize);
 }
 
 void *sys_mremap(void *old_address, unsigned long old_size,
--- a/tools/testing/selftests/mm/split_huge_page_test.c~selftest-mm-extract-sz2ord-function-into-vm_utilh
+++ a/tools/testing/selftests/mm/split_huge_page_test.c
@@ -544,7 +544,7 @@ int main(int argc, char **argv)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
 	nr_pages = pmd_pagesize / pagesize;
-	max_order =  sz2ord(pmd_pagesize);
+	max_order =  sz2ord(pmd_pagesize, pagesize);
 	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
_


