Return-Path: <linux-fsdevel+bounces-71858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98414CD76BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA2E304A116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434633F8BD;
	Mon, 22 Dec 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+3meb4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25433F37B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442657; cv=none; b=p4Ik15JMRQh8x+ImSpkHUJ+ZN6zBjB4JDwVVe1MIkf4qqI5S1Xxmy+At9ZMU0YGVNWoUkPzij+jByw8hGXRH9LMxu8IkJxT8H7Lf52tnOGC6/w2/pqcqY3SFoHeuLsjSN5ZR2BsNdVJmOG77m5qGXPocqJAmfQOxp590JrT2B6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442657; c=relaxed/simple;
	bh=RwYUerJ4hJmzwuH1LlZyqEcdJj9Pt2Fovq5QE2M9JM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvkB7zna/+8oJeO8CnkIXujdZ0FDJQKGozhjijVvyDxkRndLtTuK7C4PDiZCPgmfspa6Mp8bICAD4iFEhQT/nSzAJPoQs5usZcddeCKLk2XR0savTxsjTONTUN7GPjvp7QSNoY0fqSXzb/imGS3m/battvvWJ8oOK54zm8itMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+3meb4+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfVyyD1PexB1d/N6d8HS6nBZO+yvtrhFLe6ajtg+Ako=;
	b=O+3meb4+XkTj/42wK8I9B1egO1xNBI9evKGtsXSipL6PbHwJNx2x/+O5hX2r9VIOkQCHN7
	yWBBMlkO/lQPC7ejppm0eGvMyUH6zz7DgGeQAWXrmlN+9krZVrrBUH80IsgTPEIk4rk0vE
	PNAh6mvbdIsuIF1yx7JqYbc4cbHsL1o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-GAHAakMJMKqUAGXldYxezw-1; Mon,
 22 Dec 2025 17:30:53 -0500
X-MC-Unique: GAHAakMJMKqUAGXldYxezw-1
X-Mimecast-MFC-AGG-ID: GAHAakMJMKqUAGXldYxezw_1766442652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BA8D1956089;
	Mon, 22 Dec 2025 22:30:52 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FA8F1800664;
	Mon, 22 Dec 2025 22:30:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/37] cifs: Scripted clean up fs/smb/client/compress.h
Date: Mon, 22 Dec 2025 22:29:38 +0000
Message-ID: <20251222223006.1075635-14-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
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
 fs/smb/client/compress.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/compress.h b/fs/smb/client/compress.h
index 63aea32fbe92..2679baca129b 100644
--- a/fs/smb/client/compress.h
+++ b/fs/smb/client/compress.h
@@ -30,7 +30,8 @@
 typedef int (*compress_send_fn)(struct TCP_Server_Info *, int, struct smb_rqst *);
 
 
-int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
+int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq,
+		 compress_send_fn send_fn);
 bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq);
 
 /*


