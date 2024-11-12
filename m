Return-Path: <linux-fsdevel+bounces-34548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB49C6288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198381F238D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052CD21A71F;
	Tue, 12 Nov 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jL3gxqG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE33219E4F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443183; cv=none; b=HijNIWtqFFeSlimKDhYBBJI7+20rylUGy+7Ev3dwLgnw49mD+yV/L8LVFenDJa+q5bA778k8zUY6hcDV9YIlkGedMKACiP5OY3K6LOzYuPAyRBds8sMScB9c8M3Ri6Mbjeq+67VwoS0s7ClP8EUYm4cZp8m3uUeRRTgozlUp+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443183; c=relaxed/simple;
	bh=dz8hAZBYlkxwUWyevfCzkusNjX0GA2HGTCKjG2qP4S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUpEn2UpbrrK26sCIle14L20UQROt4sKVSUrOz4jEJ6GDUQeSl4KN1rdWJfIwWvzQZeRuV+2zOLQ/yx1N8GI73cFkvRuvche+iQRP6LeM1s6zRicx+CRpfCRxTjnq+CJoMAJSCTOua8kHDKyWsAzjboxD4X9NHUTP/d2kcJWAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jL3gxqG8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SntDeM1eadCkveab5L1XV2HQp4EhBxldUQDc9BWkONE=; b=jL3gxqG8j00+W5pML5YeTlJ9VO
	dp2N/BfIPKZhiiuUF0qyD8AOIvSuwe+8j2jNY5ene3zpEbzSkcCTPfJ2PKY63RK1saxdEBVoJ+Dsw
	rtcvcgAdsLhEgTTexOuijdmA7PfMGF0cIgwO7FnrnBl36P/VYrm/RK+PFxZ7vURdMn+xQ5nS6Vyja
	agvFyGScTvMiR8+CmDWDFDsFU+UBYKI1P2RpLbdljPHVVdwqMu2B441kC0h52/3nN+GsWjdl6kjjO
	w69kN2Kf9XSk17MV091+vXAYZE0hUyGCqJ4FBalbOYlpDCo/l+vvDHWejbsPdfkta4ba3uODX9cya
	coxwB1vA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxSt-0000000EEtE-2f1p;
	Tue, 12 Nov 2024 20:26:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] kill getname_statx_lookup_flags()
Date: Tue, 12 Nov 2024 20:25:49 +0000
Message-ID: <20241112202552.3393751-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

LOOKUP_EMPTY is ignored by the only remaining user, and without
that 'getname_' prefix makes no sense.

Remove LOOKUP_EMPTY part, rename to statx_lookup_flags() and make
static.  It most likely is _not_ statx() specific, either, but
that's the next step.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h | 1 -
 fs/stat.c     | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 8c1b7acbbe8f..8cf42b327e5e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -246,7 +246,6 @@ int open_namespace(struct ns_common *ns);
  * fs/stat.c:
  */
 
-int getname_statx_lookup_flags(int flags);
 int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer);
 int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
diff --git a/fs/stat.c b/fs/stat.c
index b74831dc7ae6..4e8698fa932f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -231,7 +231,7 @@ int vfs_fstat(int fd, struct kstat *stat)
 	return error;
 }
 
-int getname_statx_lookup_flags(int flags)
+static int statx_lookup_flags(int flags)
 {
 	int lookup_flags = 0;
 
@@ -239,8 +239,6 @@ int getname_statx_lookup_flags(int flags)
 		lookup_flags |= LOOKUP_FOLLOW;
 	if (!(flags & AT_NO_AUTOMOUNT))
 		lookup_flags |= LOOKUP_AUTOMOUNT;
-	if (flags & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
 
 	return lookup_flags;
 }
@@ -301,7 +299,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
-	unsigned int lookup_flags = getname_statx_lookup_flags(flags);
+	unsigned int lookup_flags = statx_lookup_flags(flags);
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
-- 
2.39.5


