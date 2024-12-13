Return-Path: <linux-fsdevel+bounces-37310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DF9F0F41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853221882F9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359401E2031;
	Fri, 13 Dec 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxOVPV0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421D53BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100471; cv=none; b=q2J2x3SyAqqTHqI0Cjyi/ZeKcg9hblxCzpRWgrFXM5X9n2ikOaVfOzmdmi2snGnTfjSaDhr1FXEN7PTacUVr2hnZWwFyD1t6el0tjdh7/7/zXYHPPkSoynDH8LcKgrMgVuONZ0y/8VfWiyvgLm6T/g+JFT3aDP1UEa8cx8zQlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100471; c=relaxed/simple;
	bh=yFtZD+UPM1ePkp0Yq4a3wIk67MwG6zsMYHtpmOjHkJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hS//T6DyvJxIMGuzpMdtPBF55lLOkGhBANTnqAu3HkZdBmArjTGhWHAUMIkZFpkdvmSUd9dUXOCrYGA0IAXUlsC2Y3SOQ2F09TVwUNpWP7R1Khl8H/gw2R6ttKt3IadfNs/5g5jyTsq8hQYHz9QRZydzCHXZKDBI3lXSkb8GbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxOVPV0p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P6N8JzZaMC3z4vaLYtDoojUwf2WJU58QmHrWCSEOujQ=;
	b=QxOVPV0pvwbcSVAUt/AXtCNW8paNXnsuqpF3QCpSCyZx+iuYIPb3OC6BwxsS4ogYu5J1sS
	pXZmAHU72VLqTP9mRDWq3m1u0VxeiBCwv6/jwmn0uqaBbAq/7HSQeZvI1XFw9vqUFOSjKs
	umTHKN3F93NHiI72JBDFrsJ8WXTP5Qo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Mdk_dJWPN46BYSD4GBosEQ-1; Fri,
 13 Dec 2024 09:34:24 -0500
X-MC-Unique: Mdk_dJWPN46BYSD4GBosEQ-1
X-Mimecast-MFC-AGG-ID: Mdk_dJWPN46BYSD4GBosEQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65B7619560AF;
	Fri, 13 Dec 2024 14:34:23 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FA21195605A;
	Fri, 13 Dec 2024 14:34:22 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 0/6] iomap: incremental per-operation iter advance
Date: Fri, 13 Dec 2024 09:36:04 -0500
Message-ID: <20241213143610.1002526-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi all,

This is a first pass at supporting more incremental, per-operation
iomap_iter advancement. The motivation for this is folio_batch support
for zero range [1], where the fs provides a batch of folios to process
in certain situations. Since the batch may not be logically contiguous,
processing loops require a bit more flexibility than the typical offset
based iteration.

The current iteration model basically has the operation _iter() handler
lift the pos/length wrt to the current iomap out of the iomap_iter,
process it locally, then return the result to be stored in
iter.processed. The latter is overloaded with error status, so the
handler must decide whether to return error or a partial completion
(i.e. consider a short write). iomap_iter() then uses the result to
advance the iter and look up the next iomap.

The updated model proposed in this series is to allow an operation to
advance the iter itself as subranges are processed and then return
success or failure in iter.processed. Note that at least initially, this
is implemented as an optional mode to minimize churn. This series
converts operations that use iomap_write_begin(): buffered write,
unshare, and zero range.

The main advantage of this is that the future folio_batch work can be
plumbed down into the folio get path more naturally, and the
associated codepath can advance the iter itself when appropriate rather
than require each operation to manage the gaps in the range being
processed. Some secondary advantages are a little less boilerplate code
for walking ranges and more clear semantics for partial completions in
the event of errors, etc.

I'll post an RFC of the folio_batch work shortly after this to give an
example of how this is intended to be used. Otherwise, the changes here
actually aren't all that substantial. Patches 1-2 are prep work, patch 3
enables incremental advances, and patches 4-6 switch over a few
operations. Thoughts, reviews, flames appreciated.

Brian

v1:
- Reworked and fixed a bunch of functional issues.
RFC: https://lore.kernel.org/linux-fsdevel/20241125140623.20633-1-bfoster@redhat.com/

[1] https://lore.kernel.org/linux-fsdevel/20241119154656.774395-1-bfoster@redhat.com/

Brian Foster (6):
  iomap: split out iomap check and reset logic from iter advance
  iomap: factor out iomap length helper
  iomap: support incremental iomap_iter advances
  iomap: advance the iter directly on buffered writes
  iomap: advance the iter directly on unshare range
  iomap: advance the iter directly on zero range

 fs/iomap/buffered-io.c | 46 ++++++++++-----------------
 fs/iomap/iter.c        | 72 ++++++++++++++++++++++++++----------------
 include/linux/iomap.h  | 14 ++++++--
 3 files changed, 73 insertions(+), 59 deletions(-)

-- 
2.47.0


