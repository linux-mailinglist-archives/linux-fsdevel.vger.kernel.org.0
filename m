Return-Path: <linux-fsdevel+bounces-28040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF5966299
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6703F1F23150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6081B4C35;
	Fri, 30 Aug 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtsDommX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C971B4C33
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023185; cv=none; b=Qk89Z0sCdIX89T3hKMV0OBvuyNRMMeue+YUKUORoXNhqWRJnu3E1y/uoFWXsqJp3g7Abl8tA0mO/q1xhjvLOx4Jq19C7DZLlvYIP9omNg2yhtLqpFmzqDqqL982rfgImAiIG4ka3qdfPmishPgJRqcp+s7yIWS3RzSOMmG9Dzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023185; c=relaxed/simple;
	bh=hC6hPuH2LomzSUd3WOSO5wPh2FCfHtQOP1NTqJrdxEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bVIVkUXap8h5Y6Sy/Ze5p9YXOKpdf3ziOjinIhqLlJEHWz9DhN3gUq/I/zrBHyZ1qtWqCl2pAzwzACTATnB94zWEl8sS9jsim+itQrCKPM05qmWuIvaCCzidhb0J9sxWThv4284Z1Eyq2NkQtFbXo4K/TmgTuyXlMbCVxoT963Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtsDommX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D79C4CEC7;
	Fri, 30 Aug 2024 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023184;
	bh=hC6hPuH2LomzSUd3WOSO5wPh2FCfHtQOP1NTqJrdxEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LtsDommX4Ehprldy4yFJQ4huifBysNwG+d2ZsJ/Uix2D3qghGSTfKeedjxplzj7QM
	 c5w2xYzEq7eM8NpZAiULB+mmjmH8Lcng9sVcYjsuY/hw3JjzQ0dORlDyMR2smLYTgW
	 CauCRoj9RNsqAbOwbhinZCSpnZW34gr+GpZv9gYX40Sbsf9Kxc5fNFnB0ZDHk3i5Uj
	 0Yl++HuS+Hb8JdbKFkpIdxRvvGlbI0dcity1is8YI1bsIFN+qLVg0rmSOgxbLGMjuq
	 SbhZ3tTFA6yfgOes2x7vw4NqaEEExqQkm7bnnFPMFocq7yzTqDGen6+zuHUdgSrzqT
	 hdNQkESHAyeUg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:59 +0200
Subject: [PATCH RFC 18/20] fs: add f_pipe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hC6hPuH2LomzSUd3WOSO5wPh2FCfHtQOP1NTqJrdxEM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDyXscWsyToqINvZ5+lEf+PFm5Sma67f63bx+GZtL
 eNTUdstO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaybBHDH47E0tc/vbWPJ3iV
 Xrr657BBT6D7p12zeJuW8nWKvrzs/46R4QLjY+kvK3ZYL97G/7iurSNwQkDSl/evevkmVtVJnPo
 myAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Only regular files with FMODE_ATOMIC_POS and directories need
f_pos_lock. Place a new f_pipe member in a union with f_pos_lock
that they can use and make them stop abusing f_version in follow-up
patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3e6b3c1afb31..ca4925008244 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1001,6 +1001,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_cred: stashed credentials of creator/opener
  * @f_path: path of the file
  * @f_pos_lock: lock protecting file position
+ * @f_pipe: specific to pipes
  * @f_pos: file position
  * @f_version: file version
  * @f_security: LSM security context of this file
@@ -1026,7 +1027,12 @@ struct file {
 	const struct cred		*f_cred;
 	/* --- cacheline 1 boundary (64 bytes) --- */
 	struct path			f_path;
-	struct mutex			f_pos_lock;
+	union {
+		/* regular files (with FMODE_ATOMIC_POS) and directories */
+		struct mutex		f_pos_lock;
+		/* pipes */
+		u64			f_pipe;
+	};
 	loff_t				f_pos;
 	u64				f_version;
 	/* --- cacheline 2 boundary (128 bytes) --- */

-- 
2.45.2


