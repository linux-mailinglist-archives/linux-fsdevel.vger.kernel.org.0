Return-Path: <linux-fsdevel+bounces-27166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA195F1F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB54C284D1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D919882B;
	Mon, 26 Aug 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq1hs73g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33D197A72;
	Mon, 26 Aug 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676403; cv=none; b=naKsc/menb//Icdm92mJIG2hbDyqWLrCwKsIhbN+F9+EvHhYw9+R9FvTOcefcQGDOzvMwM9OeRSAOCbBkuUaGNT92BxKLk/c+4X1m+RJZyWppCGBvmqkjnJkmePZY5aIn3obLAyxg8EYJsDGTqTItXJbm+6yl55lRXOB63LK99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676403; c=relaxed/simple;
	bh=rKoPX2aFnfuNciBlyHag/9kJn1ArYzxDDv3KOmqc830=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlQ9lWUNaQPewwOz0KDNDBux7mhmiKfDhaWS/Bh5BIjqfsits5KcZeFTaUDonfC3sz3vvyQI1NimGoUdYNi+jVKy1wC6nKe+cYS2krL6yPm5oaIGMqdeZIm3+nGNS8vCyNQRLYgUPfY+mMIzLyySHjI0FWdOcTUHRETY8wwSxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq1hs73g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3B4C581B8;
	Mon, 26 Aug 2024 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676402;
	bh=rKoPX2aFnfuNciBlyHag/9kJn1ArYzxDDv3KOmqc830=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gq1hs73gUyANERB1YldOUPxfSZyI3lQmbrARU2nUWflL6DPt2zUQDTnrzBpuT6gpG
	 52cvg6kRxM98h02fN7VrHgCjVA251PdIxnYLk/YGXIdk+qLlM3pwVomlwEbIPtFB1v
	 dWe4obuTVkpwFGrbB/42mntKxnSKkGJlIo4oO226EaVNZpoyvEkw83Iv13YXKJoRvJ
	 AzN0ybtDmd0pWsxTc49G1w03JLKydKWyEiA1idhxTKiIwq5l8zIY8yLuTcfni7sbSb
	 mZ2KVMn9vlzgc8p3lqByq9LPPVLi+XNS0xUiRmjhu/DTyGvm9Vb/LWQbxhs9VgcDST
	 dNZvkXEGl/3XQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:13 -0400
Subject: [PATCH v2 3/7] nfsd: add support for FATTR4_OPEN_ARGUMENTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-3-e8ab5c0e39cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rKoPX2aFnfuNciBlyHag/9kJn1ArYzxDDv3KOmqc830=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHkqas/6T5SLXv4qCPcBKtChYhIQGZKZQqQkp
 IaMKDB3Zp+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5KgAKCRAADmhBGVaC
 FQDgD/9Tanc3VGL/ESU3EB+wzeQUC5DMe1qL9Uzdoyv3HEudQ74qBe6LBenVlNe2v+oxIqqMxAw
 Ux9Gmuj+/MeliCuTh738N99hkLP4CasEAxToRqUoxF5wINAIGmix1lDAk4NDYEWxhuJCw/yT0co
 BZxuvziT8KRsPJvTS6vP2hRr0vhIJ1RDZtVhgURxxxT1JzLYDWez+R3xZHiENzdWlLhue4nh/jj
 BMHxHA/GuZ7IbU/bIAoAzyAmN8qK+wJsk5cvIoBCr37YpO4eMtEzUBnTmvvuvk8fwkYY/MywCMl
 unSRxRo0Iw86KK6u2c2bTIfeORwpZ9U2HcVuHbYMSeSM7IwWiT4iinC4IJDCXCkSl/NDAgfyssX
 fROBRhjD2MMd4RiSdUHqGNoMy2RC6ZkH923XgN19JXjYZOfzntYop+b3nL2kkDm2dTZaVWWSUm2
 fbrkk4ymrpp1Ri8ZqSQB96kRhKgNxgs8QxvKvmmwq+QBNSKSQFkZjEDAhTveeNYv82EplIqDUTs
 N37xPTMcjm24GmNc39srQb0ynFWeU6tF1A6f32ixta/515uIttkrRrgtYHDuh9u1PzppxZ9T4Fx
 rB3PumM6LztBT4bruh8yPUC1LZvWzKH3tt7N+05kDrIc/llhHOsIt5djyokTf0hdNE2zVy8TP/F
 UJuZ50zBE4zWEGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for FATTR4_OPEN_ARGUMENTS. This a new mechanism for the
client to discover what OPEN features the server supports.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/Makefile  |  2 +-
 fs/nfsd/nfs4xdr.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  3 ++-
 3 files changed, 52 insertions(+), 2 deletions(-)

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
index f118921250c3..1c8219ea8af7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3399,6 +3399,54 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
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
@@ -3499,6 +3547,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
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


