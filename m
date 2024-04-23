Return-Path: <linux-fsdevel+bounces-17491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF68AE311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409B1B21655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866C84A2E;
	Tue, 23 Apr 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tcz4wkXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA67E118;
	Tue, 23 Apr 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869377; cv=none; b=Rc+LKWqaZGIgMh5Nj1gx1wWqTbzi0Zf2rau45qV1iPnoE4/Qwfau1ZoSEXZZeC13Xk+bTVOZp8/e865/9TlVYIk3r4cC1qgXbvKu/6QF1i4LRpwZGtWAoVs3zE+/aFr2mPXEbsgox85Rkl9vjh/1KkGPMUFvmh0A3MLmh1/vF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869377; c=relaxed/simple;
	bh=t2/9kzu5cn37NlBr754kfbC9x4lMRcCfuiRc7DMS7GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2PNivVQesAFeDlCI44Xkgwbh7HYaDpo+7GWQ4/OvsxskblQ5CbQwCXpUIdOzIxVeLb7a5NQ39BmRN51O1qjOllqFzGGJt16iTt44EXGz5R3o2+THlmZpUBcoT/QhOekHneDpdJwxn9ATGD0uFy+gv9G7YbVZEWmPnfoqiBnWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tcz4wkXJ; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b1a0:0:640:e983:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id 0378B60AA7;
	Tue, 23 Apr 2024 13:49:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id TnHoiCGOm4Y0-nnKlF5bh;
	Tue, 23 Apr 2024 13:49:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713869371; bh=5kgbLMAE980GVvENsTEIPE4CBNTxsGKzzeodVahHYoU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tcz4wkXJYAwcAKMdLdgv9qaHJS9DMXEHOP1CxThaqGHSmYF8l2SE8Td9ROtxpOkXJ
	 5+esTkOVhuiAbedXYk6nhUzZcbbG3XPuZQ4h07XXKBekLt+uDQHLGjfiz1LJ9L/i7+
	 9BFA6dxMvAL3JpGn62OLigdcgdbhfXuPsd5fycNw=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] fs: reorganize path_openat()
Date: Tue, 23 Apr 2024 13:48:23 +0300
Message-ID: <20240423104824.10464-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423104824.10464-1-stsp2@yandex.ru>
References: <20240423104824.10464-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the call to alloc_empty_file() below the call to
path_init(). That changes is needed for the next patch, which adds
a cred override for alloc_empty_file(). The needed cred info is only
available after the call to path_init().

No functional changes are intended by that patch.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Andy Lutomirski <luto@kernel.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 fs/namei.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c5b2a25be7d0..2fde2c320ae9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3782,22 +3782,30 @@ static struct file *path_openat(struct nameidata *nd,
 	struct file *file;
 	int error;
 
-	file = alloc_empty_file(op->open_flag, current_cred());
-	if (IS_ERR(file))
-		return file;
-
-	if (unlikely(file->f_flags & __O_TMPFILE)) {
+	if (unlikely(op->open_flag & __O_TMPFILE)) {
+		file = alloc_empty_file(op->open_flag, current_cred());
+		if (IS_ERR(file))
+			return file;
 		error = do_tmpfile(nd, flags, op, file);
-	} else if (unlikely(file->f_flags & O_PATH)) {
+	} else if (unlikely(op->open_flag & O_PATH)) {
+		file = alloc_empty_file(op->open_flag, current_cred());
+		if (IS_ERR(file))
+			return file;
 		error = do_o_path(nd, flags, file);
 	} else {
 		const char *s = path_init(nd, flags);
-		while (!(error = link_path_walk(s, nd)) &&
-		       (s = open_last_lookups(nd, file, op)) != NULL)
-			;
+		file = alloc_empty_file(op->open_flag, current_cred());
+		error = PTR_ERR_OR_ZERO(file);
+		if (!error) {
+			while (!(error = link_path_walk(s, nd)) &&
+			       (s = open_last_lookups(nd, file, op)) != NULL)
+				;
+		}
 		if (!error)
 			error = do_open(nd, file, op);
 		terminate_walk(nd);
+		if (IS_ERR(file))
+			return file;
 	}
 	if (likely(!error)) {
 		if (likely(file->f_mode & FMODE_OPENED))
-- 
2.44.0


