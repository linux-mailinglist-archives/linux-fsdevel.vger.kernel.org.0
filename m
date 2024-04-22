Return-Path: <linux-fsdevel+bounces-17384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C18AC7D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC651C20D7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430954901;
	Mon, 22 Apr 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ObvEmjJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward202c.mail.yandex.net (forward202c.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AB5337F;
	Mon, 22 Apr 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775841; cv=none; b=RoK3vgFlhpTniApfRZMnRs2uWFqSsiptk0izcaFikJj9Y7rphNtdOxBKZZWvA4jJTbjdJQYJeTCWuP6hJ4Gvr/U/JsslTwHZfIABVYat+B0I98PyvXYAPfbQkHKulo5tTqabWF6rA/ET08NSS9JooTiHEdHy6MQf2Q9qGSIqSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775841; c=relaxed/simple;
	bh=t2/9kzu5cn37NlBr754kfbC9x4lMRcCfuiRc7DMS7GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGNKMg44e7EUA0iUEh1KwbEZhFjbfjp4IJjkqfXWGv1r5C54zPwP2sZvJnYXGwZ4IYvyl7VDMERuTT7EqVhrj7N8DWrvktGKscgnksAFDTKce+E8B1otuxs6t72tGxUrT9gJX9zQpBoY5OX2yPvZHsLuz7i/068OPKt5p01rZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ObvEmjJ0; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward202c.mail.yandex.net (Yandex) with ESMTPS id 66E0C64AEE;
	Mon, 22 Apr 2024 11:45:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f220:0:640:b85:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 05F1A609C3;
	Mon, 22 Apr 2024 11:45:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FjEovW2OjiE0-dGbQCA9m;
	Mon, 22 Apr 2024 11:45:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713775516; bh=5kgbLMAE980GVvENsTEIPE4CBNTxsGKzzeodVahHYoU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ObvEmjJ0lkv8C/q4v7NpJijo21BTW5495IkxfhW9ozV8fJYF6NC418d0HkeuGRse9
	 SNu2Duz1Hqsf3mB+ULgpt6ikY1kPl5moJ8mmms8eJy1eBTr6ZT4FnN7gmzJwoz0Ecr
	 Di/zpjzACSTXUbU6UJoUbvSatw5coHKwl7QYkQQg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andy Lutomirski <luto@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: reorganize path_openat()
Date: Mon, 22 Apr 2024 11:45:04 +0300
Message-ID: <20240422084505.3465238-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
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


