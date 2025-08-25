Return-Path: <linux-fsdevel+bounces-58944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DADB33591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85091B2457B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CB28541F;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k3Lml8HZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08A277C8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=IO5fJWrtxEWSiL1/aYxE0VBgkFcTaakG65MgUlJqE524lSedLkCMXfYPFAWCY/F8m24YRwLHXjVSczdVL/uu3MtfqGGnZlhlEXtTMnGwlFt+nGHAoFqEMQTs46adNibxOr8FnJblvovk66PShjYmzgW9KluvYfYeb8X5a6kZEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=YBT5A/hgUhMzh2yDPTUd+3X2r+6ZfRRiWE5eGGmkTD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtOIVGYTX/QC4YhYmFa/sE4F/JrFrHCzdPhNtobS//ahxv7i1wBLMja0UcSO3BMEYXeRWdU4vde0hGqFZLokcOWTQeaEc2fSpJaJCMNA5ZX2jeD3wq1A+XYaSFdk6cLvlj9r8McoyD5GaO5N5CxMq38+yIHHCX1nVnf1iDYQSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k3Lml8HZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NjUEMZg2h2n5wj2nNRaCy/YbJGq5OiV1Kwq5h40mw3c=; b=k3Lml8HZIsGOtL2YPGEG7XC59a
	O8bPk1G2Qd9qwdipjZogqQJBUuT92/Ee6lPWTZRa+62Q4x64JpUj2s6mUU7aonoVPQA5lAr0cYXYN
	eB8dBxcUz/D7ayt6H1m1LDvzLEV0uNT+GQcP8eylxXY7IZYHtmrKY5gPpUkJTbLcjekeowuBor0YB
	Er/QIYDEKNAejqIqkmDeBjloGPgqhck0yQQ66a1UYEwDbXfv3tSIWKqT8R9RzIpYkIfi5qz/5yUN9
	jkC/sMHuhgOdqlEvvqf2iHQRX/wqy9ryYaUzh8Gc+TsYuGlKj0UBNsXnG6vHEX/Ui9TX2oZcyBb3S
	+78ETgIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TF0-1XQt;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 44/52] path_mount(): constify struct path argument
Date: Mon, 25 Aug 2025 05:43:47 +0100
Message-ID: <20250825044355.1541941-44-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

now it finally can be done.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h  | 2 +-
 fs/namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..fe88563b4822 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -84,7 +84,7 @@ void mnt_put_write_access_file(struct file *file);
 extern void dissolve_on_fput(struct vfsmount *);
 extern bool may_mount(void);
 
-int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 68c12866205c..94eec417cc61 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4024,7 +4024,7 @@ static char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
-- 
2.47.2


