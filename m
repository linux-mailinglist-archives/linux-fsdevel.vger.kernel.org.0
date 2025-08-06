Return-Path: <linux-fsdevel+bounces-56810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E624EB1BFF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 07:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89FD1894B95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 05:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0E1F5842;
	Wed,  6 Aug 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="h7mT/qah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8763CF;
	Wed,  6 Aug 2025 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458286; cv=none; b=TxQ0Fgpi6otcJg6HWctRTxoCUWj/ZaQgy81t2IZfODVdtJjnu0PkbetRawgfBARBOHxMe+kX8jJ90zRFOv9+Q7lfFO5B6NyA5rK8mn8P4CYN68HAFs/qVir2HcL3uBu1h6Syg4enmOszPo0KzKkbhhUA5LkNM/v1nNpXYI0HSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458286; c=relaxed/simple;
	bh=2RYD2pQObq3tNb04UFNYpATe1tShwI1TlP+mfS+PGx0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EBngff1f7qqWm0yAMEvXYw20b7tj2Utx8z32HLpDWlqETHCquSi09CzAAdClshDeV+KvtLRibqFcLQTUa310azFnwl7wciXy56asB9Pj2VPXtWm1986vZjoKbMotI7JRKn6a3MBCFsSj5H02QF0+URZm1MgY0FnMMBPl4LCjK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=h7mT/qah; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxf6J29phz9sd0;
	Wed,  6 Aug 2025 07:31:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754458280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=is0tc9fB94hygPbW8dEcANHhDnM2HyIndcnLOHNoUEI=;
	b=h7mT/qahCc8sQfrIpiP1mgi2ljRqKSfkGgelDrbsHNLj3kxdzcT6wYYs2eqVPF2o29j+2t
	m/uOe1FZ6Y4zBWOh5iTkHRgF02vaS2EorNqKJ6jQZ0fEFVttqvfUCWHJ6K8xZ4IE+3q8Gv
	90iDojt/EgFXFQ3vebTFww5voYHPxMNEf8L1xtfDaqc/W8BGqlvR1bTV/9Qy21JDUy1O/a
	NMzL0t2A7LbAaFuFsy2KzrZ1EAQZteha/SkOTevjow8NDfhFuDjtidS1T7bgL+n5ZGVL12
	dffLdIl4TxzeQWKTJAZuHvPvWV1rArr/0gfioSedQJDSiC4OpcVl1tUA2Q1y7A==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 0/2] fscontext: do not consume log entries for -EMSGSIZE
 case
Date: Wed, 06 Aug 2025 15:31:09 +1000
Message-Id: <20250806-fscontext-log-cleanups-v1-0-880597d42a5a@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3okmgC/x3MSwqAMAwA0atI1gbiX7yKuCg11YC00qgI4t0tL
 t9i5gHlKKwwZA9EvkQl+IQiz8Cuxi+MMidDSWVDPbXo1AZ/8H3gFha0Gxt/7ooNOSrqqu1qw5D
 iPbKT+x+P0/t+cQZ5xmgAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=2RYD2pQObq3tNb04UFNYpATe1tShwI1TlP+mfS+PGx0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMerFI9c5hCXcrHbOXa6Paguz+mOy50rmv8EtVnt1kF
 879/HtXdJSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJqB1m+O/Mx23+Ve31/6S7
 L4Se/jVROHd/le2/xNb06yo6M7a6HPrKyNDvdfikouVp2xUTzXtf+299unhW5pJ7vj7C/KV9G+b
 WP+IAAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Userspace generally expects APIs that return EMSGSIZE to allow for them
to adjust their buffer size and retry the operation. However, the
fscontext log would previously clear the message even in the EMSGSIZE
case.

Given that it is very cheap for us to check whether the buffer is too
small before we remove the message from the ring buffer, let's just do
that instead.

Fixes: 007ec26cdc9f ("vfs: Implement logging through fs_context")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Aleksa Sarai (2):
      fscontext: do not consume log entries for -EMSGSIZE case
      selftests/filesystems: add basic fscontext log tests

 fs/fsopen.c                                    |  22 ++--
 tools/testing/selftests/filesystems/.gitignore |   1 +
 tools/testing/selftests/filesystems/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fclog.c    | 137 +++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 9 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250806-fscontext-log-cleanups-50f0143674ae

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


