Return-Path: <linux-fsdevel+bounces-55548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F6B0B9DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 03:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09317A5198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944D18BC0C;
	Mon, 21 Jul 2025 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="OtZ+xECl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F98F40;
	Mon, 21 Jul 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062953; cv=none; b=NSDhRalSXiKYMGL5CyYG1T5A+w4lyLnIBYaX8rBvMVHK7fIACPgfIw7vPeV0RnRjFXtsEHpfOwgKAx+2MHmcpEKLDmLLcHJBTO+IvwejT6U/DBiEGJLq0m9jHmIvRnd8A5fPDkxKHhbyu4ebd5k2iR/rJnW3vaWN7f+28gaWE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062953; c=relaxed/simple;
	bh=VAKaSJmtNmzgSVuSIxO04Qedewfp7qeQAq6n5kMBBVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qKvQxaMeeYFNbFzsZTs6ZOUwyZRYZFXk0XB0jeqngDWQ/PLcM3HnBmUdJplaI9/lExANPttTm8YmWNbqX0Nigdl+f3lwlj+YOtAWyIwrO6KMbFlzZeGfQ6HTqNizzOeEINLPKTiVsjEeKAelCZWlvgAqb3vQyWXxlgkXEVmKtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=OtZ+xECl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4blk4y70qSz9ssn;
	Mon, 21 Jul 2025 03:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753062947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EEI9/Md4eBKhgsbhNrEczfjHWuVAnYhWLgaDPG7L3mM=;
	b=OtZ+xEClrgggEL2GJWGMT/1tXSqI7U0/ntdPZyf7jWd+sULr0SDOdr9qSw3PDG1eex2LHX
	il+hU/JAXyZX1uUU9U093LgZz1fKc/pzXPN1HKq0l/RZsRpvg/k672+wr8+0qa7AcIwdbQ
	ulTEhrzeabr0D8WAso3OlOWifSKcp5ovEZHbJxqZMSQJaLg3QXS24+aub2dUJn4XyhQSCL
	/asqtfhGQbS/hRd26QS6lfxRZHPdMP7DiLH86S2YTrqOsvPBwfvzs9u2jL7PvE/ZaneysQ
	Petc19SYDfXQhjyn2Cpt6PcMyGG59rtUEzouWHaTrOa8qo7y+ztBcwktcrEktg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 21 Jul 2025 11:55:36 +1000
Subject: [PATCH] openat2.2: update HISTORY to include epilogue about
 FreeBSD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-openat2-history-v1-1-994936dd224a@cyphar.com>
X-B4-Tracking: v=1; b=H4sIABeefWgC/x3MQQqAIBBA0avIrBN0IqyuEi3MppyNhkYU4d2Tl
 m/x/wuZElOGUbyQ6OLMMVToRoDzNuwkea0GVNgpg1rGg4I9UXrOZ0yPRNtvRruB2kVBrY5EG9/
 /cZpL+QBIhgYmYQAAAA==
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=VAKaSJmtNmzgSVuSIxO04Qedewfp7qeQAq6n5kMBBVk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWTUzpN1uBqj+PnQPt8MGbtX6+K5d4WsPbx30ZVX2VUML
 p+uvdm3t6OUhUGMi0FWTJFlm59n6Kb5i68kf1rJBjOHlQlkCAMXpwBMZP8shr+CxpJyp56cWNE2
 ++5f40WSJu+zEjU6NiZpiPx1b6vpDudl+J/8lDdZXIVh2hr3e2zPa3u7anuumU/IfqjZl7i/Ydb
 OWg4A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4blk4y70qSz9ssn

While RESOLVE_BENEATH was based on FreeBSD's O_BENEATH, there was a
well-known safety issue in O_BENEATH that we explicitly avoided
replicating -- FreeBSD would only verify whether the lookup escaped the
dirfd *at the end of the path lookup*.

This meant that even with O_BENEATH, an attacker could gain information
about the structure of the filesystem outside of the dirfd through
timing attacks or other side-channels.

Once Linux had RESOLVE_BENEATH, FreeBSD implemented O_RESOLVE_BENEATH to
mimic the same behaviour[1] and eventually removed O_BENEATH entirely
from their system[2]. It seems prudent to provide this epilogue in the
HISTORY section of the openat2(2) man page (the FreeBSD man page does
for open(2) not reference this historical connection with Linux at all,
as far as I can tell).

[1]: https://reviews.freebsd.org/D25886
[2]: https://reviews.freebsd.org/D28907

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/openat2.2 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/man/man2/openat2.2 b/man/man2/openat2.2
index e7d400920049..53687e676ae5 100644
--- a/man/man2/openat2.2
+++ b/man/man2/openat2.2
@@ -478,7 +478,20 @@ Linux 5.6.
 The semantics of
 .B RESOLVE_BENEATH
 were modeled after FreeBSD's
+.BR O_BENEATH ,
+but avoided a well-known correctness bug in FreeBSD's implementation that
+rendered it effectively insecure.
+Later, FreeBSD 13 introduced
+.BR O_RESOLVE_BENEATH
+to replace the insecure
 .BR O_BENEATH .
+.\" https://reviews.freebsd.org/D25886
+.\" https://reviews.freebsd.org/D28907
+FreeBSD's
+.BR O_RESOLVE_BENEATH
+semantics are based on Linux's
+.BR RESOLVE_BENEATH
+and the two are now functionally equivalent.
 .SH NOTES
 .SS Extensibility
 In order to allow for future extensibility,

---
base-commit: 5d53969e60c484673745ed47d6015a1f09c8641e
change-id: 20250721-openat2-history-2a8f71c9e3b0

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


