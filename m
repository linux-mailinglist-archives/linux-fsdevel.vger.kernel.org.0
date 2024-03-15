Return-Path: <linux-fsdevel+bounces-14509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF8E87D22E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2600CB24A47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31F4DA0C;
	Fri, 15 Mar 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBTcnOtq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207B5F551;
	Fri, 15 Mar 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521654; cv=none; b=kj2aGbZV1Uvknu3jFMLlfGjfCr2KH0/SWhrC7TmBfQWzc2x/ut37R299h2KdKKMsnSZhFy9wVAU81OvHFE4ot3FouV5iLrAiMkHcPCTNeyp6jG8Pp3e8zF9klSS09H4CIHkELNiGyhmNxtIVH1zhRFaYsib4FWiT996yt4bASao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521654; c=relaxed/simple;
	bh=r/E0+ttZBJ+9OQpGAaGdbsceE93QLD/K8Cil0//zQ0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBGPFCDvK8TJLFpmVtXH71Xcre6FrPMGYyEajBG++y5uUteqGqiYPYJr+fP6WocnDdmzGWEaSFBFW25/4h7hmDO5LhHZ9W5Ee3X2G4JKaZgDIfGOg97TaXftk7O4ezqo/ka6Sb7pd0OG0meeNbJHZ/vfSLnwsdEqGKYGQ2WIG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBTcnOtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B15C43143;
	Fri, 15 Mar 2024 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521654;
	bh=r/E0+ttZBJ+9OQpGAaGdbsceE93QLD/K8Cil0//zQ0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PBTcnOtqQm2xViXydU0vepOlwiFedPt0uzMfQQLybF1pooU8JSPuuCegpM6TWwmEm
	 Pi2Ole2yA9ebT9I8DQ2OlsU+c49znZ9R0KtQFJ2SdHbUvkmmG8XHIRISIhCB8bhQk1
	 1FQt5NA+aXFSpwf5csS2xwlJs+4r3HzYzgrOv5NAO5Y7NjRHDjcGqNp1ZQ21arASZC
	 ZnSdP5Qn/D1wqStrbMUoKU1/YCqFtMRfPEMx8uB4XUSrDj1rHpTGNE70BYlSv7jhfE
	 E3MVjEgV7s2aXr4bjfwuSR69rIxwbQBPzppLSO5yc2u0ZhbFvm2Wq2MpzdjaZv/Tmg
	 /liS757mOJ/rA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:12 -0400
Subject: [PATCH RFC 21/24] nfs: add a GDD_GETATTR rpc operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-21-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7304; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r/E0+ttZBJ+9OQpGAaGdbsceE93QLD/K8Cil0//zQ0Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzvbrxGDH4zPVZvjnQ6UxSQDBPK33TlO88hC
 0zSIPsb0LeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87wAKCRAADmhBGVaC
 FSdJD/9tS/UejUix07NO9BdxnZuzLrlwwKs/m6NSoZmz4cbO7yQFRg0uPP5nBQm3J7Htzwdn+qn
 vpiWw2be2z8qQ6G3xz86gw3ISuxMKjGD8pPTrSzcC8cbWo6ZxNFWEK8Z47CxbTVZdwf6mVh+CLl
 yI57OGn7NFhVVTTwaXfRlRAFc2UsW2GkqSP0w//AfPTaKF/bDxWCfJAZqHXvebQ6O0wOA/5GB8R
 QQYUvXmXALLk+QlVW+5RhwJkQ32CchFzyPkf2atp7LeapKFS7+HOOAQJTY1QsR7xwI+phRAGvaH
 uavHdaoj0ljpxAUdUXLd3pPsPPd4rOWNuhsUZxm5xhsAyCCMwwDmtKAeWQKwx+pbaIPbdxQT0kw
 rPGk2i3hxbf9DLp4LTtC10XBZm93oDGIFxRzt4Uohl+4P0nPPJ5hT6DaU5sXTdXyrExEyIvNHB3
 B36PSaiqoZbwvx86ujqnNQiY8oZcA0UgF9Lfs3sn/FDuuYkqkSNRksqIk2IUiwvIgKOzeDGXZWb
 O29C+uEmc4TNpAqkWcMfee/p1G+E9NExobEwNEewBvlZE96osbGbp8AtAVgVO6oO1lIOrC8Vvz7
 lxvkCLtG7TbWMs1RO8iqLNO5mE9V/EwfaB43TTPOcyI5jeJIasffpSxtGhnIByLdz6tW0VTy658
 Buj/Zz0JicD+VGQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new compound that does a GET_DIR_DELEGATION just before doing a
