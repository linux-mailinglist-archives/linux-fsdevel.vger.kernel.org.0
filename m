Return-Path: <linux-fsdevel+bounces-38624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7CFA04FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965CC188511D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FCA38DE3;
	Wed,  8 Jan 2025 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="OQwtYONq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="otripk5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E3142905
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300850; cv=none; b=G8loSlGHOk3t1Z8cbIzzXakw9qSzC2kOrfX6j64UJpylgsSbYfBd4IAy9g/vb6BREBhkT0LIA2w00Go44BNkO7v4hB8TTtjRWOqtFvjRw1+ymCpZqPaU3lC/uUs1OHZSTXVNpYaHmKPpuzw1UcXKL+e10FMgIynPX4WlMN7BHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300850; c=relaxed/simple;
	bh=oS0DcxaIaQpkO21Q15XllaD+d+RB8Pkov0NdvWyEqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SobewCjgVf1NXAtLsOZVkt/Z5a8LXC0ojjJ+aBEs02oZoPgK29vPm9mE2phPR73+oMTq/pVA2UbSTp/Dt1nkh3B+yPCXuc1d/4aDiKM3ohtsz5bVGj8qVGBiaGir3XqlTXSV2tedXQiIQX+lBN8M7svwC1wL3pye/kO0qISmd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=OQwtYONq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=otripk5h; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D25DC114015B;
	Tue,  7 Jan 2025 20:47:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 07 Jan 2025 20:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1736300846; x=1736387246; bh=RN+WmroQAy5U//HcW1Bpq
	k2VS4LIfsmqhq83IHpBk4s=; b=OQwtYONqsNiaBxYn1go/sqjUGPAxtJhtu5v8z
	HIapm3DAAZu3XuYSP2LT905rfjAMXTEMeeajvQXHkUZkL/2UTuIxZWd7UmHsRuvI
	40c4ZWpWeVn5tGhPLMheoTquoXFkAMsesDVYcnhkxjim873yEJJhGCRzCD8s0nmW
	N93AJHORHeGsl6W3I9bZbyXefMVt/9m2mHhfELr+pCbx2Kn5SZIXxCLVy7cQeiGq
	hZJdBvh4qZ7YIs5q3/uaScg0pAVyXF5oqfFuDa88K4ISOu/mA6AvzqNd5Rzh90Lk
	NpXmO4NnJ4vA2TvMYYNXdiCkLlPJg/cZ+GJaDjV1xSHgwtYTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736300846; x=1736387246; bh=RN+WmroQAy5U//HcW1Bpqk2VS4LIfsmqhq8
	3IHpBk4s=; b=otripk5h0y09oGxooWLmyVuiIb7eXAz9vk9nVAcCDdXopvV05oc
	NCcPkO8frDUkLpTYtT0x7E5XUnz/RHWdttfKjWiFUN/fsqBI+KuNy995X9Qweulp
	Z0rZHZIs8YIStvbDSLxrVZZ8EUqyaF1ku3BCabqlFU0i1rOCNvFmFNy9u0/jBR05
	CLYSY0FyBOBWgAZp98H68GQ7FH7zcDdHHCJqO518IT4g9TkQ8kNbWLqMtRLox6qu
	1aznYUK7vlySkORJxEt9BqcbNgpNYexztMmuVQX65VMHgEN8kaf0sxkXl+bk38k1
	VpR4cIhFeRlY4sZgUa3nxERYuk14BckajJw==
X-ME-Sender: <xms:Ltl9Z3o1yeEfYHt02azmK89WNFPlysChvi1gocyWZ-Z7t6smGujRLg>
    <xme:Ltl9Zxp9JUm4b_7oazjJnhCTsJm48p7v_RyHGLb4uoWD-ZZlI8lNaUpEUUkHskfDu
    wDIK2B2wNAl8WNr8f8>
