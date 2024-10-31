Return-Path: <linux-fsdevel+bounces-33351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF059B7C4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928CF1F223DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD71A00E2;
	Thu, 31 Oct 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzTTuc0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2514F121
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383407; cv=none; b=VelwKZi+dEWon/GlPVne+JKFXiyXk+RqMvaKpBj2Ndpld/sKX1ywJP34seVrZ45Ju7oZlwnyM3umKr7MfL6yyCx1tiWH2gKDFAQK6dI54DhJUwJKf+JdInt8gUzeynRoG6ikv9QhKW0iTkY3NgnwWot7Rgw1UukUHIWj857Qcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383407; c=relaxed/simple;
	bh=ORMMfHD0704KdLjeHSczKsfoBJUA+wC+ZhHF3DzqHN8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJ/LPdhZKYMMP71NACu3irRi9sCJBbBwR6ZeUTW2GiH+uvlWtKa0WwkLUB029RRkwYT4Pt8vIT/W4QkuUllLYQLuMhViPSpNxSrrEEz5BRXoWq6zt7iua46eQYR4pAB2QDmvJ/w+qvb7K/cyG8pyA+DVaRRHqlVZQy6XCvLIOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzTTuc0J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730383404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BoRAB9KfY9Z3tEXztO1Dnw8/aEGgX4fJyFSDTjTkIvM=;
	b=EzTTuc0JFFq41MLih7faScdXK9Jg7z5gPYJBa4b7q3s2jJx2kCDf6OeToMRrVR24nFAYiv
	tga6qeMH7Y9zGNYCkKsU0oj5CxlqoWOUaOkdJSgGNVDCIRYltk4RqXQlu6h9BFPJz7Ov7y
	CLg4fL79JuqmRip+gAtMgoHtRpCqytk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-cum_cxw5PvuDVDUgvDKRTg-1; Thu,
 31 Oct 2024 10:03:23 -0400
X-MC-Unique: cum_cxw5PvuDVDUgvDKRTg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A16B1945CB5
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:21 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A208019560A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:20 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] iomap: avoid flushes for partial eof zeroing
Date: Thu, 31 Oct 2024 10:04:46 -0400
Message-ID: <20241031140449.439576-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi all,

Here's v2 of the performance improvement for zero range. This is the
same general idea as v1, but a rework to lift the special handling of
zeroed mappings into the caller and open-code the two approaches from
there. The idea is that for partial eof zeroing, we can check whether
the folio for the block is already dirty in pagecache and if so, zero it
directly. Otherwise, fall back into existing behavior for the remainder
of the range.

This brings stress-ng metamix performance back in my local tests and
survives fstests without seeing any regressions.

Thoughts, reviews, flames appreciated.

Brian

v2:
- Added patch 1 to lift zeroed mapping handling code into caller.
- Split unaligned start range handling at the top level.
- Retain existing conditional flush behavior (vs. unconditional flush)
  for the remaining range.
v1: https://lore.kernel.org/linux-fsdevel/20241023143029.11275-1-bfoster@redhat.com/

Brian Foster (2):
  iomap: lift zeroed mapping handling into iomap_zero_range()
  iomap: elide flush from partial eof zero range

 fs/iomap/buffered-io.c | 99 ++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 43 deletions(-)

-- 
2.46.2


