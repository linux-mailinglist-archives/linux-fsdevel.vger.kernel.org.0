Return-Path: <linux-fsdevel+bounces-69910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59575C8B889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DC70346DB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8A33F394;
	Wed, 26 Nov 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tj3LzkvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76263148BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764184335; cv=none; b=nlqCZHzrJO4ea7YRKlUmEz0N7ODh0fOZU/iEncf9pNVwjiip1prIGIu+d+T8aN5rcxKjnonwxZVaAthOgkYUNGj0flFkoDpOMO5fJl84ePAzLq2A2OC4EDGdv2r0L31q8XN/06njmyAxIrIDlP50Qh1YrcvJ4SfDHgLRFSVSfiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764184335; c=relaxed/simple;
	bh=Cwoq2ma9ZZxfqmgLgzptaFPoWzYAqQ4SZkGO42dhMyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hcO5059S/j/BNtM6Sdn4TMd52Xru6udwMucsd1kqfMyJ0N8s7a9lyKsDOsRWGCJOfliYFaYFgGZyVKyosH+QuDTRDPbEpj5z1BisO6u9wo7v8ayIMfFQ5rPEUralt3fV10CfHTX8WLCcMQBrGFOmtn7Q7qiwfcGJ0zcVgjd+ZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tj3LzkvG; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dGq1b4N9dzf94;
	Wed, 26 Nov 2025 20:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764184323;
	bh=vTKBVYOCE/I20IjvfX+o3ThluEwSnb226Eg4T2+sfJk=;
	h=From:To:Cc:Subject:Date:From;
	b=tj3LzkvGbUxqq6fI87oyh8wkDAz1TcMk/cVkRflY5PAQEz/knvP76J8x4nZySnxBS
	 7tb1EyZXuy9SV1/sjyYDWzjDzfgWPJYdZeZ9JP0qKsJt/arLxgVJBibKOWRTijNXOg
	 xftdPtamlXYSm+HozRUySm9nOe393n0oYLn1Jbv4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dGq1Z3zLfzVxJ;
	Wed, 26 Nov 2025 20:12:02 +0100 (CET)
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
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Paul Moore <paul@paul-moore.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 0/4] Landlock: Disconnected directory handling
Date: Wed, 26 Nov 2025 20:11:53 +0100
Message-ID: <20251126191159.3530363-1-mic@digikod.net>
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

This fourth version implements an hybrid version of disconnected
directory handling, simpler and safer, suggested by Tingmao.  One patch
was merged, and a new one improve variable scope.

Previous versions:
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
 tools/testing/selftests/landlock/fs_test.c | 1335 +++++++++++++++++++-
 3 files changed, 1373 insertions(+), 21 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

-- 
2.51.0


