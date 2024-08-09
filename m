Return-Path: <linux-fsdevel+bounces-25524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCA594D174
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04961C2082E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB4B195805;
	Fri,  9 Aug 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFuypPs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A21194A43;
	Fri,  9 Aug 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210815; cv=none; b=HiwRRzh9vMh8nw+jC7DCqim91hZj9DkRCvMRd23lN+bNF5aIHTd3VEZZk72TofIrprGbHOvLWb0sOIOKHszBVTHPNVjO/aC2P2UlLRETtd16UfeLMYBhRz6g+58iY0Xoy+/XusH4/XrrYpqacFFQu1aNlgWHSpcz4HU7c2GddQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210815; c=relaxed/simple;
	bh=PCOC6t5DUlw6Zai6p4bX3oYBp74piqtotQ4OSwhgsZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d3UcjIgLqfz1aDkaNqkCQBhS91Aj9p5um+dLP4l0IPZO8xDPPBcnEiCQFem16M4x5pCWnxSjCwT6roQWM/RgUEnX8uOHYOwNl3kK30nzhaeCMj7L6XcThFWyxINaCKq5nlGZ1hOKFFAC/90moG8aIXtB0CaP/BchFRCP24sUzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFuypPs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A687C32782;
	Fri,  9 Aug 2024 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723210815;
	bh=PCOC6t5DUlw6Zai6p4bX3oYBp74piqtotQ4OSwhgsZU=;
	h=From:Date:Subject:To:Cc:From;
	b=BFuypPs7UPPwv1QU90slF1cFAdExzRWbGKRcrWZLq1AfHnAKZn/tlgfSkMa27/cnY
	 V3MpUoXvVj5JiptZM8hWM8IoshYyYSD5pN/ZRnZKhjE6xblzGs8ITn8n0xaIFG03U7
	 lvMT1Wb4gBlyjpB9aXgGcL9848XKDIvEy/Y1OCW33/WT8X3Figf4dyVLnt6yg9ZW+P
	 j1OVc5s6AyxmEQ+LamM8iaQ81l5BCn40vplj4En1CV6YSPVa5atSFyNfIWU7IEnw0c
	 iCB+aC4M7Pc0Z06kS7bjik4PeKmwPnqS3Z5ZlXHZfgJmxUzk/c85/QlH0lP8TBlwwG
	 9WzTMuclZ+YAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 Aug 2024 09:39:43 -0400
Subject: [PATCH] fs: don't overwrite the nsec field if I_CTIME_QUERIED is
 already set
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mgtime-v1-1-b2cab4f1558d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAB8ctmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNL3dz0kszcVN3kpGSjxESzlGSDtFQloOKCotS0zAqwQdGxtbUAqts
 gflgAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PCOC6t5DUlw6Zai6p4bX3oYBp74piqtotQ4OSwhgsZU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmthw+OIwQZVqktO49/ow2VAmNNr0ZpytiuuLhj
 10a9LEhP76JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZrYcPgAKCRAADmhBGVaC
 FSOYEACJdVic638uQHhz0mp/jJD1UDNaRxqW8vMDlhgLa0Gt7tlMyZVd9i5IGl8BV+RSLA1LTGa
 8qSFrVkNejAU4iZWjM9zQTjeFZaaNao2rb8JEGVv6XSX5RvXQHWs3+wkqHp7k8zU3oGhZX3J7kN
 Wo/o+DEHk+ZReMhhu9Xk2UIs0lveK0cmcnjtIFsMTA94JPx5F7DNjhd3BtgBATOuiGHXvcfGDlg
 ySGCZxO4Y4iaj+CIxfjhFAIqOn/KhVQAVyZVqd8njM/WeOtBowYB80eLmmb7DvxXiqo4QMkkVp0
 eK5Vwx2O+Pup+fd3cBnyot5xvCeJMiIXFTmxIActwdDXtDvlGf8WcQoiPxKATPyMjh+Nmmvv78u
 0TwlsWdvW1l+rPbAt9adtum9KMI3BvXBcTGVqz3iuV5GVkp1YraZrF+vNGKFQ/I2Bj/JpvSsYET
 UVh4ZpsoAbW5X62y8ZM2JHxdOdxD1IiXBizTQXGlkEyYIOjvKNi/a5nfhupJ/0Qhy2uig80wk6u
 SJnWgSnvIl9tZCI4+Az9BOHUqyeSpT+d9I9qh1YRA3diJV+rHca16UJVrmRK3I1rr9ZLYXLWoQN
 M2vAqIZgwQveoDBAhDtXHbD6ALtWNRiXZs6gAFyVpICsnf6SWYam6xkyCf1QIKSj3mvHBmFQimf
 RJ/7MIl5Sl7x0tQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When fetching the ctime's nsec value for a stat-like operation, do a
simple fetch first and avoid the atomic_fetch_or if the flag is already
set.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I'm running tests on this now, but I don't expect any problems.

This is based on top of Christian's vfs.mgtime branch. It may be best to
squash this into 6feb43ecdd8e ("fs: add infrastructure for multigrain
timestamps").
---
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/stat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index f2bf7cca64b2..9eb6d9b2d010 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -35,8 +35,8 @@
  * @inode: inode from which to grab the c/mtime
  *
  * Given @inode, grab the ctime and mtime out if it and store the result
- * in @stat. When fetching the value, flag it as queried so the next write
- * will ensure a distinct timestamp.
+ * in @stat. When fetching the value, flag it as QUERIED (if not already)
+ * so the next write will record a distinct timestamp.
  */
 void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 {
@@ -50,7 +50,10 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 
 	stat->mtime = inode_get_mtime(inode);
 	stat->ctime.tv_sec = inode->i_ctime_sec;
-	stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
+	stat->ctime.tv_nsec = (u32)atomic_read(pcn);
+	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
+		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
+	stat->ctime.tv_nsec &= ~I_CTIME_QUERIED;
 	trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
 }
 EXPORT_SYMBOL(fill_mg_cmtime);

---
base-commit: 9000eec2bdc08a0b9027427f9d3d9a3545694258
change-id: 20240809-mgtime-cbc2aa6dc0fe

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


