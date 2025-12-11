Return-Path: <linux-fsdevel+bounces-71114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C40CB5DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E5B3065793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84030CD83;
	Thu, 11 Dec 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0k1x5Mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6F30FC2C
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455595; cv=none; b=l500fgNHlK6/6ykVDVzste/W4nYshsh7A22S79o7kyt+1+XA2iIdI4n/CrmQpjrSTDRpFEfsMWre/VvCB5WYkoUVls4vcwtR9amV3YRjhG+rT1AWEFtslHTaZ8GlmpvOyQgYYSYqrnbDpJhNAPxfS98NkCB00jLpzI2P2vmo9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455595; c=relaxed/simple;
	bh=kHsDSsBbEJjgzmCquEl2lb6YJgpKoKwc0ROqUXOGtwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKXA03vY8qPhtUwdV+Jr6Ef+smGVLHXl+562JZlEW8mPGmL6/OOnNCS6HW7j7GgJF0L90JTkPcZ3QEwzg8FweH6X5lBYaJAK1vdsmgtTqC/pnjZ3bmMoGpflvk8kT1fxh819TLFQC3T9ods7E26oFOpjHOqzqz75gBYtAbZaHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0k1x5Mm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzr6N7b5JybtHCAVwGJNHrVs+Vz79HR5PooQE+V9Huo=;
	b=G0k1x5Mm3Q1VAfKgpkSs0FpI+h0BDiEc6l+OouLOzmPAYRL0cXA5Go04ZHRpuT0bNDuWOK
	yIUBqjUM/2audhsBKbACGlOtB49NS6fxeGjFbivA4wnsOcXUJlPBTnnuLK1wu9vkmB1apd
	aqqP7GGQk9dL6aWDzgIwiXId5W7W89Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-V4OYB4LeOZyTvdbitEz3wQ-1; Thu,
 11 Dec 2025 07:18:42 -0500
X-MC-Unique: V4OYB4LeOZyTvdbitEz3wQ-1
X-Mimecast-MFC-AGG-ID: V4OYB4LeOZyTvdbitEz3wQ_1765455521
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F6511800592;
	Thu, 11 Dec 2025 12:18:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9F861956056;
	Thu, 11 Dec 2025 12:18:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] cifs: Scripted clean up fs/smb/client/cifs_debug.h
Date: Thu, 11 Dec 2025 12:17:09 +0000
Message-ID: <20251211121715.759074-17-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifs_debug.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifs_debug.h b/fs/smb/client/cifs_debug.h
index e0035ff42dba..35bd5c8e1d71 100644
--- a/fs/smb/client/cifs_debug.h
+++ b/fs/smb/client/cifs_debug.h
@@ -15,7 +15,8 @@
 #define pr_fmt(fmt) "CIFS: " fmt
 
 void cifs_dump_mem(char *label, void *data, int length);
-void cifs_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *server);
+void cifs_dump_detail(void *buf, size_t buf_len,
+		      struct TCP_Server_Info *server);
 void cifs_dump_mids(struct TCP_Server_Info *server);
 extern bool traceSMB;		/* flag which enables the function below */
 void dump_smb(void *buf, int smb_buf_length);


