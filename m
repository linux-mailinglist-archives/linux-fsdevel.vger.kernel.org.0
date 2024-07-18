Return-Path: <linux-fsdevel+bounces-23920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7A934DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57D1284710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B813210D;
	Thu, 18 Jul 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcCWlANJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F30913C802
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307697; cv=none; b=XTmjLbyFtcjHWBMfQWAIz6RuFkEKKLO1EohccEEh6YAn9/JfpN97rrjAgDyuSLf4wjA5uXQ/UpYuZW1thqBcbdBpo8kU/B1I+hIj2DIKzChLtRH4gCEcUvd8DoUBXi1fEsGxa8kdW17eH3+6JkXbfsjMDyLMRiY3os3LJVraox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307697; c=relaxed/simple;
	bh=v1ZKdLXLM9suGBhGOVb3oYBWJmJ2zwAEsSPI7Al97kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9nkXkyLR3VxgdZ/xrhuEVVgMkSWxRVwoJDpLYEpdQLZIP8Yf8sq8ZYyxme/NBlXaOmAv78bTgulGoBDoiy8vfVcaDltPt9R95m8U8KqhtEdQB81aGv5PaLXu6BVWsLJlHkyJ7R4QHxoVFsfWUIEAQIJVLLN5f8L/UyKYd78Mok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcCWlANJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721307694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bk8WncT64lzd4LgIcFxlqG71mv9F7AOrhpNIyzQF2CI=;
	b=fcCWlANJVyIaABvCcAflwKZ7IORQXbMU8VnFHo3M8nNixLcpArz6TQb9DwjwstEexGv0Lb
	taP02+Ya6PQ4ztMziYft7ehvmdZgV/FGHPSh8w/DOYRqRjBaW2Ujj0Ac0B5lkJrqsEC3xD
	Lmm0Mjk7Gq7ko7QNQxU8SOwXknWjguY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-7098IFzjMyC3RB2-ZVHpBA-1; Thu,
 18 Jul 2024 09:01:32 -0400
X-MC-Unique: 7098IFzjMyC3RB2-ZVHpBA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BFC21955D60;
	Thu, 18 Jul 2024 13:01:31 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C565B19560B2;
	Thu, 18 Jul 2024 13:01:30 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] xfs: remove unnecessary flush of eof page from truncate
Date: Thu, 18 Jul 2024 09:02:12 -0400
Message-ID: <20240718130212.23905-5-bfoster@redhat.com>
In-Reply-To: <20240718130212.23905-1-bfoster@redhat.com>
References: <20240718130212.23905-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The EOF flush was originally added to work around broken
iomap_zero_range() handling of dirty cache over unwritten extents.
Now that iomap handles this situation correctly, the flush can be
removed.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff222827e550..eb0b7a88776d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -862,16 +862,6 @@ xfs_setattr_size(
 		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
 				&did_zeroing);
 	} else {
-		/*
-		 * iomap won't detect a dirty page over an unwritten block (or a
-		 * cow block over a hole) and subsequently skips zeroing the
-		 * newly post-EOF portion of the page. Flush the new EOF to
-		 * convert the block before the pagecache truncate.
-		 */
-		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
-						     newsize);
-		if (error)
-			return error;
 		error = xfs_truncate_page(ip, newsize, &did_zeroing);
 	}
 
-- 
2.45.0


