Return-Path: <linux-fsdevel+bounces-34015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895C89C1D2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DA0285E35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF61EABB1;
	Fri,  8 Nov 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5n42CSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5681E882A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069680; cv=none; b=Nvk7yKs81s56fsLvfyQgaUQ1KNu9G4EQqRJA2R5lz81VnCwlYu7Ob1BEtS1A4YAtKW5QJTcuFIqn70+ai8j3lZxsiEo8ur4PsKdnraRuBlH49xqG9YIllV48XWwr2AlGym2r3H4hhBrbhmNFIwIdtGyfUy4tpCwy5lOGojlSUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069680; c=relaxed/simple;
	bh=CZJi/OyUjBJ3Qns3n/1YgPbQWTEBPth83uDK/Wns008=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMjwZN1e19rPqJkP5FS2IUA0OOe2EU84CYs4oZfv4rd5j1wmUf6z2DskBWNkeuRyyKiWEAK6iZrd3+tO7X39OXDkNVXv+ZH5JYD0qXRedYpgVY7rBhLeok3OG1uQFePbTzkM0zwy+A6TO2Ndg5+gYj01rGEcIJ9UlhZTffRC93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5n42CSi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731069677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdLf/MaIVZKlGy8e6e0n3R3u77Bw4zfNKRce7SSBUDw=;
	b=X5n42CSinbMfNj0PnWnebmnv/R0EP2Xtx4TDQsnXjaOlqnxsN6l9WLKxM9ll10ZEA0k/vZ
	D7lzVu6D6oiIa79DDu0F6O/bjBd5UwxydHStvd3EBvSBI9o41X6b6UahtQlE+tbl4GkmBE
	pGKIcHyfvabVdgVM1DZcfO7xYcxtPlU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-0UGv2EowMryeisKsJyHQTw-1; Fri,
 08 Nov 2024 07:41:16 -0500
X-MC-Unique: 0UGv2EowMryeisKsJyHQTw-1
X-Mimecast-MFC-AGG-ID: 0UGv2EowMryeisKsJyHQTw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6292419560B0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:15 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E024F1956054
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:14 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/4] iomap: warn on zero range of a post-eof folio
Date: Fri,  8 Nov 2024 07:42:46 -0500
Message-ID: <20241108124246.198489-5-bfoster@redhat.com>
In-Reply-To: <20241108124246.198489-1-bfoster@redhat.com>
References: <20241108124246.198489-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

iomap_zero_range() uses buffered writes for manual zeroing, no
longer updates i_size for such writes, but is still explicitly
called for post-eof ranges. The historical use case for this is
zeroing post-eof speculative preallocation on extending writes from
XFS. However, XFS also recently changed to convert all post-eof
delalloc mappings to unwritten in the iomap_begin() handler, which
means it now never expects manual zeroing of post-eof mappings. In
other words, all post-eof mappings should be reported as holes or
unwritten.

This is a subtle dependency that can be hard to detect if violated
because associated codepaths are likely to update i_size after folio
locks are dropped, but before writeback happens to occur. For
example, if XFS reverts back to some form of manual zeroing of
post-eof blocks on write extension, writeback of those zeroed folios
will now race with the presumed i_size update from the subsequent
buffered write.

Since iomap_zero_range() can't correctly zero post-eof mappings
beyond EOF without updating i_size, warn if this ever occurs. This
serves as minimal indication that if this use case is reintroduced
by a filesystem, iomap_zero_range() might need to reconsider i_size
updates for write extending use cases.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7f40234a301e..e18830e4809b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1354,6 +1354,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
+	loff_t isize = iter->inode->i_size;
 	loff_t written = 0;
 
 	do {
@@ -1369,6 +1370,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
+		/* warn about zeroing folios beyond eof that won't write back */
+		WARN_ON_ONCE(folio_pos(folio) > isize);
 		offset = offset_in_folio(folio, pos);
 		if (bytes > folio_size(folio) - offset)
 			bytes = folio_size(folio) - offset;
-- 
2.47.0


