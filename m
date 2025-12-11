Return-Path: <linux-fsdevel+bounces-71104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95491CB5D12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D6CD30480BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E22DEA79;
	Thu, 11 Dec 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJyeDFVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E682D5920
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455509; cv=none; b=mcQ/dtroB5xn3yWF/aY/oTWdbFmV5z+GDiIMKXUK96qBaiRYvyYgTWgm7ZnPzEUPLw2tsGQSVAGy6VBzurYoJcZfBSHYuaCnql0r5K3iKcYjEoccKjCmAElEfMlWdsmtbbgVgT8VabvPgxkR2n/Ov1/ndkASp1wfchEwvtTJ99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455509; c=relaxed/simple;
	bh=o0MayiftDnLIdmHvfSlZ8/ZHloBTKIoCsuSPWWVhOlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFDfKcVuV7iD67wuWzbxXX4nwnrpP1XFBIcu1Hzd7IDcvTuFAYZ4E+A1+kXqsiAMLort4LqObPK4aRqJ0+8cHUS33FCDFYM3SOuMByxLACn7fPT12Z9Z9+kkUnkjKo+APPfxIOD2YJ9LKjG82lucoyHUJHV+eALvlywlNfCKBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJyeDFVS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFJzJ1e1EZECnAmehQNetdpj4AilrLDU4YxRrL1opts=;
	b=EJyeDFVSr6JTfNSyvYGEZ8EeDNX45RwpCSk4Fuk6khAxNxKJDIofrLrFh0vxEzeEZZJ3Cc
	jKGVq7E76KJtV8+eeUeyigZEnMnUbeRlrmjxz6MaH3OrYVyeunlcTkEat6kAUXkZ4vGFcD
	NLZA6E2pvNfVnxGugypbg5LMr5E2Yfo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-tEk_SZllOkGUWJ-EijuHsQ-1; Thu,
 11 Dec 2025 07:18:21 -0500
X-MC-Unique: tEk_SZllOkGUWJ-EijuHsQ-1
X-Mimecast-MFC-AGG-ID: tEk_SZllOkGUWJ-EijuHsQ_1765455500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9457D1800343;
	Thu, 11 Dec 2025 12:18:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFA3B180045B;
	Thu, 11 Dec 2025 12:18:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] cifs: Scripted clean up fs/smb/client/dns_resolve.h
Date: Thu, 11 Dec 2025 12:17:02 +0000
Message-ID: <20251211121715.759074-10-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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


