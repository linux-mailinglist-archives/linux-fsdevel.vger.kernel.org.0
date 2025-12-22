Return-Path: <linux-fsdevel+bounces-71851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB00CD74BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A208F300A423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303130FC05;
	Mon, 22 Dec 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgkAkhnt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4614313535
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442635; cv=none; b=ArAeL2H4TGldiHleWF5/wp8SVBFKPuJvsUPnv9zSL8ivZBHd5cHvSf2WmFQYMlr/ZOaNHMOuoha/aXoBj39BIqTL28C4U1tbQOpb4zuW8qtGTrivvUfbmXGSm7ZGwSy5OymzwViRZVD1QtCUJ1wwL48E7rVwS4Tw+bD3bLw9tkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442635; c=relaxed/simple;
	bh=WUHmRUnzqNPwEhuk1TuFL7+GybFR3BK5bT0LH/vyASk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+oYY3aL1gnMpIDmqt434MXFEU6ZCIuV9ZLutX4X0OlY8ZZ8AbJUSTlMsaot1j2FL48u4elTTNRTvWDRQgvVFIsFn3j8jllEGK7G2NJTm3WCuWOQTTzZzckfLySGJqhL8Dt+81HltaVTZ4v8LQhjxMi9UomPdpTZ6vTjE3PVByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgkAkhnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8+H9Ob/mTH0hxN19qOue5SWqY4tfGh4uckSGOp+AJQ=;
	b=AgkAkhntwlWX8BFb4ABqOASqQKxFQB/eWDX7VcsE5HKChLcVqfm1oVfIIILFrtsnORYknT
	AnDUTlkFh86GaffV2kKS+jrXSHXFS6w61zk5jCm0Gi/KD+sPA6kEAPesBj6ddD1jP+awmG
	4Rz2z4DEWsLBj4Cd86gYL5Thtm/kPMI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-tEqXTdK-MaKRIP7-tS2QxA-1; Mon,
 22 Dec 2025 17:30:29 -0500
X-MC-Unique: tEqXTdK-MaKRIP7-tS2QxA-1
X-Mimecast-MFC-AGG-ID: tEqXTdK-MaKRIP7-tS2QxA_1766442628
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 376BF1955F11;
	Mon, 22 Dec 2025 22:30:28 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D9A019560B4;
	Mon, 22 Dec 2025 22:30:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/37] cifs: Scripted clean up fs/smb/client/netlink.h
Date: Mon, 22 Dec 2025 22:29:30 +0000
Message-ID: <20251222223006.1075635-6-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


