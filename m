Return-Path: <linux-fsdevel+bounces-41593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B0A327B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A8A1887C2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D020F085;
	Wed, 12 Feb 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhQICPPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AFD20F070
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368501; cv=none; b=uB8krtSIB9Qu/6jD5p4qHlOcSIic6hIkBp3GdpImGJgACdJMgwG7leGpgM3Z1PeoA6ckgiw/Xzqr/CAPtiFuRi6LNECwdAgDbehP1wAj6adkc+heQzvnAiUH6HWqqMXIAxYJl+c7/1LpPRcJjeOQHLUrvxgBjnv3FUzDYh0S/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368501; c=relaxed/simple;
	bh=ZIsMVLYs5pCC1DXZWCyVG8sbKYaHzwRXfZHw1ZYAU4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlafcqowWAy+MDJdeZNXBPczI9kfrOPVd0gn8P2fBD7BxBOOTBff3338L5MQybzuXXdpzFM8/7/r6Lk9Hx65AXqOSQG0mYZiMWwm7eBm1uOHUKEx3AoH6/ajKlD9Hfd0CTTRNXoTnDMk+/mK3d350NYKBArmLsJdCiYs7pM+I9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhQICPPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739368499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbgh6ptBj/wymE+eKK74668a7uISStfybNJ7dCObli4=;
	b=XhQICPPKgAdcX1XYPs97eydnwMEk23xnyMMb+W+YL5n9WiLUPxBDva4ZafehWNOF4z6cW6
	w5S7QP4O8DYYRt5a+EA7bb9qCpw9zbUEC4ETSxzmvOTeAPb4uC452RFm2CLB8RwMRRhK4H
	rwQmLzqxWQlsXsvYcTuyJeeap54Hkbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-su2TOh8yOcOrxgaqbbCAAQ-1; Wed,
 12 Feb 2025 08:54:55 -0500
X-MC-Unique: su2TOh8yOcOrxgaqbbCAAQ-1
X-Mimecast-MFC-AGG-ID: su2TOh8yOcOrxgaqbbCAAQ_1739368494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9D6F19560B0;
	Wed, 12 Feb 2025 13:54:53 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F34393001D10;
	Wed, 12 Feb 2025 13:54:52 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 06/10] dax: advance the iomap_iter on unshare range
Date: Wed, 12 Feb 2025 08:57:08 -0500
Message-ID: <20250212135712.506987-7-bfoster@redhat.com>
In-Reply-To: <20250212135712.506987-1-bfoster@redhat.com>
References: <20250212135712.506987-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Advance the iter and return 0 or an error code for success or
failure.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 0f611209ee37..d0430ded4b83 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1266,11 +1266,11 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 	u64 copy_len = iomap_length(iter);
 	u32 mod;
 	int id = 0;
-	s64 ret = 0;
+	s64 ret = iomap_length(iter);
 	void *daddr = NULL, *saddr = NULL;
 
 	if (!iomap_want_unshare_iter(iter))
-		return iomap_length(iter);
+		return iomap_iter_advance(iter, &ret);
 
 	/*
 	 * Extend the file range to be aligned to fsblock/pagesize, because
@@ -1307,7 +1307,9 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 
 out_unlock:
 	dax_read_unlock(id);
-	return dax_mem2blk_err(ret);
+	if (ret < 0)
+		return dax_mem2blk_err(ret);
+	return iomap_iter_advance(iter, &ret);
 }
 
 int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
-- 
2.48.1


