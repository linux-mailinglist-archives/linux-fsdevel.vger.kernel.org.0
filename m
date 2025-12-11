Return-Path: <linux-fsdevel+bounces-71098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE9CB5C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580F8305D402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80371302750;
	Thu, 11 Dec 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtcmSzFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2922F6162
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455487; cv=none; b=CandivVYdlv4KI3OGimrqbnKxkxawraVY1/H57M8QRVDAVOor3sfwr8hBjpiCAd31zSGH8sSdM2CbwyzqIOIXVIZIc0NQAZR4eCT5n7GlgVGJc12aiFU0UZ+8a1GMGrb4rddC8v4T4QCTLX0v4tisW31AZZBlnzhNa/JP5P2OlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455487; c=relaxed/simple;
	bh=B5B1UpVLxfIVT8FXHwNiuCVnkKxhHweN84i+Ja0mBUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAxiwIMsmEJMVV65eWYOw88ZSe3yI3E5oTiyNefW76sY86GqnX8OwcNRGTXRCiyPY+lTn6Xyl/F9B+gmC3+Djbur8vVOXsFYHA5wU6CH0xazbRtjyeSaQsDK1itEjF7FngbRyX8SIlqTxi6f0qmSiytimEMiQ+sa1zok7mNLmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtcmSzFB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Azyu375a0PbyVqSBelYOYqj6n7XdILlIQ8dFfw/FECA=;
	b=EtcmSzFBsS+yhEw1Em7nCoe8vt03ikvPQB/s9+PeRgQWeyybcyD8K+VLxA3vgHk4B+60Hu
	PIEGxaUarRT5QMLnQaMPFngMFJPNn9rmxYYVKbktiVf9C8+0wT+e57S8LZ9N29c6s44od1
	W7IS9P+u+mBtTzxHKSV/6N+kh1llVGQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-dmSxYOeBMVyRmSOHxxMyAw-1; Thu,
 11 Dec 2025 07:18:01 -0500
X-MC-Unique: dmSxYOeBMVyRmSOHxxMyAw-1
X-Mimecast-MFC-AGG-ID: dmSxYOeBMVyRmSOHxxMyAw_1765455480
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62F14180060D;
	Thu, 11 Dec 2025 12:18:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98492180049F;
	Thu, 11 Dec 2025 12:17:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] cifs: Scripted clean up fs/smb/client/dfs.h
Date: Thu, 11 Dec 2025 12:16:56 +0000
Message-ID: <20251211121715.759074-4-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/dfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/dfs.h b/fs/smb/client/dfs.h
index e60f0a24a8a1..6b5b5ca0f55c 100644
--- a/fs/smb/client/dfs.h
+++ b/fs/smb/client/dfs.h
@@ -151,7 +151,8 @@ static inline void ref_walk_mark_end(struct dfs_ref_walk *rw)
 	ref->tit = ERR_PTR(-ENOENT); /* end marker */
 }
 
-int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
+int dfs_parse_target_referral(const char *full_path,
+			      const struct dfs_info3_param *ref,
 			      struct smb3_fs_context *ctx);
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx);
 


