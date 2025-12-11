Return-Path: <linux-fsdevel+bounces-71110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CEFCB5DA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A90843051621
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44E3101DE;
	Thu, 11 Dec 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwTjA+sl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE330FC30
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455530; cv=none; b=p2LhiBMOkKg7O98ARz5/3lNTZ7TNSpzkm1nsOnPhAqbST1MsyNQUD88abkwDAJK/+2rk4fI89lFT57w87+RK66s8E2ipHLXzaTjHErsFPVlAEzB8M4DzrLF/x+y7mH2d1SS0XyjqcDpr/Y0JXULgI+6IPXE14vAbXmayCY053vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455530; c=relaxed/simple;
	bh=+Wo+l71IAU0AqaO6ZoV2OG/pvIDGGYqR2GhGhU27Y68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJceCNm2bJ1uAriPlU6NETQPYPEsgiE02P8Qa4IZu7AynxC08jtdOv0ocf/g1dhCyIppz4WJy4uqzH9cHa+JtwiZ5NwVQjlFcxnYRa/3ldWBpUqcBloUTcYyQDxjEMuv4vpUqAOX6Egw0IqDswuROnV2SZkoMq84fw2WgIK1qlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwTjA+sl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+sZRfUhZLYVTFCknqCPjwaISkbiMEC9lHaFs7CeHiY=;
	b=fwTjA+sloccFX6sTKin+LDWjwJEhvUE1x6zZ7/68s7z6hTMIISiwxe6ch12qn3lBAG9vKG
	GBL3ynGeUDFjgyrMFf/U+HqmN4xYFaQNFHE92HzSit/UVfpUQQ3BJSJwtLiHYypFmR2Ib8
	B4goAocOT3tU5KH8rXH4kkHMS3ib5W4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-kz4gVK2sNH-hU3h-RKxHCQ-1; Thu,
 11 Dec 2025 07:18:39 -0500
X-MC-Unique: kz4gVK2sNH-hU3h-RKxHCQ-1
X-Mimecast-MFC-AGG-ID: kz4gVK2sNH-hU3h-RKxHCQ_1765455518
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 968F119560A5;
	Thu, 11 Dec 2025 12:18:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D93F0180049F;
	Thu, 11 Dec 2025 12:18:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] cifs: Scripted clean up fs/smb/client/cifs_swn.h
Date: Thu, 11 Dec 2025 12:17:08 +0000
Message-ID: <20251211121715.759074-16-dhowells@redhat.com>
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


