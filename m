Return-Path: <linux-fsdevel+bounces-14516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EB87D301
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02301C2196B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA54C3DE;
	Fri, 15 Mar 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXlSxJNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A84EB3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524828; cv=none; b=ouJ7EugojbTHcT1u3qKF6ATopWnvTV1hg1M0RCB+2Rz6t96M+YyZEVsyi4HuE2Axqghnw+MVopB3b458gQAc+y/uwf6C+hPSL+yQzVMJO3o+VIDP1MQxjmafSX745VQ5Ftos9pS/ODqfdvNYqbWAw6YeK4aDV/Wshomd9qwXM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524828; c=relaxed/simple;
	bh=RmCgRs5HzSO7P38Av5bqqFIAIkh90FiNVc/QFn5NP4g=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=mx/nnF6LQaD2OVXCIgII6KKKdo/W+y8JBWSEh/wmlgHv65v20+9jplnRFBzaYNwFkEbMSFpKKQdO4adoHaj17v7ASU6tHAqk+R8LYhYc1bo9cLPxWiH1QEqrTsc4118wzHnINukzfse/kl27ZAEpyLijXdAu01UN+yZR5024Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXlSxJNI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710524825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lvZGptx8g7mx3bOds9bwSZppU35WtAPsYKkwwS0x1O8=;
	b=VXlSxJNIfgl5Hp2EzqE9i4wfk/cnaUQYLhWHXfgSsYG66y1CX3UjxaWuKo2My4yNhGFFnq
	sZW9cqZpnJH96ehWa3VCPcRnrt7HzlVqi4R+yhdhH5nVcWE2nqpxPUAyeVvOobc2xfxb9L
	mGrixanWwDE9pbLHOIpJZW2lwkJ+wIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-TgbSeDmzPC-tD4x_tB-kQA-1; Fri, 15 Mar 2024 13:47:01 -0400
X-MC-Unique: TgbSeDmzPC-tD4x_tB-kQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 969DC800269;
	Fri, 15 Mar 2024 17:47:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D91E7C041F1;
	Fri, 15 Mar 2024 17:47:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Move some extern decls from .c files to .h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4077774.1710524816.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Mar 2024 17:46:56 +0000
Message-ID: <4077775.1710524816@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Move the following:

        extern mempool_t *cifs_sm_req_poolp;
        extern mempool_t *cifs_req_poolp;
        extern mempool_t *cifs_mid_poolp;
        extern bool disable_legacy_dialects;

from various .c files to cifsglob.h.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsfs.c   |    4 ----
 fs/smb/client/cifsglob.h |    2 ++
 fs/smb/client/connect.c  |    3 ---
 fs/smb/client/misc.c     |    3 ---
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 81d9aafd2210..aa6f1ecb7c0e 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -151,10 +151,6 @@ MODULE_PARM_DESC(disable_legacy_dialects, "To improve=
 security it may be "
 				  "vers=3D1.0 (CIFS/SMB1) and vers=3D2.0 are weaker"
 				  " and less secure. Default: n/N/0");
 =

-extern mempool_t *cifs_sm_req_poolp;
-extern mempool_t *cifs_req_poolp;
-extern mempool_t *cifs_mid_poolp;
-
 struct workqueue_struct	*cifsiod_wq;
 struct workqueue_struct	*decrypt_wq;
 struct workqueue_struct	*fileinfo_put_wq;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 8be62ed053a2..a538a15de461 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2104,6 +2104,8 @@ extern struct workqueue_struct *cifsoplockd_wq;
 extern struct workqueue_struct *deferredclose_wq;
 extern __u32 cifs_lock_secret;
 =

+extern mempool_t *cifs_sm_req_poolp;
+extern mempool_t *cifs_req_poolp;
 extern mempool_t *cifs_mid_poolp;
 =

 /* Operations for different SMB versions */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 86ae578904a2..e6f501b56c52 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -52,9 +52,6 @@
 #include "fs_context.h"
 #include "cifs_swn.h"
 =

-extern mempool_t *cifs_req_poolp;
-extern bool disable_legacy_dialects;
-
 /* FIXME: should these be tunable? */
 #define TLINK_ERROR_EXPIRE	(1 * HZ)
 #define TLINK_IDLE_EXPIRE	(600 * HZ)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 9428a0db7718..c3771fc81328 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -27,9 +27,6 @@
 #include "fs_context.h"
 #include "cached_dir.h"
 =

-extern mempool_t *cifs_sm_req_poolp;
-extern mempool_t *cifs_req_poolp;
-
 /* The xid serves as a useful identifier for each incoming vfs request,
    in a similar way to the mid which is useful to track each sent smb,
    and CurrentXid can also provide a running counter (although it


