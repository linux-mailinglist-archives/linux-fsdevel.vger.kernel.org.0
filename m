Return-Path: <linux-fsdevel+bounces-60517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 441EBB48E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359AE1B26E61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F9303A26;
	Mon,  8 Sep 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7Sh9yMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE3303A1B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336226; cv=none; b=psnmo9efw+PK7HrnCI4mc8doZxTCOeWrEst6C7GujUOu8YhzAg5bY1/5CZdXgYB42I6FRF++5915fKc8uhr4sXz6gGaaWdPISqsFL6lwRk3Jas2hQ9Lv2tesOiUkxROpENofhAS59+sdYa9PqFeuJLJEMdr0z8HbTjWFjH0Q82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336226; c=relaxed/simple;
	bh=E3gsleOXnXA3suE0igHg9JzS4476PLjtVmwdlRH4xpk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMPrQmQYi83PmfA6ENtvNnAk6kv34bJxmIQCDj1o9NXdqqJQOTClz8laFC8pdLMozGz5RWw2af/FCPjoNfeuF/fX3/sTctAXx39VOjlOPS5vzQ3GTDRRN8NZb0eTKtuL1ROS6zlPMeK80Yxawcmn/p0SSRpJxCV6Jl3iQEPZws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7Sh9yMA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757336223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vKMwsBStQu+Kw1KvPxsPWcF5rUYSs5h6ZCmutbu606k=;
	b=F7Sh9yMAYKYAQNE+FHUQC5FMhmGuq6FhsvnhSiv1xZwAMSg4LgTFn2jxIe+ZCQQs+QgNip
	CmZJkZ5NQzjrBr8ygVDFYHHES7ZhtCtpflc9EAt37uQ7KLKtrZpzwaG7RTpihRaJTgsNS6
	DEXIFIiy9ftuTD53X9NpzFSmvB45Azo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-0I1gYvyRO_GL2i0Yo9CgFQ-1; Mon,
 08 Sep 2025 08:57:00 -0400
X-MC-Unique: 0I1gYvyRO_GL2i0Yo9CgFQ-1
X-Mimecast-MFC-AGG-ID: 0I1gYvyRO_GL2i0Yo9CgFQ_1757336219
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B29531800562;
	Mon,  8 Sep 2025 12:56:59 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.44.33.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF70119540EE;
	Mon,  8 Sep 2025 12:56:57 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 0/2] iomap: ->iomap_end() error handling fixes
Date: Mon,  8 Sep 2025 09:01:00 -0400
Message-ID: <20250908130102.101790-1-bfoster@redhat.com>
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

This is a couple small error handling fixes for ->iomap_end() errors
(via iomap_iter()). The immediate problem here was that the
->iomap_end() error return started overriding an iter.status error code,
which on ext4 happened to trigger dio fallback to buffered I/O in some
cases. Jan has actually fixed that separately in ext4 [1], but I wanted
to take an independent look at iomap to see if it is worth fixing as
well.

The more I poked around the more it seemed like it's more appropriate to
return the initial error code in iter.status if one is pending. I also
eventually noticed the DAX vs. reflink case documented in patch 2, which
further tweaks the error handling and supports the former reasoning.

These are separate patches because they are separate issues. This has
survived my testing since the RFC was posted and some Reviewed-by's have
trickled in, so there are no real changes for v1 other than adding those
tags. Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-ext4/20250901112739.32484-2-jack@suse.cz/

v1:
- Added R-b tags.
rfc: https://lore.kernel.org/linux-fsdevel/20250902150755.289469-1-bfoster@redhat.com/

Brian Foster (2):
  iomap: prioritize iter.status error over ->iomap_end()
  iomap: revert the iomap_iter pos on ->iomap_end() error

 fs/iomap/iter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.51.0


