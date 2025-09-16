Return-Path: <linux-fsdevel+bounces-61778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F86B59D74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9190117788C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E8374261;
	Tue, 16 Sep 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jlQuqEVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2D317708;
	Tue, 16 Sep 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039770; cv=none; b=g3JrvHy36Kitm0r5eF7+0GyOIs6j34sqgxDZF36kTNGDEsViDvPpdU0EwuYBD4va6U3qg9B6bWCqHgIh4HSzyAqdg32mTl/ulTJ/Q/EeYlYvR5O+ceCQoJwJc6KKF/tdS6vY9FJnhby0WgRroCDxVIbtuBdrfYlb/wGJWrwNM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039770; c=relaxed/simple;
	bh=7LsBV4e3Rnk8wom29SyP++Te8FODni9lRbmx/oTx8tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NGCtJOCvJeQdRCl5UWt/OFNR8x2AJwj3vTL1PXa5+wRzu7mr9+O41mgOFBUIOwQMeQiPN4Gt/yZBr6UyQ1b4//svzH8LgwEI2/AHvzeiXXDksdx64bYjxNXkLxiQuvn2g3ta//dDUC/nAUD4tYdoalw46CmF3RD3awhkGawW8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jlQuqEVk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nxevTbftj4dI8i0qJa3Ef5NsErX7ynlC5NtJtiuvFWs=; b=jlQuqEVk1YvmsLuFVKjm1wVW1c
	oNebOqc2almtek0xtxPr9AsDkiA9n3930DlRaxy/hJYDD+Q2u4XKzqdjrwr7qvoRe/qtamT/RAtPf
	ujqrOBF/t/S7eJBmifgcSZFmxy5C04mDFU96hHwxX7WarNxB/ddrSpHPQYqrS9hX8MplBbKx4S6y+
	529qszd1BbR6ChXLl2F3O0nMGMSFRwKFGetBiHdSBqeoADhv8IhzWoM3h7lkCE12udC7cUSaYp/6P
	lrgnilMkpLF+PnxJyBYNjQoD8whpE+RJ6I36B/EqRsHX8YIyg6/eOFXkQUOI76wQ7g0sDQq0mJX7Q
	txK21XFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyYS5-0000000FAKd-0DSq;
	Tue, 16 Sep 2025 16:22:45 +0000
Date: Tue, 16 Sep 2025 17:22:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-nfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>
Subject: [PATCH] nfs4_setup_readdir(): insufficient locking for
 ->d_parent->d_inode dereferencing
Message-ID: <20250916162245.GR39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Theoretically it's an oopsable race, but I don't believe one can manage
to hit it on real hardware; might become doable on a KVM, but it still
won't be easy to attack.

Anyway, it's easy to deal with - since xdr_encode_hyper() is just a call of
put_unaligned_be64(), we can put that under ->d_lock and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ce61253efd45..eaa1416e0e32 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -391,7 +391,9 @@ static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dent
 	*p++ = htonl(attrs);                           /* bitmap */
 	*p++ = htonl(12);             /* attribute buffer length */
 	*p++ = htonl(NF4DIR);
+	spin_lock(&dentry->d_lock);
 	p = xdr_encode_hyper(p, NFS_FILEID(d_inode(dentry->d_parent)));
+	spin_unlock(&dentry->d_lock);
 
 	readdir->pgbase = (char *)p - (char *)start;
 	readdir->count -= readdir->pgbase;

