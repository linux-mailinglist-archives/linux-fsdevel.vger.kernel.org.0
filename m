Return-Path: <linux-fsdevel+bounces-21745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5859095FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 06:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281CA1C20DA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 04:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F1F507;
	Sat, 15 Jun 2024 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="m8SymDI6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0FD517;
	Sat, 15 Jun 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426348; cv=none; b=f/82qfvoDuSU46AQw799OQKs/y6jN/D3zcYhkyLnNT20rXSgqYBNjR5KHNM0o67H/PvSVttdnBSCIDrgpstterpxubWpcfB68WW6Kj1woxpw+Aqp2LL3N0nLoWwrNu2c+0Jlf8xYEf3YkSOxZwUd7Ty7T4XImFmnAGe+xaQqyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426348; c=relaxed/simple;
	bh=ZfBQKJ/zqEB12UpD+dypBmDQEFr7tmObzwDhgJfIaf0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uGFbz/am9q9wu8Z+MF8r+zBZZuqh+q2BVOOt89CExf1Y5xw4MA8DO3NLQM5QR6SYlSAfys1MV8M33qrzRzpw3IZ0thIlMzA3u8Okq8N4wRhthhTNMOOUuvv8Q3fTCu2DZXML/IxQ/IPR/6XZVHR2siVjL5GmooI1w/8BmPBsLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=m8SymDI6; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718426323; bh=TbnaeDCMFC8mDLM8U3qCPOGqIZSkpYEhQWHYBR3rMDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8SymDI6YQKERJhfcxQzgyblQUSruJlrmKR/IBvoKZ/IroFB7dzWmYj+FZbiF2f9z
	 4+xwtJKk3Csm9JSWGaWs3ykylJEUBXMP8KBdxJcS0rhidPFGeyhXdSDFYGKFKN2P/B
	 zG4ng5ew02Y2Iz6JX3scfQl+3HfOc4J/C7HLuHEs=
Received: from ubuntu.. ([36.129.28.219])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 9A9930AD; Sat, 15 Jun 2024 12:38:41 +0800
X-QQ-mid: xmsmtpt1718426321txzl8iil9
Message-ID: <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+FIEqY/GtKlkQbX15go7mBJyJ77MNq3a0ks3yZyu+2yYtEFgQvp
	 Cv37InPutOszHWUfBNT3lL1W3gvG1FvL3ZA7SqOlyCizbZ914XJhUrNPWKj2QrKZGGgHenHXPoJi
	 1RZA/vgQwVHTJVUB0ezcCpIIZTrT5DvhmOdAv7jTdzTtYfvdmdIQZn5ohPFCAPXwlf5lvV+TZRQ4
	 3jT21P0Mvd+BYcNN01KU87p7cgbG/tDic9i78KUODysKXyQDNvUIrfMU2dHgyH/9aMV2G6x7bgNU
	 5vLeb67G0zhz5YeUnVogst4bovG5XKtIR01tKeXf+zXOfuTBrV1Et8NTLYginZuciVVQTzwuqcb4
	 lWAG5LWTmoFyA81VXdaldS0skuz9E0xIeYrAj6ZuIEIDgayECnX/9VJHG8Gak6FdqDdJ0TSWBAST
	 AbTocABs2TJ9MtEC6W9AYcyqT8alMytLGNmiHI5V+kh0nZa/41uiAD01GAxpg6GI/D35rauA4g8u
	 PbwhbT+Z1Wkjlvm28x8hfSHGYXR6zSJ8MH0eXwzgIEKW27YGiasCemAzZdlIS48ImgD6wPhHMemH
	 qQAs8PhFThHQevQATHfN1ygse5fhEqNtZKpwRpXISyfr54QBEgN7ZdLme0aIJVYqCEujE9Uzjnd4
	 y3Hx9IRmx4QIPV1tGgqJp7/huQnn/pIvoGU/nTnrLzkz0xSabu0ACxZ4FkgCcVwLcxpzxUzKF/VE
	 dLJim8RZHZ3XjlBZfRE8qNJphWbrL9ghzVk3AEFNQi9uXO9RcaDpck/mW7+BD9yPIPcIjkvDhf4/
	 jdnL8qflpjNyWNy/rzb5J3cAWlremUKxIqnUK+kSVBOyaV34O9IWM1hJ/MDF0BuUEDR6RCw7/+NM
	 z1Cp8KhSD528oNjE5daRKJu8P6Rz5CL+L4oAxN2ssZZO2r2L4vUuXaPRR3l7CXS6aWy6w28JA5wD
	 5xZNO5pujTS1RGYk4KXLNH4ZjrpPZJlRQgQz6AjD60GK7vm0fbzN56aF2ykJjV1xWoS7SHhm5ltA
	 h+v3h/4VINbLgutI5HK/QTb1afZj0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Congjie Zhou <zcjie0802@qq.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zcjie0802@qq.com
Subject: [PATCH v2] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Date: Sat, 15 Jun 2024 12:38:32 +0800
X-OQ-MSGID: <20240615043832.9796-1-zcjie0802@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240615030056.GO1629371@ZenIV>
References: <20240615030056.GO1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify the annotation of @dir and @dentry

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa..2fd3ba6a4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4095,8 +4095,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 /**
  * vfs_mkdir - create directory
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
  * @mode:	mode of the new directory
  *
  * Create a directory.
-- 
2.34.1


