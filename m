Return-Path: <linux-fsdevel+bounces-29717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F308797CC01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 18:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD442842C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A21A01B4;
	Thu, 19 Sep 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1QBxM5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385B19F470
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762000; cv=none; b=qjJruzSp+pBEpxadIKzFuSUW5BA1A7AB+KdBpmPWgoXvE00RUln2jzTeLotULOMI0kTvAmxPqwCU1RylBMQ++0ELI7HzCw9wwb6q+GRRbF2L4PYvUvwDpGY2ZA7pIhNiaXmCnCTrYB8BywBW/WYvDH0TnqfQu8ihydFYMQ6OOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762000; c=relaxed/simple;
	bh=9Qq+iN7PzMYtjCVjfoImaHrZ+BBncjDqQchaIziyS4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7A32zCt5q6QMWmpj9q1WR579uzlw4yG9sB2AaeMoRMlAJIsEFpLZP6Y8ALhDvTf25U2x3vwO+t1adytfbGto810+7r5yRJKOvMdDBABylVBlR+/yd/NbCrXEPI8rjl0FNBaG7y3JBvJNJ5BsMg3JHaX9RSmlvNytBcjAJfhHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1QBxM5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726761997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=21rYFMXb31lvADICgRw9dmiluvbLAQsvS5HBqpSM0e4=;
	b=T1QBxM5q9UCP2BWtSPeL4XULZEu8Xq2W5eYegKOEv31NYwJQW1d2vwb1IPLpGsSK2pzMFa
	O6MDxcieH+y+2RHLKFP8idrYO25xjSdHlw7IcmYi+hANiB55sVFx1J2c+jiyDyL+z7Woz8
	ktKFTOfw76yIC6lPBDEQqNdYHAup5oo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-U3qnpmrpMeKr523u27Cxxg-1; Thu,
 19 Sep 2024 12:06:35 -0400
X-MC-Unique: U3qnpmrpMeKr523u27Cxxg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7A0B1955D47;
	Thu, 19 Sep 2024 16:06:33 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.9.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AF7019560A3;
	Thu, 19 Sep 2024 16:06:32 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 0/2] ext4, mm: improve partial inode eof zeroing
Date: Thu, 19 Sep 2024 12:07:39 -0400
Message-ID: <20240919160741.208162-1-bfoster@redhat.com>
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

I've been poking around at testing zeroing behavior after a couple
recent enhancements to iomap_zero_range() and fsx[1]. Running [1] on
ext4 has uncovered a couple issues that I think share responsibility
between the fs and pagecache.

The details are in the commit logs, but patch 1 updates ext4 to do
partial eof block zeroing in more cases and patch 2 tweaks
pagecache_isize_extended() to do eof folio zeroing similar to as is done
during writeback (i.e., ext4_bio_write_folio(),
iomap_writepage_handle_eof(), etc.). These kind of overlap, but the fs
changes handle the case of a block straddling eof (so we're writing to
disk in that case) and the pagecache changes handle the case of a folio
straddling eof that might be at least partially hole backed (i.e.
sub-page block sizes, so we're just clearing pagecache).

Aside from general review, my biggest questions WRT patch 1 are 1.
whether the journalling bits are handled correctly and 2. whether the
verity case is handled correctly. I recall seeing verity checks around
the code and I don't know enough about the feature to quite understand
why. FWIW, I have run fstests against this using various combinations of
block size and journalling modes without any regression so far. That
includes enabling generic/363 [1] for ext4, which afaict is now possible
with these two proposed changes.

WRT patch 2, I originally tested with unconditional zeroing and added
the dirty check after. This still survives testing, but I'm having
second thoughts on whether that is correct or introduces a small race
window between writeback and an i_size update. I guess there's also a
question of whether the fs or pagecache should be responsible for this,
but given writeback and truncate_setsize() behavior this seemed fairly
consistent to me.

Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/fstests/20240828181534.41054-1-bfoster@redhat.com/

Brian Foster (2):
  ext4: partial zero eof block on unaligned inode size extension
  mm: zero range of eof folio exposed by inode size extension

 fs/ext4/extents.c |  7 ++++++-
 fs/ext4/inode.c   | 51 +++++++++++++++++++++++++++++++++--------------
 mm/truncate.c     | 15 ++++++++++++++
 3 files changed, 57 insertions(+), 16 deletions(-)

-- 
2.45.0