GETATTR on an inode. Add a delegation stateid and a nf_status code to
struct nfs4_getattr_res to store the result.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4xdr.c        | 136 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs4.h    |   1 +
 include/linux/nfs_xdr.h |   2 +
 3 files changed, 139 insertions(+)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1416099dfcd1..c28025018bda 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -391,6 +391,22 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5)
 #define encode_reclaim_complete_maxsz	(op_encode_hdr_maxsz + 4)
 #define decode_reclaim_complete_maxsz	(op_decode_hdr_maxsz + 4)
+#define encode_get_dir_delegation_maxsz (op_encode_hdr_maxsz +				\
+					 4 /* gdda_signal_deleg_avail */ +		\
+					 8 /* gdda_notification_types */ +		\
+					 nfstime4_maxsz  /* gdda_child_attr_delay */ +	\
+					 nfstime4_maxsz  /* gdda_dir_attr_delay */ +	\
+					 nfs4_fattr_bitmap_maxsz /* gdda_child_attributes */ + \
+					 nfs4_fattr_bitmap_maxsz /* gdda_dir_attributes */)
+
+#define decode_get_dir_delegation_maxsz (op_encode_hdr_maxsz +				\
+					 4 /* gddrnf_status */ +			\
+					 encode_verifier_maxsz /* gddr_cookieverf */ +	\
+					 encode_stateid_maxsz /* gddr_stateid */ +	\
+					 8 /* gddr_notification */ +			\
+					 nfs4_fattr_bitmap_maxsz /* gddr_child_attributes */ + \
+					 nfs4_fattr_bitmap_maxsz /* gddr_dir_attributes */)
+
 #define encode_getdeviceinfo_maxsz (op_encode_hdr_maxsz + \
 				XDR_QUADLEN(NFS4_DEVICEID4_SIZE) + \
 				1 /* layout type */ + \
@@ -636,6 +652,18 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				decode_putfh_maxsz + \
 				decode_getattr_maxsz + \
 				decode_renew_maxsz)
+#define NFS4_enc_gdd_getattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_get_dir_delegation_maxsz + \
+				encode_getattr_maxsz + \
+				encode_renew_maxsz)
+#define NFS4_dec_gdd_getattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_get_dir_delegation_maxsz + \
+				decode_getattr_maxsz + \
+				decode_renew_maxsz)
 #define NFS4_enc_lookup_sz	(compound_encode_hdr_maxsz + \
 				encode_sequence_maxsz + \
 				encode_putfh_maxsz + \
@@ -1981,6 +2009,30 @@ static void encode_sequence(struct xdr_stream *xdr,
 }
 
 #ifdef CONFIG_NFS_V4_1
