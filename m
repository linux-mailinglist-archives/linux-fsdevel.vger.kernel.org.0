Return-Path: <linux-fsdevel+bounces-70171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4032C92C94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 18:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29DDA4E38DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB832ED2E;
	Fri, 28 Nov 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RGQoObzu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3992627EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350543; cv=none; b=cBbvRjdawHCs2KXtfByNjzteywblVuQMNfa6ImM87fOoeHcmDysli5YnU++5OOt39d2D3Axosq1cSLU9YnSC5JHdvLYEP3H9XjKNy9JR8+k7NgEpqQLJ5ZfKqCXzEHZXoNrYzSBQp2UPDKJe3e3TSZZfaAy8v/Sgq/xtAUgapAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350543; c=relaxed/simple;
	bh=P6UIVr2CNd4ad7Fu1upHIBzuTPQC7fing/byQ1HTTrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMQbQVRJOQK2HR4ki005zpupQsOUhkmFMLo90760WnjZ0O9qmo+ZnVey8hC12QKkhMBGswm37i9h3/U73Xp4sYTzaUSzDfq2mZ5SULRNHTggwh8b69DyMUECeURqYM2pI9kYNS5/6RTyArhESUrfbH7FSLeNzwwgwfiXmXKyggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RGQoObzu; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dJ0Tw4jyCz5Dj;
	Fri, 28 Nov 2025 18:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764350532;
	bh=iaAABCSbs4TYzo2GswVcvmxZzq7Ib83Nu4YA+H9Sx3o=;
	h=From:To:Cc:Subject:Date:From;
	b=RGQoObzuNjoGHzARj+mFO5BRVuoUsij/20wM9sLmHM+ptWQANMtx3C4f9OLyshK8L
	 Ve9JcRlRNgkzVREHQ52l79/g9Jf7h4rHtVvUPL10MqEzu6THg6BmP5p/73VLJzPESa
	 6QsOfZcrBrfbAC6kFL934GFXrCO4NopynzG5oiS0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dJ0Tv5hpgz3tl;
	Fri, 28 Nov 2025 18:22:11 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	NeilBrown <neil@brown.name>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 0/4] Landlock: Disconnected directory handling
Date: Fri, 28 Nov 2025 18:21:55 +0100
Message-ID: <20251128172200.760753-1-mic@digikod.net>
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

This fifth version improve a comment and add more tests.

This approach is not perfect but it is the best we found:
https://lore.kernel.org/r/20251128.oht7Aic8nu9d@digikod.net

Previous versions:
v4: https://lore.kernel.org/r/20251126191159.3530363-1-mic@digikod.net
v3: https://lore.kernel.org/r/20250719104204.545188-1-mic@digikod.net
v2: https://lore.kernel.org/r/20250711191938.2007175-1-mic@digikod.net
v1: https://lore.kernel.org/r/20250701183812.3201231-1-mic@digikod.net

Regards,

Mickaël Salaün (3):
  landlock: Fix handling of disconnected directories
  landlock: Improve variable scope
  selftests/landlock: Add disconnected leafs and branch test suites

Tingmao Wang (1):
  selftests/landlock: Add tests for access through disconnected paths

 security/landlock/errata/abi-1.h           |   16 +
 security/landlock/fs.c                     |   43 +-
 tools/testing/selftests/landlock/fs_test.c | 1474 +++++++++++++++++++-
 3 files changed, 1512 insertions(+), 21 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

-- 
2.51.0


