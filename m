Return-Path: <linux-fsdevel+bounces-51654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB9AD9A50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7279A189CA37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1461E5213;
	Sat, 14 Jun 2025 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uOl8TBKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC011DE2D8
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880954; cv=none; b=k6vyc4LWMna/jUVgdDUCI5vAVemiVzzbrN9wlW+7AWJxQvAOi5QFhRtrDMKCJEVSDrwhH0BF8AYNRIYbMYxIS+NP9/utfbKUxxqp2s/Q+jG/jH6aGzNNrGe/rLrKmQwHIG8xNvNytQksxLnxujGpI87gS5YX7DBkYsTkKdFGTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880954; c=relaxed/simple;
	bh=P2OMcl9Mw08LsHKwQxld/M4/gERASbKAh/7FXgmwuYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLyy/2jDCLARdZ+ifPWx4KDbAXWL2cCKMiGO7P07/y88dWAK4utRhdNmFwx5Vot9WEPqOXPHFFvTQP4WQglg7E6eZocOZAMJZXOR3gKqkxGY4z6zSLSkU0bJNjmnEA8G3/gdEz9qRA55MyDZuQ+ItiMG4Dopl/mdSNPot5yN8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uOl8TBKC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4WEbTTzGIc9M/336WTmmFjEORii//S3bF/Bo+dQSZMU=; b=uOl8TBKCmvlDAM7wlMd9BKWzgg
	Y+49At3FaLtYRFS5pF+zXZQgX5FBK2RBy3DaFqxILRREncFvfBmmZiQM0xehS+GN8c+xVKL7XusjJ
	Q/+OSSor5vJM8Nyab82acUbxhDy5vqFoxptm9V2yyI4Z8IwRfN9MKkOPRnvYIuSX3WTZhbPxGSvZq
	Y36keGwSu1AWnvoRwvy0hxDuS94wzqvFtu6n9/GF5tiNQO4Ul1PSK0X2buuWzW726tyh/7CXakx88
	pO0gMowlGiQ5v2M2mR94syx1KA0zjcUVWZGRBZQdhJJR04Z6OhI6GFCIHQbUPc1D3Pcp/srxAwJcN
	JdyJ27Dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyJ-000000022qL-2Ejr;
	Sat, 14 Jun 2025 06:02:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 5/8] pstore: switch to locked_recursive_removal()
Date: Sat, 14 Jun 2025 07:02:27 +0100
Message-ID: <20250614060230.487463-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

rather than playing with manual d_invalidate()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pstore/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index bb3b769edc71..93307e677f91 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -318,8 +318,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 		list_for_each_entry_safe(pos, tmp, &records_list, list) {
 			if (pos->record->psi == psi) {
 				list_del_init(&pos->list);
-				d_invalidate(pos->dentry);
-				simple_unlink(d_inode(root), pos->dentry);
+				locked_recursive_removal(pos->dentry, NULL);
 				pos->dentry = NULL;
 			}
 		}
-- 
2.39.5


