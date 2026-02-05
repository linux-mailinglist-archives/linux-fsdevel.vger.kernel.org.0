Return-Path: <linux-fsdevel+bounces-76369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKyKBLtJhGk/2QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 08:41:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F892EF835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEED30071E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916135CB6E;
	Thu,  5 Feb 2026 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s7jg/jWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DF334C08
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277302; cv=none; b=csQFdvt4TIWafiB4qaSr/+DTACoUM/Tugd92VIv5rlsaDAfbkIn7l+Y6BI01xAGqSghY2Fs6mkYtLGFeJXtegwkospM1GrSnbyVOG7GEAYIkskMLm3VVTKXirAvZikyR42km7UoroGTWGVfYNU8NtG6YuCJXkoVnPX9sk2cr/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277302; c=relaxed/simple;
	bh=cXHCOvajtVYiXqTkJTybg33SpPIqnOy93rzrlC7CWy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MbAdDlnCX8ZX323WF40RsWiQXKHSoQfDf1+9CY076Smj+q4tGXUb7sb+lu+3hG5TEYcS/YOISoFkrmE4rrRUuqw+lDr63FYL7HjcJJklNeuVauQKu7B16oYUtr/mB0Q9/bexKjnP5LUaW/JDYYjtjYtZgbYk45/g3frkAh1oW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s7jg/jWf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6idPeOukR7RDsihHW5LjfvXzJnxIbS62IKiT73Yy394=; b=s7jg/jWfsb2tBk9e8MCpWBXn9/
	qtyPz4K+WGzagXMZ+wHEj9ay51M237LU+iSYAwE0SYjwl8OXf2tO2YYLwxeBKv/R7d2tiVhXinYDa
	E6BZqho+sUo9c8E+xlLlwfuXjOq0OPZrG8facunptY2X07kO1+3xvhqmnJfhoHlqHHVouHPvPCW6t
	fbS09Swgcdhr1rlgpaGY3zgbAvHX70Vm6JSUj5sbd/mVj4mqw/Ysjbj1mgzm5C7AkxzfWpupccKep
	b/ekwY9IMbTZpqi4NcEzqH005fGN+H4UKg7y6wMfJG9+hi47x5htfQI95K0UIgkvOix9l1ComIdvx
	ctpXC6XA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnu1e-0000000AYQz-36ro;
	Thu, 05 Feb 2026 07:43:42 +0000
Date: Thu, 5 Feb 2026 07:43:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH][RFC] rust_binderfs: fix a dentry leak (regression from
 tree-in-dcache conversion)
Message-ID: <20260205074342.GR3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76369-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F892EF835
X-Rspamd-Action: no action

[just realized that this one had been sitting in #fixes without being
posted - sorry]

Parallel to binderfs patches - 02da8d2c0965 "binderfs_binder_ctl_create():
kill a bogus check" and the bit of b89aa544821d "convert binderfs" that
got lost when making 4433d8e25d73 "convert rust_binderfs"; the former is
a cleanup, the latter is about marking /binder-control persistent, so that
it would be taken out on umount.

Fixes: 4433d8e25d73 ("convert rust_binderfs")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binder/rust_binderfs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index c69026df775c..e36011e89116 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -391,12 +391,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
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
@@ -431,7 +425,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 
 	inode->i_private = device;
 	info->control_dentry = dentry;
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+	dput(dentry);
 
 	return 0;
 
-- 
2.47.3


