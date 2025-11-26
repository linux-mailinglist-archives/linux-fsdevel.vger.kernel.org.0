Return-Path: <linux-fsdevel+bounces-69906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B882DC8B65F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AD95359EAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4F311C37;
	Wed, 26 Nov 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4szpytc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF424279DAB;
	Wed, 26 Nov 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180774; cv=none; b=u+QLUIJpbmZNn8bh64ITaAGtmN6VLL0yPR7qwoHhcYQiP3nBH41NsjSPLuABZgyt7xMaBolV47/Z/4GteX+sxymK/4zy7w2RT8Pwx4Rlb5IsrYLEbM23PtaF5pc8Fpw3eZJSqyRCQelrut4vX6QUWG9WS4fzwJOXxQhyRUc+L3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180774; c=relaxed/simple;
	bh=EIrTBEZNlirUyofA7nDfDrA8J4CjiUXqWkdrgiXPPp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MTXLdbsy7e543FrJfsSsJnCT7zPRp8AwgTq35CdkYIhk6vM41CjJ7JDvxqdvJFapDcVXT6Gr0dU/XuXj1cPvzu+5PnKNf6OALVsdsc2vWO7E5aM0PQm7Ox1LjI/mFyl4nXlREsAc3KKGVxfN6PPY9VMvsgfvzjACmd0c+gtvWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4szpytc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C86C4CEF7;
	Wed, 26 Nov 2025 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764180773;
	bh=EIrTBEZNlirUyofA7nDfDrA8J4CjiUXqWkdrgiXPPp0=;
	h=From:Date:Subject:To:Cc:From;
	b=e4szpytcIa4IhXycdOQb3Dorcu77zWAzV0kN1BqpdW0xOJzRlP1+xYSSQYHdeEJit
	 qamERovbUJwwODRK9nqrYeCU4ZD6efGMQZD9hiwOu7tPVw6iuFn17pyH1ASfbArQzk
	 QPqYia+hQRumS4ubhn5+jpRl/f267rOmehZ/7SgkpOULP0MiKhz9vQb4FeqI50oZYD
	 jrQpQdAHIXX3p9S/WIGEfWydwWE4Isjdoq2cfdxuhrI9w5NWm3wGsawwPzF0bk/WB9
	 wXPY22YSrK/VHJdFfRieNLWOowX5n1b4mbvFBHZBoXOBvaK54A60MSfQ5X5Q5c45sK
	 LLIyYfCsnl+2g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 26 Nov 2025 18:07:40 +0000
Subject: [PATCH] selftests/filesystems: Assume that TIOCGPTPEER is defined
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-selftests-filesystems-devpts-tiocgptpeer-v1-1-92bd65d02981@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOtBJ2kC/x2NwQ6CMBAFf4Xs2U1oTVX8FeNB6CtugtB0N0RC+
 HcbjzOHmZ0URaB0b3YqWEVlmSu4U0PD+zWPYImVybc+OOcvrJiSQU05yQTd1PBRjlhzVSbLMGb
 LQOHUx3OLcO1uoaOaywVJvv/V43kcP25qBgR6AAAA
X-Change-ID: 20251126-selftests-filesystems-devpts-tiocgptpeer-fbd30e579859
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EIrTBEZNlirUyofA7nDfDrA8J4CjiUXqWkdrgiXPPp0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpJ0Mjb4nhnWiL8j0wQTgbEYcQbdRlJptd+EaHF
 MPgW2SIQDmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaSdDIwAKCRAk1otyXVSH
 0LuEB/4v7Mkhi3Gr0rir3EDE65tozl5UaXv+kViFa6i7F7oOC1+8nqXpfpIG6ACCiZ1ArMNsA7N
 t0c2c/Oida4ZF8lFtIiZqsIwAxxN0WZnRQ7fgNw3/9Dr7z0hjPkZV3TRsU3NyshD6pI9p9ts/G/
 BTOjwfErhxcF1WckLe5ntduF5LXKvQVHg4q8IIfdyoILSPFdZN2rnsLmOEPT1RMPMZR+qo4lrea
 Cv69gXVXHEZYS0Y/Xd5YdNiBqNLEL4ddwGvkjY36PnYxZgXH9Nhrj4rUgD2sXBWdLE1pvY9Y0u0
 p+p3knfCwUObfTOzl6pd2mAVTkDSSIAk0EQTdZP9Z4/f5JGD
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
 tools/testing/selftests/filesystems/devpts_pts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b1fc9b916ace..cad7da1bd7ca 100644
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
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251126-selftests-filesystems-devpts-tiocgptpeer-fbd30e579859

Best regards,
--  
Mark Brown <broonie@kernel.org>


