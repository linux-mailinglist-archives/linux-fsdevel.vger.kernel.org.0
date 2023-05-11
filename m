Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1516FFC0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 23:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjEKVnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 17:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbjEKVnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 17:43:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457E1BF;
        Thu, 11 May 2023 14:43:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BKnC5t028641;
        Thu, 11 May 2023 21:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=Cov16k64OzXqlzTyds2Bk3zCFsqJ7IamkbY3wZnVRpE=;
 b=J80GldgWARyuqzlQgUayGc+PsRVJLue+W0c658hqfy0w60HjkwMSGI7mkbOXJLVV6+Ls
 EtG7P0OuQMTKpO1CTodNoYyZMyLQ2YSmJao+6TQo9E39rTLZ6uyzPtvsn/6CfUOeRWSs
 ncKBtkc5uXZNo7aHC9nL2tbQRSwvMtQVGo2ySIO6sSasTPPV2tMHHISp+9FtNlAAkBYW
 JQTW75CaGa+JtD+nf0f+dU5IT57aQeRRaObnv8UQAaETI30+2ksBpoRiBZW7WPFuzUie
 asUVTk3qg6Sz5C9a/DYME7JquPib2n2YvyOGPaMu40HTtOheBUL/yTT7YyBsOljmcMxQ 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7778ad1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BK1Sjg018283;
        Thu, 11 May 2023 21:43:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77kcm8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BLhX1c028893;
        Thu, 11 May 2023 21:43:36 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf77kcm6r-4;
        Thu, 11 May 2023 21:43:36 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
Date:   Thu, 11 May 2023 14:43:02 -0700
Message-Id: <1683841383-21372-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
References: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110184
X-Proofpoint-GUID: NY6kW3ljEoPFiheS3yVgPrsTAhIe23YO
X-Proofpoint-ORIG-GUID: NY6kW3ljEoPFiheS3yVgPrsTAhIe23YO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Includes:
   . CB_GETATTR proc for nfs4_cb_procedures[]

   . XDR encoding and decoding function for CB_GETATTR request/reply

   . add nfs4_cb_fattr to nfs4_delegation for sending CB_GETATTR
     and store file attributes from client's reply.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |  17 +++++++
 fs/nfsd/xdr4cb.h       |  19 ++++++++
 3 files changed, 153 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4039ffcf90ba..ca3d72ef5fbc 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -87,6 +87,43 @@ static void encode_bitmap4(struct xdr_stream *xdr, const __u32 *bitmap,
 	WARN_ON_ONCE(xdr_stream_encode_uint32_array(xdr, bitmap, len) < 0);
 }
 
+static void decode_bitmap4(struct xdr_stream *xdr, __u32 *bitmap,
+			   size_t len)
+{
+	WARN_ON_ONCE(xdr_stream_decode_uint32_array(xdr, bitmap, len) < 0);
+}
+
+static int decode_attr_length(struct xdr_stream *xdr, uint32_t *attrlen)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+	*attrlen = be32_to_cpup(p);
+	return 0;
+}
+
+static int decode_cb_getattr(struct xdr_stream *xdr, uint32_t *bitmap,
+				struct nfs4_cb_fattr *fattr)
+{
+	__be32 *ptr;
+
+	if (likely(bitmap[0] & FATTR4_WORD0_CHANGE)) {
+		ptr = xdr_inline_decode(xdr, 8);
+		if (unlikely(!ptr))
+			return -EIO;
+		xdr_decode_hyper(ptr, &fattr->ncf_cb_cinfo);
+	}
+	if (likely(bitmap[0] & FATTR4_WORD0_SIZE)) {
+		ptr = xdr_inline_decode(xdr, 8);
+		if (unlikely(!ptr))
+			return -EIO;
+		xdr_decode_hyper(ptr, &fattr->ncf_cb_fsize);
+	}
+	return 0;
+}
+
 /*
  *	nfs_cb_opnum4
  *
@@ -358,6 +395,26 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
 }
 
 /*
+ * CB_GETATTR4args
+ *	struct CB_GETATTR4args {
+ *	   nfs_fh4 fh;
+ *	   bitmap4 attr_request;
+ *	};
+ *
+ * The size and change attributes are the only one
+ * guaranteed to be serviced by the client.
+ */
+static void
+encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
+			struct knfsd_fh *fh, struct nfs4_cb_fattr *fattr)
+{
+	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
+	encode_nfs_fh4(xdr, fh);
+	encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap));
+	hdr->nops++;
+}
+
+/*
  * CB_SEQUENCE4args
  *
  *	struct CB_SEQUENCE4args {
@@ -493,6 +550,29 @@ static void nfs4_xdr_enc_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
 }
 
 /*
+ * 20.1.  Operation 3: CB_GETATTR - Get Attributes
+ */
+static void nfs4_xdr_enc_cb_getattr(struct rpc_rqst *req,
+		struct xdr_stream *xdr, const void *data)
+{
+	const struct nfsd4_callback *cb = data;
+	struct nfs4_cb_fattr *ncf =
+		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+	struct nfs4_delegation *dp =
+		container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = cb->cb_clp->cl_cb_ident,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+	encode_cb_getattr4args(xdr, &hdr,
+		&dp->dl_stid.sc_file->fi_fhandle, &dp->dl_cb_fattr);
+	encode_cb_nops(&hdr);
+}
+
+/*
  * 20.2. Operation 4: CB_RECALL - Recall a Delegation
  */
 static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
