Return-Path: <linux-fsdevel+bounces-65626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0A5C09369
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDD8189BFF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D8303A1D;
	Sat, 25 Oct 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJPc3swo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBA30217F;
	Sat, 25 Oct 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408609; cv=none; b=sXsTw4IHIp8hmWsMReKMqT/gM5jmqi0W23QQZi0AWCyfrdwgoCKB9r8YFSnSVEUFNs4N4G0gzUKYl9Z8l7+uN6BCvUjVTvJngcoWBdiyMkOFVR69L8Gb24F3C8JdofQQjwXtIwdjvKt8GWvhmSiXfGpk1o/ziwo87wdroAF5Wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408609; c=relaxed/simple;
	bh=uXA6AkceThz5/itTMQ8e260mgmj8wBHkMorWRPFJGGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL83qvV2zDQ5Azc8/S3bFEC6eEoCYSIHhPkwU0dDFpxUGYG6qMayfGWvjytkwxs958e7h23L0bcm6DyvG92Qobh/uG8iPYxVyU5f8CjMlBtxjHEWsvCEDwPm6dbsCpeLPtIi5lbANWJWtiGEKW8cWmvCrweJqkH2NHfU47U0MUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJPc3swo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC73DC4CEF5;
	Sat, 25 Oct 2025 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408608;
	bh=uXA6AkceThz5/itTMQ8e260mgmj8wBHkMorWRPFJGGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJPc3swomSWvIeOMtRPergcT0C8hC+DUQWC6RTH4BhLCb/Zj99UWaw/0UwOduuukk
	 avM0AFg6HTySV1z2/SFXkPSILIMYUG/xYNkd8gQk/oqgkdPpRc31lxklD7ylBME6uK
	 iq3W5hjdgFX3XsiSJdzWAK4cDlN8YqUKBlQqYDAXbRtx55Y40EqSO+f0kjfeoCyG59
	 INn/xDJYiNXn+n5MJ5bZZjtOZO4Rb77f3AUDZu0cngRYtXcTuy6osOWEG09jvLtWRF
	 D+xJ2GhMOBxltNmtJ8FS9CBQoj4lReE4MQysRMtE5lmVAyJSB0PQv8Ui1HGtZLXCqx
	 /gDQv+IgkgJuQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] allow finish_no_open(file, ERR_PTR(-E...))
Date: Sat, 25 Oct 2025 11:54:12 -0400
Message-ID: <20251025160905.3857885-21-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit fe91e078b60d1beabf5cef4a37c848457a6d2dfb ]

... allowing any ->lookup() return value to be passed to it.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this commit closes a real VFS bug that lets `finish_no_open()`
report success after being handed an `ERR_PTR`, so it needs to go to
stable.

- `fs/open.c:1072-1077` now returns `PTR_ERR(dentry)` when `dentry`
  encodes an error, instead of stashing that poison pointer in
  `file->__f_path` and reporting success. This is the core fix.
- Without it, any filesystem that forwards a `->lookup()` result
  straight into `finish_no_open()`—for example FUSE
  (`fs/fuse/dir.c:746-753`), CIFS/SMB (`fs/smb/client/dir.c:488-496`),
  NFS (`fs/nfs/dir.c:2174-2201`), 9p, Ceph, vboxsf—will propagate
  negative dentries as if they were successes. `atomic_open()` then
  dereferences the bogus pointer in its success path
  (`fs/namei.c:3668-3673`), leading to immediate crashes on routine
  errors like `-EACCES`, `-EIO`, or allocation failures.
- The documentation update in `fs/open.c:1061-1070` captures the
  intended ABI: `finish_no_open()` must accept every `->lookup()` return
  value (valid, `NULL`, or `ERR_PTR`). The previous implementation
  violated that contract, so this is a bugfix, not a feature change.
- Risk is minimal: the change is self-contained, touches no callers, and
  simply short-circuits on the already-known error condition.
  Backporting does not require the later “simplify …atomic_open”
  cleanups; it just hardens the exported helper so existing stable code
  can’t corrupt `file->f_path`.

Natural follow-up: run the usual filesystem open/lookup regression tests
(especially on FUSE/CIFS/NFS) after picking the patch.

 fs/open.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9655158c38853..4890b13461c7b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1059,18 +1059,20 @@ EXPORT_SYMBOL(finish_open);
  * finish_no_open - finish ->atomic_open() without opening the file
  *
  * @file: file pointer
- * @dentry: dentry or NULL (as returned from ->lookup())
+ * @dentry: dentry, ERR_PTR(-E...) or NULL (as returned from ->lookup())
  *
- * This can be used to set the result of a successful lookup in ->atomic_open().
+ * This can be used to set the result of a lookup in ->atomic_open().
  *
  * NB: unlike finish_open() this function does consume the dentry reference and
  * the caller need not dput() it.
  *
- * Returns "0" which must be the return value of ->atomic_open() after having
- * called this function.
+ * Returns 0 or -E..., which must be the return value of ->atomic_open() after
+ * having called this function.
  */
 int finish_no_open(struct file *file, struct dentry *dentry)
 {
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 	file->f_path.dentry = dentry;
 	return 0;
 }
-- 
2.51.0


