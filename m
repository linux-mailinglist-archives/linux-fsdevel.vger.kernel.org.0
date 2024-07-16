Return-Path: <linux-fsdevel+bounces-23730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F66931ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 04:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2511C2126C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 02:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785CEAD32;
	Tue, 16 Jul 2024 02:25:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869B6AD7;
	Tue, 16 Jul 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096746; cv=none; b=io/bMIoxK/Ka/UWqebab3UteAUikENy02AvbOOXOhhxz+W4Iq3qaTCBP+mdxZq7g50NOB848w8q3OY1tk+cr2vtCoL0BE1YuhsBEPtNWbqMoej3gHHCC1sB6f4xO8QNw8raeaoSHK4Xh6gI2zDJrCwvAx9s8++ddUhe8A3AltWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096746; c=relaxed/simple;
	bh=2yoqaLo2pc4l6/p7QkidUJVKwWX7gOmBrxk/TKU2nyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iHC1CUzhgUG/qjOsDoT85oUiXEygiiXmRbRvwci2561rx+TTfcWYiaNBJtteqLi4GFG37DfHPnT3qQKbVXsEr8FQ+KYQhO7bnwqKYJe/TCNtICCepgBaeM5JP4JsDVYpYsJBDj7ruD4NC1HyOzRksnt27WC8i0Els+v0q0kwUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACnr+cP2pVmVeKLAw--.25774S2;
	Tue, 16 Jul 2024 10:25:26 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] filemap: fix error pointer dereference in filemap_fault()
Date: Tue, 16 Jul 2024 10:25:18 +0800
Message-Id: <20240716022518.430237-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr+cP2pVmVeKLAw--.25774S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1UurWkJF1UXFyrXrW5Jrb_yoW3Zrc_GF
	y8tws7WF45CF93ur1IvFWSvFWvqrZY9ryfZFWFvFy7t3s0yry8Wa4qvr1rJrW8GrWDKF1D
	Gr4jqrWrA3sxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOX
	o2UUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

This code calls folio_put() on an error pointer which will lead to a
crash.  Check for both error pointers and NULL pointers before calling
folio_put().

Fixes: 38a55db9877c ("filemap: Handle error return from __filemap_get_folio()")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..cd26617d8987 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3420,7 +3420,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * re-find the vma and come back and find our hopefully still populated
 	 * page.
 	 */
-	if (!IS_ERR(folio))
+	if (!IS_ERR_OR_NULL(folio))
 		folio_put(folio);
 	if (mapping_locked)
 		filemap_invalidate_unlock_shared(mapping);
-- 
2.25.1


