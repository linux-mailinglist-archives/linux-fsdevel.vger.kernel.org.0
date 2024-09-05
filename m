Return-Path: <linux-fsdevel+bounces-28732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17696D907
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA3E1F2B8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018E1A00FE;
	Thu,  5 Sep 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5xtVzfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF919FA9F;
	Thu,  5 Sep 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540130; cv=none; b=RwFHmco8QP1qbDNz+vKrtntaeJwF7CmgUsyd0JlOdm+arkanjuE8zZPSBTaMBa6ppQO7ESht/RF/MmDNk1rhJPGRgoDmKd5dyxOdMPrzx6mpT3UMRT/xqdKxg6WNVFM6lW90fx3+3XATowXhb3+IifwsfajsoIWL/vHobPmxev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540130; c=relaxed/simple;
	bh=kpELDEFTy1D47hjM4/MCx13/I9LcpRbQfLN1rgDDfE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZPQ0EnTz/XTsU3Nn4YmEvbE3Qf9d8VjJBEk7rb2isFO/Rd244l6XpSr8S/EMvQnWqgNh7F+ZVl3PIOwpiBgk1LvE5AmerF3wsqHgalOo5DGYa3GPYL6qSg1PhIu3kjcJ/1JE5cleu8zHWMcnObh+i9IWURv8z3erPBn/coz7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5xtVzfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B216C4CEC4;
	Thu,  5 Sep 2024 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540129;
	bh=kpELDEFTy1D47hjM4/MCx13/I9LcpRbQfLN1rgDDfE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V5xtVzfOiGstIKXw75qVH8BC/K5IgzAayMdl++LRYYWI4A5W9oWF97tQGY/NWoBez
	 xrXyV0J9yFxtAOiboLsVadGMPDpKYyeNfXX8SaA78jEkL8T6nLEZzRVNekvTaZbBZt
	 lwLu36RmoqZ1PBP2DghBdjUhFgl8VGfgDiNtYmnE97Yvm8ObQYRyEzUC/Py4ON8noA
	 33aP1+qeRJdqipKCNChtWsRVBbFIo5AZ7YIfl5CNyXJiejzoDggYd6UueQSuQ7od7K
	 mEb4XOgvql5Nef27szm21i8btCuO5BNSPA6NEPLrZHrI/rhLMRAPpGdxJDvprBfL+6
	 xQ4VkWNvlLdAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:51 -0400
Subject: [PATCH v4 07/11] nfsd: add support for FATTR4_OPEN_ARGUMENTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-7-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
In-Reply-To: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4392; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kpELDEFTy1D47hjM4/MCx13/I9LcpRbQfLN1rgDDfE4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acVzA7dBQNEEQ6EPQRPXv9CyTkyr5TeH8ZPw
 AELqv2xxJWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FZvwEACMFBhG5OquAPTxRqrKbsdseRVbYBiXePjrMHSir6Zxsq91W4Ci6xePfLdRkjNGlMAUGx6
 f56FCb1MUivjA1AAcBmV3Nu84BJJ2aPlcrodz3tlaOUTqwIPWih7ZUFSWwqu2IRG1FIU8Pu+iK6
 dK3b7ZNtTOoF7Zg/UYrrw5ZpzSrucwjN5/mfc/rh9U5uk96lYyCfB17cT8figXblnVCGudem53G
 4+VsuIRLKdnBY+X+tFj5rz0KJQ3o5lYBVq4UvP8HrYzKKR5837ay2vh9b/3Mgpkp9+03cgSJmis
 TDBRCDXiu8HGgJgd6KrBRIZY+jxPlbfutBY2r04wYeX3NNB2rnDdvquQns/E6FQDbRzC2bH3Tsx
 Tgw1k2yIohpRAUfap7m/53SpK3sxACibB+jNRDqa+ZFY6mOxBkZ9k9KyZYrBTMsoK4ekklTeuLs
 1km5jAsKUQJJpThwqg6NQMN6InScyYgjrMK32+26l/upkVIJLqRcXs12Nj63sAguJeZxJ8Ga/4L
 yKTJuuyVtmx/UtNIfXcLCUOz1j7T1t7ZpB15cxZ3HXJ/3mgovZxsbhn8VzQLwIomozcPGq2x2m7
 ob0bMwUqKZ+VkMuOWpxW05Y7kmPaxDGYbQkAwPiArMvIm77DbLSXPdejbUAjJCZ4GRFcPxRg1WG
 Y7SVbjYT3cEdjPQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for FATTR4_OPEN_ARGUMENTS. This a new mechanism for the
