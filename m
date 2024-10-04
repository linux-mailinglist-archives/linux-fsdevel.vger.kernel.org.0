Return-Path: <linux-fsdevel+bounces-30988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780489903D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A011C21F4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30E21732E;
	Fri,  4 Oct 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDxvQo21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F97216A31;
	Fri,  4 Oct 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047898; cv=none; b=cGIjkcfS6yS9V6lPwiKb1JbPdDsAlW/AQUY+QcjSXW982mj890JXBIJKBwpycH8S0e7HXcnVtSq3vBRO3OjSIrthX+nImSm9o9CWTJ5MpVyjG+DFlYJLqAz7HgAVVxsLpnEQ3mi9a5sn3DU0RPhdY57wrFSef6HUaVPnK+JMCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047898; c=relaxed/simple;
	bh=whTl98z0wl8xepmuzh8oTLlhqj3nth1umWXiJ96EUWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fh1zlWGpcDwM4LMg9Ll4EuHeSVIraGKNTPc0k5drekW1WHNty4MEe5s/H0tCaxUhrSi79MdeSK21IPbEUbEoXJZhHOlFR0u9sR/purKl3plLPdFheg69R6ei/TvsMqORb6Gnbo6lyQCpk/fPqSO8alEZ06VXgYgnG3THBxLSjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDxvQo21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0EEC4CED4;
	Fri,  4 Oct 2024 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728047898;
	bh=whTl98z0wl8xepmuzh8oTLlhqj3nth1umWXiJ96EUWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uDxvQo21MltWw7fUJTSL5MnjDfMDcTHMd80lnH9jOLPQWJ9A5ERsQsxbJQlshpzZB
	 KavbZAshTsLyUPpuSLCsDFy00UEr3jFRW+XgSeu/sUasHyQCKNl+Eix1nvItMvKocl
	 yscIY934Hi477KA98ngS2BwSlqqHJWAH1PR9KhnsXd7meLu70rlvG5+GBc1AdZ/dHr
	 0S9Cx2VQRK6q15vcdqshK5xXL/CUo13cpsYd+MhJkg2gBDHaps0NOp0fU7Y/c7AIKp
	 Hjq3P6gfhOGcUUIQzJiNmvOnPWSgb53Q6T7yd+M+DSmLHbscFv94nit3A82AORId/e
	 bRMCMRbKkmaDQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 04 Oct 2024 09:16:49 -0400
Subject: [PATCH v4 6/9] nfsd: add support for FATTR4_OPEN_ARGUMENTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-delstid-v4-6-62ac29c49c2e@kernel.org>
References: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
In-Reply-To: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=whTl98z0wl8xepmuzh8oTLlhqj3nth1umWXiJ96EUWc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/+sNu1eXZvqukcr2tGYHPovBSZByEKfyLx+lG
 dPbW8IovriJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv/rDQAKCRAADmhBGVaC
 FSWKEACR8pMTk6mpsHGWVdABnoBTp2gsKl1FY6XKB5WkOEnOU9QBXoF/+muJ+RhHPat4j9p3ISM
 Hywq19MCeJmTBcpxqzzIGCfYQSxPrM6Ho7IXoh6UQbPPV4B7nR008Sq0/f0jrTt4pDp9Oe4IwCP
 Rc8cxBhhtZw8mjL7rGdbrzNt+p7EUg7ESyaK4EtqnKTdetAo7XMSI+ITeH4QT3iqjPXJqb7zasb
 heh4wc6P66wryOm8l6hXdLVTFyyLkx1xWIffDbYCdzTuA8EooH0YvFunD62egBxRFDikWNWSGIQ
 XzRGzp16Djg/20qvfA9CdWT6rr/7SY9wvKJJNIZ2VJyzTohOfPP0LygJLP4kyu0K0cSOQVVwUWN
 g8ORrmjSQpNM/qfHwd0dFgEBpFNcn2izIUCYFK7CyNOVo/Yz+KqyFHeDpjjPrsP1HdYTDAjG2cF
 6xm4kAyGVHlpFqEBVH/lN9IKnCUWhAtXah/myfutkmHlkt4icozNun76QdBuq+FqsI/xKvUFiD9
 eopyC7zI3DbZxGSk8nNdrbmx0KosMhXjVVgeVJTF7br8Vt2vLjvkTR8I9It6bRpAh4LmQRK3UMS
 x4B3MexnFNLOHKg1cCv5x42+0lROErnS8fUn93i3cVpiG1iAKbCMkNaZ2BvyRQKwdumjwF67ZyR
 ZzKYMoMONcQ53Rg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for FATTR4_OPEN_ARGUMENTS. This a new mechanism for the
client to discover what OPEN features the server supports.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  3 ++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c5a716aa9f79060828eedcc41366e32970dea042..9fb7764924240a8c584517bcdf682fea1b417180 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "nfs4xdr_gen.h"
 
 #include "trace.h"
 
@@ -3396,6 +3397,54 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
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
@@ -3496,6 +3545,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
 	[FATTR4_MODE_UMASK]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_XATTR_SUPPORT]		= nfsd4_encode_fattr4_xattr_support,
+	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
 };
 
 /*
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4b56ba1e8e48d08c4e3e52f378822c311193c3d4..1955c8e9c4c793728fa75dd136cadc735245483f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -458,7 +458,8 @@ enum {
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_MODE_UMASK | \
 	NFSD4_2_SECURITY_ATTRS | \
-	FATTR4_WORD2_XATTR_SUPPORT)
+	FATTR4_WORD2_XATTR_SUPPORT | \
+	FATTR4_WORD2_OPEN_ARGUMENTS)
 
 extern const u32 nfsd_suppattrs[3][3];
 

-- 
2.46.2