+static void
+encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr *hdr)
+{
+	__be32 *p;
+	struct timespec64 ts = {};
+	u32 zerobm[1] = {};
+
+	encode_op_hdr(xdr, OP_GET_DIR_DELEGATION, decode_get_dir_delegation_maxsz, hdr);
+
+	/* We can't handle CB_RECALLABLE_OBJ_AVAIL yet */
+	xdr_stream_encode_bool(xdr, false);
+
+	/* for now, we request no notification types */
+	xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
+
+	/* Request no attribute updates */
+	p = reserve_space(xdr, 12 + 12);
+	p = xdr_encode_nfstime4(p, &ts);
+	xdr_encode_nfstime4(p, &ts);
+
+	xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
+	xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
+}
+
 static void
 encode_getdeviceinfo(struct xdr_stream *xdr,
 		     const struct nfs4_getdeviceinfo_args *args,
@@ -2334,6 +2386,25 @@ static void nfs4_xdr_enc_getattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode GDD_GETATTR request
+ */
+static void nfs4_xdr_enc_gdd_getattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+				     const void *data)
+{
+	const struct nfs4_getattr_arg *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_get_dir_delegation(xdr, &hdr);
+	encode_getfattr(xdr, args->bitmask, &hdr);
+	encode_nops(&hdr);
+}
+
 /*
  * Encode a CLOSE request
  */
@@ -5919,6 +5990,43 @@ static int decode_layout_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 	return decode_stateid(xdr, stateid);
 }
 
+static int decode_get_dir_delegation(struct xdr_stream *xdr,
+				     struct nfs4_getattr_res *res)
+{
+	nfs4_verifier	cookieverf;
+	int		status;
+	u32		bm[1];
+
+	status = decode_op_hdr(xdr, OP_GET_DIR_DELEGATION);
+	if (status)
+		return status;
+
+	if (xdr_stream_decode_u32(xdr, &res->nf_status))
+		return -EIO;
+
+	if (res->nf_status == GDD4_UNAVAIL)
+		return xdr_inline_decode(xdr, 4) ? 0 : -EIO;
+
+	status = decode_verifier(xdr, &cookieverf);
+	if (status)
+		return status;
+
+	status = decode_delegation_stateid(xdr, &res->deleg);
+	if (status)
+		return status;
+
+	status = decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
+	if (status < 0)
+		return status;
+	status = decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
+	if (status < 0)
+		return status;
+	status = decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
+	if (status < 0)
+		return status;
+	return 0;
+}
+
 static int decode_getdeviceinfo(struct xdr_stream *xdr,
 				struct nfs4_getdeviceinfo_res *res)
 {
@@ -6455,6 +6563,33 @@ static int nfs4_xdr_dec_getattr(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	return status;
 }
 
+/*
+ * Decode GDD_GETATTR response
+ */
+static int nfs4_xdr_dec_gdd_getattr(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
+				    void *data)
+{
+	struct nfs4_getattr_res *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_get_dir_delegation(xdr, res);
+	if (status)
+		goto out;
+	status = decode_getfattr(xdr, res->fattr, res->server);
+out:
+	return status;
+}
+
 /*
  * Encode an SETACL request
  */
@@ -7704,6 +7839,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC41(BIND_CONN_TO_SESSION,
 			enc_bind_conn_to_session, dec_bind_conn_to_session),
 	PROC41(DESTROY_CLIENTID,enc_destroy_clientid,	dec_destroy_clientid),
+	PROC41(GDD_GETATTR,	enc_gdd_getattr,	dec_gdd_getattr),
 	PROC42(SEEK,		enc_seek,		dec_seek),
 	PROC42(ALLOCATE,	enc_allocate,		dec_allocate),
 	PROC42(DEALLOCATE,	enc_deallocate,		dec_deallocate),
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 11ad088b411d..86cbfd50ecd1 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -681,6 +681,7 @@ enum {
 	NFSPROC4_CLNT_LISTXATTRS,
 	NFSPROC4_CLNT_REMOVEXATTR,
 	NFSPROC4_CLNT_READ_PLUS,
+	NFSPROC4_CLNT_GDD_GETATTR,
 };
 
 /* nfs41 types */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d09b9773b20c..85ee37ccc25e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1072,6 +1072,8 @@ struct nfs4_getattr_res {
 	struct nfs4_sequence_res	seq_res;
 	const struct nfs_server *	server;
 	struct nfs_fattr *		fattr;
+	nfs4_stateid			deleg;
+	u32				nf_status;
 };
 
 struct nfs4_link_arg {

-- 
2.44.0


