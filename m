Return-Path: <linux-fsdevel+bounces-51558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD89AD841E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB6A7AAF17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB212E1759;
	Fri, 13 Jun 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iqXyPSDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A62D662B;
	Fri, 13 Jun 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800077; cv=none; b=huL453GoNofL2lR7LRPAW4gTlRVowxav3Cmyxhem+fHOyr3ZazZ+7xxyklVxXZXayLoYUly96CdHuSPMO9cPGm/k4ZnQwsGnS/V6ZzvXbxLpAXguYGp5TBxp4j8HPDAI5lIhd2E7eTdZ48AarWbvvwqQKDlDdFt1CncCrK7R6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800077; c=relaxed/simple;
	bh=LJu1OY3fvPIFXU4lCCF00oqI6kjeuHvxUnP3ly9W5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGtWgLYYGMHO4clhh2ltauTPHZ7EEc3GaIiEiqDignVwfMamq8MjNcf1bVThuyZaaGovxcqJHsPzw8Mdka5nnFCQE8ncyrytzz30igcJyW+BO5uS1AAQNIGBp/Ctyj0e7ElquV/c51eyUjrsT0aG3mgEmQgML1FwCcq9UcsYI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iqXyPSDg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wr0H5jh3TZJ0zV7oltYvQB4G1eh/qrqcOY7Bhi9PWLU=; b=iqXyPSDg+85WJ7PMiC8gxJ4sXi
	oC4Q4vij95fPGIFXs2aaq90Nrbn0IrTx69KgG9J/ORLQp0pE+vyur0bIZQA5ldZ4NqmUDGSS+d7OX
	B4IOwb4/LdJdhDEAlYOD3xeFJ99sYbiMRNbnxZ7YHcnL1oh3HAS8rsIjhzl8cAH1FBN3++jzf5ufm
	9YjJs7eMsfNVLyWru2sOzcs0RonujA4J3BxZQnTi1qwhthfQ/P/Vm4auZj9PJC+3W66ZAzNJlNRR9
	4Dd6jQLCT4NpLEouZxiV1UjuTqBBcIf3G5aUGTG6w/S2zupFDp6JhN2j+L/OCTZuzoPTtrpuCvgIJ
	U314LzfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvo-00000007qpE-3vys;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 01/17] simple_recursive_removal(): saner interaction with fsnotify
Date: Fri, 13 Jun 2025 08:34:16 +0100
Message-ID: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073149.GI1647736@ZenIV>
References: <20250613073149.GI1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Make it match the real unlink(2)/rmdir(2) - notify *after* the
operation.  And use fsnotify_delete() instead of messing with
fsnotify_unlink()/fsnotify_rmdir().

Currently the only caller that cares is the one in debugfs, and
there the order matching the normal syscalls makes more sense;
it'll get more serious for users introduced later in the series.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..42e226af6095 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -628,12 +628,9 @@ void simple_recursive_removal(struct dentry *dentry,
 			inode_lock(inode);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
-				if (d_is_dir(victim))
-					fsnotify_rmdir(inode, victim);
-				else
-					fsnotify_unlink(inode, victim);
 				if (callback)
 					callback(victim);
+				fsnotify_delete(inode, d_inode(victim), victim);
 				dput(victim);		// unpin it
 			}
 			if (victim == dentry) {
-- 
2.39.5


