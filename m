Return-Path: <linux-fsdevel+bounces-28726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB396D8F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A1AB236BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A619D8A9;
	Thu,  5 Sep 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTYGGTAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4619D880;
	Thu,  5 Sep 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540121; cv=none; b=TUvX+y2hgQ3z4njAgOdCFzRIDAxrz4Io1m3G/nAVgxaeggCgA4+pLzBviJ/0G9q7ZEhDdqHtNOZsDh4/kDvlya2ikwM82v5mUW2jgTurjfCl5f/G5sIPIBBdAonzeVp9bFKyCEKDGKgyntGsJHPU3nosOeBAl3362/D2noYQ/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540121; c=relaxed/simple;
	bh=lo5fg8EfTLkVA9DYVM0X/8i1HjBrQtIclBbgHsn2k30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=up945z83ueGEs7rM9wTQASWEyNExEBebNiG/bv2hS/uqX9qVZ4Ln4W0tMh1KhP43GuB7UZigFjbX9NdIu2sCTsc3c6Fk3wTmwy9Px6Tki4STnE8AaVcAKkAVAzhfU0e1EfqufiWA9HFyVPD2CJYqoqJyV+wlfDFc65YDuU37LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTYGGTAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6303C4CECB;
	Thu,  5 Sep 2024 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540121;
	bh=lo5fg8EfTLkVA9DYVM0X/8i1HjBrQtIclBbgHsn2k30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FTYGGTAxoHoCPEIC3ePPUEzzHO2Uz46fygxHTjufpZC1lLgdvmbf8OsOmkYYsYHGQ
	 F0ny3dBRAgrPyCCfWXrwNPX3Gt0Suz4GuKvdkaDzfBy0t9L0whhhuQ8n9AGDDERiGw
	 9BO/AuXnJq8+5p02v8KAei3jw67B/TpkkV1L+Sr904eIFIWwNeXjyspSSkB0YBdZZE
	 dL8dTuhlMmjqWf7nmy3j/iiasOhZxbXEy5n7LnjcRQOtr4wtKO73on5gZUnoas77fK
	 4U7ovlW9vauRquFbIIUC7orLMu9U/wtNPXQfiu/KLb0KrdRLBGxXwaUT5/JYC1MDtz
	 uv0D+wJnyTomg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:45 -0400
Subject: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2631; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lo5fg8EfTLkVA9DYVM0X/8i1HjBrQtIclBbgHsn2k30=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acUUInFhjUD9KJZQi9BTLZT2glTH01mvschh
 E0kto7gztiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFAAKCRAADmhBGVaC
 Fb94D/9bRFaO0c1Pv0U2QXAo1IrMLijhH3a4gFrX2/7fILEoXRqSCp5u00vJs02OjB7pQlWENpC
 zB2a1yr/nSuxqgZn4hazwnliWMsFAq7butwQSha7iTO526Za6gvWsdTPHwltBD+v5Z8EL1oAG2o
 7eKHOu6GsaKMrghUpnu9QWaMAsXfjQyvz2ghIHbI8YcHG/KAkPuD0PMHQb+Mf9xL3zi3VQr0XnY
 bvrqMa4q23E9V8gtMxyQsQSYpltEvV41h1S/p96bv13zGV+mspbf70Z4h/8ERh5DbJpb/jOagIW
 n1kZLtiwfEIQ5FAItYNdmjGi9Wbw88uiwr1SAbcXRMhQk8cO3fTEWcGnAWps4Z10+gUM4vy4fUq
 Ne1YFrodG0ksrSt2wX0vaLk11FHy429m7yP67YTAsgBwlqVS8mj/51uAy8s9KKbBtbv7Ff5JC04
 ugu7N24+X3RHcTujJKYJjnrQYJZc+9gutCFW57cGD5ztSApL2H4yx8ESly4QataTAnpNWLnpTEn
 /FwKVmnRES3JrzBqNOzR6uwoqerm/fZjq3sbBGjdmS41j48HESbXnH62K0PVPBS0EsO+QjoSlST
 oP/8q8w+Vh9ggcOxJ1r4/LCTFFztljl8wU2k0mdm3MGFad1+TtO2MJqnN0B1VJvVXjBYcnGWH1l
 5+2wtdja4lT5/rg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

At this point in compound processing, currentfh refers to the parent of
the file, not the file itself. Get the correct dentry from the delegation
stateid instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index df69dc6af467..db90677fc016 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5914,6 +5914,26 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
 	}
 }
 
+static bool
+nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
+		     struct kstat *stat)
+{
+	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
+	struct path path;
+
+	if (!nf)
+		return false;
+
+	path.mnt = currentfh->fh_export->ex_path.mnt;
+	path.dentry = file_dentry(nf->nf_file);
+
+	if (vfs_getattr(&path, stat,
+			(STATX_INO | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
+			AT_STATX_SYNC_AS_STAT))
+		return false;
+	return true;
+}
+
 /*
  * The Linux NFS server does not offer write delegations to NFSv4.0
  * clients in order to avoid conflicts between write delegations and
@@ -5949,7 +5969,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	int cb_up;
 	int status = 0;
 	struct kstat stat;
-	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = false;
@@ -5985,20 +6004,16 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
-		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
-		path.mnt = currentfh->fh_export->ex_path.mnt;
-		path.dentry = currentfh->fh_dentry;
-		if (vfs_getattr(&path, &stat,
-				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
-				AT_STATX_SYNC_AS_STAT)) {
+		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
 			destroy_delegation(dp);
 			goto out_no_deleg;
 		}
+		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
 		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo =
 			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
+		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
 	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);

-- 
2.46.0


