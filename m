Return-Path: <linux-fsdevel+bounces-14500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74187D1EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF96E1C21DDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473AB5BAF8;
	Fri, 15 Mar 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaLjsm6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1A5BAE0;
	Fri, 15 Mar 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521625; cv=none; b=IRa15Go2Lyn627zMuLFUxNfUUitWMLLwS1a4m3V0QUTcpkRTd0hHR3OT/8bGJvp41tptFSCnPhJDxrj2hOi4Nlym4sODRFDbj9giy7eUnMIQVOfbS2JPOHfPkQerveu1Msdgr6c2EfNnXQ7hUGQftEcde6N+NuoRww+DBanNS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521625; c=relaxed/simple;
	bh=eWqiPxkORa/jrz1Vpk1ANB4N2FUMiPwwSkg+tEGN67g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BR2L+8ROlufyekzV038NuZZ9B7hyGqwrSYDaawH7jCy/WUspbRKaxc6j8OusjyMjvy4tJs9e3JmOFZWpn92nAMwsn8qF/M3Ei6PzARz8xWp5mQDpvSyb8aXF+CO7hN0vCceDCGeuwGb4nWdgu2Hk6262mEkRCyIV7V2EIC+Mmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaLjsm6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCD3C433C7;
	Fri, 15 Mar 2024 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521625;
	bh=eWqiPxkORa/jrz1Vpk1ANB4N2FUMiPwwSkg+tEGN67g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DaLjsm6W/cWSlQSAQt35MPc9Zvw094Gl7MELDI4FTPVOOpT1fKMt5DsBli3Ipej0R
	 1dVgCEofeJInRk29a2Ta9N82rgQf07sr0VssqYuZn+2WAiJD//WcbzJw9lQl08aCSU
	 tIsjbdFLmAygkGv6f0+87SH3lgLX+u1HqnuEj1BUKtnKmBcvb1OGVC2iQ8I9yIYtkR
	 C5Z89987p1Prp6NMZ3UhUywjt7nVEtPVsEVJRhWrhxJXCmaiIosLpq5fjRjdogHh0X
	 jjWdeB6Q0T7vIdkUKJabaAxKEed4005kwO/w03pv6KzqsbeQNwEEWJmGNqiz0xM3yP
	 sYZD2V24y06Tg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:03 -0400
Subject: [PATCH RFC 12/24] nfsd: encoders and decoders for
 GET_DIR_DELEGATION
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-12-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7250; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eWqiPxkORa/jrz1Vpk1ANB4N2FUMiPwwSkg+tEGN67g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzux84pP1BToC0cXEcy2JAB+wMmRTWbjNYm5
 XHEP5hDfFWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FRmxD/0Ufx0/2UuQ6C25+vBZuUnPRr9VhDlbCwMDlCy9cXI8txz2UVOoYZLmjGCYg1SZLLi50u7
 lm90hF04X/7njqEQcfyguWVWxeGtclJpzpxln1YOdrbLAbGxaCItoyAKylyIlDlIn6noZGMssuW
 5Br5yitk0S2CXTkjJaaSGaeEXIWMS2ao4ms1Iymowan9+9mo+wXMWB/OxOycWkB9Mct2eJhKGfT
 XkAHS+zWYRhEQ3vlyalw/q2h0rbPTomMLThTscs/J7UjpQF93VmdQiftcNLGK8JmzGcnoKZvgTj
 yNS8f9YrDheyDGGETOjEZjjt9VmO2onTb6oaiJegojkRbH6xQlUrd/tfhrbcHZoZhand2hiy09p
 Moz6+2Xcxl0B+GLAqT0MvA8B7shcD3OCYa1mbd9wjxdhh9x+GMO3hO24LNa5o9iBSjAZfuibTsU
 yDNTfMayUPx6saiZUrIeqwBJPrxBPeTHauxmuiYKNOVeVgDP4NUcv85C5P6MxeN+5ZBKqHDDO3g
 kjp3S4fjyIN/9oHw3lUkrI13rLLcwuMPOwJh9w7+/9n1yzNUotX2MJ+35SsObSUDCjMWlpFtzeU
 1C1xCzQmSjuarhFsLWbSHVYR31rWwePTrhUbdtzsyYpwOuxYSGDGo6xcidIZAmQcHmYv0YDMqxL
 sqNrVxjUU5D2fFg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This adds basic infrastructure for handing GET_DIR_DELEGATION calls from
