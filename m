Return-Path: <linux-fsdevel+bounces-71871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED12CD75AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6714430B78CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1EE34BA57;
	Mon, 22 Dec 2025 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vt9rrpJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA93346E41
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442704; cv=none; b=oVGyglSj3yUvmHEqIt6COt+rv9U41IknsGiYv02tENhRaCHGLVyhtrxEd6BVkVP6X/H2lUyYbjVsLVsZtJf4IAt8v/5IlRO1m+fJyXc1fiIouCb8cxyP5LU7thRCKDMaxm2BGbSY/kKP7GUADT8PIC56lJDqbqIqdoqSeYn9JsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442704; c=relaxed/simple;
	bh=XgdGjZ9BVvMde+kL2Tyz95xAvJLj+J89DTnyL1NvZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ctrb4Vco+zOz34BsIRVyMcYrLpsAn2sg9whYnDyL92JUEip0AA93ATkaNRANvVn4AvHlRIh9CkBJlcgBkCqGZFN8hOfQsQLyo0MdpS+5agMB8k/X3WQFPEMEW6jhvp15LI1SeOvp+vh6HsPVvoe0VEjBJSFzxaF1GYiUbF1HJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vt9rrpJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNp1Q0C39sr+VUAHKLf607gt9IqxtWRJqB9RikBX+PE=;
	b=Vt9rrpJClQdHJx9+GQ3VzemngwKFw/vv/X8fQHWRzfB8dVqTN4qQjJk1iqSfBWlljcY872
	luuwpdnXPj4/L3kyxIxEfvN+jzjwwgiX8CumqQwR00VfOX9u+llmg10a6NpDq1lj5zKwx5
	QVEj1XniXvZIW9w3abHsKcUv6vQGal0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-gxLtjfLrNBq6FzG-03rhrg-1; Mon,
 22 Dec 2025 17:31:34 -0500
X-MC-Unique: gxLtjfLrNBq6FzG-03rhrg-1
X-Mimecast-MFC-AGG-ID: gxLtjfLrNBq6FzG-03rhrg_1766442693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92B26195605F;
	Mon, 22 Dec 2025 22:31:33 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EB1F30001A2;
	Mon, 22 Dec 2025 22:31:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/37] cifs: SMB1 split: Adjust #includes
Date: Mon, 22 Dec 2025 22:29:51 +0000
Message-ID: <20251222223006.1075635-27-dhowells@redhat.com>
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

Adjust the #include set after the removal of the SMB1 protocol defs from
cifspdu.h.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifs_unicode.c | 1 -
 fs/smb/client/cifsacl.c      | 1 -
 fs/smb/client/cifsencrypt.c  | 1 -
 fs/smb/client/cifsglob.h     | 2 --
 fs/smb/client/misc.c         | 1 +
 fs/smb/client/netmisc.c      | 1 +
 fs/smb/client/smb1proto.h    | 2 ++
 fs/smb/client/smb2file.c     | 1 -
 fs/smb/client/smb2inode.c    | 1 -
 fs/smb/client/smb2pdu.c      | 1 -
 fs/smb/client/smbencrypt.c   | 1 -
 fs/smb/client/transport.c    | 1 -
 fs/smb/client/xattr.c        | 1 -
 13 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index f8659d36793f..e7891b4406f2 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifs_debug.h"
 
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 7e6e473bd4a0..f03eda46f452 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -17,7 +17,6 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 #include <keys/user-type.h>
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index ca2a84e8673e..661c7b8dc602 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -11,7 +11,6 @@
 
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 188201519f47..2cbaf3f32e8e 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -104,8 +104,6 @@
  */
 #define SMB2_MAX_CREDITS_AVAILABLE 32000
 
-#include "cifspdu.h"
-
 #ifndef XATTR_DOS_ATTRIB
 #define XATTR_DOS_ATTRIB "user.DOSATTRIB"
 #endif
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index b5bd55501571..dab2d594f024 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -18,6 +18,7 @@
 #include "cifs_unicode.h"
 #include "smb2pdu.h"
 #include "smb2proto.h"
+#include "smb1proto.h"
 #include "cifsfs.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dns_resolve.h"
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index 59a19f3854a8..1f8994a38b37 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -19,6 +19,7 @@
 #include "cifsfs.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
 #include "smberr.h"
 #include "cifs_debug.h"
 #include "nterr.h"
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index c73cc10dfcc8..916030b1d635 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -8,6 +8,8 @@
 #ifndef _SMB1PROTO_H
 #define _SMB1PROTO_H
 
+#include "cifspdu.h"
+
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 
 struct cifs_unix_set_info_args {
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 5b03ae4afc66..0f0514be29cd 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index fff1db197543..d1183579cf08 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -13,7 +13,6 @@
 #include <linux/pagemap.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 9815e30eecfc..22168a20894b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -35,7 +35,6 @@
 #include "../common/smbfsctl.h"
 #include "../common/smb2status.h"
 #include "smb2glob.h"
-#include "cifspdu.h"
 #include "cifs_spnego.h"
 #include "../common/smbdirect/smbdirect.h"
 #include "smbdirect.h"
diff --git a/fs/smb/client/smbencrypt.c b/fs/smb/client/smbencrypt.c
index 1d1ee9f18f37..094b8296d9b4 100644
--- a/fs/smb/client/smbencrypt.c
+++ b/fs/smb/client/smbencrypt.c
@@ -20,7 +20,6 @@
 #include <linux/random.h>
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifs_debug.h"
 #include "cifsproto.h"
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 3b34c3f4da2d..75697f6d2566 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -23,7 +23,6 @@
 #include <linux/sched/signal.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/task_work.h>
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
diff --git a/fs/smb/client/xattr.c b/fs/smb/client/xattr.c
index 6bc89c59164a..e1a7d9a10a53 100644
--- a/fs/smb/client/xattr.c
+++ b/fs/smb/client/xattr.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include "cifsfs.h"
-#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"


