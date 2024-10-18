Return-Path: <linux-fsdevel+bounces-32310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04A9A35B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DB9B22553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8D188A00;
	Fri, 18 Oct 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6RzztvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C3820E30E;
	Fri, 18 Oct 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233665; cv=none; b=PnlQKktOL03SzOk/bY+htUZuIDd2ZN8mADIJITGAQ1LsFTA5f43Kq95S5qZnXu4TDcUN6ObpKhhrRtNykpV2CBxpsWzYjD9EHSwgPCHdrj2Pgw1ix7jXQnXz5HhszOeJ/ACXp0cP7rtP7M8Db2Zgc4sIPzcgjvMomgoSmCOZPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233665; c=relaxed/simple;
	bh=0lpsj1UvR6AcnHgvukFN7BtQLeSUmvJMMadL8XBpSFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hW3rIMYNMQ9NaFsV4VjXmj4um8nGJ1nT9gndGG7PgQgvQEhKc9fF4A4+sbzYTSxJ0Ec4vriXhmP64yeNK0WSXWIaLzOMToxAd9jiGv7jW50u6Wpx4rOb0ju8OnesurmFgT/cRrqVADdvagb95UVF39IeB2ldVgOiTH2sENLFmzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6RzztvN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233664; x=1760769664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lpsj1UvR6AcnHgvukFN7BtQLeSUmvJMMadL8XBpSFM=;
  b=T6RzztvNKL4z6FnpNAdlXRbdPG5W+jid9EH+1WysK7m35wRpnS/FzTjA
   M8evfOAQgAjrKGKtY5/RxmAAFD6gKTmXkvGfQ8JLUk0fBkIGunylGS15o
   PEeF9ONWgFpJLT46hdO9tPdMNhDP+wt1M9lVCcuYTLZCq3kj7yv7LmxuX
   oZk4KTSdehX6H9VbNu/sxFL83ZwiM6gMzVmbDkxMvxmmpo1FmSoKQWV7x
   VLSCu5iAPFc6oHInSnoqITVMftcR+7r4an617mHs1rAwGeKH4PnmdsYAN
   ZreT3vA7wOKuNTrqG5qdjpqJh0FauMs9/Mtow4EB/hNeAJ5oZX1lv4oNt
   w==;
X-CSE-ConnectionGUID: N+Kf5DnqQkuPvePqegVhGA==
X-CSE-MsgGUID: Zx0xJsVKQtStClyrXwzuvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884778"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884778"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:01 -0700
X-CSE-ConnectionGUID: EXdOqHO4QOiTM5LpwBoMEQ==
X-CSE-MsgGUID: X736q6ymTDK46QF8X8oAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607487"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:01 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to acomp_alg and acomp_req
Date: Thu, 17 Oct 2024 23:40:49 -0700
Message-Id: <20241018064101.336232-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For async compress/decompress, provide a way for the caller to poll
for compress/decompress completion, rather than wait for an interrupt
to signal completion.

Callers can submit a compress/decompress using crypto_acomp_compress
and decompress and rather than wait on a completion, call
crypto_acomp_poll() to check for completion.

This is useful for hardware accelerators where the overhead of
interrupts and waiting for completions is too expensive.  Typically
the compress/decompress hw operations complete very quickly and in the
vast majority of cases, adding the overhead of interrupt handling and
waiting for completions simply adds unnecessary delays and cancels the
gains of using the hw acceleration.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 crypto/acompress.c                  |  1 +
 include/crypto/acompress.h          | 18 ++++++++++++++++++
 include/crypto/internal/acompress.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 6fdf0ff9f3c0..00ec7faa2714 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -71,6 +71,7 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
+	acomp->poll = alg->poll;
 	acomp->dst_free = alg->dst_free;
 	acomp->reqsize = alg->reqsize;
 
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 54937b615239..65b5de30c8b1 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -51,6 +51,7 @@ struct acomp_req {
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	int (*poll)(struct acomp_req *req);
 	void (*dst_free)(struct scatterlist *dst);
 	unsigned int reqsize;
 	struct crypto_tfm base;
@@ -265,4 +266,21 @@ static inline int crypto_acomp_decompress(struct acomp_req *req)
 	return crypto_acomp_reqtfm(req)->decompress(req);
 }
 
+/**
+ * crypto_acomp_poll() -- Invoke asynchronous poll operation
+ *
+ * Function invokes the asynchronous poll operation
+ *
+ * @req:	asynchronous request
+ *
+ * Return: zero on poll completion, -EAGAIN if not complete, or
+ *         error code in case of error
+ */
+static inline int crypto_acomp_poll(struct acomp_req *req)
+{
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
+
+	return tfm->poll(req);
+}
+
 #endif
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index 8831edaafc05..fbf5f6c6eeb6 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -37,6 +37,7 @@
 struct acomp_alg {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	int (*poll)(struct acomp_req *req);
 	void (*dst_free)(struct scatterlist *dst);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
-- 
2.27.0