X-ME-Received: <xmr:Ltl9Z0P4s6oFjYZzptcXLN0Ggn6ncemv0gcVagOH8rgTgeh4avfr0cin1hBxyZhAPrnhCCnVHTSH3UD5zJX2prq95Vtk97pRVVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceo
    shhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevieegfeffhf
    ekudeuieelgfeljeekgedthfeiveeltedukeegfeeuvdelvdejueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihhopdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepiiiiqhhqtddutdefrdhhvgihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhrhesuggvvhhkvghrnhgv
    lhdrihho
X-ME-Proxy: <xmx:Ltl9Z65SVJw6x4RJatsA7sU3J-mOqjDrwcVpfq0ycr5eQgFecYEXCw>
    <xmx:Ltl9Z25M26oxsYk7Hgy3p4MnV-OfOC4A-fniZmwRM1UmfqrgU5bq_A>
    <xmx:Ltl9Zyj7WCCbfa7SregXlnBP_OMEaz2sEybjs_4ZdwOAGXmerslqTw>
    <xmx:Ltl9Z45xBmOqH0SrWkG5IcszKmEv3YR_SwximzgpNSShVFa_9-KC9w>
    <xmx:Ltl9Z9aBsD8XA1Rvde8qGdJkO2eg_LeULRqAcIzzg3-JqQKGhz71NZSc>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 20:47:25 -0500 (EST)
From: Stefan Roesch <shr@devkernel.io>
To: david@redhat.com,
	willy@infradead.org,
	zzqq0103.hey@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: shr@devkernel.io
Subject: [PATCH v2] mm: fix div by zero in bdi_ratio_from_pages
Date: Tue,  7 Jan 2025 17:47:23 -0800
Message-ID: <20250108014723.166637-1-shr@devkernel.io>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During testing it has been detected, that it is possible to get div by
zero error in bdi_set_min_bytes. The error is caused by the function
bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
global_dirty_limits. If the dirty threshold is 0, the div by zero is
raised. This can happen if the root user is setting:

echo 0 > /proc/sys/vm/dirty_ratio

The following is a test case:

echo 0 > /proc/sys/vm/dirty_ratio
cd /sys/class/bdi/<device>
echo 1 > strict_limit
echo 8192 > min_bytes

==> error is raised.

The problem is addressed by returning -EINVAL if dirty_ratio or
dirty_bytes is set to 0.

Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Closes: https://lore.kernel.org/linux-mm/87pll35yd0.fsf@devkernel.io/T/#t
Signed-off-by: Stefan Roesch <shr@devkernel.io>

---
Changes in V2:
- check for -EINVAL in bdi_set_min_bytes()
- check for -EINVAL in bdi_set_max_bytes()
---
 mm/page-writeback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d213ead95675..fcc486e0d5c2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -692,6 +692,8 @@ static unsigned long bdi_ratio_from_pages(unsigned long pages)
 	unsigned long ratio;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
+	if (!dirty_thresh)
+		return -EINVAL;
 	ratio = div64_u64(pages * 100ULL * BDI_RATIO_SCALE, dirty_thresh);
 
 	return ratio;
@@ -797,6 +799,8 @@ int bdi_set_min_bytes(struct backing_dev_info *bdi, u64 min_bytes)
 		return ret;
 
 	min_ratio = bdi_ratio_from_pages(pages);
+	if (min_ratio == -EINVAL)
+		return -EINVAL;
 	return __bdi_set_min_ratio(bdi, min_ratio);
 }
 
@@ -816,6 +820,8 @@ int bdi_set_max_bytes(struct backing_dev_info *bdi, u64 max_bytes)
 		return ret;
 
 	max_ratio = bdi_ratio_from_pages(pages);
+	if (max_ratio == -EINVAL)
+		return -EINVAL;
 	return __bdi_set_max_ratio(bdi, max_ratio);
 }
 

base-commit: fbfd64d25c7af3b8695201ebc85efe90be28c5a3
-- 
2.47.1


