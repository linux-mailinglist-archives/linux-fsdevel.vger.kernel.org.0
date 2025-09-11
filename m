Return-Path: <linux-fsdevel+bounces-60885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7EB527FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 07:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F343166F70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 05:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CAA24DCFD;
	Thu, 11 Sep 2025 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Efly0rxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B451C54A9;
	Thu, 11 Sep 2025 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567138; cv=none; b=nRDbOf90k1VKH86vSBY9N/46ONQGG/g205nKWKv9IKTC4pjIxUgOE3bisKj1fJRO14sSd2DbGBPZsJQWKA4jj0muW0NITlPlRWgbkjE0wrjid5k731OqLWyDBzvyQ+5eCsg1ssIb9unj6Q7vvYzyYe1gwtSMQPE2cgpTWLaeGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567138; c=relaxed/simple;
	bh=PfBA80Cw7f4klse2KRBc5/cjmHQ/ueU2uDFOCP1i6MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7zjBH00KBsz18sbREh0Oln5r2X3d6SEoOS5U7mSvsfWxg2UZw6XWdTLXip/7e5AvLAJalPlpHpKrAe+IbtJBTHpOGxrVMXB3Auhlx+sHRrvzMysJrg8SnvLocgRqkuoT/B4u+7e7AH4A4u+X39n1MZqoxKjeo9YFctOdDT3C68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Efly0rxV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0aQiQQMRHudQ3Avpzp+/xw5XZKKw58fDSXyPEHl+RS4=; b=Efly0rxV7NJaoRjEltiZQ4a11x
	aIl9ptP0xaV6kqvUCWbBIFHjlal5P9RbEw97Z1C9IfiFY2NN4V+qKZ924p8FxALj52dcwqRphSo6b
	kgNr9GPqe7rtbZl+lFX6QN2ngO0eHfCjLK71G2Tb4OOg0mjvlI/+7voeP7Vzke+GjJjhGkEVmsRT2
	MaoBrHRuZL4Qp6M9qhU0XsfdaVqi6N3YzGlsv4KbwR4kRd/quV7efxP9ctZMuY5ue2U9oZNEIRn8t
	TIdmz8IC4t4vXvzevEr6Ce6q/JW/3D23VvCMqOfZ2VLh9A8+MudqnSM8aWTBQGnes6b/u3P5n1h1w
	TOzFMGfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZV0-0000000D4kH-33kK;
	Thu, 11 Sep 2025 05:05:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	linkinjeon@kernel.org
Subject: [PATCH 2/6] exfat_find(): constify qstr argument
Date: Thu, 11 Sep 2025 06:05:30 +0100
Message-ID: <20250911050534.3116491-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Nothing outside of fs/dcache.c has any business modifying
dentry names; passing &dentry->d_name as an argument should
have that argument declared as a const pointer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exfat/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index f5f1c4e8a29f..c8388a2ec227 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -587,7 +587,7 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /* lookup a file */
-static int exfat_find(struct inode *dir, struct qstr *qname,
+static int exfat_find(struct inode *dir, const struct qstr *qname,
 		struct exfat_dir_entry *info)
 {
 	int ret, dentry, count;
-- 
2.47.2


