Return-Path: <linux-fsdevel+bounces-66031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944CC17A87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187C91C829E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B362D6624;
	Wed, 29 Oct 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpCVlQR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B733993;
	Wed, 29 Oct 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699151; cv=none; b=HLHaNKJVGXd3EEDnDO4/9a8wIzg5fzEtUp6zduY954iJRfhHD11T79h0GWNyN3x4R8+1i6WrqQktYO2Ja/MFIcy60yLNKBE/UUtgGGhGWn+Ovuo1G4L9NXeTd7EPX9n8pgjz374BLewwEKsANj/KlYe6KSo+Jj2OKni0xHmVOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699151; c=relaxed/simple;
	bh=X+p3cwZYIvR1aWEh28CbOcaQMblOMheV/P+4i2+0ceA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgN8t8P9iEAPjtgeoA0Ohw639ZGkjmTnRzodJ56wJ01f/Cx9b8FjaFi93cCKi0MgpLoIQZPQVkEULeeLnBy4kPn9mmiQo+QmG/Mq+hyRUGOKEafqwAomWR2NHsfA9RYtCqSY38t2NgMwMPZpCP2Ef+3DiN0OnPVcHybbPg7l6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpCVlQR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9FDC4CEFD;
	Wed, 29 Oct 2025 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699151;
	bh=X+p3cwZYIvR1aWEh28CbOcaQMblOMheV/P+4i2+0ceA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZpCVlQR/g6BhAziwGZiroo1/aRMQFPUMFSiGvvIR/I9jgLTEmJXnVB7pvb93dBLda
	 pNgJ3OEMD+Qc+g0B8ImuCFRQAdUEMl8GW5GlL8EZDhrtMYW/P2GtgnA832QYaNXQhN
	 6riOlQsXF8o/SUQCkfsf87AfrdNUwEllQx4EnPUMatVwIj4ESm/Bui5P/cYGPvPy+3
	 t5GTLpmHeMBVaorY5VqXpc33TlEdAv+Qyk0aNLNBm3CHfUVgqPFMMipRtkM4OAsFuk
	 cG4fosANv6qIHPtg0+Lgb2X9V2t4V9ogXo9Ek2ZyO1u6SV7MgN0ttr+UY9JOob3UjD
	 mQmp7X0NJ1/HA==
Date: Tue, 28 Oct 2025 17:52:31 -0700
Subject: [PATCH 29/31] fuse: disable direct reclaim for any fuse server that
 uses iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810980.1424854.10557015500766654898.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Any fuse server that uses iomap can create a substantial amount of dirty
pages in the pagecache because we don't write dirty stuff until reclaim
or fsync.  Therefore, memory reclaim on any fuse iomap server musn't
ever recurse back into the same filesystem.  We must also never throttle
the fuse server writes to a bdi because that will just slow down
metadata operations.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index f4cb9dcde445ef..9dab06c05eee28 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1016,6 +1016,12 @@ static void fuse_iomap_config_reply(struct fuse_mount *fm,
 	fc->iomap_conn.no_end = 0;
 	fc->iomap_conn.no_ioend = 0;
 
+	/*
+	 * We could be on the hook for a substantial amount of writeback, so
+	 * prohibit reclaim from recursing into fuse or the kernel from
+	 * throttling any bdis that the fuse server might write to.
+	 */
+	current->flags |= PF_MEMALLOC_NOFS | PF_LOCAL_THROTTLE;
 done:
 	kfree(ia);
 	fuse_finish_init(fc, ok);


