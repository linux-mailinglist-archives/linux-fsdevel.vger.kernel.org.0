Return-Path: <linux-fsdevel+bounces-56823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E44B1C0A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D339118A030E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF1213254;
	Wed,  6 Aug 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="iuto2o0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF619004E;
	Wed,  6 Aug 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463023; cv=none; b=H07zE4KbbPR44IZmLz38JFrjvQ6hIbv5v6O71ayjCtokPbGfkpWyBE6wT2mZHegFY+RiochF0SUl5e7VB8zZVXCdKp73WgpcDrPs5aOimqV6jQFiHqlVnEI2nt2iqXECaWESPkSxRulGoIdpKsQ0516n+kuxP7keHicV5VYlVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463023; c=relaxed/simple;
	bh=JczhU5pM013iI83aouiqP4IVd5Ev3N0r9QjhV/E8Sp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQq8wtmDqc5O1is9AVNwH7qoeJVZhXCoDEhkqtOZrPxACFfBYryT2U2YzHnfQ8av8EGekiX72LiDPfHw8Q7cT6VDJEwstZY5mTzXhXknU8qO1DGvv38TIMl9dBYqLiZ9NNgrexyjsxAfD4R/qZO0GA5/LpO9NDvhzPa6SdfUhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=iuto2o0t; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bxgsL11P4z9slr;
	Wed,  6 Aug 2025 08:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754463014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/kk+ECCud1N6/ryh54JK38bVRbSm/UgdDZHvwcylPk8=;
	b=iuto2o0tB+iM7qDWwirz//G18WXFUSVTOzJNFhaElFGpNKsklXPReGYqhU4Tl2l0Kmk48C
	vYEVRofk1P/ou/3joy4YHRulvsRsS9x7wJUPb4hfERR3hcyPCf6RnL5Vct1FEMBrxZfiat
	99LvK4OQ/3ekgw2WZJMoXAS6BQDi0ZqtYNtD6SXSKsTgPyWhjIpUQvbRQ63fqaIMfZS5aC
	keq/nAQBvj/pvL9Jv12PX4xJ+mKtHRrmSTGsVAzR3oK/pIj4BXwfRWo7dQDrNNFM0EpUQV
	O4eG/V9m2x+0epyLw9jOgfxgip7Z+kpBqNVI4rEc6KJ4p2Ky7jBislcb2feOhw==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 0/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Date: Wed, 06 Aug 2025 16:49:53 +1000
Message-Id: <20250806-fscontext-log-cleanups-v2-0-88e9d34d142f@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABH7kmgC/4WNQQ6CMBBFr0Jm7ZihUkBX3sOwaMoUmmBLWiQQ0
 rtbuYDL95L//gGRg+UIj+KAwKuN1rsM4lKAHpUbGG2fGQQJSS3VaKL2buFtwckPqCdW7jNHlGS
 orG51UymGPJ4DG7ud4VeXebRx8WE/f9byZ/8m1xIJ25bkvekroaR66n0eVbhq/4YupfQFZJHRT
 b0AAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=JczhU5pM013iI83aouiqP4IVd5Ev3N0r9QjhV/E8Sp8=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRM+i1mrpqWGq8lc6KkIFf9hp+w1/esHXbeOlk/g8tkf
 a3+JNp3lLIwiHExyIopsmzz8wzdNH/xleRPK9lg5rAygQxh4OIUgImUNDIydFVx33ee2ji9lkWe
 u96+8ZXa8xCXm41Xyn4zvleR7vsqzMhwvntqto52T/i3nPm/q1ZEMEx95sk0fcqsR+29KRt2qTc
 zAgA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Userspace generally expects APIs that return -EMSGSIZE to allow for them
to adjust their buffer size and retry the operation. However, the
fscontext log would previously clear the message even in the -EMSGSIZE
case.

Given that it is very cheap for us to check whether the buffer is too
small before we remove the message from the ring buffer, let's just do
that instead. While we're at it, refactor some fscontext_read() into a
separate helper to make the ring buffer logic a bit easier to read.

Fixes: 007ec26cdc9f ("vfs: Implement logging through fs_context")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- Refactor message fetching to fetch_message_locked() which returns
  ERR_PTR() in error cases. [Al Viro]
- v1: <https://lore.kernel.org/r/20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>

---
Aleksa Sarai (2):
      fscontext: do not consume log entries when returning -EMSGSIZE
      selftests/filesystems: add basic fscontext log tests

 fs/fsopen.c                                    |  54 +++++-----
 tools/testing/selftests/filesystems/.gitignore |   1 +
 tools/testing/selftests/filesystems/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fclog.c    | 135 +++++++++++++++++++++++++
 4 files changed, 167 insertions(+), 25 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250806-fscontext-log-cleanups-50f0143674ae

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


