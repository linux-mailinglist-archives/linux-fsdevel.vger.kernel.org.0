Return-Path: <linux-fsdevel+bounces-78101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKXrNkjhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D217F3E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C5D83027E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9EA37F752;
	Mon, 23 Feb 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE65eXnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706C37C11B;
	Mon, 23 Feb 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888966; cv=none; b=TOY4pPXVBJMwjrqsP5AJ4jyrWY3hxDqPxcC3mnIXMBKsvKG6zh1RA4EgThMIAHJ8cn28T+zzQhCthPK1RBNvHeqhvVTuZVUnOaoZ8p/7JFPHmByV/4sIDGmVGb1Tw4T0SrFgorJod5Rx2N77oJCQobeV3jqvUYCPNIOsursLYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888966; c=relaxed/simple;
	bh=K2sKHiDR5dYBsEc6CRdWkMy5uWadHJrfkxT/4BpVo7c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+UEOeJekAR6Wh2jdLys8Q3r+KaJmgB0sqk+dMby3PFZBxmeVxMmAoa5T4zeLr8y6U0ggUEISuiE9vMa+QdSciLA+scwU8bp7ZQpDKrI8yK7BnuWAG3h+QbAUyfOZvHK59GOT9J0gkrs/LFf4ymZ3UZTskm+5tnvldUMls/Ujes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE65eXnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64ECC116C6;
	Mon, 23 Feb 2026 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888966;
	bh=K2sKHiDR5dYBsEc6CRdWkMy5uWadHJrfkxT/4BpVo7c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qE65eXnfAAGGza8Bho3ZrpHro5P7p1KPHlSMLqjgWYRuq2nXL7A9PDtW0Ebj82p2Y
	 6FKCEMWpMyNKSH64rcD2ImfQd+nrRByW5EtyTxzfxMI6QL4ZYKsYxEL6H4C/W8c7ht
	 uszgTfUQ/REDXiEZGNKPQCZuz4y/9HJjRH1QDwChb77o+RyZVdHk8MIdjthedEoJNK
	 sR2MM32Szr+lU769Cn9b5i7iOAZb14Xm5FO4ZmD1BejLS4ff6Uwd51kOnAoY+X9ioo
	 fkClP+2Cxj66yZ4t8HV4di5Mho1kN7nC6l3QasA5P1mjdTXmWS/akNKbUyhYMD7eyn
	 VXyAPS+S/XSJw==
Date: Mon, 23 Feb 2026 15:22:45 -0800
Subject: [PATCH 09/12] fuse: overlay iomap inode info in struct fuse_inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736220.3937557.5311553585166787815.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
References: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78101-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A84D217F3E3
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

It's not possible for a regular file to use iomap mode and writeback
caching at the same time, so we can save some memory in struct
fuse_inode by overlaying them in the union.  This is a separate patch
because C unions are rather unsafe and I prefer any errors to be
bisectable to this patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1ba95d1f430c3e..f6725d699b3e26 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -188,8 +188,11 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+		};
 
 #ifdef CONFIG_FUSE_IOMAP
+		/* regular file iomap mode */
+		struct {
 			/* file size as reported by fuse server */
 			loff_t i_disk_size;
 
@@ -200,8 +203,8 @@ struct fuse_inode {
 
 			/* cached iomap mappings */
 			struct fuse_iomap_cache *cache;
-#endif
 		};
+#endif
 
 		/* readdir cache (directory only) */
 		struct {


