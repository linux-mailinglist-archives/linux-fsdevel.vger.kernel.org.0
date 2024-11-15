Return-Path: <linux-fsdevel+bounces-34978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113609CF55E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CEC2820FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9261E1301;
	Fri, 15 Nov 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J68g6SN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB61DA23
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700829; cv=none; b=nSN/DrQqTNsX46ZtYXaJfxGdVzFNSthf8TSf4rmHBUhNFnQ9tnxd1CvfZzOVL1wBk1vt6AGGe1lM/VEBT02tqVpF/ZAQXyWT5p6b9/9NFozkUIEDOdxNx01ZnBmWfmFkWAZTUfjYbUNCh54khoyOOmcK7FDFWmcPjYUPcMt0SxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700829; c=relaxed/simple;
	bh=08Aa6vvPQS4QfNhVj2ez31vfeIrNw+g2CEKRYFqpECk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKwmRRaOKgLy4wV3Wlw8HLpaIBrkdOJ40ba2kXa2q2+Z5BL7Caj5veVZiiLKnX6l11nMT8l1ZBPZUIfUg0C9Tf5bXH4vIp4v4/Viz9eNVExvjrTmlZmm6Fr6y0YfsbK2iaqjgsfFV/UyfYeammOwk9AAFbrVtyD0c+1K33YYhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J68g6SN0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731700827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nAPUPGWq9EiDqg2+E5uyrXvP2R1jRrs8FLWMOsY6ij8=;
	b=J68g6SN0KPd/U/jbKsVrX53thMk3YS9KXF1qpNV0aS0+ytDRVl2IqZ9a99zx34/t0+A7Ao
	8l2y6oEqB4wv00J4w5IyIt5aRJf+l8wmeeZwBkKVIMeBH+W7dPY3VmkRJcMC0Cvn8RQKbG
	kZT1KjaZAXorVneblRg+No2k0d5rh1s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-3nizc3uTM96RlwaQp6fXmQ-1; Fri,
 15 Nov 2024 15:00:23 -0500
X-MC-Unique: 3nizc3uTM96RlwaQp6fXmQ-1
X-Mimecast-MFC-AGG-ID: 3nizc3uTM96RlwaQp6fXmQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 317CD19560B4;
	Fri, 15 Nov 2024 20:00:22 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E088B1953880;
	Fri, 15 Nov 2024 20:00:20 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org
Subject: [PATCH v4 0/3] iomap: zero range flush fixes
Date: Fri, 15 Nov 2024 15:01:52 -0500
Message-ID: <20241115200155.593665-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi all,

Here's v4 of the zero range flush improvements. No real major changes
here, mostly minor whitespace, naming issues, etc.

Brian

v4:
- Whitespace and variable naming fixes.
- Split off patch 4 to a separate post.
v3: https://lore.kernel.org/linux-fsdevel/20241108124246.198489-1-bfoster@redhat.com/
- Added new patch 1 to always reset per-iter state in iomap_iter.
- Dropped iomap_iter_init() helper.
- Misc. cleanups.
- Appended patch 4 to warn on zeroing beyond EOF.
v2: https://lore.kernel.org/linux-fsdevel/20241031140449.439576-1-bfoster@redhat.com/
- Added patch 1 to lift zeroed mapping handling code into caller.
- Split unaligned start range handling at the top level.
- Retain existing conditional flush behavior (vs. unconditional flush)
  for the remaining range.
v1: https://lore.kernel.org/linux-fsdevel/20241023143029.11275-1-bfoster@redhat.com/

Brian Foster (3):
  iomap: reset per-iter state on non-error iter advances
  iomap: lift zeroed mapping handling into iomap_zero_range()
  iomap: elide flush from partial eof zero range

 fs/iomap/buffered-io.c | 88 +++++++++++++++++++++---------------------
 fs/iomap/iter.c        | 11 +++---
 2 files changed, 50 insertions(+), 49 deletions(-)

-- 
2.47.0


