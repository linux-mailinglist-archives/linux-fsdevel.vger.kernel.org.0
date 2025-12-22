Return-Path: <linux-fsdevel+bounces-71854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F7CD74FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF9130A0D65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE4133890D;
	Mon, 22 Dec 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC66eb0Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1A31076B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442645; cv=none; b=aH8kGZu8DMGB6iD1k1VW6yXMz31mVAX5Mr94Sy7rOgmBApbzNc7FQcohGbBy2s+PFb+y+JeoqlN548yccfBtiWNUrq7ppTseSkwjrDGVqaeFDGj727HK3MAbK/ta+NHo0Wyx2NfwdJ0f1KyF9Die5IoJJcX2iS5NFcdg8qADR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442645; c=relaxed/simple;
	bh=o0MayiftDnLIdmHvfSlZ8/ZHloBTKIoCsuSPWWVhOlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRw4GqOp0nipsNN1lCca6yHVZ0VrGuEse6/fDMC0or9wOE3sy8+fMIDwa6S/OAbWoW2svhOps/4MObnfoeKRYaaQhRJieicMHXaT8pxj0O2zYVzMNk8vnHTgU/SrklWP2IeJYFNCdm0GFjG16K6pxQrma/F1nh66ui8K+OLO7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BC66eb0Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFJzJ1e1EZECnAmehQNetdpj4AilrLDU4YxRrL1opts=;
	b=BC66eb0ZIIqvtz9l2O8oeAPZHDABRujnC3W5MexndmO3qh1SXweaFkKyhqUg2sr9UTmdtA
	VZZHALTDBY8gCq/Muu9Eq2Bqg/SpGdkpxv1xbSihIXfOdy6uFhGHBPzAhdbawAi2FZVnHg
	AM4FYS+xwlfcHziNoosk8aw1znaSRlE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-ZKyaZ1XEMxShZ0qWyVjfGA-1; Mon,
 22 Dec 2025 17:30:38 -0500
X-MC-Unique: ZKyaZ1XEMxShZ0qWyVjfGA-1
X-Mimecast-MFC-AGG-ID: ZKyaZ1XEMxShZ0qWyVjfGA_1766442637
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DB4518001D7;
	Mon, 22 Dec 2025 22:30:37 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88BA21800664;
	Mon, 22 Dec 2025 22:30:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/37] cifs: Scripted clean up fs/smb/client/dns_resolve.h
Date: Mon, 22 Dec 2025 22:29:33 +0000
Message-ID: <20251222223006.1075635-9-dhowells@redhat.com>
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
 fs/smb/client/dns_resolve.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/dns_resolve.h b/fs/smb/client/dns_resolve.h
index 36bc4a6a55bf..951fbab5e61d 100644
--- a/fs/smb/client/dns_resolve.h
+++ b/fs/smb/client/dns_resolve.h
@@ -15,8 +15,8 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 
-int dns_resolve_name(const char *dom, const char *name,
-		     size_t namelen, struct sockaddr *ip_addr);
+int dns_resolve_name(const char *dom, const char *name, size_t namelen,
+		     struct sockaddr *ip_addr);
 
 static inline int dns_resolve_unc(const char *dom, const char *unc,
 				  struct sockaddr *ip_addr)


