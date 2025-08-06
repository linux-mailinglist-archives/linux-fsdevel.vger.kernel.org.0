Return-Path: <linux-fsdevel+bounces-56871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60387B1CB77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD3165C1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46A929ACE5;
	Wed,  6 Aug 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="TQFxLmJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775D1E7C03;
	Wed,  6 Aug 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502940; cv=none; b=QOpIS/ty+6N01cXvCIVu5tVEHjPr4YRO8GZy7ql4jcX6NwnMlp9YoGktS9UhLHEltnfvUz7m1sgsQwkMa+FHat6UydaeK218mO9R+mL4BDWFZ8YBTFnApnt3HH9HKBDl3K2gNfnrLUcEY+yWkuPrRAmapW4GUAXJGELiCXa2ooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502940; c=relaxed/simple;
	bh=7sGOK1HbMV2yAJZ5byPs1K26Aem9Pe9kK2x28ncmDnE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u6/UPynVcrdoeLkslhup0tA3DXF94y2HDIDwzsis3iVW6R/Aj+oBCTxCvfbB2OLD2YOiXef9WdiVkKkbxiP7uh17wqMwe2d7Go+xlpyPHHkv/Ptzi1Du6vsUtPJYefa05kNDfd16wjOczNvQvpMB930MiMMzbFlmYp4CCrz5XNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=TQFxLmJy; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxyd03t9Bz9sZK;
	Wed,  6 Aug 2025 19:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y9pX0bCl4McW/rTvOXLdP6eFfo1IPUimuTRLuRX27D4=;
	b=TQFxLmJyxtzoFkVYQASkhLeRIQxrqa8cPDHL7n4IUBSgPhdWqIVoDoGtEEaAOmCtQ79zbO
	jnQZ2hTF8lrgFXx6kJ7PQkSdeN3VjpCNc1fRPAPGHNWqC1JLngqkE1nGvRcBJz6wt/sMYe
	vW/0ulIzfVDUgpwKaMMQEln19zDZVNa7pqdkZa3WiX/5bZfg6tk73Psfg+t2pYlGb7Rhhe
	dRn8rc4/lmZ9LxnaC3XKXbPGVM91N7Fwf0Ky763MHt/iMoDLa4OQ20TCFCjhg7dBIODvFx
	A8AWJzOvN57qkXxb+NIiRwg40ugQgHtZx23lGKEAuCj7tss4/sw332t4OQmOIQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v3 0/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Date: Thu, 07 Aug 2025 03:55:22 +1000
Message-Id: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqXk2gC/43NTQ6DIBCG4asY1qUBBH+66j2aLggMSmKBgCUa4
 92L7rpql++XzDMbShAtJHSrNhQh22S9K1FfKqRG6QbAVpdGjDBBOtJgk5R3MywznvyA1QTSvUP
 CghhCed20XAIqxyGCscsJP56lR5tmH9fzT6bH+pPMFBPcdUT0reZMCnlXaxhlvCr/QoeZ2X8OO
 x3odc015cx8Ofu+fwD890z0BQEAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=7sGOK1HbMV2yAJZ5byPs1K26Aem9Pe9kK2x28ncmDnE=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMns5vwvZrlacL2+4dCx5aze/zCJp6yXvX3a3HTHS9b
 705yLl5fkcpC4MYF4OsmCLLNj/P0E3zF19J/rSSDWYOKxPIEAYuTgGYSNFahv9ZL7PqOYReTBFr
 yO9NOrbj/7QPp07wemVzPYrsPrfScsdWhv8VZQdnx9bve3v83WNtOb99r0v7bFPt3nXcjGrQ9z+
 vv5sDAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bxyd03t9Bz9sZK

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
Changes in v3:
- selftests: use EXPECT_STREQ()
- v2: <https://lore.kernel.org/r/20250806-fscontext-log-cleanups-v2-0-88e9d34d142f@cyphar.com>

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
 tools/testing/selftests/filesystems/fclog.c    | 130 +++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 25 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250806-fscontext-log-cleanups-50f0143674ae

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


