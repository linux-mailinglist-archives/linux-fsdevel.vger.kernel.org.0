Return-Path: <linux-fsdevel+bounces-35685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F959D76F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C419DBC4A3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B93209F42;
	Sun, 24 Nov 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG/xtGVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3111D63CF;
	Sun, 24 Nov 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455877; cv=none; b=kZuxoUw3nr/+NGwG6q244xOF9NC5CsamErNFER9NSNDo7SjVuQ5+lehy1nV1plmlMq/8KrpJYvBpz76A6CncSRPAb4wDm2ps9ocrUq/ignau9i2tHZkcF1NBzecOE9NrdGM/x2CywL3lwKyx7T9A04OCeIXpgu0nAAJi5db0pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455877; c=relaxed/simple;
	bh=5BZqSEtfHEZtuwJx5SewGy8hXt5AEF8UkUzuAtgQ7MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu4AtX5ykOvkywi5VqcY8hBwTGaUpBkIRLZgTSgM4MMR2BAATfRq1ewe3BIrHBweFeFZE5x6xOvhUuWuCmCkMTUqtsMIE3pCZ1Xks+P2JBPkoDqZ2LfEhMe+HhEvYhpNvzA2tR7TC8IBn1YGYlbldwVOWpkCn54CFI+JtmBra2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG/xtGVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD84C4CED1;
	Sun, 24 Nov 2024 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455876;
	bh=5BZqSEtfHEZtuwJx5SewGy8hXt5AEF8UkUzuAtgQ7MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rG/xtGVDH06HE1ilf2qXSYqvCpFWpW5SeYMgB6BX71IMv+lteG8dNKkBtgDQ+grBI
	 /H3QIIsUMoYyJxSzK2CkinyoPK1qQ69scnWptLeHeQuFulFnro9/h28JnBLxHMs004
	 HNl4Ket5BNxo3MzJv2EbldS+fHcXMT3aGqofO2YEVgP51EfPI1pnwziqQGjQJYRet9
	 +5fPaxqT7xsxweWB7p0L1JqsqIbzUjlQLCsUlCGtDu0aU4F4xpQTc/KmT20WkZ3qNe
	 WoiAx79A8Rn6mVFCUtFYXnJhO+dwDtbfvfWCea8pneSmAf8vZ0GHw4KlZmcxD7EPfY
	 sHS2is55pAXjg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/26] aio: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:43:56 +0100
Message-ID: <20241124-work-cred-v1-10-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=brauner@kernel.org; h=from:subject:message-id; bh=5BZqSEtfHEZtuwJx5SewGy8hXt5AEF8UkUzuAtgQ7MI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7686ZcOrmgZ7jxp4tdyqafdv8vxxkVTrwPa5RfM4k2 7qEWbuSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS0c7wVzR+u/vGH29PnL9i +DWi4Fy60Xl5Y8c2S+NfV9Ka7hYf3sHwh/+b7qkPJdcDnkiFs3qc+WbO/lViZ6C74S1JVZtUnj+ vuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/aio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5e57dcaed7f1ae1e4b38009b51a665954b31f5bd..98eb0f5d0ee49c564d87f9050d304c5a99130445 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1639,11 +1639,10 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
-	const struct cred *old_cred = override_creds(get_new_cred(iocb->fsync.creds));
+	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
 	put_cred(revert_creds(old_cred));
-	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }
 

-- 
2.45.2


