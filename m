Return-Path: <linux-fsdevel+bounces-78282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMugAXTJnWl9SAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:53:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B41895DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD753071A7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD83A63F2;
	Tue, 24 Feb 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv/V5M0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5003A63E5;
	Tue, 24 Feb 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947998; cv=none; b=KvsKUoFMNWLcQY3Sckrvyc//ZcbL45OeSNV+bmniTz49nDAnoLyUHQy497CZ3yrU612t5xgxFbGZGA+RKiWIKdRVsCaqArQFx3kxsmDAZgdNVR6gBmz0LciLVd5N95E9gOGFN2eJQkB1QkU5SKcwcE7MIauYthUXeLdGmbxSl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947998; c=relaxed/simple;
	bh=pgNWTALCG31c8QV/yBVOrazzlcOyBJhDOZW21qXbjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GymaRbzZRyP0pvuBbNtXCRUKMK7vy+2HoCdRoFfIfM1BtzW552mGQRTDNyyAARY3tNFy4BZnsULKrwjuJ45CwQNUm1PhKSc8b/wCbLykAgNHRx7+kKTJiDiSL/DWwxGa8z52PjD1B2IdQwy78HspWF1r8HkkQ4AU0akR8/KAtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv/V5M0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F43C19422;
	Tue, 24 Feb 2026 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771947997;
	bh=pgNWTALCG31c8QV/yBVOrazzlcOyBJhDOZW21qXbjhI=;
	h=Date:From:To:Cc:Subject:From;
	b=Tv/V5M0VxLy+PjeHfd02WY7DFNUhs0MVccD+Ru9neqlRi7/flV8FFCJ645OjtWV/a
	 o8n7vPRCm27DNK9FqvvgKwEsDddiE/iM19zZ/agnVKJ0eqU8rvOfoXU7tQWAspLxW8
	 1Qb1c7O/joB/Nmpqngk/YfJSKsyDULglkgMRiMIHEDpXAp3ixDiU45vRHgiWYz5fJO
	 Xt9Q5uzq512bYlm1n/2r3zjBfVOSsS1PfeZIq5LBiXbpsGNcEb90Uof9+rOEwtuQ5g
	 AfT+KCqyMnnhRpPX8xaFAYaHxbgJwwAeDPXwvNDrRonRt1ehPvMbSjqWVfU4ikyH0U
	 +jodJbE57a/8g==
Date: Tue, 24 Feb 2026 07:46:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] iomap: don't report direct-io retries to fserror
Message-ID: <20260224154637.GD2390381@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-78282-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C7B41895DE
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

iomap's directio implementation has two magic errno codes that it uses
to signal callers -- ENOTBLK tells the filesystem that it should retry
a write with the pagecache; and EAGAIN tells the caller that pagecache
flushing or invalidation failed and that it should try again.

Neither of these indicate data loss, so let's not report them.

Fixes: a9d573ee88af98 ("iomap: report file I/O errors to the VFS")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 95254aa1b6546a..e911daedff65ae 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -87,6 +87,19 @@ static inline enum fserror_type iomap_dio_err_type(const struct iomap_dio *dio)
 	return FSERR_DIRECTIO_READ;
 }
 
+static inline bool should_report_dio_fserror(const struct iomap_dio *dio)
+{
+	switch (dio->error) {
+	case 0:
+	case -EAGAIN:
+	case -ENOTBLK:
+		/* don't send fsnotify for success or magic retry codes */
+		return false;
+	default:
+		return true;
+	}
+}
+
 ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	const struct iomap_dio_ops *dops = dio->dops;
@@ -96,7 +109,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 
 	if (dops && dops->end_io)
 		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
-	if (dio->error)
+	if (should_report_dio_fserror(dio))
 		fserror_report_io(file_inode(iocb->ki_filp),
 				  iomap_dio_err_type(dio), offset, dio->size,
 				  dio->error, GFP_NOFS);

