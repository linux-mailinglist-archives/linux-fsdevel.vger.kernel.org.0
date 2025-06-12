Return-Path: <linux-fsdevel+bounces-51500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31319AD740B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E82417372D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A7255E23;
	Thu, 12 Jun 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J12ndiLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF353248888;
	Thu, 12 Jun 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738908; cv=none; b=FgYIE/azWgp1oc7gGXNYd7CeXdV1vMqE5TMacHxv4cmRbrEvuHMRI05FtqyTjVQ0YXVaxL+TCKCiF0ZjqhCbiBqdekqmiuWXaL3qpHNWgMUOyNpFB1ErGtMFlH4Z7Ci6vkKLskHx5z8/B8ujnInZSTRaZqB7/jXJE0KsyqAbJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738908; c=relaxed/simple;
	bh=gRQfVCY9GjMwU+ZM5yJJd7a/2FGxatoteh4ZgkNoh80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSD7pOKoX4IRN3P8qg19LQ5uRTbt172VfZ9qx/vDj/9XtSzTc7+VhXf5jhJyBo2ra0ZW/Cktia9/3UtQvOBzW8Dy69CqTpXFcFC7L9Hg64yqL74mGgvRk3k9ox7uQhsbLsWZF3DkZFZveIfiKaGhT+c/0mkTZrFzKwnmNc8BHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J12ndiLq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Q4ZIiG9hyUUXtN5leWGJRb9X1Nx/fDwxr9B6Ufma5qU=; b=J12ndiLqKqj30Lx29OqyPPB1GZ
	AXR3xlbD3Nghzjfm/iOsMSh8/0tHv7+7OaTeJ7rVRE2MRB9MOy/KgiXCtgJbyAYaXfFNG0L/hXCns
	qt1lGA43veMKi+zlzHpjbs27uFdycd+4UJY8DM6EqdTe2qkixwPW09tW2awwa67oGgCw2054aggBH
	zV6Au25HhLf6xiTS6dfr/F6WgIOIPXdjKjT/4ItHWU8xage0KoLf1Z2KywqbXLUeNosYEekfP8/M3
	duBjvlFQ6OfJ1KSnGIunN5evrcJsSg7ZHwwbc55R7GIhOI/OJd8FNVZDYY3m+mrVV4gSVfClmmqBO
	FdfRMemw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj0y-0000000BwxE-23mQ;
	Thu, 12 Jun 2025 14:34:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] direct-io: Use memzero_page()
Date: Thu, 12 Jun 2025 15:34:39 +0100
Message-ID: <20250612143443.2848197-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612143443.2848197-1-willy@infradead.org>
References: <20250612143443.2848197-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memzero_page() is the new name for zero_user().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index bbd05f1a2145..111958634def 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -996,7 +996,7 @@ static int do_direct_IO(struct dio *dio, struct dio_submit *sdio,
 					dio_unpin_page(dio, page);
 					goto out;
 				}
-				zero_user(page, from, 1 << blkbits);
+				memzero_page(page, from, 1 << blkbits);
 				sdio->block_in_file++;
 				from += 1 << blkbits;
 				dio->result += 1 << blkbits;
-- 
2.47.2


