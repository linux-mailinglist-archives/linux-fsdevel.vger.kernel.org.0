Return-Path: <linux-fsdevel+bounces-50349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FBACB106
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693C018963C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ABE237176;
	Mon,  2 Jun 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BryyJgNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C712367B5;
	Mon,  2 Jun 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872983; cv=none; b=GFWl6g7CbdjfnGYuB0h0CIFpmliWzCziVnkXptvGYX+SE6c8Y/o9MzPUke7iNFXlTdyIYIUOPK3oDpxw/LAMJM4gTDtGf6AgoVIL3Uw/Vjp4zECTyG9m2dsherFDSSYOm3YSid/Xfuyo0LFcNLCRfKB8DbWnIsfoXG/BOxRKkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872983; c=relaxed/simple;
	bh=IAW2Swc9Ux+I09E48UJb8JVeRwV4qhwM+6f680yjtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HU1mdlwQaHSd3rDjSPM5YVZV2c1TUbby+CG0ef0ZJWVIDgcEw9JNox2TCwCK8Nm0f02H7KAKlze6zvTUsKBE3x9TScW8iqkxyudx+y9LfoqJDmr+qswdBfhA2g83BUZVvcTN43Gj4RGiRhkTjeWav5F9b7VekrqT3dsAy95ylxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BryyJgNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A468C4CEF2;
	Mon,  2 Jun 2025 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872982;
	bh=IAW2Swc9Ux+I09E48UJb8JVeRwV4qhwM+6f680yjtME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BryyJgNZ1UZbsSntnRWoUVEnXvdMmr8uY7iftCpCO/kSTVlr0CwCZe3EHCfILhtjC
	 8VPkNmul+UxQ3E9vckSFkmMUxkKBJ00puZr/Fe5ABj9whwVysJN9cUQysDWQ7qHGIM
	 NA4/ci/4UZ+rb2l9sXDTwwlkQz8fsyonOzUj+oW074/bpf5eSOycy/lXsOXCCpMSkH
	 ktRNrmqz93cLE1GyYuvKfKxFbTeA8ZrXlFJ4VXzCgVldZL69gRX7YCeoY7P7P06X9z
	 OsLpKWLrQc+B//GANsA+sx+NYbnIBPTkj+4dO4cj+hQrRQs4vKdZkHZ3HmZw2AURQ1
	 OCi/FbaHSBQkA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:02 -0400
Subject: [PATCH RFC v2 19/28] nfsd: add callback encoding and decoding
 linkages for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-19-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IAW2Swc9Ux+I09E48UJb8JVeRwV4qhwM+6f680yjtME=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7o/C4u2CzxSt45gwy2PBAYNdBgyeACaOv0y
 IHMrgVKNbGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6AAKCRAADmhBGVaC
 FQxTEACkJl9eXB8VhcZVobO4W5PtDfxBWSV3CmwRjCiCIQQO4640dXqNIkwMCZdfuUsRP602Gtu
 Tl8tF/N50AcDrGQTUORowh02HnTal+NEmD2ZJwtaSdBlNdF6C8ZMSprQM6mXSlfJHgvIpJ8sB7B
 ar1yKdvZH1ktD5mxH7u1oMHZr0gRYPl7Mj7US0zqerNa8xZHPZ80wOKeQGquDAT7oKMRMIBMNxA
 kQL3cM/QF3/Hse2g2VuJLb7CzvRPnLa8gIPma1q2Ysm7uXn06dSalm/hbwm94X/wI7EXJxq7Nqi
 GdEEC6gzkHAlAhEbQlia0USmOUSQVXsvblja8ueejmlWPLuM7BiW9wXBubRKzwj8fQGv6tP7GOR
 g02rGndFtFvyfds+PFw8/oPrnOc+IG0h8Xe9nNFVSTpaQk2X9yDANVL7JDM/tcctDKcD7HA4l0l
 jP0gxDZaXjmklxtsGqi7otJPKmP18PyMyF6tSuu3OqXI4mxrNN4MibKvJoagECmOlB5L+jCZaRP
 xLbvlLCqM8THZts+B7NA12XuD9NBncmutbNhozwPIfWtLUQaZtSsWlZYr0Tfl0wNzjYX3LqJex7
 8y5rvALskO5xUdsgC44qAawTCK6j4+zlZI8BgmoBf7ITdIkB7l13oXVHH6/JItNyOApMiWAxmsu
 eWXI20xi5FJ2JLg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add routines for encoding and decoding CB_NOTIFY messages. These call
into the code generated by xdrgen to do the actual encoding and
decoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |  1 +
 fs/nfsd/xdr4cb.h       | 11 +++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e00b2aea8da2b93f366d88888f404734953f1942..2dca686d67fc0f0fcf7997a252b4f5988b9de6c7 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -865,6 +865,51 @@ static void encode_stateowner(struct xdr_stream *xdr, struct nfs4_stateowner *so
 	xdr_encode_opaque(p, so->so_owner.data, so->so_owner.len);
 }
 
+static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   const void *data)
+{
+	const struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = 0,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+	struct CB_NOTIFY4args args = { };
+
+	WARN_ON_ONCE(hdr.minorversion == 0);
+
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+
+	/*
+	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
+	 * buffer, and zero it.
+	 */
+	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
+
+	hdr.nops++;
+	encode_cb_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_cb_notify(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+
+	status = decode_cb_compound4res(xdr, &hdr);
+	if (unlikely(status))
+		return status;
+
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
+	return decode_cb_op_status(xdr, OP_CB_NOTIFY, &cb->cb_status);
+}
+
 static void nfs4_xdr_enc_cb_notify_lock(struct rpc_rqst *req,
 					struct xdr_stream *xdr,
 					const void *data)
@@ -1026,6 +1071,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #ifdef CONFIG_NFSD_PNFS
 	PROC(CB_LAYOUT,	COMPOUND,	cb_layout,	cb_layout),
 #endif
+	PROC(CB_NOTIFY,		COMPOUND,	cb_notify,	cb_notify),
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0eeecd824770c4df8e1cc29fc738e568d91d5e5f..5f21c79be032cc1334a301aad73e6bbcc8da5eb0 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -743,6 +743,7 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
 	NFSPROC4_CLNT_CB_RECALL_ANY,
 	NFSPROC4_CLNT_CB_GETATTR,
+	NFSPROC4_CLNT_CB_NOTIFY,
 };
 
 /* Returns true iff a is later than b: */
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index f4e29c0c701c9b04c44dadc752e847dc4da163d6..100f726ed92730ba953ae217b47be0bd7aefd4e5 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -33,6 +33,17 @@
 					cb_sequence_dec_sz +            \
 					op_dec_sz)
 
+#define NFS4_enc_cb_notify_sz		(cb_compound_enc_hdr_sz +       \
+					cb_sequence_enc_sz +            \
+					1 + enc_stateid_sz +            \
+					enc_nfs4_fh_sz +		\
+					1)
+					/* followed by an array of notify4's in pages */
+
+#define NFS4_dec_cb_notify_sz		(cb_compound_dec_hdr_sz  +      \
+					cb_sequence_dec_sz +            \
+					op_dec_sz)
+
 #define NFS4_enc_cb_notify_lock_sz	(cb_compound_enc_hdr_sz +        \
 					cb_sequence_enc_sz +             \
 					2 + 1 +				 \

-- 
2.49.0