client to discover what OPEN features the server supports.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Makefile  |  2 +-
 fs/nfsd/nfs4xdr.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  3 ++-
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..d6ab3ae7d0a0 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -18,7 +18,7 @@ nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
-			   nfs4acl.o nfs4callback.o nfs4recover.o
+			   nfs4acl.o nfs4callback.o nfs4recover.o nfs4xdr_gen.o
 nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ccaee73de72b..4cedcb252aa1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "nfs4xdr_gen.h"
 
 #include "trace.h"
 
@@ -3398,6 +3399,54 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
 	return nfsd4_encode_bool(xdr, err == 0);
 }
 
+#define NFSD_OA_SHARE_ACCESS	(BIT(OPEN_ARGS_SHARE_ACCESS_READ)	| \
+				 BIT(OPEN_ARGS_SHARE_ACCESS_WRITE)	| \
+				 BIT(OPEN_ARGS_SHARE_ACCESS_BOTH))
+
+#define NFSD_OA_SHARE_DENY	(BIT(OPEN_ARGS_SHARE_DENY_NONE)		| \
+				 BIT(OPEN_ARGS_SHARE_DENY_READ)		| \
+				 BIT(OPEN_ARGS_SHARE_DENY_WRITE)	| \
+				 BIT(OPEN_ARGS_SHARE_DENY_BOTH))
+
+#define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
+					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL))
+
+#define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_PREVIOUS)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV)| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_FH)		| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH)	| \
+				 BIT(OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH))
+
+#define NFSD_OA_CREATE_MODE	(BIT(OPEN_ARGS_CREATEMODE_UNCHECKED4)	| \
+				 BIT(OPEN_ARGS_CREATE_MODE_GUARDED)	| \
+				 BIT(OPEN_ARGS_CREATEMODE_EXCLUSIVE4)	| \
+				 BIT(OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1))
+
+static uint32_t oa_share_access = NFSD_OA_SHARE_ACCESS;
+static uint32_t oa_share_deny = NFSD_OA_SHARE_DENY;
+static uint32_t oa_share_access_want = NFSD_OA_SHARE_ACCESS_WANT;
+static uint32_t oa_open_claim = NFSD_OA_OPEN_CLAIM;
+static uint32_t oa_create_mode = NFSD_OA_CREATE_MODE;
+
+static const struct open_arguments4 nfsd_open_arguments = {
+	.oa_share_access = { .count = 1, .element = &oa_share_access },
+	.oa_share_deny = { .count = 1, .element = &oa_share_deny },
+	.oa_share_access_want = { .count = 1, .element = &oa_share_access_want },
+	.oa_open_claim = { .count = 1, .element = &oa_open_claim },
+	.oa_create_mode = { .count = 1, .element = &oa_create_mode },
+};
+
+static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
+						 const struct nfsd4_fattr_args *args)
+{
+	if (!xdrgen_encode_fattr4_open_arguments(xdr, &nfsd_open_arguments))
+		return nfserr_resource;
+	return nfs_ok;
+}
+
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_SUPPORTED_ATTRS]	= nfsd4_encode_fattr4_supported_attrs,
 	[FATTR4_TYPE]			= nfsd4_encode_fattr4_type,
@@ -3498,6 +3547,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
 /*
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4ccbf014a2c7..c98fb104ba7d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -454,7 +454,8 @@ enum {
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
-	FATTR4_WORD2_XATTR_SUPPORT)
+	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
 

-- 
2.46.0