clients, including the  decoders and encoders. For now, the server side
always just returns that the  delegation is GDDR_UNAVAIL (and that we
won't call back).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c   | 30 ++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h       |  8 ++++++
 include/linux/nfs4.h |  5 ++++
 4 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2927b1263f08..7973fe17bf3c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2173,6 +2173,18 @@ nfsd4_layout_verify(struct svc_export *exp, unsigned int layout_type)
 	return nfsd4_layout_ops[layout_type];
 }
 
+static __be32
+nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
+			 struct nfsd4_compound_state *cstate,
+			 union nfsd4_op_u *u)
+{
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+
+	/* FIXME: actually return a delegation */
+	gdd->nf_status = GDD4_UNAVAIL;
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
@@ -3082,6 +3094,18 @@ static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
 		* sizeof(__be32);
 }
 
+static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
+					  const struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size +
+		1 /* gddr_status */ +
+		op_encode_verifier_maxsz +
+		op_encode_stateid_maxsz +
+		2 /* gddr_notification */ +
+		2 /* gddr_child_attributes */ +
+		2 /* gddr_dir_attributes */);
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
 				     const struct nfsd4_op *op)
@@ -3470,6 +3494,12 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_get_currentstateid = nfsd4_get_freestateid,
 		.op_rsize_bop = nfsd4_only_status_rsize,
 	},
+	[OP_GET_DIR_DELEGATION] = {
+		.op_func = nfsd4_get_dir_delegation,
+		.op_flags = OP_MODIFIES_SOMETHING,
+		.op_name = "OP_GET_DIR_DELEGATION",
+		.op_rsize_bop = nfsd4_get_dir_delegation_rsize,
+	},
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO] = {
 		.op_func = nfsd4_getdeviceinfo,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index fac938f563ad..3718bef74e9f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1732,6 +1732,40 @@ nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
+static __be32
+nfsd4_decode_get_dir_delegation(struct nfsd4_compoundargs *argp,
+		union nfsd4_op_u *u)
+{
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	struct timespec64 ts;
+	u32 signal_deleg_avail;
+	u32 attrs[1];
+	__be32 status;
+
+	memset(gdd, 0, sizeof(*gdd));
+
+	/* No signal_avail support for now (and maybe never) */
+	if (xdr_stream_decode_bool(argp->xdr, &signal_deleg_avail) < 0)
+		return nfserr_bad_xdr;
+	status = nfsd4_decode_bitmap4(argp, gdd->notification_types,
+				      ARRAY_SIZE(gdd->notification_types));
+	if (status)
+		return status;
+
+	/* For now, we don't support child or dir attr change notification */
+	status = nfsd4_decode_nfstime4(argp, &ts);
+	if (status)
+		return status;
+	/* No dir attr notification support yet either */
+	status = nfsd4_decode_nfstime4(argp, &ts);
+	if (status)
+		return status;
+	status = nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
+	if (status)
+		return status;
+	return nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
+}
+
 #ifdef CONFIG_NFSD_PNFS
 static __be32
 nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
@@ -2370,7 +2404,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_CREATE_SESSION]	= nfsd4_decode_create_session,
 	[OP_DESTROY_SESSION]	= nfsd4_decode_destroy_session,
 	[OP_FREE_STATEID]	= nfsd4_decode_free_stateid,
