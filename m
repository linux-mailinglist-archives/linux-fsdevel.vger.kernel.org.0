Return-Path: <linux-fsdevel+bounces-59999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA85B40874
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3BC560C84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC531CA74;
	Tue,  2 Sep 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjzsx244"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3531987D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825445; cv=none; b=muClckjODhhGkS31IpC1S42q5YGhQ6sNUyMlDiSU98G5pvXY/ytvSaezHb6RRoV8oU9IVMcKR8jnRYgAbnpBgF6dEvQqCAa2xlz3zOmLvObBJXgp+81jkB4YABa5EBwbxqdtHdTVv0IcX88AxPU5NFf9b/E4t0Qy3k8bRTuHnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825445; c=relaxed/simple;
	bh=KiGg4VB9Q+vBrlHvlnozuESQ3v0AxzxtG55gaHVkV7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYVb+s/eRHj09bFz8yqB55vRyOv0eU/fe2ba1K2Dhp5oumtgC0ifsEF9dVpJLc0aZwEKu06ORpqcrFoCkTt835NZf4J2pCOFdDuZWAdEnME9h//sQ50Bg43j2Np++2sc/4YhYlAuaOwXPRmgk06un20fqKJYN8UFLpLJPZJ6tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjzsx244; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756825442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yLnbBWzIJBq9wjG+I2pL5jR/NeW1MkJJAe+iK3c2bI=;
	b=fjzsx244o4JyfokbP+eF0q+n8szgwuqq3w5/YSJUDmUIiml9SIMZpTa44AQ1sfaoXXlPMX
	o26Hvt8N5xZH/d/aka1Zja8vP9HBEjHoT4ejCF30aYp+DxnkXeFeEf7uvxC7lyOVUV9GSD
	iJSYGhIkyFMgCcD84qOTB94lxs2twrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-I24Q0sLiMZqcHXhoGDbXjQ-1; Tue,
 02 Sep 2025 11:03:57 -0400
X-MC-Unique: I24Q0sLiMZqcHXhoGDbXjQ-1
X-Mimecast-MFC-AGG-ID: I24Q0sLiMZqcHXhoGDbXjQ_1756825436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D340A18002C1;
	Tue,  2 Sep 2025 15:03:55 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5D09180044F;
	Tue,  2 Sep 2025 15:03:54 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: jack@suse.cz,
	djwong@kernel.org
Subject: [PATCH RFC 2/2] iomap: revert the iomap_iter pos on ->iomap_end() error
Date: Tue,  2 Sep 2025 11:07:55 -0400
Message-ID: <20250902150755.289469-3-bfoster@redhat.com>
In-Reply-To: <20250902150755.289469-1-bfoster@redhat.com>
References: <20250902150755.289469-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


