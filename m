Return-Path: <linux-fsdevel+bounces-79481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLNSHHNgqWnj6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:52:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDB210096
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 11:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D5430440E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F438E108;
	Thu,  5 Mar 2026 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K69d4D5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778C38839A;
	Thu,  5 Mar 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707849; cv=none; b=EbK7uXSIKqSfi4EvtzT0F0eVUCqcGuMnwX62eHHcuO2+PKNSXeRLUSEozqkAAPZKon026W2suNUtBIrRlZFj0lTYMOCyI9+epHLgzMoCj+ek6VW+IrMFuyM19CJZBDi4B9Pd5GR76k9FNVXZNMuCYS80VuwW+poqvogHUVzeWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707849; c=relaxed/simple;
	bh=TF/Y8m2ST7SjfkcrUaxHq0mGyE5PLPgmgeUh4mbmrZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rICdP6xB8UZv8Qy06DOKzpEr7nJItPrauYUbm20GcHLIvH/+g+4M8frYthd0UP1RmpVHzh+cnUsLiQXVE23qg9PEehvGYAVsXpi+UDviwehvO8J5hCIMQW0JGn3SU5vrmLPM9wXkqDfX1T7pLY6r2di9TNINbUhl4RG87vK6Z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K69d4D5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5D1C116C6;
	Thu,  5 Mar 2026 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707848;
	bh=TF/Y8m2ST7SjfkcrUaxHq0mGyE5PLPgmgeUh4mbmrZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K69d4D5rkvQAOQO0X9LY14GVr8nxRsOyTxPOk3HOl5lilOcGooMFJ1RSYabqmcbgi
	 2Kb4JKE3xl5ujn+rVENRM01RMuTqfN5GJwiDujdpNrnz+/bSi+4/iUwDcrGQaZHKos
	 WXzPNA75E+fgOcKflJ9S1lqO3dtH7VUiIB1E7Hc1lEg87BCGJu+oHuw3etXLaH5ZL1
	 rOurPfYGNpyXfojRseUPlcwfGElAUfDsaU0vtsWbc6yGvwoo83oJQDYFDfivlslCRt
	 kK1RuRQF4zkVJg5hHHManDOSl2kFut9lIrxZm0xduQ2NivqK7NLhoCGGzPedfWaFhz
	 XSvIMevRPsU1Q==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-mm@kvack.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] tools/testing/vma: add test for vma_flags_test(), vma_desc_test()
Date: Thu,  5 Mar 2026 10:50:19 +0000
Message-ID: <376a39eb9e134d2c8ab10e32720dd292970b080a.1772704455.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772704455.git.ljs@kernel.org>
References: <cover.1772704455.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76EDB210096
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79481-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Now we have helpers which test singular VMA flags - vma_flags_test() and
vma_desc_test() - add a test to explicitly assert that these behave as
expected.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index f031e6dfb474..1aa94dd7e74a 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -159,6 +159,41 @@ static bool test_vma_flags_word(void)
 	return true;
 }
 
+/* Ensure that vma_flags_test() and friends works correctly. */
+static bool test_vma_flags_test(void)
+{
+	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					       VMA_EXEC_BIT, 64, 65);
+	struct vm_area_desc desc;
+
+	desc.vma_flags = flags;
+
+#define do_test(_flag)					\
+	ASSERT_TRUE(vma_flags_test(&flags, _flag));	\
+	ASSERT_TRUE(vma_desc_test(&desc, _flag))
+
+#define do_test_false(_flag)				\
+	ASSERT_FALSE(vma_flags_test(&flags, _flag));	\
+	ASSERT_FALSE(vma_desc_test(&desc, _flag))
+
+	do_test(VMA_READ_BIT);
+	do_test(VMA_WRITE_BIT);
+	do_test(VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	do_test(64);
+	do_test(65);
+#endif
+	do_test_false(VMA_MAYWRITE_BIT);
+#if NUM_VMA_FLAG_BITS > 64
+	do_test_false(66);
+#endif
+
+#undef do_test
+#undef do_test_false
+
+	return true;
+}
+
 /* Ensure that vma_flags_test_any() and friends works correctly. */
 static bool test_vma_flags_test_any(void)
 {
@@ -334,6 +369,7 @@ static void run_vma_tests(int *num_tests, int *num_fail)
 	TEST(vma_flags_unchanged);
 	TEST(vma_flags_cleared);
 	TEST(vma_flags_word);
+	TEST(vma_flags_test);
 	TEST(vma_flags_test_any);
 	TEST(vma_flags_clear);
 }
-- 
2.53.0


