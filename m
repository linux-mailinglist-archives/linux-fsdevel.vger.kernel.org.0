Return-Path: <linux-fsdevel+bounces-12025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D504585A62B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645C4280E39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F1381AC;
	Mon, 19 Feb 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjOUuEko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD22EB0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353560; cv=none; b=ea51WE7fW1O7IVBKZR1fa+ZfHIFzJUm4MDEKgOwTGcqdGTo8KMuxmMnJQ/ckJIqW1Dc4hQe2PA7Ez9cxtLzFr+Q64z5U/18K5bpRFFMSHdryhrxDiVCaME0crCh0KyZDfLKSN6OoG5Te21xL3Z3uOKnBIIhik5iTW/mVntYr1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353560; c=relaxed/simple;
	bh=q6i/qIM7No4B8p1Gsv1EcuGge0SWmBXroEjze9FrxRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bad2aaKhMP/hn9F3/72c3CKC1skvpHIUBJiRBkfKieWsjVM7JcsNRTfgO7gXTYhhrZ4aEWA09xaSYrrdrS/8SUPpxNLHrNUYxLfb/YLmZlMvIZT4cSJqlCvB1VZf2kQ4MdkokjLR2WulyYgxKZJ2fVdwUZWfhJNYKHRyH91GZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjOUuEko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708353557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2z5xVfPbtvAXi+poyaZjlxvFkPKDSd6KB5QNpLYkM5w=;
	b=FjOUuEkoWuQyQkUNMdVgtIuZSAKNrbmuYhJNSo6TtT0aAmHFxGAgtniA8cMOB+IhRUzAF3
	QsxS4YA8YGXDpMWDlS/B5w6T9AvaldxwTZM+/FRvY0RN5mkOJSQYleZguAp2q0hDj66sl9
	jRYwAJ64e3OVNWNBZ/YJqsTczWEMrDM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-0a4mPoAgNBuqh-rfWblxlw-1; Mon, 19 Feb 2024 09:39:13 -0500
X-MC-Unique: 0a4mPoAgNBuqh-rfWblxlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A837C881B6C;
	Mon, 19 Feb 2024 14:39:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A03AA200B2D7;
	Mon, 19 Feb 2024 14:39:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Daniil Dulov <d.dulov@aladdin.ru>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] afs: Increase buffer size in afs_update_volume_status()
Date: Mon, 19 Feb 2024 14:39:03 +0000
Message-ID: <20240219143906.138346-3-dhowells@redhat.com>
In-Reply-To: <20240219143906.138346-1-dhowells@redhat.com>
References: <20240219143906.138346-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Daniil Dulov <d.dulov@aladdin.ru>

The max length of volume->vid value is 20 characters.
So increase idbuf[] size up to 24 to avoid overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

[DH: Actually, it's 20 + NUL, so increase it to 24 and use snprintf()]

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240211150442.3416-1-d.dulov@aladdin.ru/ # v1
Link: https://lore.kernel.org/r/20240212083347.10742-1-d.dulov@aladdin.ru/ # v2
---
 fs/afs/volume.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 020ecd45e476..af3a3f57c1b3 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -353,7 +353,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[24];
 	int ret, idsz;
 
 	_enter("");
@@ -361,7 +361,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz = sprintf(idbuf, "%llu", volume->vid);
+	idsz = snprintf(idbuf, sizeof(idbuf), "%llu", volume->vid);
 
 	vldb = afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {


