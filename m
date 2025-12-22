Return-Path: <linux-fsdevel+bounces-71860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB350CD76B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8F13064FCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5B34250F;
	Mon, 22 Dec 2025 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwXhvgKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDF341078
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442666; cv=none; b=UB+0pxZhvcqj77RTpPPBMP94n3tCXzR1y5lLN5BYH7kJyqVyT27Lm3HC6O92v+ZkHlB8+NIE7WNTKUv+Wq5lSPf48+ykgEgOxTvm/eGYdV0PzAwhcH3lp1HJPWvlyhu+7c8gHxvgE903E01Fxn2alG0g43+nUsDw8trnpX0l4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442666; c=relaxed/simple;
	bh=+Wo+l71IAU0AqaO6ZoV2OG/pvIDGGYqR2GhGhU27Y68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEpm6auGqEBBQyvqoJmok9cyvXO1wH8TYFQ8WhQoHEM9WGU8Cptz93ajdFBnnlvQBQO76m7igEGhRGFPAOklTQs94Tzdeq10O98LT6MT6Y2h8z7W5l00d/YsluP6tA/XAFAzqZxJ/9M7mrezFLSimD+aGbi+87qD0QuPT6vJkf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwXhvgKw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+sZRfUhZLYVTFCknqCPjwaISkbiMEC9lHaFs7CeHiY=;
	b=JwXhvgKwW514BPIwDlZ7zuyGJvgNXAsDudx5jOwj/N2t1tQvNSCrzrlElIV+slg1WSZG3u
	1wygED43evXhHem3G6cWqXXfrPuKSoGiPn+mMqdQIPV7kvRlU07XDkuCjJ0ioYRwfPxChg
	MLR+LJmod0YYVdr20KkhJmOj+d9IuEY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-8l_MDOCeP1uPcFSvSd8H2g-1; Mon,
 22 Dec 2025 17:30:56 -0500
X-MC-Unique: 8l_MDOCeP1uPcFSvSd8H2g-1
X-Mimecast-MFC-AGG-ID: 8l_MDOCeP1uPcFSvSd8H2g_1766442655
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 664BA19560B2;
	Mon, 22 Dec 2025 22:30:55 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F6DC30001A2;
	Mon, 22 Dec 2025 22:30:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/37] cifs: Scripted clean up fs/smb/client/cifs_swn.h
Date: Mon, 22 Dec 2025 22:29:39 +0000
Message-ID: <20251222223006.1075635-15-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifs_swn.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifs_swn.h b/fs/smb/client/cifs_swn.h
index 8a9d2a5c9077..955d07b69450 100644
--- a/fs/smb/client/cifs_swn.h
+++ b/fs/smb/client/cifs_swn.h
@@ -14,15 +14,15 @@ struct sk_buff;
 struct genl_info;
 
 #ifdef CONFIG_CIFS_SWN_UPCALL
-extern int cifs_swn_register(struct cifs_tcon *tcon);
+int cifs_swn_register(struct cifs_tcon *tcon);
 
-extern int cifs_swn_unregister(struct cifs_tcon *tcon);
+int cifs_swn_unregister(struct cifs_tcon *tcon);
 
-extern int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info);
+int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info);
 
-extern void cifs_swn_dump(struct seq_file *m);
+void cifs_swn_dump(struct seq_file *m);
 
-extern void cifs_swn_check(void);
+void cifs_swn_check(void);
 
 static inline bool cifs_swn_set_server_dstaddr(struct TCP_Server_Info *server)
 {


