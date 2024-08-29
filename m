Return-Path: <linux-fsdevel+bounces-27839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E268A96468A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB6B283297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917A1B2EF2;
	Thu, 29 Aug 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijFnXcba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72B1B29CC;
	Thu, 29 Aug 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938024; cv=none; b=lLEOdfJinunSyo8yBbSf0MhlbibRsG18kMDlVO32aCT8ijhpUQlCSWj/isB+OjyrokGvQONkM62Sz/GrLhiSzH+7B7SW2PyqMFLTEHwFHEHPqGbw7hkMaGECYpKB9zmUNTL7c1cdFYeCr26ZRAcS93gu7/ChQyCqZb1qezns+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938024; c=relaxed/simple;
	bh=RTtljvwynX93vIDKZhhaEQYmk0aezhi8afLpT+S0rFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IbhVr+P60wpMkS/LF++70I919P8aViQzQPS9ARq4eJVz0lbV/BCq0W8lYvdszrXPkqiuKad2CJcbH2DtIz7p8QAYgFJbrv/3gyW8Wz+2EgLK6uMqEOXboYP3/ZmrMeuSPyHBx/1jSgeEYfCs7bVCAKKRBzCh0WtytzRLddNE/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijFnXcba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE6FC4CEC5;
	Thu, 29 Aug 2024 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938023;
	bh=RTtljvwynX93vIDKZhhaEQYmk0aezhi8afLpT+S0rFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ijFnXcbaLe9xUgRZXn0NOa0SzFQKt/WjUpGBHvVRwl7/MuVfvzWpONgmT+q6gQ2w0
	 qb8i4UMUb6u4X3E7hVrJ3W84+oEIJOfRc3O/it6bv0bGeEH3/7X+DeT920Ap6bscGZ
	 +F9plPpglqKYpa385hj7peoW/cuqpdcm2Vk2swW+8BE9sYgeZNsLJEZaJ14H8ucuvL
	 aPb8mq8Q2Sqyd5sYYTWPHelhaixnsskWV0jrcm9JRIsWqfY2TdkxY3ThqcDMNQ/IFb
	 s770S1B1HJYhUrOcNWqetcbp/ZWDEx625cfgeei01Eun5usm0SeukB96GBzEw9RHrQ
	 rG2NoaRizR01Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:46 -0400
Subject: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-8-271c60806c5d@kernel.org>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
In-Reply-To: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RTtljvwynX93vIDKZhhaEQYmk0aezhi8afLpT+S0rFI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcXzwy82fkbxUqUvVZm2GvvVf6Xy5kCoy7EE
 mCgJqZLY3mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FbBQEACIPavoJ3prq+7lSABLfVtVxwzS8UZJMVBl6Cv+DfN29EtytU2JS0CGTy4eAO82Rn+hCnz
 FFaUU79tsmLWZc1dr7cSb2ucw7KIJX/PYCATzoAF+O2p6z1gTO7uTauGkQSpezS0fOxjboO9DDo
 chbf3C/h1lur7Ke3tl+gCSco2xiUqvenJ3GQNdHzBM2TMS8OctrHutOZFk8h2Ww4jA6ABt518Sa
 AiUNNNKR6jdG5bYtpTNjDnyhS9DS+FKvY9CJ2geQx3BGRkyYDSGikf9wxmZYnG5kbV58NBeOIwB
 y8WwgJLU9OX1XQ34NIRipH9+9J3nq3IsUIgHf7cofIhA1DzUShPIM3aTJ6ZhxXnO1cFcqviYvjX
 MHJdsQnrKCS9NEZN8XRBx6lMqEfsHJfNkmxgpCnfY2yCXMGLleBUNfx2CV/QJSvuowEHybiWzsZ
 QEsaaWA3y1OXfCTo8WqacfkhEr6LHEoz7d4Q4LicSqPaqTAcYEdNkKp2hMslx7El2AFHRI1UBsx
 qXqgkgHe/SbnwbFtZEOMp5LD9eqiqxABmfZIlHZS75bXq4k9Jbu+txSvuM8WZB1uldES3jTLYGY
 JzGOHvDI937JrGqRM4xelekoXqcqLjJpDhbgPUOMfkjXedX6XScNncaA2UI8TB9WcQ7euHylozH
 GCGuVbJukv5R6eQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Long term, we'd like to move to autogenerating a lot of our XDR code.
