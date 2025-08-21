Return-Path: <linux-fsdevel+bounces-58668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11BB306B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EE51D240C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF447350845;
	Thu, 21 Aug 2025 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KgEv9jqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341D38FDE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807666; cv=none; b=j1FBCI/v8i7IYG8eZ0nTERYdGCJ6fp8RrgP4bJ+6qpCEVTrelHkioBQ9aq27+isSCckFW9SAxy3UyLnCkkpy+ONR6zLZ4/tpRqjHIqzyOnpyRrIKawFFQvnNk1XtCc+U9yx1KTI3+BNqXOsexOMmxOB244zaRUHgWkhOuHlC3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807666; c=relaxed/simple;
	bh=to9lRi/o+/xXxHd3B0bfDtijVgiwZ6hVm+a/w2vBauM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV8OUImRCCMNQry7bA6kuFPKbWw/n/9aEfiZEMeVW+dpe4nt1dcMCyQxg8eHWH1BTMojmC7liaP/SpTq+nosNT5gXiIrRQlUFRBEU1Umet3tmuM4HingZ1XaQiG0p8XL/BI6XP3KbN15gJeZWtP9W6uK1Kc69RO4glWYq5JOSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KgEv9jqG; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e951246fcb6so862268276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807663; x=1756412463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIC/ISbalbO5T/gWKTH4VAVcp4NvscnrAnAnWHhl+Qc=;
        b=KgEv9jqGg8T2pn+HpxC+hny71QYE34dJL+VJce7Q1S/o4aRViTxUd09LwfNzAPvyrg
         lrsZfsH6zs7jsPMbqlvxbCyJtTJqCIWBOBAk4avk04hBns4zQSJZCE77p0rYBfIbwTHL
         e5fsvMNJsC9hifkpsJ1jsLLjxOCJNKI5R/LU0669EiV0m5OZ4nTAYbSJETnFh0oH738k
         ng0fFPekDz7P5zFNAvwTqUQhKMKCU9sKF8B/I3w+PQ+9ehjsgMi6Lk79W0yOQSIH0T6h
         qWs/52VTV5r0IVeYHjti+1q5suE07JTd6kMDCGN21yKJNUsJ+OQLtOeQVC47IzJSr4QH
         hppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807663; x=1756412463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIC/ISbalbO5T/gWKTH4VAVcp4NvscnrAnAnWHhl+Qc=;
        b=BDCiOIRlOqN0AxhwQzJ7mflcbCijFq0/DHoTN83B7wL2/F07o+JeusXPOROQc1Ut6F
         oIi5+6KoDmKlr09bh0kzUBJ86G2n9/CcqZpH7/kHGfMy/C0T4rTIaDnbOjDhzJ+fWYRR
         VaDz1uPjfJuec9M5KfjXD3qO9h0DDlkqkTEIdaS7HTFl4zRUfmB2LedRjIDhxSM7eFby
         jlo4N+M3zkKLh4eZel8YRqkGGHEj6BFaXplLWvxh2S+7Bfnp+HYIeUqze2VlSzo9Iurh
         F5Yf4hOwHOikc2DeFjihvF4wwOdz0KIinR4j2Mv5xTcXlrJzuQoNisIrDdvW+HYvb79I
         n+mw==
X-Gm-Message-State: AOJu0Yy96MYU0QA4c5U6vFpp0D2HT/jJoKsrhEgNHP6DyZEW9xPeFK+N
	0NhypJpio9jOFtK1wIvf++w53Oetno5fFd/gdA7CKLji4MjMwm8dUE08/ESZJoivqFJeYqk8m7N
	ZCsVPNAtyBw==
X-Gm-Gg: ASbGncu15ofT36NfL1yhmS+1XNWsOiL2Qp6qoSg46xZA+YYweUYDHD5cXYG9IbKODK+
	ZdHnaY1wbM4YbMk/gD+GveNZcy+T5dqsrcD/lqqN/ohg3wMfArjhTm2wkPRSNctgkSiWsi+x+Sh
	QdANK/khuyw91S3/VOqPZVs3bQER3jjDc5BH+9p1tUKu6GczNu06aVhbdJXSyqxMPgLwsfMI3BY
	jAv/gTQnDIxREhYiC/NT+LytLncxXXGWCXMeqlrm2CxM6DNXXxKL5hlOArfmsC5tCawPpkSymyu
	KfmFySo//p+HyHK9Pua3VcVOSjnOSWA/U3HMKNl/LR0urY6DNSEl0BM0+d6zuUVFMDTJzQ+ZVEh
	wpG+HQgZAQK1EWV7DwA6FD/sOp6/uDWWVJxspvI4SnWTwCqbdn3ntmdQSTBeYEH33I46yEA==
X-Google-Smtp-Source: AGHT+IH46jygWYnTlpj1UoKEmKzHBIHOl1cf2I1tXvSwkzuUG5h0TlajXJST0yFzWjVJ/MCztTkBPQ==
X-Received: by 2002:a05:6902:1891:b0:e95:11d6:258 with SMTP id 3f1490d57ef6-e9511d6033cmr3195120276.16.1755807663175;
        Thu, 21 Aug 2025 13:21:03 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951cc79b06sm121716276.33.2025.08.21.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 31/50] btrfs: don't check I_WILL_FREE|I_FREEING
Date: Thu, 21 Aug 2025 16:18:42 -0400
Message-ID: <a7e18e602e704e65c6e875fa84bee6c61fb36a07.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs has it's own per-root inode list for snapshot uses, and it has a
sanity check to make sure we're not overwriting a live inode when we add
one to the root's xarray. Change this to check the refcount to validate
it's not a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e85e38df3ea0..03fc3cbdb4af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3860,7 +3860,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!refcount_read(&existing->vfs_inode.i_count));
 	}
 
 	return 0;
-- 
2.49.0


