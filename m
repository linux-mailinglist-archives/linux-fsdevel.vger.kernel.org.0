Return-Path: <linux-fsdevel+bounces-60436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780DB46A96
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C01891C60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73D2D1F69;
	Sat,  6 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FkytnxKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04672BDC37
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149904; cv=none; b=Wnbpkq//cNVv+FWtCUuw7gf6FsShccomcr3TbJWaDUJR5lEeRjW0YERAtywSgez2BTbZJaPvT2KBcv0PiO6ZHe+E2KrD+oXMnOoknb62v7xEHXh0/JNNNI42McP8I3Ry/zWA2dd7xBjY06Azit1zmTCAjjnAsVB4GJtePu7FmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149904; c=relaxed/simple;
	bh=vMMN4sjh7Vux6/n6ve1Gzk/31wYt1aOl6liIEI2tL5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSbIE9+GHDfTfwdAd2BKWZPulmGVRmEcVXWOUrsaX+TQRAv723+1N70XWARn82uxr45AYUZNUEGsvr0Q+DgGaMuhtbsU2jJ3pQPcY1sKOVTMphmyGtr1/5sdlgLZjyX/z21RC0Uu2qtmTn6BHrdeoNHVoz7gGgtrs0Q22xO8ln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FkytnxKi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MkmTZ0vv1yCiNVnD0Z9pqAc+rwA5HLLPUHhOMMvGorY=; b=FkytnxKimRdvaKLmRNqzr2AOW1
	13icHqxErEXynq7ajhVPpbh5BR13xvViCx11+EZ0m38o7dN32Eh2RZZCWwtXMicDYfN5ZmdS+leB3
	IZoYZGN2sq0V8UjzsuGaVqzbynjokRfeI+BP+f6N5rNL9Lrx1OBv73tr2aCM4zNWyrMb6QAWaFfyX
	OZfHW+OeQ5FZQ0fQy4HmvJd/rWLHXnfGMgk5hp0QLkhxjHl/CsH8bEzEFgPhCDwQOJpRJtNyFu7/7
	hEE7cV3GIMs8yPAkETJNvcIW3krXZVoRXQuBJ87R7+CA6s9g7g5T2bkRzYAjrr9RuZi0G5yr9HQ4L
	5PlejQsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxR-00000000Ov0-0KtO;
	Sat, 06 Sep 2025 09:11:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 19/21] ovl_is_real_file: constify realpath argument
Date: Sat,  6 Sep 2025 10:11:35 +0100
Message-ID: <20250906091137.95554-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f5b8877d5fe2..fc52c796061d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -120,7 +120,7 @@ static bool ovl_is_real_file(const struct file *realfile,
 }
 
 static struct file *ovl_real_file_path(const struct file *file,
-				       struct path *realpath)
+				       const struct path *realpath)
 {
 	struct ovl_file *of = file->private_data;
 	struct file *realfile = of->realfile;
-- 
2.47.2


