Return-Path: <linux-fsdevel+bounces-78733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPqZG0m5oWkYwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:33:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 199EE1B9DBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30AFD321AE17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275643CEC3;
	Fri, 27 Feb 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMY0rTOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334B43C056;
	Fri, 27 Feb 2026 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205644; cv=none; b=dH9lIvOxGkf9+oSLDODA7cKxlfXuBUIYbtrOY/bKF1G7LJNa5mJ5g+Ias8mppikU4QxhPggSNgfeeHFxJsYtRWNvGmlRHZpBnm/XcZM2L8YroEdQBLb0pW4MW5Zl+4MVmNXP5Udiuh9gzxtxA8QPTEXhG1qgu3HuiyiWFyBjMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205644; c=relaxed/simple;
	bh=zjmsx5oq16zysg8L8WJOCU1HqD9oMxXD4LVv5E0RhVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WaG1rrW/OGZue/PXdBP2hbuJ9nEDeIDuD+WgtDpbPOOIE3kNvy5aHm1l+b0JaSwFMdMJU/Kx79c5l6fmZqEmDzDUxkslHzxbUs3+4hmkg9K7PPqeNmzsU+YHg9mXfUr4ms8s0nQXITQPjKE87GpzX3gOEQx/ywJ7+V09ACZ7U3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMY0rTOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C12C19422;
	Fri, 27 Feb 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772205644;
	bh=zjmsx5oq16zysg8L8WJOCU1HqD9oMxXD4LVv5E0RhVs=;
	h=From:Date:Subject:To:Cc:From;
	b=BMY0rTOk+ymiw8JyvlaMBxBJvkLronYSxySGlluGWWAC4K+mAVveBozSi697R518x
	 uunsQqREDm1CE8Ncip6NUmztFaP6RPTdsrIK7wp7nqG5ksaYsE2jLJXIDXSbN4cPey
	 8VBY5kY1GoFLhUef10+yvv2HyK0vDTPxnjrOb558SMUbOpuxUehiC91os1Nd1wgkCA
	 gmzz5oMyotcSoMmcN1MZZoMMqKdqmIO0Vu6y8WsoZrCrK/yiUJAbz86Q0DL8/UbAs9
	 iYQHFY7k7M/43vH8doWFdnnSvzRer09tFIb90Wp1bdHXoQ6ipYnwd+M9DYjShaa+DG
	 j8qNaPe32Tlfg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 27 Feb 2026 15:20:35 +0000
Subject: [PATCH v3] selftests/filesystems: Assume that TIOCGPTPEER is
 defined
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-selftests-filesystems-devpts-tiocgptpeer-v3-1-07db4d85d5aa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEK2oWkC/52NsQ6DIBQAf6VhLo1gUejU/2g6qDyU1ArhEVJj/
 PeiS9OxHe+Gu4UgBAtILoeFBEgWrZsylMcD6YZm6oFanZnwggvGeEURRhMBI1JjR8AZIzyRakg
 +q2hd1/voAQI1rS4LELWSQpGc8wGMfe2r2z3zYDG6MO/nxDb7xyQxyqjira6ELriS7PqAMMF4c
 qEn2yXxT5kz+UOZ53IjTCvkuTYg5Fd5Xdc3NHoiDzsBAAA=
X-Change-ID: 20251126-selftests-filesystems-devpts-tiocgptpeer-fbd30e579859
To: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zjmsx5oq16zysg8L8WJOCU1HqD9oMxXD4LVv5E0RhVs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpobZJ5ekNHznEW5s/NuBTABpDBWVZVBUe6c/4k
 UTlLh3D4A2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaaG2SQAKCRAk1otyXVSH
 0NdJB/9C9ZyAjlme8dJSu2hjuAsCd65gzpOSfFl3U6UY7b7mNVxPfR/hMeMHqcQiJeaHMEykuni
 +EqgIkyDKM3dRbaY5sOztbrRDe8pSy++89KUt9ZmAisyZSlC27rf3UH5a2t46Pt3eWsM/zXaVze
 0ek7vLJgkJKY43dOHkQ5w5qtnGsH1vcsDDWzwg1tXw/UNZB5sey0KBPKhPc3U3DW1IdL/SMAJWh
 aVXpysp2SRtxEAV2L09jI28l/QtxJWsDWXlSj29GiYoNOXy4G/JMLpm07X/B99q7MjVU4mjLXil
 gqmc0phCcNvyOg6V9SnnTFBWY6UaHhUbRfaU80Mit77l8GQ5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78733-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 199EE1B9DBF
X-Rspamd-Action: no action

The devpts_pts selftest has an ifdef in case an architecture does not
define TIOCGPTPEER, but the handling for this is broken since we need
errno to be set to EINVAL in order to skip the test as we should. Given
that this ioctl() has been defined since v4.15 we may as well just assume
it's there rather than write handling code which will probably never get
used.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v7.0-rc1
- Link to v2: https://patch.msgid.link/20251218-selftests-filesystems-devpts-tiocgptpeer-v2-1-a5fb5847fe58@kernel.org

Changes in v2:
- Rebase onto v6.19-rc1.
- Link to v1: https://patch.msgid.link/20251126-selftests-filesystems-devpts-tiocgptpeer-v1-1-92bd65d02981@kernel.org
---
 tools/testing/selftests/filesystems/devpts_pts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index 54fea349204e..aa8d5324f2a6 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
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
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251126-selftests-filesystems-devpts-tiocgptpeer-fbd30e579859

Best regards,
--  
Mark Brown <broonie@kernel.org>


