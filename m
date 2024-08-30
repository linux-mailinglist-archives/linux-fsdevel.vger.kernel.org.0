Return-Path: <linux-fsdevel+bounces-28056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4B9664A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E68E1C24188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332241B2EF4;
	Fri, 30 Aug 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce2GUpJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A641B2EF2
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029741; cv=none; b=FuXktZzERVH2xsUFe0uyBRYzKDwBvZ970ILsfcvc3F8gR9ybh/o1PNWwt2lEd/MDeSy5DtUb4HJf2+2vJSNYeKaehNtZZwhJcjXtApzGCcbl0DLwT1eoFncvd1W2CIPchsK25yTloQMbw7Yi2WOhV0gXxAGy7vhUXyQrUuuADts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029741; c=relaxed/simple;
	bh=ttlJ0hIsOz0MJeYdutGcjiLw3S4mdO0k7NDti/+qcR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BqC6ah4gFAj4RXm38KbUHfdmA9RVKJUMJh7GsX29T/pPXBNUTECzkIMLf5RuSf3jKExF/yTQ5kMs+kyXnGn0AcPazoRL/0vsnQ8tkY/CQhNx15AAsSL4j8EwgPNAGnr6RZhdA2W6+cD59DtEl8ZwlIwlp8MQRKwEwI0OvW27rQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce2GUpJ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725029739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JwHpiZXbGxrJhO1vpFmweIXaK0VnryqtWGEiK2+OJ5U=;
	b=ce2GUpJ3CWsAJMEOO31tBJuQ1plyjILnyTY1vVgg2zNfuia4hRCEbLeKFeUP0ixUHNYvx0
	slG4YABLU9nfhOL8dsOjYyxqyX83AuwPx2+2vtc+alQ/rcVwbK8ZHfkiCtRs35zgYS+BAn
	MRIHaXISOEsp6l2yp09d6OAqCQW7cwk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-TmN2kNP2Pr6bppKhqYtomg-1; Fri,
 30 Aug 2024 10:55:35 -0400
X-MC-Unique: TmN2kNP2Pr6bppKhqYtomg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8221C1955F3E;
	Fri, 30 Aug 2024 14:55:34 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.95])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B6E219560AA;
	Fri, 30 Aug 2024 14:55:32 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	josef@toxicpanda.com,
	david@fromorbit.com
Subject: [PATCH v3 0/2] iomap: flush dirty cache over unwritten mappings on zero range
Date: Fri, 30 Aug 2024 10:56:32 -0400
Message-ID: <20240830145634.138439-1-bfoster@redhat.com>
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

Here's v3 of the iomap zero range flush fixes. No real changes here
other than comment updates to better explain the flush and stale logic.
The latest version of corresponding test support is posted here [1].
Thoughts, reviews, flames appreciated.

v3:
- Rework comment(s) in patch 2 to explain marking the mapping stale.
- Added R-b tags.
v2: https://lore.kernel.org/linux-fsdevel/20240828181912.41517-1-bfoster@redhat.com/
- Update comment in patch 2 to explain hole case.
v1: https://lore.kernel.org/linux-fsdevel/20240822145910.188974-1-bfoster@redhat.com/
- Alternative approach, flush instead of revalidate.
rfc: https://lore.kernel.org/linux-fsdevel/20240718130212.23905-1-bfoster@redhat.com/

Brian Foster (2):
  iomap: fix handling of dirty folios over unwritten extents
  iomap: make zero range flush conditional on unwritten mappings

 fs/iomap/buffered-io.c | 63 +++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_iops.c      | 10 -------
 2 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.45.0


