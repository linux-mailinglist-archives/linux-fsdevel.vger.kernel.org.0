Return-Path: <linux-fsdevel+bounces-54696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FC7B02476
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 21:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917CE7A9399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5C2EF9CC;
	Fri, 11 Jul 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="z175gQpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11C1E00B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261609; cv=none; b=XHV830YWkyZLb6e1gfxn4LK+gWTXd5uno5qS7cUQxgbllhy2p5ll1+ufegmrHgxpdvEy5uOCGRmt+JFZ1+WjkS82AoE/F0Ljjvs77xyrOa6zUKovQx2gXwQorPBVYqAZ6cmKNTWknWqffxWuufb1lWEv18WPzGx9wkqLHFQiQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261609; c=relaxed/simple;
	bh=nfrBas3+tC4+wyryUZlyqW+BnLEfrE6Z9dkDddwyLdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dSm786wmyQ6MAErSyfX150/R1/4yFBZ6hnDvULUrcUcNXcwzqfiyeJSHMVOf2hbcaiQA1+5Fh7LzmC2xgOHHPWAhjVLrHdUeg2knIgQWtDLkJhpl3CCubHFWjm28PihnBFTUrnxcW+OgP9M4A+zIYhbak31Rzdkd9JjknH+ZsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=z175gQpo; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bf1kN0yp5zNHp;
	Fri, 11 Jul 2025 21:19:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752261596;
	bh=s6LMdhlLzq+Om1yenjXuqcSNzbRMr+2AP8W0jPDUv1g=;
	h=From:To:Cc:Subject:Date:From;
	b=z175gQpohRTzvaav/hd3/A4/0tCZmMZbVlO0EeAPjJ3giLmQURBMEzskxu+HLp/iV
	 64XvJC4G4a55ZuFReb0/AAGDTWSHfrjwhsxwQ6qtFSw3LCnxtGVpbv10LeQ4nL+Qko
	 swZ4SOE30ag07NNJGAgtOuEiWtQwNZ86oY6OoGL8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bf1kM2T78zKjt;
	Fri, 11 Jul 2025 21:19:55 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/3] Landlock: Disconnected directory handling
Date: Fri, 11 Jul 2025 21:19:32 +0200
Message-ID: <20250711191938.2007175-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi,

This patch series fixes and test Landlock's handling of disconnected
directories.

This second version fixes initial reset access rights to not wrongfully
deny some requests.  Also, a lot of tests are added to improve coverage
and check edge cases.

Previous version:
v1: https://lore.kernel.org/r/20250701183812.3201231-1-mic@digikod.net

Regards,

Mickaël Salaün (2):
  landlock: Fix handling of disconnected directories
  selftests/landlock: Add disconnected leafs and branch test suites

Tingmao Wang (1):
  selftests/landlock: Add tests for access through disconnected paths

 fs/namei.c                                 |    2 +-
 include/linux/fs.h                         |    1 +
 security/landlock/errata/abi-1.h           |   16 +
 security/landlock/fs.c                     |  124 +-
 tools/testing/selftests/landlock/fs_test.c | 1317 +++++++++++++++++++-
 5 files changed, 1432 insertions(+), 28 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

-- 
2.50.1


