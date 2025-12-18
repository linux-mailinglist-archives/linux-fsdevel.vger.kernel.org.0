Return-Path: <linux-fsdevel+bounces-71672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9CCCC8A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02A60306B465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF83446A8;
	Thu, 18 Dec 2025 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEs7Ndyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B934402F;
	Thu, 18 Dec 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072084; cv=none; b=pLkU9qNgE7ZHFoTdUM2CvX2ogN7ll6MFJpHNgnkTx+5E153abKf3u2A8ZChnKfgwXVFXUyirJbkj2Sv7dDS+xawzNAMkWW3/abZJqFAXo9q2dzOTUPVU+UfUoNcGgUk6IvMFu9AGZUMtb2SKXgV35exg9YW64JopjqbYZiydDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072084; c=relaxed/simple;
	bh=wOGwPqV7qe5Ae7SOo5zrEqHEYhzAYbMGLY4AwoM9W5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IJNAm+TWSc8jLssVMZuGVB8KgUrJMCqL0bk8WLXmD77pZgsgrluJpn8VR7+oyDQdo5exQ9ZNWuzu4cC5RfqLDXAd2m6w38ZDeXSfrvy33gNEJ6tmRrYULNkCEH2CtR4FsxwgR49GisjaGYZkHmVVh1T6CIsiO9vV4pTIBd5tAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEs7Ndyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B1C4CEFB;
	Thu, 18 Dec 2025 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766072084;
	bh=wOGwPqV7qe5Ae7SOo5zrEqHEYhzAYbMGLY4AwoM9W5s=;
	h=From:Date:Subject:To:Cc:From;
	b=vEs7Ndyo48m3edlZhtMc+ES6mnTiI4WoB8iL2FDYvfS4jUyiq7n6neOol2YE+bNO+
	 6VPhSwZgeyi63CNdJx75QnnHLZyKo80WOViJ8MVbjxqB85n5VNFSfi+0w1p8NJoGqo
	 U0QL1lmGVIhlI2yDW+aCwU5xB/oFnjLtEYp7+h7LWDzhdMdQg1qPPLrDEoBum1IAxG
	 Su/QKxjv4MkSJ4B1jvAn84QT5p/fNLddg7iknn04M8vTEROOxPEzxf+6C/KAtB7ufO
	 5k+Aci0zNHc/UOd2PDY6rCI7c2aFRjHWkR/GNx73aG1zpJpAS587emjdMGOLvchSo2
	 lqfJmq/38lLoA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 15:34:17 +0000
Subject: [PATCH v2] selftests/filesystems: Assume that TIOCGPTPEER is
 defined
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-selftests-filesystems-devpts-tiocgptpeer-v2-1-a5fb5847fe58@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPkeRGkC/52NQQ6CMBAAv0J6tobWFKkn/2E4CN3CRqTNbtNIC
 H+38gSPM4eZTTAQAotbtQmCjIxhKaBPlRim5zKCRFdY6FobpXQjGWafgBNLjzPwygneLB3kWFT
 CMIwxRQCSvneXGszVtsaKkosEHj/H6tEVnpBToPU4Z/Wzf0yykkpa3bvGuFrbVt1fQAvM50Cj6
 PZ9/wJxTAuM4QAAAA==
X-Change-ID: 20251126-selftests-filesystems-devpts-tiocgptpeer-fbd30e579859
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wOGwPqV7qe5Ae7SOo5zrEqHEYhzAYbMGLY4AwoM9W5s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpRB8SbFypJlINb4ro1PNihK6NQgsqVpq0MB8RE
 Cmd+Ix7n/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUQfEgAKCRAk1otyXVSH
 0OI4B/4rUMQBV9plrPbNFLGKi7thzZrN21u5erajICH5u+hqMX+h+DtLxNu+Y+EwYu5qqTS6h4B
 4qPPHK/Z9xVw1cCsNcQWjLPRA5c/mjnEdk59LM+f8Aa4+qlNJPqua8Bacx9/oJJf7fY4gY0nlcO
 I3RO34wIrp51yxQlPEhibJsh4ajHinmBmrf9hKiBQyTo7n6E5SZk/7yr5FbrJXT1MNknjzk+vuF
 hnUWCmGsJJe8weVOyZkp5os2czLrzvxMW3m06/oocsq4bWi88h270JU7bU57WGz9L7zoG1n+HoH
 wqzAq6cVq6CunGQthxSr2Al9vTtBDbmGuP8Iba53Skiny/Kz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The devpts_pts selftest has an ifdef in case an architecture does not
define TIOCGPTPEER, but the handling for this is broken since we need
errno to be set to EINVAL in order to skip the test as we should. Given
that this ioctl() has been defined since v4.15 we may as well just assume
it's there rather than write handling code which will probably never get
used.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.19-rc1.
- Link to v1: https://patch.msgid.link/20251126-selftests-filesystems-devpts-tiocgptpeer-v1-1-92bd65d02981@kernel.org
---
 tools/testing/selftests/filesystems/devpts_pts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index 54fea349204e..950e8b7f675b 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -100,7 +100,7 @@ static int resolve_procfd_symlink(int fd, char *buf, size_t buflen)
 static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
 {
 	int ret;
-	int master = -1, slave = -1, fret = -1;
+	int master = -1, slave, fret = -1;
 
 	master = open(ptmx, O_RDWR | O_NOCTTY | O_CLOEXEC);
 	if (master < 0) {
@@ -119,9 +119,7 @@ static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
 		goto do_cleanup;
 	}
 
-#ifdef TIOCGPTPEER
 	slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
-#endif
 	if (slave < 0) {
 		if (errno == EINVAL) {
 			fprintf(stderr, "TIOCGPTPEER is not supported. "

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251126-selftests-filesystems-devpts-tiocgptpeer-fbd30e579859

Best regards,
--  
Mark Brown <broonie@kernel.org>


