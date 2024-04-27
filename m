Return-Path: <linux-fsdevel+bounces-17970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC1E8B4619
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 13:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FAB238FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033574C61F;
	Sat, 27 Apr 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qzFP3BHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A164AECA;
	Sat, 27 Apr 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217106; cv=none; b=ht6wSNmlFCeNnqSO3eju99ULcdTyEGUtTcMf9lDnIeaRGAUER9z2UePAugL305HniigkoX6oE8SsUWS0iMQ25QqmdGp6ncKqkmBHlIjmeN7rdCrPxykeRjGl9qqQ6dRdjT8uMk51r0D6cbvPwxYF+dvltOcrs4l8RjRxoMMo1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217106; c=relaxed/simple;
	bh=eW+R7T+4wDE0CCmXnPO5w8nUsJ7ogtYZtHHlx4MY378=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPNcCG/PIjRnSFJ4GwUb4EblSfr1lAx1y2ZrYZCjdWg8dSOzC490BxcqCQX3HQEelKNbGFfFitOJKUYKbXhKrQjhwwJHcq3mH8mMm7rD688tZDrZjTowE5nBU9EfnUJtRgKvSAO/GiMoAQ4kj9BWHwSpwv4roYTJic38kziyizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qzFP3BHf; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C6FAE60030;
	Sat, 27 Apr 2024 14:24:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uOMFvPQXlqM0-vUxBD1Hs;
	Sat, 27 Apr 2024 14:24:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714217098; bh=N6Wa5ZdYH+jnqmFV3t56OpNcrMxvOQwAgYBdbDZuPl8=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=qzFP3BHfeY7rNGhZqBxXwE4wxJOr2GnR07ho6nERxZiLgP3hs34KsBaZUdFQUWueA
	 ybOo2p7OvRCqzugDoddGG6scVZTISVNsvZRwRuPHoKZDu9BsTWeK75cjmp3Ngl2Nj0
	 Z1DNCq4MaKmj2OiVF3aYmInGHMWD8uK+kuKN9Lus=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
	David Laight <David.Laight@ACULAB.COM>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v6 1/3] fs: reorganize path_openat()
Date: Sat, 27 Apr 2024 14:24:49 +0300
Message-ID: <20240427112451.1609471-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the call to alloc_empty_file() down the if branches.
That changes is needed for the next patch, which adds a cred override
for alloc_empty_file(). The cred override is only needed in one branch,
i.e. it is not needed for O_PATH and O_TMPFILE..

No functional changes are intended by that patch.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Andy Lutomirski <luto@kernel.org>
CC: David Laight <David.Laight@ACULAB.COM>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 fs/namei.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c5b2a25be7d0..dd50345f7260 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3781,17 +3781,24 @@ static struct file *path_openat(struct nameidata *nd,
 {
 	struct file *file;
 	int error;
+	int open_flags = op->open_flag;
 
-	file = alloc_empty_file(op->open_flag, current_cred());
-	if (IS_ERR(file))
-		return file;
-
-	if (unlikely(file->f_flags & __O_TMPFILE)) {
-		error = do_tmpfile(nd, flags, op, file);
-	} else if (unlikely(file->f_flags & O_PATH)) {
-		error = do_o_path(nd, flags, file);
+	if (unlikely(open_flags & (__O_TMPFILE | O_PATH))) {
+		file = alloc_empty_file(open_flags, current_cred());
+		if (IS_ERR(file))
+			return file;
+		if (open_flags & __O_TMPFILE)
+			error = do_tmpfile(nd, flags, op, file);
+		else
+			error = do_o_path(nd, flags, file);
 	} else {
-		const char *s = path_init(nd, flags);
+		const char *s;
+
+		file = alloc_empty_file(open_flags, current_cred());
+		if (IS_ERR(file))
+			return file;
+
+		s = path_init(nd, flags);
 		while (!(error = link_path_walk(s, nd)) &&
 		       (s = open_last_lookups(nd, file, op)) != NULL)
 			;
-- 
2.44.0