Both the client and server include include/linux/nfs4.h. That file is
hand-rolled and some of the symbols in it conflict with the
autogenerated symbols from the spec.

Move nfs4_1.x to Documentation/sunrpc/xdr. Create a new
include/linux/sunrpc/xdrgen directory in which we can keep autogenerated
header files. Move the new, generated nfs4xdr_gen.h file to nfs4_1.h in
that directory. Have include/linux/nfs4.h include the newly renamed file
and then remove conflicting definitions from it and nfs_xdr.h.

For now, the .x file from which we're generating the header is fairly
small and just covers the delstid draft, but we can expand that in the
future and just remove conflicting definitions as we go.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 {fs/nfsd => Documentation/sunrpc/xdr}/nfs4_1.x                | 0
 MAINTAINERS                                                   | 1 +
 fs/nfsd/nfs4xdr_gen.c                                         | 2 +-
 include/linux/nfs4.h                                          | 7 +------
 include/linux/nfs_xdr.h                                       | 5 -----
 fs/nfsd/nfs4xdr_gen.h => include/linux/sunrpc/xdrgen/nfs4_1.h | 6 +++---
 6 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
similarity index 100%
rename from fs/nfsd/nfs4_1.x
rename to Documentation/sunrpc/xdr/nfs4_1.x
diff --git a/MAINTAINERS b/MAINTAINERS
index a70b7c9c3533..e85114273238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12175,6 +12175,7 @@ S:	Supported
 B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
 F:	Documentation/filesystems/nfs/
+F:	Documentation/sunrpc/xdr/
 F:	fs/lockd/
 F:	fs/nfs_common/
 F:	fs/nfsd/
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 6833d0ad35a8..00e803781c87 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -2,7 +2,7 @@
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification modification time: Wed Aug 28 09:57:28 2024
 
-#include "nfs4xdr_gen.h"
+#include <linux/sunrpc/xdrgen/nfs4_1.h>
 
 static bool __maybe_unused
 xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d7430d9f218..b90719244775 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -17,6 +17,7 @@
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/xdrgen/nfs4_1.h>
 
 enum nfs4_acl_whotype {
 	NFS4_ACL_WHO_NAMED = 0,
@@ -512,12 +513,6 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
-enum {
-	FATTR4_TIME_DELEG_ACCESS	= 84,
-	FATTR4_TIME_DELEG_MODIFY	= 85,
-	FATTR4_OPEN_ARGUMENTS		= 86,
-};
-
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 45623af3e7b8..d3fe47baf110 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1315,11 +1315,6 @@ struct nfs4_fsid_present_res {
 
 #endif /* CONFIG_NFS_V4 */
 
-struct nfstime4 {
-	u64	seconds;
-	u32	nseconds;
-};
-
 #ifdef CONFIG_NFS_V4_1
 
 struct pnfs_commit_bucket {
diff --git a/fs/nfsd/nfs4xdr_gen.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
similarity index 96%
rename from fs/nfsd/nfs4xdr_gen.h
rename to include/linux/sunrpc/xdrgen/nfs4_1.h
index 5465db4fb32b..5faee67281b8 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -2,8 +2,8 @@
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification modification time: Wed Aug 28 09:57:28 2024 */
 
-#ifndef _LINUX_NFS4_XDRGEN_H
-#define _LINUX_NFS4_XDRGEN_H
+#ifndef _LINUX_XDRGEN_NFS4_H
+#define _LINUX_XDRGEN_NFS4_H
 
 #include <linux/types.h>
 #include <linux/sunrpc/svc.h>
@@ -103,4 +103,4 @@ enum { FATTR4_TIME_DELEG_MODIFY = 85 };
 
 enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000 };
 
-#endif /* _LINUX_NFS4_XDRGEN_H */
+#endif /* _LINUX_XDRGEN_NFS4_H */

-- 
2.46.0


