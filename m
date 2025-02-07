Return-Path: <linux-fsdevel+bounces-41212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575FA2C55B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4DA7A4354
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8144323FC72;
	Fri,  7 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIB1pd+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149F23F26E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938638; cv=none; b=Y2NJonLoHlsJVBRFiyCPBaf5cm4G8qEMlRr+JobhU8w5MAeSGBWyXvAP2USRbbBuW+C0N+D1tE8sFlwSs/SfBOx+pq0QjVVmxqXH83+snygWohGNLBTrFOP5+LgtgctdqO35IuDFuuexADvTzn0kv7x/4CswiQ9pa91v5mbWPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938638; c=relaxed/simple;
	bh=tUjJkObDW8QJsnZXAzIkCuejhXsS6PQLYke8bWCA9Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U5nVh8+xSDQ89wWEkI/xlGAKf0hMhnsak2lWQ/78xeSb90DjHtd/bh8F6/gCACHZXg5wkGwCoI02gbzrq20d6J4W3QVEKsGEJUXhHubfxViCpf+pQJjgmQ0zhPyQBLMUldZqiF8zVzcYIHKvrzQg60DzdpyGBUtws8DgWEkexjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIB1pd+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IjUS6N+ZBpzbjXfQp+nedPv0lpFcfv0WqnF7TeYhgAI=;
	b=EIB1pd+KHOrAEiYZKqiZ1lGSa8Po7PGdkAOu+FcS5SLzj42/tOapO1V5eGUEOMCcwgZlyI
	PuJMWvgLUgWsCmgV0SJrUaZ351K/M3Vysjcs+YLjHZSytYMRZH/V9vgctzeZ6KD5suRYuL
	L8ErNCBoAvxG0TxmMJFy0XfqJAJtij4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-29abC8XwO52PAhefhHd2iQ-1; Fri,
 07 Feb 2025 09:30:28 -0500
X-MC-Unique: 29abC8XwO52PAhefhHd2iQ-1
X-Mimecast-MFC-AGG-ID: 29abC8XwO52PAhefhHd2iQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88DDF19560B5;
	Fri,  7 Feb 2025 14:30:27 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9940A180087A;
	Fri,  7 Feb 2025 14:30:26 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6 00/10] iomap: incremental per-operation iter advance
Date: Fri,  7 Feb 2025 09:32:43 -0500
Message-ID: <20250207143253.314068-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi all,

Just a couple comment changes, no code changes from v5.

Brian

v6:
- Comment updates in patches 6 and 7.
v5: https://lore.kernel.org/linux-fsdevel/20250205135821.178256-1-bfoster@redhat.com/
- Fixed refactoring bug in v4 by pulling 'processed' local var into
  patch 4.
v4: https://lore.kernel.org/linux-fsdevel/20250204133044.80551-1-bfoster@redhat.com/
- Reordered patches 1 and 2 to keep iter advance cleanups together.
- Split patch 3 from v3 into patches 3-6.
v3: https://lore.kernel.org/linux-fsdevel/20250130170949.916098-1-bfoster@redhat.com/
- Code style and comment fixups.
- Variable type fixups and rework of iomap_iter_advance() to return
  error/length separately.
- Advance the iter on unshare and zero range skip cases instead of
  returning length.
v2: https://lore.kernel.org/linux-fsdevel/20250122133434.535192-1-bfoster@redhat.com/
- More refactoring of iomap_iter[_advance]() logic. Lifted out iter
  continuation and stale logic and improved comments.
- Renamed some poorly named helpers and variables.
- Return remaining length for current iter from _iter_advance() and use
  appropriately.
v1: https://lore.kernel.org/linux-fsdevel/20241213143610.1002526-1-bfoster@redhat.com/
- Reworked and fixed a bunch of functional issues.
RFC: https://lore.kernel.org/linux-fsdevel/20241125140623.20633-1-bfoster@redhat.com/

Brian Foster (10):
  iomap: factor out iomap length helper
  iomap: split out iomap check and reset logic from iter advance
  iomap: refactor iomap_iter() length check and tracepoint
  iomap: lift error code check out of iomap_iter_advance()
  iomap: lift iter termination logic from iomap_iter_advance()
  iomap: export iomap_iter_advance() and return remaining length
  iomap: support incremental iomap_iter advances
  iomap: advance the iter directly on buffered writes
  iomap: advance the iter directly on unshare range
  iomap: advance the iter directly on zero range

 fs/iomap/buffered-io.c |  67 +++++++++++++--------------
 fs/iomap/iter.c        | 102 ++++++++++++++++++++++++++---------------
 include/linux/iomap.h  |  32 ++++++++++---
 3 files changed, 122 insertions(+), 79 deletions(-)

-- 
2.48.1


