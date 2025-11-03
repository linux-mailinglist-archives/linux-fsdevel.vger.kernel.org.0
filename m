Return-Path: <linux-fsdevel+bounces-66735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE91AC2B614
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008694F6754
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40930305061;
	Mon,  3 Nov 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGnAQ3tR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D17304BB4;
	Mon,  3 Nov 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169234; cv=none; b=YLrB3k11LyUx/8X0/B7Hg0S6c4Lya7KP7wivNE7HqxKZ6xHvjHWG0J97EOVzNL29fGwu95uYLRaZzRtDlQ68XHXJDy/4dA2XE0u22VdJT5GdtuxXvD3uvT+prslwiX6gUSekuK6ceocmQxItFg7/IKrn5GsIpjdbGEfgnFApmIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169234; c=relaxed/simple;
	bh=VcUIGwwKN/fhXkDTSmha7C+Rr/wXO/1VNsCTsLfj5Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsS7UiHAMMyiHP0b1T9CdbCefhDbPFPKuEeWxaDgN5E6TWqTWjERoX0bmgAp31mNKiTa2DkRWW06uBHom2YdmzZ/jpZ2cko3lOyQ98hI4H7d4ie08+n2eDoNRRYJ8OpFsK1CigdQ/18LXJKTw/nI9E7xQn9MnC9yEA5SX4s/b5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGnAQ3tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71722C4CEF8;
	Mon,  3 Nov 2025 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169233;
	bh=VcUIGwwKN/fhXkDTSmha7C+Rr/wXO/1VNsCTsLfj5Z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IGnAQ3tRPPjorQ1+iD6J8WpE2snil5nXhlYYaMzMblC27Q7UW1C8AUCNkhTTnHmXB
	 ojpglavzAw+t7jnhjOOKrx9FgI8J3v6b1yj54L+7I7QGmMWwbJuwjf0EK6tgMoXOP9
	 Ln6zCdjmMlbCeXOKTzDRpiGH+o+4Oflmm6UMSvDT2G8VsOMkO01JezyGV6I8IrczaX
	 cAhLr8VJSQFB1BDpdoSNdcEOz01LjdagIuipmDSHu6PXHBFcl4xH9qgiSwQlcJq9x+
	 wBteyF/8mfMS8WG4rFcgzyVYXm7b1kaP5ppeCVQCxt0TOfrzSXjpdsIVXMnZoH+wKy
	 Cijms8FKajLOA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:50 +0100
Subject: [PATCH 02/16] aio: use credential guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-2-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=925; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VcUIGwwKN/fhXkDTSmha7C+Rr/wXO/1VNsCTsLfj5Z0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGx34UuK1y8Wn/fcvmTfbgm2oJ3Rc9hyGCcu6knct
 GCXTrtRRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ25jL84Qx9qzArhc+RXZhj
 5Z3Lq1eYP7C/eGoZWwtvAtfjurrJaYwM7/3/v9Q8HpPxIqeDceLPo1ZfbuxaZBP6Wp8ndtW908r
 CLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/aio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5bc133386407..0a23a8c0717f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1640,10 +1640,10 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
-	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
-	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
-	revert_creds(old_cred);
+	scoped_with_creds(iocb->fsync.creds)
+		iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+
 	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }

-- 
2.47.3


