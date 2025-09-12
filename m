Return-Path: <linux-fsdevel+bounces-61125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638ECB556B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26082178AE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BD334731;
	Fri, 12 Sep 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sApHXyVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3631691E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703559; cv=none; b=nS4UN+AVMdO6wc9La4goCvhJ5OoHYUhyT3gl6RLtpnH4TJvh4sIncNplnK9Wam9Cx6gP4TmnRO748R6Rb7LGffLnZTx1JwdjRUlmJbWBZ3IO55XhZxH5GAGWxoPRVuZ1Cpch0fo7MnNgfG8rTzbrafWfbSLDr5L0C7IRFzPURTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703559; c=relaxed/simple;
	bh=lR10101o2F2e90STPUxn9dvKmy899EtrDhLantnzMr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfRbKyTAc0ivW6nQf/F/olEPa/zwsxQl3CRrr1idgN9ymSZYTS6Qym5DzONo1yzNeiYePhf+2+rzWLHhRO52qj+5BAcwuqVHWGyarr1S87Mhp16QwsIs8nVHDy/qH7mrkPXvo+cL0nGCZn0zEqJXH6TxH1MyT7J4Z87vkhMwp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sApHXyVr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XvYYvTY7PrU8vWV77PO7qL33KJuBz2lmT7MdI3oMTAk=; b=sApHXyVrSmaH5NwY7vtNlz6PBC
	YwVAPgHRK1MicsjKVL4dGbHuyG+SSN7exlU03Mw5u+SUC//AgrxFEDQ8Tzqqe8TyNwQ+a+oPcwQMj
	y1TlR0Fv71dj3Rdqe98432uZnaz4T282F5/zVN8Bt8YsDkIfRPKPFgEPjgFHDCxLoN5OzVpnikuoE
	4z5XLwyw3kF1bP7Oo/ra1RB1cNPuozq93c3AtAjiL/vh7ntIGqhuz8z17ahpq5ZTIxCzYjHMiFPNB
	qJ7lv9NLF7EhdJuFUeJppb4Px1gwJE7oXDL4cRkLWgKqes10E49BE9amVk+FXI7W78up8aWlDgfdR
	GBHgGGWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zM-00000001g5a-2PUk;
	Fri, 12 Sep 2025 18:59:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 1/9] allow finish_no_open(file, ERR_PTR(-E...))
Date: Fri, 12 Sep 2025 19:59:08 +0100
Message-ID: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250912185530.GZ39973@ZenIV>
References: <20250912185530.GZ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... allowing any ->lookup() return value to be passed to it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/open.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9655158c3885..4890b13461c7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1059,18 +1059,20 @@ EXPORT_SYMBOL(finish_open);
  * finish_no_open - finish ->atomic_open() without opening the file
  *
  * @file: file pointer
- * @dentry: dentry or NULL (as returned from ->lookup())
+ * @dentry: dentry, ERR_PTR(-E...) or NULL (as returned from ->lookup())
  *
- * This can be used to set the result of a successful lookup in ->atomic_open().
+ * This can be used to set the result of a lookup in ->atomic_open().
  *
  * NB: unlike finish_open() this function does consume the dentry reference and
  * the caller need not dput() it.
  *
- * Returns "0" which must be the return value of ->atomic_open() after having
- * called this function.
+ * Returns 0 or -E..., which must be the return value of ->atomic_open() after
+ * having called this function.
  */
 int finish_no_open(struct file *file, struct dentry *dentry)
 {
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 	file->f_path.dentry = dentry;
 	return 0;
 }
-- 
2.47.2