-	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_notsupp,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_decode_get_dir_delegation,
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO]	= nfsd4_decode_getdeviceinfo,
 	[OP_GETDEVICELIST]	= nfsd4_decode_notsupp,
@@ -5002,6 +5036,40 @@ nfsd4_encode_device_addr4(struct xdr_stream *xdr,
 	return nfserr_toosmall;
 }
 
+static __be32
+nfsd4_encode_get_dir_delegation(struct nfsd4_compoundres *resp, __be32 nfserr,
+				union nfsd4_op_u *u)
+{
+	struct xdr_stream *xdr = resp->xdr;
+	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+
+	/* Encode the GDDR_* status code */
+	if (xdr_stream_encode_u32(xdr, gdd->nf_status) != XDR_UNIT)
+		return nfserr_resource;
+
+	/* if it's GDD4_UNAVAIL then we're (almost) done */
+	if (gdd->nf_status == GDD4_UNAVAIL) {
+		/* We never call back */
+		return nfsd4_encode_bool(xdr, false);
+	}
+
+	/* GDD4_OK case */
+	nfserr = nfsd4_encode_verifier4(xdr, &gdd->cookieverf);
+	if (nfserr)
+		return nfserr;
+	nfserr = nfsd4_encode_stateid4(xdr, &gdd->stateid);
+	if (nfserr)
+		return nfserr;
+	/* No notifications (yet) */
+	nfserr = nfsd4_encode_bitmap4(xdr, 0, 0, 0);
+	if (nfserr)
+		return nfserr;
+	nfserr = nfsd4_encode_bitmap4(xdr, 0, 0, 0);
+	if (nfserr)
+		return nfserr;
+	return nfsd4_encode_bitmap4(xdr, 0, 0, 0);
+}
+
 static __be32
 nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 		union nfsd4_op_u *u)
@@ -5580,7 +5648,7 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_CREATE_SESSION]	= nfsd4_encode_create_session,
 	[OP_DESTROY_SESSION]	= nfsd4_encode_noop,
 	[OP_FREE_STATEID]	= nfsd4_encode_noop,
-	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_noop,
+	[OP_GET_DIR_DELEGATION]	= nfsd4_encode_get_dir_delegation,
 #ifdef CONFIG_NFSD_PNFS
 	[OP_GETDEVICEINFO]	= nfsd4_encode_getdeviceinfo,
 	[OP_GETDEVICELIST]	= nfsd4_encode_noop,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 415516c1b27e..27de75f32dea 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -518,6 +518,13 @@ struct nfsd4_free_stateid {
 	stateid_t	fr_stateid;         /* request */
 };
 
+struct nfsd4_get_dir_delegation {
+	u32		notification_types[1];	/* request */
+	u32		nf_status;		/* response */
+	nfs4_verifier	cookieverf;		/* response */
+	stateid_t	stateid;		/* response */
+};
+
 /* also used for NVERIFY */
 struct nfsd4_verify {
 	u32		ve_bmval[3];        /* request */
@@ -797,6 +804,7 @@ struct nfsd4_op {
 		struct nfsd4_reclaim_complete	reclaim_complete;
 		struct nfsd4_test_stateid	test_stateid;
 		struct nfsd4_free_stateid	free_stateid;
+		struct nfsd4_get_dir_delegation	get_dir_delegation;
 		struct nfsd4_getdeviceinfo	getdeviceinfo;
 		struct nfsd4_layoutget		layoutget;
 		struct nfsd4_layoutcommit	layoutcommit;
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index ef8d2d618d5b..11ad088b411d 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -701,6 +701,11 @@ enum state_protect_how4 {
 	SP4_SSV		= 2
 };
 
+enum get_dir_delegation_non_fatal_res {
+	GDD4_OK		= 0,
+	GDD4_UNAVAIL	= 1
+};
+
 enum pnfs_layouttype {
 	LAYOUT_NFSV4_1_FILES  = 1,
 	LAYOUT_OSD2_OBJECTS = 2,

-- 
2.44.0


