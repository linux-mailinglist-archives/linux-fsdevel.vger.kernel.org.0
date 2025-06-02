Return-Path: <linux-fsdevel+bounces-50355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81FACB10D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DADD16D90C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F523D2AD;
	Mon,  2 Jun 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhT+uzN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC42236FC;
	Mon,  2 Jun 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872997; cv=none; b=vBf7BKq1xr6WV70kE2NuXPdRkM67yoa9W88nFqIm+fpq5SLyFQsrfhTNTB0sNJY2rBzYeJciN/ULQe5Pj0kc6JlDur/IymBSQ2MIyQuX/uNYpA04h30TjGKzSr/5Vdk10n0UUXr562GWHYxnrnhtLZI6YJM25r9jrq+gSa9qbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872997; c=relaxed/simple;
	bh=H0xMoRMbO/wWa3vUx7i5LYdj5QyZv1EQ/6dovruf8N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/DrFRkpKOL+uQYuoU1SC94o4m2cnN+VzzjEdnMUhtG52sJqyeJsKnNAPYEH8jSR7h2U8JP12qkCrGFhArXD0ozvjrYmGgok7/49Hs/YmMtmAiYi7oOShXqK1Tc0azTzItzfEVVIixYTPF79KDpTSlxseCBSURrvsEsWq19ElJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhT+uzN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C288C4CEEE;
	Mon,  2 Jun 2025 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872995;
	bh=H0xMoRMbO/wWa3vUx7i5LYdj5QyZv1EQ/6dovruf8N4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IhT+uzN60w/TcRihzKBQtQLrmCisCge/93iB3Xx1+s/EgrcpNAFVVpb6aMKiLc6WW
	 Mmp/II6Z/Dhvp9Mv6vZOP+wRgpjsyp9c9XueDh8k1pcgOKvv2CeYBWD3RoNRnRW1On
	 zoHUCwFlBcZFZii68EOZGwkxYRHEqa4Ds0m+mOl67kMufocblSoSBVPWWS62Rt8fyG
	 PLX6Hl50lXeEfTvDAWOPRYvpZPcfwQ2AFAStYw5OIU68L6q5++HYOV4UhmNY0BCel3
	 k2BLiTEBQnD1WQpEAI5pjOHl361yWu3teGJqz45HIkcsD+nRB/P0JvvCEj1rJ6Nr9i
	 HdWRSQk03koRw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:08 -0400
Subject: [PATCH RFC v2 25/28] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-25-a7919700de86@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=H0xMoRMbO/wWa3vUx7i5LYdj5QyZv1EQ/6dovruf8N4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7qLjDR+iYEt5LHIKN3FETfC8LjOi06SmIUb
 my5kUQQOuaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6gAKCRAADmhBGVaC
 Fa0ZEAC/ilcsSqLGWNmLU0y+pByHH5TpRYO/30ZWZ+qDc0DIUIJqksYup/D+5jJ1x37YYV3HPFQ
 oIrmcbg/NZSsyIzs9bPcG90KJfasq+/0WS85gKI6MXOlIdedi3Bxr2pkcoEeBfsxeCfHNJyn+qP
 zYNbkmYPacav2ixJi1RMLxnCznFvcWdbHvyPr+WibN5Sz815fCFRk+IDVtKJrhBYyCyWuSar0pB
 2+wGeg4E6jONHtkF54K26mmxFQr3NiZ3qtUIKpORPMlflGDhK+/5kgx+SYDn4xZ/t1i3SVEPGVL
 NVlzPxgHd6veMD6jmdQpxlBEwFQPw5r7w++hUfTwvoqUxya2usD3DyKDE/njbKk+hXIuJPnl9P6
 zInERqZ/6dQyONZRJ9cHs97nJ1IHsF6mSi7aI1hB0N/SK9UI+gW9n4ckYg0NSsBK4qxVX30MWRn
 8V5sWUiAkxIdX1lmA1dMQxPkfmgbnFGQjyGvhc17ZlRG33pLtyYKcopeLzEyCSHV/x9a72efSum
 vx1x8U6NPcdtYyKBeM0gKb7c7ieuwDPhlw8urmNnh/Iq8xDldzwF/GYZlYfphjD/zf0vsfFDEHM
 g8ePJnyVAGx7TR1WQz7b5zboyBucwi8+A/lnUQkS8kOEVTMflH0eR/C9U0knrkDNdAKMFMyR20N
 Xq+36HfUokGbCwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When requesting a directory lease, enable the FL_IGN_DIR_* bits that
correspond to the requested notification types.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  3 +++
 fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index fa6f2980bcacd798c41387c71d55a59fdbc8043c..77b6d0363b9f4cfea96f3f1abd3e462fd2a77754 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2292,6 +2292,8 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
+#define SUPPORTED_NOTIFY_MASK BIT(NOTIFY4_REMOVE_ENTRY)
+
 static __be32
 nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 			 struct nfsd4_compound_state *cstate,
@@ -2330,6 +2332,7 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 
 	gdd->gddrnf_status = GDD4_OK;
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
+	gdd->gddr_notification[0] = gdd->gdda_notification_types[0] & SUPPORTED_NOTIFY_MASK;
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35b9e35f8b507cc9b3924fead3037433cd8f9371..a75179ffa6006868bae3931263830d7b7e1a8882 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6075,14 +6075,14 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, unsigned int ignore)
 {
 	struct file_lease *fl;
 
 	fl = locks_alloc_lease();
 	if (!fl)
 		return NULL;
-	fl->c.flc_flags = FL_DELEG;
+	fl->c.flc_flags = FL_DELEG | ignore;
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6299,7 +6299,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9523,6 +9523,21 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	return status;
 }
 
+static unsigned int
+nfsd_notify_to_ignore_mask(u32 notify)
+{
+	unsigned int mask = 0;
+
+	if (notify & BIT(NOTIFY4_REMOVE_ENTRY))
+		mask |= FL_IGN_DIR_DELETE;
+	if (notify & BIT(NOTIFY4_ADD_ENTRY))
+		mask |= FL_IGN_DIR_CREATE;
+	if (notify & BIT(NOTIFY4_RENAME_ENTRY))
+		mask |= FL_IGN_DIR_RENAME;
+
+	return mask;
+}
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -9569,12 +9584,12 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp,
+			nfsd_notify_to_ignore_mask(gdd->gdda_notification_types[0]));
 	if (!fl)
 		goto out_put_stid;
 
-	status = kernel_setlease(nf->nf_file,
-				 fl->c.flc_type, &fl, NULL);
+	status = kernel_setlease(nf->nf_file, fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
 	if (status)

-- 
2.49.0


