Return-Path: <linux-fsdevel+bounces-27840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E9996468E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A66E1C23BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414EA1B3747;
	Thu, 29 Aug 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4aYEzfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E721B372D;
	Thu, 29 Aug 2024 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938025; cv=none; b=rWuYGS4iiCA9rJM0ib5wh2jopdUCrp3Mbed5sHxn3o4acl15U/N2p6vnzTYBmLzRKMrj6/p3H20JGVStYJ7tL7fCKnZZvm/sOO0CnPWfNWxvi+J7TS3Y4CjEvRg1TR6OcvJjTWI0lyTRIw3+TyLmJ7bvf+QT8pEATWjUDI3gn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938025; c=relaxed/simple;
	bh=XP3eG6tLbFwyyAoMBoeZ16l1O/uJyxUNuU3OGpmKOUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pa0OD5Ri6ZF0guIJWO820KXLBIekBtOWT/oAWxKoyZUtnm5GftxdNH8OLLP6SGAVyL6ucgaXxwjZZg99Rn6Rm45LTPC3xJ2yMhRt1Q7aq9Ljdb4WOfSk2K+zEBERK1pFtn7GgaILT9WNVKQs2mMaEKBxZs1/k0qS8jIP+AkFW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4aYEzfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F37C4CEC1;
	Thu, 29 Aug 2024 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938025;
	bh=XP3eG6tLbFwyyAoMBoeZ16l1O/uJyxUNuU3OGpmKOUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D4aYEzfpsQEhyUqp8xRTiU/Ah8DewiE78gVUusimWWmJGmfx7gYDiPhTP8EAJXyGv
	 gWmJNfflKE++5e3eBFQ75lOu/uUKQmIYcNP3QKD1tAxBnWXYu97mrAC1p19GELjnyr
	 s53TFNwHdMtoRDpD59WLITzsylQ4FE2u7/NkLanZjj+wB7BtSJjbX1NQyXXZsa3Z6N
	 sjAsWhPpgbGQH4goZRcC67dqS9kQcYqQITCZUiFRiBVsyvQU+ZBDOua6ngWSTNzBOx
	 nL6qnwPpxqwFaDiB0vk1H1jBrE5rbs/BwZpxp5XP/6huEi+q8ZhnmHzHRbBx1E0UfP
	 Dd1vEUDO8iqpg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Aug 2024 09:26:47 -0400
Subject: [PATCH v3 09/13] nfsd: add support for FATTR4_OPEN_ARGUMENTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-delstid-v3-9-271c60806c5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XP3eG6tLbFwyyAoMBoeZ16l1O/uJyxUNuU3OGpmKOUo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm0HcX+dGMtmCsZPu8ruvvIKoC3em3P4CAzooaP
 JWAdZKja0+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtB3FwAKCRAADmhBGVaC
 FRMSEACkUBa3QcnY+rgXlU3ROyUqw95mUT64Jihfk/ocnXO59a4IJ8/yVKF/UqlQmYVKDCv8CpZ
 X6zu2bVMSAHJF1LZNaNqQ3rpUG6ETG3yY/brWPidruDTFfgM/NaoM/GqzK2pcLpeKAnM7o53YUc
 DVPA6S8JNr2PwyipjrjD4fZ6/H7O4c+NQIr2qGMeKcuPuHvhkGeqmUGbtwHlzkyjBSnAjIAcLcw
 EJqtHSyY73/q+XTZU/TeZIN+NlogdF79qrazAXUFAYHH0I2t6F/mH9lnrrN8gRphfHrRKarYbt9
 F2XpRs2/yhw7tooaDrsrS6G3ggUFIptFxWdMpsPeMEjcflL+PuAKCmiDh3KGvj7VViPst9kBi+S
 OUIFqBEVSS4iag0wfJCMD6PNgQRTB4SliKmx3khL79tamdxkI28FhTkp73/7wMzJshmYTrSZGrx
 +4F0/TzbQDNF6DpLkJmTyqducOKvlbE31f/dQ2L0IU22IihZ9meLXewuqtUF6ulylq5Axrwfmyf
 brQDtDUFOuQPFE6y6ZO9jttCKeu1g4hQLtdRvGi5HayooKsnRPG2+19IdZhR90DwOS/HZLKE5qY
 v10MAfeiSOHULB8Pyae2iziEfiHlPry0p/e2eJsbIKtomnpRk4VpB58TPsyKue5/CL4iflcH1Ow
 MIiY2EtST1tl3sg==
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
index a9827bb8a2f0..c25dbfa0e7ea 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3396,6 +3396,54 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
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
@@ -3496,6 +3544,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 
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