@@ -548,6 +628,42 @@ static int nfs4_xdr_dec_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
 }
 
 /*
+ * 20.1.  Operation 3: CB_GETATTR - Get Attributes
+ */
+static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+	u32 bitmap[3] = {0};
+	u32 attrlen;
+	struct nfs4_cb_fattr *ncf =
+		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+
+	status = decode_cb_compound4res(xdr, &hdr);
+	if (unlikely(status))
+		return status;
+
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
+	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
+	if (status)
+		return status;
+	decode_bitmap4(xdr, bitmap, 3);
+	status = decode_attr_length(xdr, &attrlen);
+	if (status)
+		return status;
+	ncf->ncf_cb_cinfo = 0;
+	ncf->ncf_cb_fsize = 0;
+	status = decode_cb_getattr(xdr, bitmap, ncf);
+	return status;
+}
+
+/*
  * 20.2. Operation 4: CB_RECALL - Recall a Delegation
  */
 static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
@@ -855,6 +971,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
+	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
 };
 
 static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d49d3060ed4f..92349375053a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -117,6 +117,19 @@ struct nfs4_cpntf_state {
 	time64_t		cpntf_time;	/* last time stateid used */
 };
 
+struct nfs4_cb_fattr {
+	struct nfsd4_callback ncf_getattr;
+	u32 ncf_cb_status;
+	u32 ncf_cb_bmap[1];
+
+	/* from CB_GETATTR reply */
+	u64 ncf_cb_cinfo;
+	u64 ncf_cb_fsize;
+};
+
+/* bits for ncf_cb_flags */
+#define	CB_GETATTR_BUSY		0
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -150,6 +163,9 @@ struct nfs4_delegation {
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
 	bool			dl_recalled;
+
+	/* for CB_GETATTR */
+	struct nfs4_cb_fattr    dl_cb_fattr;
 };
 
 #define cb_to_delegation(cb) \
@@ -642,6 +658,7 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_SEQUENCE,
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
 	NFSPROC4_CLNT_CB_RECALL_ANY,
+	NFSPROC4_CLNT_CB_GETATTR,
 };
 
 /* Returns true iff a is later than b: */
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index 0d39af1b00a0..3a31bb0a3ded 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -54,3 +54,22 @@
 #define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
 					cb_sequence_dec_sz +            \
 					op_dec_sz)
+
+/*
+ * 1: CB_GETATTR opcode (32-bit)
+ * N: file_handle
+ * 1: number of entry in attribute array (32-bit)
+ * 1: entry 0 in attribute array (32-bit)
+ */
+#define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
+					cb_sequence_enc_sz +            \
+					1 + enc_nfs4_fh_sz + 1 + 1)
+/*
+ * 1: attr mask (32-bit bmap)
+ * 2: length of attribute array (64-bit)
+ * 2: change attr (64-bit)
+ * 2: size (64-bit)
+ */
+#define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
+					cb_sequence_dec_sz + 7 +	\
+					op_dec_sz)
-- 
2.9.5

