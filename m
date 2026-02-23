Return-Path: <linux-fsdevel+bounces-78075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B8jBQzgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:17:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2B17F1B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EDDF3038429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C237F725;
	Mon, 23 Feb 2026 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYNGPXHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A9283FEF;
	Mon, 23 Feb 2026 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888559; cv=none; b=RsNLVnNNJH4SJ5GP4QRNwJ+ra/SluN80xMWQgsKTOdcIqzfiITD9P+DqhpptaWdZ+A5YBYNkNYdKjR4IHe2Bfm6hx14eR9nVLfciz25BL9cJoKO5DvM5chAEtDQkDkLoI9nc7EvSAJb9na22VAij0r+bw38Hkf0f6XVu0OGnDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888559; c=relaxed/simple;
	bh=E8KbnQVTN4gNs6Ol4iEVIUs9j/6FwGUh0i2CLkC8nkI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pC21qOu5B1zjtjODhTKy8MDsnuAFQDN3v8dw8RssZTSWcKaDpNviNaHuz6J8+GASj4p5oD/UGeYBmYzirtVGdV6MOR/nKmny2u3HiYOoGGvWe3uxqVbL7FazgfLLbC0odVhu6oyftC35dGG5W+nf+qEthzrAUl/3GhKZL/jutsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYNGPXHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87678C116C6;
	Mon, 23 Feb 2026 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888559;
	bh=E8KbnQVTN4gNs6Ol4iEVIUs9j/6FwGUh0i2CLkC8nkI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mYNGPXHGcrl5KldUHFpCQaeAZRdIgR0n2L1qQwM7PDR4bNyz2rPC/kevttkU/1Q9e
	 ylbkn7X4vQrbBdl64UOqYmPcwbvezvLpXe9rIaYpB4TDfHqIOY+Y6CoMFuj5udW9Sj
	 hThNWBOiqPui7EtAoMZweAI6xOjetP3MmyzFeaTjalWU2NNNkTceQG1hbDSwLWNupc
	 lScaoUOBz/3GbVf3QmCcDx4wb+LFQRLIEi2xqydu+mq7q00zlaKjuc61/lNh4iUY4b
	 KwMnCSrAZtc2EJnORKye/0cVwySl/JJyfMTZxk/+skCxdaMvZDss/3Wzfkwtgtcv3u
	 EwZWfGXDxAGoA==
Date: Mon, 23 Feb 2026 15:15:59 -0800
Subject: [PATCH 28/33] fuse: allow more statx fields
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734844.3935739.164292484209908676.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78075-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 44F2B17F1B1
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Allow the fuse server to supply us with the more recently added fields
of struct statx.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/uapi/linux/fuse.h |   15 ++++++++-
 fs/fuse/dir.c             |   76 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 12 deletions(-)


diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1ef7152306a24f..aa96b4cbdfa255 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -341,7 +341,20 @@ struct fuse_statx {
 	uint32_t	rdev_minor;
 	uint32_t	dev_major;
 	uint32_t	dev_minor;
-	uint64_t	__spare2[14];
+
+	uint64_t	mnt_id;
+	uint32_t	dio_mem_align;
+	uint32_t	dio_offset_align;
+	uint64_t	subvol;
+
+	uint32_t	atomic_write_unit_min;
+	uint32_t	atomic_write_unit_max;
+	uint32_t	atomic_write_segments_max;
+	uint32_t	dio_read_offset_align;
+	uint32_t	atomic_write_unit_max_opt;
+	uint32_t	__spare2[1];
+
+	uint64_t	__spare3[8];
 };
 
 struct fuse_kstatfs {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index fc0751deebfd20..0492619e397f56 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1466,6 +1466,50 @@ static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
 	attr->blksize = sx->blksize;
 }
 
