Return-Path: <linux-fsdevel+bounces-12422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422485F1C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 08:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DED1F2258D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9317BBF;
	Thu, 22 Feb 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HcAI79BJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53775175A4;
	Thu, 22 Feb 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585706; cv=none; b=K5s4PB4+r048+ywB1f8R+QHY5j7TUJImnTCn0uGpM6XwddUTAG7H6rPjZa7oYvQI2jaCD/6k2oyNCqJhPTdUPlK4QPrAwdKK+WCMzJIsp9yR/mUM1xz1X1gjePIfuUupKVFJdCMbsDpcVJtI/sb4kaaO9I/MYyYrQbBlR/vfkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585706; c=relaxed/simple;
	bh=JCJJxjzDXGYJItYXCEzMjq/GSfQbqYm3SGRGNchibxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WC4/MsfvLXcCPbJJ8iRqbsmPWN2Su3YDCM5DKoT/cH844OB1wWNZWmVhsEgJPyQU5FqT4VIWiPxE3Ie3K7nUbzT+/TLUTLEcOJynTw/fhNWmtYVpoVG58ScpDIzcUDaUrVkMh4P9Ph6n8tQU+yLGerfiIp1JypMJGTjzXN5t1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HcAI79BJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708585697;
	bh=JCJJxjzDXGYJItYXCEzMjq/GSfQbqYm3SGRGNchibxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HcAI79BJ0jlUL64zT1OuRh30+urTZW+qC87py30RIz7eGcHIx66WFDtT39zDGmBJm
	 HM3AVr97CHd1Z8uGeyoAPguoaxClQUfFoLFvizAGCSHNeEYre8uZUt8gUbcb1VYQSC
	 /WwVQMPXKIeLbMGJhKlB0+r/vFxcH0nAiNkLKK28=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 22 Feb 2024 08:07:38 +0100
Subject: [PATCH 3/4] sysctl: drop now unnecessary out-of-bounds check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240222-sysctl-empty-dir-v1-3-45ba9a6352e8@weissschuh.net>
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
In-Reply-To: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708585698; l=869;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JCJJxjzDXGYJItYXCEzMjq/GSfQbqYm3SGRGNchibxI=;
 b=XWUZnHu/nkrMeHxEs4qbmkwfAlq1rR7FWvv8k9GTBVFOuFcu7uJK8PSl+A+MtiSLWEAvAhI0I
 j8M7KbOPm+UA6bCmIRyLxiSyxfCwt6TFMzbkTTAlz2f+gifo220SAsx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The type field is now part of the header so
sysctl_is_perm_empty_ctl_header() can safely be executed even without
any ctl_tables.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fde7a2f773f0..4cdf98c6a9a4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -232,8 +232,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (header->ctl_table_size > 0 &&
-	    sysctl_is_perm_empty_ctl_header(header)) {
+	if (sysctl_is_perm_empty_ctl_header(header)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);

-- 
2.43.2


