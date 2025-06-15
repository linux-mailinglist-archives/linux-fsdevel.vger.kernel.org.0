Return-Path: <linux-fsdevel+bounces-51673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81071ADA065
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B740A3B5EC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B823741;
	Sun, 15 Jun 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YeNDPnqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EC4400;
	Sun, 15 Jun 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947416; cv=none; b=G1trx1jT7SjCd3jLTojPILDNDOYFZavGZPJkAz6/2bQZOUiGxkjx29kYEoJ10WepQyGrk2S3H8qHqQBnfWyRivsKrdpWeVVIb26IcNYKebyCaFverV2SiFPMf4qM1v3Uzn+FCTG1HamqYGCOKFJ2Hi3tpnYigXLWpgfX8Sth6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947416; c=relaxed/simple;
	bh=Eldq6lm/LPlazxVGrD9GhdJJ/h2HjuC5vdl2qHODYWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=um1kwP1I85TdyXzn/OIyR8J8OhZLQyDZhv3J70tdy3n3tIfxLRgXDC7KnEVQTKvVDnenOneNSiLC6hcJ9t6ypzyR4V562v1J2oWEGM6tiXlHZS+bJSwVcOIrB2BDh93Hv0GnPQLoDTdqAuv1xAuszAC6FDH8Uhg7yX0Ylsj/Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YeNDPnqV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iuCL0Ri8Pl07N5X3tOZGKZXEMZHVqq6Qzq/nlJISpko=; b=YeNDPnqVYn4Z9kLPYlaEMjHg2Q
	xOg3KtA1VhRe/+uRfoaFWicigxbVNOQFOjHUX8Au+FCvNtcbidu+wsQtHnSzDLFM8T/1T++SSE0Hc
	Y45Zf8BIzPmAqCP10DQhi0n8UHQl/pnrlzzyoc+6cKkGeVjX9dv68s2BH9g+x8nBkWwfEP2hZXm10
	pE67LnodXT2SxrUxDijEppZgqwxpYSYQu/+6gWCHTaq46DRR9HyIXVmt94nCV6QoHHiR63E9uMYQw
	HpdK9j50ixsDg2VnG3qvesKpBL+ofkwlqkkFrxnOI5So+yfS7t8l3GtPIrM93G4nNZF5GhqGRCRYM
	+W2DGH9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQbGF-0000000Cd9L-2VaT;
	Sun, 15 Jun 2025 00:30:11 +0000
Date: Sun, 15 Jun 2025 01:30:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] landlock: opened file never has a negative dentry
Message-ID: <20250615003011.GD1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/landlock/syscalls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 33eafb71e4f3..0116e9f93ffe 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -303,7 +303,6 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 	if ((fd_file(f)->f_op == &ruleset_fops) ||
 	    (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
 	    (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
-	    d_is_negative(fd_file(f)->f_path.dentry) ||
 	    IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
 		return -EBADFD;
 
-- 
2.39.5


