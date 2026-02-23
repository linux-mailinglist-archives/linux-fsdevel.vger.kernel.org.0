Return-Path: <linux-fsdevel+bounces-78185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHHjOcDmnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:46:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94E17FECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7436930C866C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419BF37FF65;
	Mon, 23 Feb 2026 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE9Dn9MR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E31E9B1A;
	Mon, 23 Feb 2026 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890265; cv=none; b=V9H9Me8cdyWWNYUx0MmaCO1f+Pd0y5WAtYWsfa/ngPcpVQBWlpPKa5fQfZnbjGiVPh0c4wTTtjJ6212lLaaUnz8mWagfOnO5JZnrHQwLnLKvVdOUfBH609W45Soc5u5nPbKMrXZbtxaqup2R5rJER/RJWWWSlfWGgvRbUA1WZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890265; c=relaxed/simple;
	bh=tWE/GnsdZUmcmQysEtguIQst6JstBG4aOcYbXOAUXKs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gioCRW1F2Q8/wbIWLNkP8vb095+iOlVvsiIN3M1XEdUPoe/Yc9uKPivpQmxgtJI9f7St5YsO2wZbpUjsBfwJviGmBxxYN9/HpcCU/JDhdoQN309/ugfAwVTamv9V3hnyEgJWyGfuNF4X+fYZN9kgykmbFa23TAuuclndk0Gita4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE9Dn9MR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E252C116C6;
	Mon, 23 Feb 2026 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890265;
	bh=tWE/GnsdZUmcmQysEtguIQst6JstBG4aOcYbXOAUXKs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eE9Dn9MRRgaSFc730x4wabuoQ3lEug9G/3kTB+tYnKFr75pF5JJ5fLFIFBYtTP58S
	 tSSzzeTIIWviEpwqtE1+36SyrNXJm/mCSN6BZ5gBDGoyCla4co8RiGyueXyXFTGBfZ
	 ObEucWZ8LjeHcH9lG+m1OB+u8P9SxQ52t5YvxwcdsW39MYqAWbUcHpHAA9Q1LLgkcl
	 9cg4zkxMmCTy89skJDolB6fftcG+myeJa2y4d8QxtPL9ECGkJ4nSjt7ylVrWzrnIMj
	 R28In6TyvElf7dKmqIN/W7cXFgrFbYKAI8Iz9SIRQdIMbbahw9TVeWns4atKdnmPat
	 Eh9NZuMdtsLPA==
Date: Mon, 23 Feb 2026 15:44:24 -0800
Subject: [PATCH 2/3] fuse2fs: constrain iomap mapping cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745529.3944453.16237870556453402118.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745484.3944453.12407213942915501693.stgit@frogsfrogsfrogs>
References: <177188745484.3944453.12407213942915501693.stgit@frogsfrogsfrogs>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78185-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D94E17FECB
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Update the iomap config functions to handle the new iomap mapping cache
size restriction knob.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    9 ++++++---
 misc/fuse2fs.c    |    6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index d7238db25261dc..c5cf471d630451 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -7187,7 +7187,8 @@ static void fuse4fs_alloc_stats_range(ext2_filsys fs, blk64_t blk, blk_t num,
 		ff->old_alloc_stats_range(fs, blk, num, inuse);
 }
 
-static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
+static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes,
+			    uint32_t cache_maxbytes)
 {
 	struct fuse_iomap_config cfg = { };
 	struct fuse4fs *ff = fuse4fs_get(req);
@@ -7196,9 +7197,11 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 
 	FUSE4FS_CHECK_CONTEXT(req);
 
-	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx\n", __func__,
+	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx cache_maxbytes=0x%x\n",
+		   __func__,
 		   (unsigned long long)flags,
-		   (unsigned long long)maxbytes);
+		   (unsigned long long)maxbytes,
+		   cache_maxbytes);
 	fs = fuse4fs_start(ff);
 
 	cfg.flags |= FUSE_IOMAP_CONFIG_UUID;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5a217b821c2d4a..4dab8034ebb317 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -6737,6 +6737,7 @@ static void fuse2fs_alloc_stats_range(ext2_filsys fs, blk64_t blk, blk_t num,
 }
 
 static int op_iomap_config(uint64_t flags, off_t maxbytes,
+			   uint32_t cache_maxbytes,
 			   struct fuse_iomap_config *cfg)
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -6745,9 +6746,10 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
-	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx\n", __func__,
+	dbg_printf(ff, "%s: flags=0x%llx maxbytes=0x%llx cache_maxbytes=%u\n", __func__,
 		   (unsigned long long)flags,
-		   (unsigned long long)maxbytes);
+		   (unsigned long long)maxbytes,
+		   cache_maxbytes);
 	fs = fuse2fs_start(ff);
 
 	cfg->flags |= FUSE_IOMAP_CONFIG_UUID;


