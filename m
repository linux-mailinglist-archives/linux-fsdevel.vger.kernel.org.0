Return-Path: <linux-fsdevel+bounces-63318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6ACBB4A36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA13C4EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22D26F291;
	Thu,  2 Oct 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxd7dsap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9726B742
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425398; cv=none; b=LTP8GZ503NKskZksC6+LcvB86a3x+F/sVYl7ZwBghTuMNsa1fhEosnx+W1A/0jOxAz0A2bBlxUiCzH3njl1PK5GO+6uKg8nHO1Wx7t9bMTaRiFrw+SoIUYF3lh8rsapMU230/UI7Wh9dKwyNkMCd+IlA5bEt8Pm/v3CJ0cFsObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425398; c=relaxed/simple;
	bh=GYb2+ToHnzWVjuFJGD9ON0xpfYNgyBnSnJFW2RA9wIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUq53M6vYeLtHBoYtplSTeaPo/yMFoYegm6pfziQEncR0ofYdQYQ14YavuYFjHsZY1YEkYl2Iw5fE245If49C6eTyIijBnJL1RflachqZ3Kykp1EMMxTZ1Fu3OEcynT+KEVReIfhtnJaS6f6KKkRkWWyuOE5mtwn7tajOOeA8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jxd7dsap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759425394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRBTs2P2/0wRUicB8nEZSbQd2L+zPdsrgJYblEMyMnc=;
	b=Jxd7dsapr9kz4n7h/7GoGEw3wCIJ0x/iQKA1366s4jQaHsko9BDLlQRJAwNZzI0jBhj3CQ
	uFBWI1YYBP05wRN1X9awfdoMcXAqblp/m+bmCvbXA1vSImne4zGqG4rVSo+7KgJ4BOhRBE
	fEUhicqK1l1zDfhU//OvYHFZXoTZJ24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-2KzQTsUaORe1siw3GFATVA-1; Thu,
 02 Oct 2025 13:16:31 -0400
X-MC-Unique: 2KzQTsUaORe1siw3GFATVA-1
X-Mimecast-MFC-AGG-ID: 2KzQTsUaORe1siw3GFATVA_1759425390
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DB231800350;
	Thu,  2 Oct 2025 17:16:30 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 616D8180047F;
	Thu,  2 Oct 2025 17:16:29 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 2/2] iomap: revert the iomap_iter pos on ->iomap_end() error
Date: Thu,  2 Oct 2025 13:20:38 -0400
Message-ID: <20251002172038.477207-3-bfoster@redhat.com>
In-Reply-To: <20251002172038.477207-1-bfoster@redhat.com>
References: <20251002172038.477207-1-bfoster@redhat.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


