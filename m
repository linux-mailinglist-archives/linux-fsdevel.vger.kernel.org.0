Return-Path: <linux-fsdevel+bounces-17621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0D8B07B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 12:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D208D1F23AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA35159913;
	Wed, 24 Apr 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZqoPQu9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D7156C6F;
	Wed, 24 Apr 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955980; cv=none; b=jg2Dl2vlTMfep11gUO50QKpxOz3NCFYeuDwM76GN9wEGG5kTrHyU9S2nUwzPW3q4y7qE7vA5X5mtfMrQ5hr+Dh0G9XAtECtgT9kKypPzkqK9VXKRuCuh75+S7banVRjOGUCQJjArScRWwAD9xo40hYnhCvHtMNqP8nNI3DXTnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955980; c=relaxed/simple;
	bh=INjyeC9pTtg4+tyevub+TUdWYrn1xrPo6yRFzraEfYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBVClYl+pOwt9VOCrrV38aP/cqDEklVqYeyavoiELTAw2lN47sO7uZzHIxLeOFWbQZITN+NpG0PJJ2xftE04gywPYB89s4/Tj+qf49QC49YuCR8mg/59ruu6Q5qFhmcnHYkY6/hBvqlys7FDLnP3kiRCF00zfreLBiyjbzE3B6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZqoPQu9i; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c27:19c8:0:640:13a7:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 35BF8608FF;
	Wed, 24 Apr 2024 13:52:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oqIZBt9V0a60-qYfBmYpN;
	Wed, 24 Apr 2024 13:52:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713955973; bh=2fagEnRvIQmMEpl2nH5toxi0dhpK1VGoWJCzVARzQWs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ZqoPQu9i2GLs+1J77wf+YRvcfOwWDjif/9Pfgb03+YtBGg5Fcvz77bBpq9iZGIkYf
	 bBI+hdV8/9lhEr61m2bC/a9z55a5VQ1aF/9b1LBCe+t0l+xtarpaRrkYZv9wem9+LY
	 LXx1Vru2K4cR0oRr/KT0LjCKYhFRwRnf8nVRq/gY=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
Subject: [PATCH 1/2] fs: reorganize path_openat()
Date: Wed, 24 Apr 2024 13:52:47 +0300
Message-ID: <20240424105248.189032-2-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424105248.189032-1-stsp2@yandex.ru>
References: <20240424105248.189032-1-stsp2@yandex.ru>
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
CC: David Laight <David.Laight@ACULAB.COM>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 fs/namei.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c5b2a25be7d0..413eef134234 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3781,23 +3781,30 @@ static struct file *path_openat(struct nameidata *nd,
 {
 	struct file *file;
 	int error;
+	u64 open_flags = op->open_flag;
 
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
 		const char *s = path_init(nd, flags);
-		while (!(error = link_path_walk(s, nd)) &&
-		       (s = open_last_lookups(nd, file, op)) != NULL)
-			;
+		file = alloc_empty_file(open_flags, current_cred());
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


