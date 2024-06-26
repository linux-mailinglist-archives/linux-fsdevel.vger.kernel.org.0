Return-Path: <linux-fsdevel+bounces-22465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1A91765F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 04:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC51C22628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8B4AECB;
	Wed, 26 Jun 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CC8lh8zp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7B1B806;
	Wed, 26 Jun 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370263; cv=none; b=iGNxXnYYLlK8UZSk/DZ0DUMkbbh9JDvFsbxFdOuu4gRJpogAGKnLbDXFvqkvGdy0yiZt0S6hgc+kEgCV0vofLPTbyoQD98YJh84v+4Kw36uHJBAyN/IzUjiTx3rjxZVChGeZW1AG8KOnz44me3tNNrklEH2pbcWq3DXnXPrOLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370263; c=relaxed/simple;
	bh=+UdFbFyoTBFSw/MBlOcW7NPpenHJlHxk4HJdOurYbw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RTJr1oMrAUyfRm1A5RaKlZwocOXifOIrA2ahzgMVSKYZrbywEt42Caftt8w+aGfTbVecJwrQ5GecSI8BuXYgfPnvHitZNtceDDsBVFt2aIW/fz6JwvkEk8pRNgoVmHmtLhFLC8csJh8lP39RIWYbebC6SdDJwoUjoNRjw7rte3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CC8lh8zp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dNW9M
	BZdUm3qDfTvaBACpmBsWZ/fc9kmEQT+JbGeXb8=; b=CC8lh8zp2v1facYTbafV6
	mfzeuHV4VvOuHz/KmwFX3BjP1j/1zXwTqdG9C+sH4HAl9Mc5U8f6ewhuZd4ZIvt0
	5MtSdz0JBF6Xc31+TYxuIKNzvNPapsdRYEtIp3NDK/RPQxOOzxfmW703qQqtV+8Y
	RkuH46sJ53nr3musL/L7cQ=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXT0W6gXtm8PInAg--.40265S4;
	Wed, 26 Jun 2024 10:49:32 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: vbabka@suse.cz,
	svetly.todorov@memverge.com,
	ran.xiaokai@zte.com.cn,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Wed, 26 Jun 2024 02:49:22 +0000
Message-Id: <20240626024924.1155558-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXT0W6gXtm8PInAg--.40265S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1fJFyUCF4xXw4fGr1xKrg_yoWfuFX_ua
	97Awn8GFs7Zry3Jr1ayw1xXrs8Kw1rKrnF9F1rtF1ak3Z2q3WvvrnFyrW2vFWrWF4ayrWS
	ya1rZrnYyr17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUji0eJUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0gz8TGWXyU9d2QABsf

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

KPF_THP means that the folio is a 2M pmd mappable compound page,
meanwhile KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are used to
indicate common compound pages, so after commit 19eaf44954df
("mm: thp: support allocation of anonymous multi-size THP"),
the folio_test_large() in stable_page_flags() is insufficient
and should be replaced with folio_test_pmd_mappable().

Patch1 is a preparation to solve the compile time warning introduced
by patch2.

Patch2 replaces folio_test_large() with folio_test_pmd_mappable() to
indicate KPF_THP for only pmd mappable THP.

Ran Xiaokai (2):
  mm: Constify folio_order()/folio_test_pmd_mappable()
  kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages

 fs/proc/page.c          | 14 ++++----------
 include/linux/huge_mm.h |  2 +-
 include/linux/mm.h      |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.15.2



