Return-Path: <linux-fsdevel+bounces-62302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC8B8C2D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3E256837F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEF2F0C75;
	Sat, 20 Sep 2025 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jaQK8cKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59D288522;
	Sat, 20 Sep 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354489; cv=none; b=IwbLeGg0ZZizBQB168vx3JcceBLAv1H+JABlTfx8g046TEZ4+kzegZTFkdIwfLfk1BRfDnTFeXIAILt0e8khI5fQmfwSz+M8X3aHnb3CH/FIn97mhc+6lqmddT1yUQ9EpK1V/4iOVXHbA+lEdbpgIJNp5qDQC7vHFze1cREU/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354489; c=relaxed/simple;
	bh=soHi416DSE0pnYSMl4YmsflCDJfcWBHwcCLNR5cniFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iunXyyRV7CoSivo+8qDvPMw9WyTKU9tY52WUURJ/DftUKmkpvnabcNUfZb58YCRmp6z+BRTimxtDPUIUvxG5BCq20iV2EIlW2D12FUF78xjWOWpoc/Ej7+rjYwI7fsbgrvOanhr61yJCttqm2dqd+T5Y2zvRuEjGu6Oi7vH3xeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jaQK8cKf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=09KvsjW0ORXF5yAgFsWr4BmJpUanJ8JfB+m1F7eGQps=; b=jaQK8cKfGBnniJ4xeduBuQ4mdy
	Z8Qh0j68aqBnrjxEeoVTW67vl2L9GR+wcjUmE89Mle6Q0bb7rqeHVynY9bc9tpgu5c4WmNLaHTz8X
	pFRwaQvcdhRslmEdhfemL9wmhLt/ZRnjNK8/6wVMphnzkYT81oAUr3WBFPmzUNXaKcTJoPn5wwBwc
	3gT57+VI+M0C00eOsH5pS2UWTzhm3bdqs39h/XrVkl+cBOEFT7NpLQAwdCOKXhmimfGv9/rNxJhf8
	Nk/W5J5B2wgPV7mcNvQdzkMn0mOJWtnkhY+5Q6eDuX1azINcV1hEDsPAZ76dQYgApjHI3y0T0qVvI
	VWGDlqAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKC-0000000ExGw-3OF2;
	Sat, 20 Sep 2025 07:48:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 26/39] binderfs_binder_ctl_create(): kill a bogus check
Date: Sat, 20 Sep 2025 08:47:45 +0100
Message-ID: <20250920074759.3564072-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It's called once, during binderfs mount, right after allocating
root dentry.  Checking that it hadn't been already called is
only obfuscating things.

Looks like that bogosity had been copied from devpts...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binderfs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 41a0f3c26fcf..bb81280a3e9f 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -395,12 +395,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	if (!device)
 		return -ENOMEM;
 
-	/* If we have already created a binder-control node, return. */
-	if (info->control_dentry) {
-		ret = 0;
-		goto out;
-	}
-
 	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
-- 
2.47.3


