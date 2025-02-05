Return-Path: <linux-fsdevel+bounces-40924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94607A28D0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03537168FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D9165F16;
	Wed,  5 Feb 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgPgxazy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7D16DC3C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763780; cv=none; b=F3hMUeCrjV95boZ3C9VBzylXr+HEDNg4RdBjiFxzMYsEEFkOYx2dSsqppTstlaFEeJ1gEWxpM0mn85Xv4wHiJi8Oiq2Sl6E9PBwikxotNwyZl7jlsS85IsRCIHoI1KhABn+TJbyjI9SkZ5Vm6UXMOt+awqur7MDUZAesF2Ke/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763780; c=relaxed/simple;
	bh=LaRZRrZk0OzVupCeCTpbLgHc8HrzAechlctB0RiHKlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGYfLR0wF8gCoQ16nXHkeGJSde9D0Y09HuixlwNBdc0H2oYS1cVXaxnJfm73/l7VeMkuEK11XYh1pm0SC/itYnNpkakC9pXtyi6jkMa6S1GlH5lSYcpklUOVMiLfq9lEiarNrKgYO6rahT85YxHJ49q9pk+DFvfuD+ggPWy/aEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgPgxazy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738763777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaOsPtGDsZkSclxwUXxI+0h/TK2M3lT6Y3Twd1dglBE=;
	b=VgPgxazyPWByEfgCuqyAF1+GlTKwB/RPhRuhqSLyi9Ohgnw07O0BHfXIsBMJxueP4/6oWe
	cJoY4rACGMaH0uIEtKEAV/daIqJvlTqZjOKv8Z2D6fRsU5TCTY+70w8mpa5GWzZT/moBwm
	IC/AVDT3q4wk/bIq2Kh/x1URu2XEYWU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-udcG9jsiP5CGMRx24N37eA-1; Wed,
 05 Feb 2025 08:56:12 -0500
X-MC-Unique: udcG9jsiP5CGMRx24N37eA-1
X-Mimecast-MFC-AGG-ID: udcG9jsiP5CGMRx24N37eA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C11F180087B;
	Wed,  5 Feb 2025 13:56:02 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C6D5300018D;
	Wed,  5 Feb 2025 13:56:01 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v5 05/10] iomap: lift iter termination logic from iomap_iter_advance()
Date: Wed,  5 Feb 2025 08:58:16 -0500
Message-ID: <20250205135821.178256-6-bfoster@redhat.com>
In-Reply-To: <20250205135821.178256-1-bfoster@redhat.com>
References: <20250205135821.178256-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The iter termination logic in iomap_iter_advance() is only needed by
iomap_iter() to determine whether to proceed with the next mapping
for an ongoing operation. The old logic sets ret to 1 and then
terminates if the operation is complete (iter->len == 0) or the
previous iteration performed no work and the mapping has not been
marked stale. The stale check exists to allow operations to
retry the current mapping if an inconsistency has been detected.

To further genericize iomap_iter_advance(), lift the termination
logic into iomap_iter() and update the former to return success (0)
or an error code. iomap_iter() continues on successful advance and
non-zero iter->len or otherwise terminates in the no progress (and
not stale) or error cases.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/iter.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 1db16be7b9f0..8e0746ad80bd 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -27,17 +27,11 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
  */
 static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
 {
-	bool stale = iter->iomap.flags & IOMAP_F_STALE;
-	int ret = 1;
-
 	if (WARN_ON_ONCE(count > iomap_length(iter)))
 		return -EIO;
 	iter->pos += count;
 	iter->len -= count;
-	if (!iter->len || (!count && !stale))
-		ret = 0;
-
-	return ret;
+	return 0;
 }
 
 static inline void iomap_iter_done(struct iomap_iter *iter)
@@ -69,6 +63,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
  */
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
+	bool stale = iter->iomap.flags & IOMAP_F_STALE;
 	s64 processed;
 	int ret;
 
@@ -91,8 +86,18 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 		return processed;
 	}
 
-	/* advance and clear state from the previous iteration */
+	/*
+	 * Advance the iter and clear state from the previous iteration. Use
+	 * iter->len to determine whether to continue onto the next mapping.
+	 * Explicitly terminate in the case where the current iter has not
+	 * advanced at all (i.e. no work was done for some reason) unless the
+	 * mapping has been marked stale and needs to be reprocessed.
+	 */
 	ret = iomap_iter_advance(iter, processed);
+	if (!ret && iter->len > 0)
+		ret = 1;
+	if (ret > 0 && !iter->processed && !stale)
+		ret = 0;
 	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
 		return ret;
-- 
2.48.1


