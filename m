Return-Path: <linux-fsdevel+bounces-63316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE1BB4A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5504319E4608
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C826F2AD;
	Thu,  2 Oct 2025 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/196dYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727C1509A0
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425396; cv=none; b=fH+5c3a6tOcf7VYN8azUEb2mtjobz8Rs6jOJi4clB1Xlxi22Hai57oLXTGTv8e7Ic02FgH0HGKJcZJwLDUz27jWlYPDpI+0feRWE5/bIw+dDjv3IobP+ZrDfsUO6bYqgHl+c2FDAmjn3fQ0Eztd4775EMPOGiLR97f7p4jIK9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425396; c=relaxed/simple;
	bh=eqDn2n47zBXwEfzuao5AJpDGCY3+38EubDDycidAmqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HV1Mh+PTBiO4oE43oAeMKdK3/+G+5xdgyoHRwon2Z78kE4TNh4YCMD5LWzSTmu6l/kl7bsG3nYo4zHe8+uBMV608PHDYCM6fYQ+MRNPZxjCCdu47DEkvEhuMKgcKGdNMauOYg+DmghdPqTfvh2Kc3cP0bPKrc9iuQLUSsSEtL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/196dYc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759425393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uBZAPpBoJYcjxeUO1B1GGGCJTdS2JFaHba0BJbJEY5U=;
	b=N/196dYcpeMZ9oTIwSgElcepJ5TEPX7Ikus9ChKr+GfF7fCHCi0t7caNUc+8HJ1PH+CkB1
	/AMI86OcVdJpPfiWIX30aOd8PMITXbcxQU1xUP9qgCWzINsSOfTa1XrI75oTP66W5EsZ79
	JW8LWli0XfF/QHG7ucV/WIJeMbE4C+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-K6v6lvvkPIK3OrG1_kg0pA-1; Thu,
 02 Oct 2025 13:16:30 -0400
X-MC-Unique: K6v6lvvkPIK3OrG1_kg0pA-1
X-Mimecast-MFC-AGG-ID: K6v6lvvkPIK3OrG1_kg0pA_1759425388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8EB01956050;
	Thu,  2 Oct 2025 17:16:27 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4D2D1800452;
	Thu,  2 Oct 2025 17:16:26 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/2] iomap: ->iomap_end() error handling fixes
Date: Thu,  2 Oct 2025 13:20:36 -0400
Message-ID: <20251002172038.477207-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

v2:
- Added more R-b tags.
v1: https://lore.kernel.org/linux-fsdevel/20250908130102.101790-1-bfoster@redhat.com/
- Added R-b tags.
rfc: https://lore.kernel.org/linux-fsdevel/20250902150755.289469-1-bfoster@redhat.com/

Brian Foster (2):
  iomap: prioritize iter.status error over ->iomap_end()
  iomap: revert the iomap_iter pos on ->iomap_end() error

 fs/iomap/iter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.51.0


