Return-Path: <linux-fsdevel+bounces-38959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5898A0A78B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A031F1886A8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213D187FE0;
	Sun, 12 Jan 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gjx1cPJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169015667D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669229; cv=none; b=CiQ5WO5pwKEPz49t2O7NkvcqZAb9zNBgCahn6myWDY9e7o5U5kPyoQgI6msK0bbco/klwIcvr6zV6QUDkLPrrAE8G4JGdUqaJRaPodujxN1uqYmzNUmzurRDyURvJJF457DaujRFGarmaaWlg0+oGo2JYf3UbYI7KJ3BpDmYyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669229; c=relaxed/simple;
	bh=5eJsLqYNtJ7xSugE5E96fAtH7ixGSu5cpqpe9a7K01M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Phbub4k5dVlx3oWAuQRy1M2YMbPIu6mmU7lBIhETmJmb2KFEnuMGnWCwqLg2VJuLW6Rek/UIxaArgKnMzI13D7HZXjQT2mY/MvrdWKw8j/VbdAec9p9c8Qk5Ylit5ib2obA7bvuWfDE0JNdziDmE/fky2uNQJBmyz4X3Nmh8w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gjx1cPJl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ClZNbglaHnnHV2LCTUaEvZTs9wMh9fgjq0YxT5cMIys=; b=gjx1cPJlnYHx9tV1LbkHPl/iRU
	1/fQsHB9ZoIX9dqJqVQYGmlWQszFSgdIdBkaITkfk0yebv3G0/+imNh21TcmE87pQNwsWe4gjojSB
	6Lv/thAKJjIOwZVSw2hrc13Dj8V9f6TzJFo8axgZcQLvkze9xzmILm5w07xtiqjMCKdYihTtJmhEe
	3lkTdUx7doiEA8uYEp0v2PPpFLdVLV5Es3nqET3fwX36T9a9xCUG8oCEbckev0N9JlmU+QM+wRaLD
	RmOpjXjbh2sq2M9NhnNyaorubiWaKBdeul3mCUh1gYJsZQLkaD5QLxpMWp+nuniN2qgmJX+6zUJpX
	4W4LBjug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWszy-00000000ajJ-00IT;
	Sun, 12 Jan 2025 08:07:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH v2 06/21] debugfs: take debugfs_short_fops definition out of ifdef
Date: Sun, 12 Jan 2025 08:06:50 +0000
Message-ID: <20250112080705.141166-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112080705.141166-1-viro@zeniv.linux.org.uk>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
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
 include/linux/debugfs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7c97417d73b5..68e9c6cbd835 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -67,16 +67,16 @@ static const struct file_operations __fops = {				\
 
 typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
 
-#if defined(CONFIG_DEBUG_FS)
-
-struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
-
 struct debugfs_short_fops {
 	ssize_t (*read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *);
 	loff_t (*llseek) (struct file *, loff_t, int);
 };
 
+#if defined(CONFIG_DEBUG_FS)
+
+struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
+
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const void *aux,
-- 
2.39.5


