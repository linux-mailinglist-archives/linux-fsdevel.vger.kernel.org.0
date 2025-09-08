Return-Path: <linux-fsdevel+bounces-60518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 474C2B48E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BA11B27DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1931306B39;
	Mon,  8 Sep 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdOPfkn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2260305E0C
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336231; cv=none; b=UDuGXJx4wwYfoqnQMSF9AuFxc4Bv1GtQLD8g+BfKTGhZf5vjHfK62eTlKFqDBnh8mFtpnaTB0WJzFj+y77Nxxo1JzNckb4Gp2hkAe5WuINaMtqwhbBPkMiMbCtyTn25vOz46+9d28lIQ6IITheNL/qnvpr4R8pE3Wps30HJxOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336231; c=relaxed/simple;
	bh=5cCbEniiAe7Z0s4SV1K9Nj6WRVuubbfqQJ+OK25NDB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHspAdotpCJtI1yKqNXFangjVnuC0xKhdfu1JS8Yc7TWT5qg9+urOBiemOUYdfn9boTicjcTaNJCUn4k2ALU31r7VhEd3kBK73uolY7FBDi6EygVTp39lzdY13M1nc4flbEuyVN0CX3DoPxXVtHnNgiEANtWXLxzT7Ly3oW9giE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdOPfkn5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757336228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJMk4KfzLsPxADx95ezsNB55aX4KcJJfO4JE01U89N8=;
	b=EdOPfkn5qG9CHPn7oyRsSpO7MlOxNkxe/8LY2Pv9PylN7Sp4Knzi4ogMXRf74MDJGUK3XN
	WBM8pytGhFsHTwOhc8EvC3+ut7B3mnwuk1Iw+BrEqtAt/Q5OGdGX1ivqm41YVA+e4moV/H
	h0PKXD/DxMjpcTfwzZhKTLO/G6QR+ns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-JBivNFHiP92_NqDDy_OY_g-1; Mon,
 08 Sep 2025 08:57:07 -0400
X-MC-Unique: JBivNFHiP92_NqDDy_OY_g-1
X-Mimecast-MFC-AGG-ID: JBivNFHiP92_NqDDy_OY_g_1757336226
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51FBB19560B8;
	Mon,  8 Sep 2025 12:57:06 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 28B6619540EE;
	Mon,  8 Sep 2025 12:57:03 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] iomap: revert the iomap_iter pos on ->iomap_end() error
Date: Mon,  8 Sep 2025 09:01:02 -0400
Message-ID: <20250908130102.101790-3-bfoster@redhat.com>
In-Reply-To: <20250908130102.101790-1-bfoster@redhat.com>
References: <20250908130102.101790-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

An iomap op iteration should not be considered successful if
->iomap_end() fails. Most ->iomap_end() callbacks do not return
errors, and for those that do we return the error to the caller, but
this is still not sufficient in some corner cases.

For example, if a DAX write to a shared iomap fails at ->iomap_end()
on XFS, this means the remap of shared blocks from the COW fork to
the data fork has possibly failed. In turn this means that just
written data may not be accessible in the file. dax_iomap_rw()
returns partial success over a returned error code and the operation
has already advanced iter.pos by the time ->iomap_end() is called.
This means that dax_iomap_rw() can return more bytes processed than
have been completed successfully, including partial success instead
of an error code if the first iteration happens to fail.

To address this problem, first tweak the ->iomap_end() error
handling logic to run regardless of whether the current iteration
advanced the iter. Next, revert pos in the error handling path. Add
a new helper to undo the changes from iomap_iter_advance(). It is
static to start since the only initial user is in iomap_iter.c.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/iomap/iter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 7cc4599b9c9b..69c993fe51fa 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -27,6 +27,22 @@ int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
 	return 0;
 }
 
+/**
+ * iomap_iter_revert - revert the iterator position
+ * @iter: iteration structure
+ * @count: number of bytes to revert
+ *
+ * Revert the iterator position by the specified number of bytes, undoing
+ * the effect of a previous iomap_iter_advance() call. The count must not
+ * exceed the amount previously advanced in the current iter.
+ */
+static void iomap_iter_revert(struct iomap_iter *iter, u64 count)
+{
+	count = min_t(u64, iter->pos - iter->iter_start_pos, count);
+	iter->pos -= count;
+	iter->len += count;
+}
+
 static inline void iomap_iter_done(struct iomap_iter *iter)
 {
 	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
@@ -80,8 +96,10 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 				iomap_length_trim(iter, iter->iter_start_pos,
 						  olen),
 				advanced, iter->flags, &iter->iomap);
-		if (ret < 0 && !advanced && !iter->status)
+		if (ret < 0 && !iter->status) {
+			iomap_iter_revert(iter, advanced);
 			return ret;
+		}
 	}
 
 	/* detect old return semantics where this would advance */
-- 
2.51.0