+#define FUSE_SUPPORTED_STATX_MASK	(STATX_BASIC_STATS | \
+					 STATX_BTIME | \
+					 STATX_DIOALIGN | \
+					 STATX_SUBVOL | \
+					 STATX_WRITE_ATOMIC)
+
+#define FUSE_UNCACHED_STATX_MASK	(STATX_DIOALIGN | \
+					 STATX_SUBVOL | \
+					 STATX_WRITE_ATOMIC)
+
+static void kstat_from_fuse_statx(const struct inode *inode,
+				  struct kstat *stat,
+				  const struct fuse_statx *sx)
+{
+	stat->result_mask = sx->mask & FUSE_SUPPORTED_STATX_MASK;
+
+	stat->attributes |= fuse_statx_attributes(inode, sx);
+	stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
+
+	if (sx->mask & STATX_BTIME) {
+		stat->btime.tv_sec = sx->btime.tv_sec;
+		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec,
+					    NSEC_PER_SEC - 1);
+	}
+
+	if (sx->mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = sx->dio_mem_align;
+		stat->dio_offset_align = sx->dio_offset_align;
+	}
+
+	if (sx->mask & STATX_SUBVOL)
+		stat->subvol = sx->subvol;
+
+	if (sx->mask & STATX_WRITE_ATOMIC) {
+		stat->atomic_write_unit_min = sx->atomic_write_unit_min;
+		stat->atomic_write_unit_max = sx->atomic_write_unit_max;
+		stat->atomic_write_unit_max_opt = sx->atomic_write_unit_max_opt;
+		stat->atomic_write_segments_max = sx->atomic_write_segments_max;
+	}
+
+	if (sx->mask & STATX_DIO_READ_ALIGN)
+		stat->dio_read_offset_align = sx->dio_read_offset_align;
+}
+
 static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 			 struct file *file, struct kstat *stat)
 {
@@ -1489,7 +1533,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 	/* For now leave sync hints as the default, request all stats. */
 	inarg.sx_flags = 0;
-	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
+	inarg.sx_mask = FUSE_SUPPORTED_STATX_MASK;
 	args.opcode = FUSE_STATX;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -1517,11 +1561,7 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 	}
 
 	if (stat) {
-		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
-		stat->btime.tv_sec = sx->btime.tv_sec;
-		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
-		stat->attributes |= fuse_statx_attributes(inode, sx);
-		stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
+		kstat_from_fuse_statx(inode, stat, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1586,16 +1626,30 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 	u32 inval_mask = READ_ONCE(fi->inval_mask);
 	u32 cache_mask = fuse_get_cache_mask(inode);
 
-
-	/* FUSE only supports basic stats and possibly btime */
-	request_mask &= STATX_BASIC_STATS | STATX_BTIME;
+	/* Only ask for supported stats */
+	request_mask &= FUSE_SUPPORTED_STATX_MASK;
 retry:
 	if (fc->no_statx)
 		request_mask &= STATX_BASIC_STATS;
 
 	if (!request_mask)
 		sync = false;
-	else if (flags & AT_STATX_FORCE_SYNC)
+	else if (request_mask & FUSE_UNCACHED_STATX_MASK) {
+		switch (flags & AT_STATX_SYNC_TYPE) {
+		case AT_STATX_DONT_SYNC:
+			request_mask &= ~FUSE_UNCACHED_STATX_MASK;
+			sync = false;
+			break;
+		case AT_STATX_FORCE_SYNC:
+		case AT_STATX_SYNC_AS_STAT:
+			sync = true;
+			break;
+		default:
+			WARN_ON(1);
+			sync = false;
+			break;
+		}
+	} else if (flags & AT_STATX_FORCE_SYNC)
 		sync = true;
 	else if (flags & AT_STATX_DONT_SYNC)
 		sync = false;
@@ -1606,7 +1660,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 
 	if (sync) {
 		forget_all_cached_acls(inode);
-		/* Try statx if BTIME is requested */
+		/* Try statx if a field not covered by regular stat is wanted */
 		if (!fc->no_statx && (request_mask & ~STATX_BASIC_STATS)) {
 			err = fuse_do_statx(idmap, inode, file, stat);
 			if (err == -ENOSYS) {


