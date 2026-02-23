Return-Path: <linux-fsdevel+bounces-78045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDHaLAnenGm4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024F17EE09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9B230C7EDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5F37E2F0;
	Mon, 23 Feb 2026 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUyGS10h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFB37D126;
	Mon, 23 Feb 2026 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888089; cv=none; b=oipL4Wui1QRjoVUPAO4fLv9JhbvXC69BG6g2HCJeRVULYuyX5tyU+n8hmtvQc/6VpGW5d4bXO7/W3cY/MN2roOSpmXR7d2DYg8teOilXk1gG2JyQ0I6DjBdtcwoJSOrNmNYc70uUPeUovx93MQnSs/QHCsS2HsqavaBBZPEJEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888089; c=relaxed/simple;
	bh=KUZyb2Ubg9BP3PHvMw19jTX2YK6qIPOY38TcKnmKfQk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8HxY9sVyZxOTUe4hUkv6AGKPqsnNT7uzvwQ2xNQsyH8nrZSv2vqKO6NdXcPE6XKqqNAeR7ubrkQtI2xPwwEF6abJqJFh3zFy7jRSAv96RFMgyFT0XWBd2ZCBYaae2blmAVrUcXsrBP12I3Pki0WuNNcUgxCCAYrIxrD7t73oh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUyGS10h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C2AC116C6;
	Mon, 23 Feb 2026 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888089;
	bh=KUZyb2Ubg9BP3PHvMw19jTX2YK6qIPOY38TcKnmKfQk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jUyGS10h1nGlL4rPj5Xc8Qp/7gRFU0XAISHFFWXuCDiGCV/4agiTFsJgr8raWgM0G
	 uwEuBctdz9YrVhnYAFHtHTWm47JUdnOo81IMMAv9VIrUBNxV8mfy0GzR9ZWELaAppp
	 IneG4lJkcxB/2p4sjzS8sAk9I5nNz9mB8CvfXcJDP53DPz/dlY52MshJTPM+olRm8b
	 +LT2ZnNsO04mmIMZNuFQ06yHfVgzBti5yYoT4IC6A3POVCMdhTL4lgsvqfXNqBxHD+
	 pXZ4S8KugEeQ/XvcDX1or7I/fQ+UVGTe24ky+sn597UH6AyG+3yIODs26IpvH6MOxu
	 kJ8Kk6NfcgKPg==
Date: Mon, 23 Feb 2026 15:08:08 -0800
Subject: [PATCH 2/2] iomap: allow NULL swap info bdev when activating swapfile
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org
Cc: bpf@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188733484.3935463.443855246947996750.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78045-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6024F17EE09
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

All current users of the iomap swapfile activation mechanism are block
device filesystems.  This means that claim_swapfile will set
swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.

However, a subsequent patch to fuse will add iomap infrastructure so
that fuse servers can be asked to provide file mappings specifically for
swap files.  The fuse server isn't required to set s_bdev (by mounting
as fuseblk) so s_bdev might be null.  For this case, we want to set
sis::bdev from the first mapping.

To make this work robustly, we must explicitly check that each mapping
provides a bdev and that there's no way we can succeed at collecting
swapfile pages without a block device.

And just to be clear: fuse-iomap servers will have to respond to an
explicit request for swapfile activation.  It's not like fuseblk, where
responding to bmap means swapfiles work even if that wasn't expected.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/swapfile.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 0db77c449467a7..9d9f4e84437df5 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -112,6 +112,13 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
 	if (iomap->flags & IOMAP_F_SHARED)
 		return iomap_swapfile_fail(isi, "has shared extents");
 
+	/* Swapfiles must be backed by a block device */
+	if (!iomap->bdev)
+		return iomap_swapfile_fail(isi, "is not on a block device");
+
+	if (iter->pos == 0 && !isi->sis->bdev)
+		isi->sis->bdev = iomap->bdev;
+
 	/* Only one bdev per swap file. */
 	if (iomap->bdev != isi->sis->bdev)
 		return iomap_swapfile_fail(isi, "outside the main device");
@@ -184,6 +191,16 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 		return -EINVAL;
 	}
 
+	/*
+	 * If this swapfile doesn't have a block device, reject this useless
+	 * swapfile to prevent confusion later on.
+	 */
+	if (sis->bdev == NULL) {
+		pr_warn(
+ "swapon: No block device for swap file but usage pages?!\n");
+		return -EINVAL;
+	}
+
 	*pagespan = 1 + isi.highest_ppage - isi.lowest_ppage;
 	sis->max = isi.nr_pages;
 	sis->pages = isi.nr_pages - 1;


