Return-Path: <linux-fsdevel+bounces-39256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 532EAA11E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6717A15EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0223F275;
	Wed, 15 Jan 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vnWbtQWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614101DB14D;
	Wed, 15 Jan 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934433; cv=none; b=UtDXMtd47WZZUVBDMYaDM7l5GaWTsWR6SI3W6xEw+tAz+u6WoH411XMmAaMBS/eTp14Ay/q34Gx6MzxS1qe3BYaVbqHSwgn8pRRoVIbMatTB55ZYUDfj5c4W5psviIw0n7CoSmSI0iZvlTAz32hooFUuMsK7f7n2UAYL7DcPsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934433; c=relaxed/simple;
	bh=xIEJNhy01PyOCKKGkI59VhkRuTKgjGtGxL8Zxx1tU3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZDjH8BLWW7q93JNaapoeD6LUUoG3ZUnP0kyEsBNeeEwjK4UgfbNX3XKOc4PiX8Ua65aXMFRJ8ypDHoGzvbPPtT0mHiM91vmbJEFVnQk4zawIvuH5CCCcP1IclffAwA1NWoFPe6q5px3Xcwn1mgOPmgb84JVjVCcc+LAnIAULbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vnWbtQWr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JLpZrvaMc6GV46XbuHZJmt3meVmUGd1vvv0MgNmLkC4=; b=vnWbtQWrrFbO8X0TgMRPAb3tVY
	2brCcEi1EjC/IEN5Xsm0cmRxzMpRg0Me95z04VjUJTfhoGUxgkc6rtgyCkdSRg+3U0O0D1uCWlZx4
	2noVjW6ZSw1ew2Fd0Buq0vq6B/oKRzzZOeSWtkb2zJBcY+c/7pZkPksFZ6ah8B2Fq2Jr1G5VflSJO
	77OftBY7nev+P89M32xt+VzoLXQxKgjhiJC7+JqZ/H1Oqs8NmDecshwkBsCcM/kNQqhBfVvUmLJbE
	hh2hDAz9CNKsT+1PBSp9p9CuEWRUs6zihfOmiTLkm+CIEW9h9Ch7qHw5l775qXw2QsqrNhHWW4Etx
	loKVmrIQ==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzS-0000000BOdo-3nru;
	Wed, 15 Jan 2025 09:47:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev
Subject: [PATCH 2/8] lockref: improve the lockref_get_not_zero description
Date: Wed, 15 Jan 2025 10:46:38 +0100
Message-ID: <20250115094702.504610-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

lockref_put_return returns exactly -1 and not "an error" when the lockref
is dead or locked.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/lockref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index a68192c979b3..b1b042a9a6c8 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(lockref_get_not_zero);
  * @lockref: pointer to lockref structure
  *
  * Decrement the reference count and return the new value.
- * If the lockref was dead or locked, return an error.
+ * If the lockref was dead or locked, return -1.
  */
 int lockref_put_return(struct lockref *lockref)
 {
-- 
2.45.2


