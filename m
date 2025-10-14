Return-Path: <linux-fsdevel+bounces-64066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936ABD7085
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74E824F1C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA502BDC2B;
	Tue, 14 Oct 2025 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FhUphQSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69A273800;
	Tue, 14 Oct 2025 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407044; cv=none; b=KvIDLN4D1QbffCNVisB383wBpOBk3bWhaxjEvxRu1OZgL9uq9hSnDqZwwj6O1O5AvrLlxG/Myb/TL89OmN1TW6981n4on90/IwsYjPjSU5L5ZndW3XOqLNxsxjvG2s3VKH9OJLJodQOSawRtrHXtys8uKWLlJEi3Jh95H4R5/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407044; c=relaxed/simple;
	bh=BCKQrsaHGq+d45yxabIDm5y9tniP/KTCykBo6R7SUKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQzCQ0UzVQtqLd9HOpNs5TBvbII8GaRbmWPWQkKmHEQoUgM0yJAt2Ky6YtJARrzZy5vvtOiH0jzL+pGPjoih5YQOFHVl4t+/GKtINQ0e2vggJGUAkyU+Oz3/pHL4DgM/9XyJQFc5zsFj6CDDSbdteIM/GuWezzEHGLBdZuuN3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FhUphQSE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lXLlne5Aiu2Wza3fn1d0N/FitSFNz7yVwz8rhz/WKjI=; b=FhUphQSEuJtQ63pFH33IQbzA9r
	TqIQ4C6JgfWPv+T9FpYLNNjKnMFaBPBic6yyFsjtuZC4YLlYmlw6rC1aNXN+dTIMBTGk9jFY/tNUu
	zAsq3YaaQYGvEaxIAgbHx6ZIc0KaWQk7PtKYhY5onYaIyYdb8VzSKPFnjPCTMICuci2sTcKRsQzqG
	G2el1BdMFS77PrYhMou1cMeyvFqC37N8Mml3ErDa1C7CDEm/Xb5rs9vLRFX1toor+XMI5djuYaiGg
	jWLSIzUv7LVaE7FxxGn9+1sUXj3seuE3/84wjvC2fE4VFtKX/9xKmGQEcQyDnACGC+ChdeEjCGLe/
	8DdXzwKQ==;
Received: from [168.121.99.42] (helo=X1)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8UHu-009Bzy-Vm; Tue, 14 Oct 2025 03:57:19 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted origin
Date: Mon, 13 Oct 2025 22:57:07 -0300
Message-ID: <20251014015707.129013-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some filesystem have non-persistent UUIDs, that can change between
mounting, even if the filesystem is not modified. To prevent
false-positives when mounting overlayfs with index enabled, use the fsid
reported from statfs that is persistent across mounts.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
This patch is just for illustrative purposes and doesn't work.
---
 fs/overlayfs/copy_up.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index aac7e34f56c1..633d9470a089 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/statfs.h>
 #include <linux/fileattr.h>
 #include <linux/splice.h>
 #include <linux/xattr.h>
@@ -421,9 +422,14 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 	struct ovl_fh *fh;
 	int fh_type, dwords;
 	int buflen = MAX_HANDLE_SZ;
-	uuid_t *uuid = &realinode->i_sb->s_uuid;
+	uuid_t uuid;
+	struct kstatfs ks;
 	int err;
 
+	// RFC: dentry can't be NULL, uuid needs a type cast
+	realinode->i_sb->s_op->statfs(NULL, &ks);
+	uuid.b = ks.f_fsid;
+
 	/* Make sure the real fid stays 32bit aligned */
 	BUILD_BUG_ON(OVL_FH_FID_OFFSET % 4);
 	BUILD_BUG_ON(MAX_HANDLE_SZ + OVL_FH_FID_OFFSET > 255);
-- 
2.51.0


