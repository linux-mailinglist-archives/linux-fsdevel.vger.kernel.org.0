Return-Path: <linux-fsdevel+bounces-27165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE795F1E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB04C1C227E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D64195811;
	Mon, 26 Aug 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbuayevS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15417C9B5;
	Mon, 26 Aug 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676401; cv=none; b=JPU/fxHvDxkC4/APg/1QXhv5CjYb1f5SBcI10Myl3P+nPYvukqMbaV0mib8dTp2kygPgdrXy5CSOTi9RlfpfisFDWWF/LA/cA+xhDzHOx4otE6NEFAwyIKpsCDTUThq8VceROKy4pTSNMooPAZDiCoHoj+drDOeZkK3fbPXtbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676401; c=relaxed/simple;
	bh=Rita/RK8sbI3aAYesZmLle/wA6UaJC2j1C6ZpQoaOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQIEu9CRqbmXZwgffHhZoiLTrAahWgycEezABO0HXxC+4DcdCFuhubRhUDGCEgIwr8VeX5fjRIaZONx8jk/pKPHQakB4YmFEmy0qOTz0ii+JG3vYwY5I5YKXuISKyw/H/7wPAMR85SOmeJhtroIZeFo+yAn1ah3TP9QYnt+28XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbuayevS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283FFC58285;
	Mon, 26 Aug 2024 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676400;
	bh=Rita/RK8sbI3aAYesZmLle/wA6UaJC2j1C6ZpQoaOsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tbuayevS14zGa+/4AMLybjNEjHAE5gc0qcbegl83QMJ8hUGqhvuVXUfl2ysaMhR8W
	 E9xZ9nikcDfOFEPkLGb54FU3wnkTnjiLxxtIkV+cZYKKNLh1cl52pIK7GDHxd+TsPp
	 job+PKEitcy3L3XKU5kgiMNuoOMbePrg+CPSNrxBRZ3daVKXCKvdleo+7WciCNKUox
	 lE/xViVU92rv68h10ZvH/69P5JyNB2aBSOCjyFXfOkskv5I3KAZUIQGxTZb/8rBg+/
	 zKxiruK2HNoJOV3eecF5m7E7KLNPqZwJlGcmAGCGNv1ey1PeSYFH4+LaXcnW7r7die
	 hC13k18M4ZjWg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:12 -0400
Subject: [PATCH v2 2/7] nfs_common: make nfs4.h include generated nfs4_1.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-2-e8ab5c0e39cc@kernel.org>
References: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
In-Reply-To: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3784; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Rita/RK8sbI3aAYesZmLle/wA6UaJC2j1C6ZpQoaOsQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHkqKuN5PHDEKNhstw0JqwBFrSLYKzm6eWleT
 V6AV11uA32JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5KgAKCRAADmhBGVaC
 FQRdD/9bi5AT6HYU73MPDktzS2M65HmQ8X0D7GtYB5kRKGeGwthcpFWpX1qP0wTzbsRQ3Tt6vnZ
 Bb2FS3W5DSsvP6BUkNyQybpD3FHxj6Oef00Kf/M76SQtax9KpfltsstqU1AO5HE65NXgclCPZqr
 7kJeJ2ML0LjOivIVr0RiDcRsyEi8e4I+l8v4VsrHEVYSPSOppXhjj18q+4UxQl3W/ilXnXIS3Az
 8bMkB+3ywM2TtbmOYAkwq5xGAHV41zOuV8shrRWE8tx6UJiyWhDXLnWktr9+xE4RcWmSbn9lk90
 WQWHc5jYxelDM066moa4fhc4YKeVMRMLZ2pfbUY+gVBGiB4EZoa0fl8tkRe6TPg2bSxueuayqau
 RdRmYXdaFk/vkCK8ZzGfld3MeRSYu25DmLLT+ilsSzWakr6XrG4+ea+OMkQkTi7/2XbRtxy0sV4
 im5oPONfqzISSiTL+w0n3zBJdvgy7M8FCyWHQOsgWM3BXAOjtWgQU5wkZZyDuV6lsNVmSEkkcfN
 UpMjV8e2VwnWE+mURgfGxOHYGsfrOECjiQuzMsI6W3bOL5pGrJ2h2a/TVWtdr2RDfqe2O3jgtpr
 nnOeynQEiRIyPnER4o1Iudxj31xdC4SuJnE3SLzRhnQd5N3F4X9gc0mOvnWmggkfxv50qnlfb7Y
 uu/djCMtyRG0KeA==
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
 fs/nfsd/nfs4xdr_gen.c                                         | 2 +-
 include/linux/nfs4.h                                          | 7 +------
 include/linux/nfs_xdr.h                                       | 5 -----
 fs/nfsd/nfs4xdr_gen.h => include/linux/sunrpc/xdrgen/nfs4_1.h | 6 +++---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
similarity index 100%
rename from fs/nfsd/nfs4_1.x
rename to Documentation/sunrpc/xdr/nfs4_1.x
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 0816cfa530e0..3e55dd1e6530 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -2,7 +2,7 @@
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification modification time: Fri Aug 23 18:57:46 2024
 
-#include "nfs4xdr_gen.h"
+#include <linux/sunrpc/xdrgen/nfs4.h>
 
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
index e79935f973ff..0272c2ee8739 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -2,8 +2,8 @@
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification modification time: Fri Aug 23 18:57:46 2024 */
 
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


