Return-Path: <linux-fsdevel+bounces-71102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083DCB5CB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5996F307F8DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D12F5474;
	Thu, 11 Dec 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYJ98Vj9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E972F0C46
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455500; cv=none; b=EltVpjewr7UeQmBa6kO8jHqRoKtaUV5M1o8pS1OheMfqWy6MWUpkTPOdyFWW2roL7pDodOHdVYNKA5tMfMA7qGwsQp3mOPEyvVHYWTalp9GBVvR7LEHgZQmpM/mYEDY4hmvqrF0KXJtYWuwOCH3f39gGTuBlHSZdYoHEq00Fes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455500; c=relaxed/simple;
	bh=WUHmRUnzqNPwEhuk1TuFL7+GybFR3BK5bT0LH/vyASk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn+ftL4l1TTnB/FHxQfaPIkm5sYLxMBLYU4/y2w7DPHAhCl8cGEEwXQpcz8Po3Tn/8oO4QS2cOpZsawvVY9eH+muGy3yXkRzI734DEdfNzo5WyNdjWii/e1/T/HCDVfGsvjsL3JQwu7b02Nn0ErXhEwjX2JmAsAvhdpxx58aC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYJ98Vj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8+H9Ob/mTH0hxN19qOue5SWqY4tfGh4uckSGOp+AJQ=;
	b=EYJ98Vj9/4xby3dvhbSnKJHYaMdGcAXbRxivE9xF29+VcuNx74x2KOI/BHZPrE8qpFrpXW
	c9KXzwwH5HU2izYiim0CH40Lh1RWXlzLZ2oZo/T5SP8964qRhrhA4EUNIWQ2MmJM90wkV6
	1d87c1VGESKexggDDGw3ihQIkeZ9rkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-8sPofmFCPUKZEuNbjWANUg-1; Thu,
 11 Dec 2025 07:18:12 -0500
X-MC-Unique: 8sPofmFCPUKZEuNbjWANUg-1
X-Mimecast-MFC-AGG-ID: 8sPofmFCPUKZEuNbjWANUg_1765455491
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31F6A18011EE;
	Thu, 11 Dec 2025 12:18:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C079180045B;
	Thu, 11 Dec 2025 12:18:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/18] cifs: Scripted clean up fs/smb/client/netlink.h
Date: Thu, 11 Dec 2025 12:16:59 +0000
Message-ID: <20251211121715.759074-7-dhowells@redhat.com>
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
 fs/smb/client/netlink.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/netlink.h b/fs/smb/client/netlink.h
index e2fa8ed24c54..d35eef981b6b 100644
--- a/fs/smb/client/netlink.h
+++ b/fs/smb/client/netlink.h
@@ -10,7 +10,7 @@
 
 extern struct genl_family cifs_genl_family;
 
-extern int cifs_genl_init(void);
-extern void cifs_genl_exit(void);
+int cifs_genl_init(void);
+void cifs_genl_exit(void);
 
 #endif /* _CIFS_NETLINK_H */


