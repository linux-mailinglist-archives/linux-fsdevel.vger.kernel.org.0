Return-Path: <linux-fsdevel+bounces-78183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GcgDw7nnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C017FF5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F6C33090225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919837FF5F;
	Mon, 23 Feb 2026 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAjCQZWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4202EA151;
	Mon, 23 Feb 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890234; cv=none; b=V0dzguzPWX+a8oIVqfyiEZLWisVJPT/vkFPssAV3+KIbv0Fc2yV9seJMLdqUgAWZtr07oSYEF/Iq98TEmQPeuT1q67cufARVEIeLeCYy0SpC1mHhq66CpqHpquuB6Ro2sgC/4+N5FGoTeWP/JbhQhcx95XrJw//+sCNJSiKU3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890234; c=relaxed/simple;
	bh=93yOoSlX1ZbKvqtkXrOB3tX1+IaZnGCwtgsNrVh/ZXc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaoJJPHjXyagfoWF1yCk+JGmdpPWfDYkIHVeJzsV2F+qja85k7Wvndm4fpxdzUfASgUp2apvyYUrZ0sKvE6oTZWJpE9iM47CzY0ci0HtzRwu0JsTvXC9XR+RI+nTrqI7IgEL1CTbShYE0r9YY1JO1duirAvjO5uDcqbLP0dPats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAjCQZWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21021C19421;
	Mon, 23 Feb 2026 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890234;
	bh=93yOoSlX1ZbKvqtkXrOB3tX1+IaZnGCwtgsNrVh/ZXc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mAjCQZWXIotFKjXJD4sFa4iijRg+h2TgAs2iuylUGwMOD9wwAGcsYeqHnqA3X51zF
	 3Id8dAE6KzDCeocEdl1rUiFwoOMzjb/VTLvn4Dcr6UCVnvwXgfW2MsX+Ob0y8+UdLC
	 1GmkKw1qh6qaXSKCkS5A8q5JTWkwQoftX9ynqFyPrde4jBTZtciM9WWbWLjUQVBswm
	 53GlectwGGXWSZkxMIsWQIrUeUJk/ATmjsBtUCv92PIUTRG0e/yl396K6vmsw7jcCW
	 XsLuQ5hoe5cc0ypuk3assU+GPqhOSzB3EysTWF39rd/pBzKRYPbRvFMpKKGe8BGpC7
	 4GWiAZxrzP67g==
Date: Mon, 23 Feb 2026 15:43:53 -0800
Subject: [PATCH 10/10] fuse4fs: increase attribute timeout in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745360.3944028.11322763576372286877.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78183-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB8C017FF5C
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, we trust the kernel to cache file attributes, because it
is critical to keep all of the file IO permissions checking in the
kernel as part of keeping all the file IO paths in the kernel.
Therefore, increase the attribute timeout to 30 seconds to reduce the
number of upcalls even further.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 8ba904ec2fc9d9..0f62d5a04fc4a4 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -123,7 +123,8 @@
 #endif
 #endif /* !defined(ENODATA) */
 
-#define FUSE4FS_ATTR_TIMEOUT	(0.0)
+#define FUSE4FS_IOMAP_ATTR_TIMEOUT	(0.0)
+#define FUSE4FS_ATTR_TIMEOUT		(30.0)
 
 static inline uint64_t round_up(uint64_t b, unsigned int align)
 {
@@ -2158,8 +2159,14 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 
 	fuse4fs_ino_to_fuse(ff, &entry->ino, ino);
 	entry->generation = inodep->i_generation;
-	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
-	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
+
+	if (fuse4fs_iomap_enabled(ff)) {
+		entry->attr_timeout = FUSE4FS_IOMAP_ATTR_TIMEOUT;
+		entry->entry_timeout = FUSE4FS_IOMAP_ATTR_TIMEOUT;
+	} else {
+		entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
+		entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
+	}
 
 	fstat->iflags = 0;
 
@@ -2392,6 +2399,8 @@ static void op_statx(fuse_req_t req, fuse_ino_t fino, int flags, int mask,
 	fuse4fs_finish(ff, ret);
 	if (ret)
 		fuse_reply_err(req, -ret);
+	else if (fuse4fs_iomap_enabled(ff))
+		fuse_reply_statx(req, 0, &stx, FUSE4FS_IOMAP_ATTR_TIMEOUT);
 	else
 		fuse_reply_statx(req, 0, &stx, FUSE4FS_ATTR_TIMEOUT);
 }


