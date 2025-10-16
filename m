Return-Path: <linux-fsdevel+bounces-64386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A4BE5238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027FC503894
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39224395C;
	Thu, 16 Oct 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrwxfDkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF823EA80
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641129; cv=none; b=nZYUI1O6EuieUr8E7MrZBBJQI9YIsAmQvsQESZWCrB3tk9iYUhavzIoUTlQkYIuQq9iKLCKNxl6Ua64BBJvXk1p9ldzu56a3Uw6fKtJYiDTnpUOd4gbGvtyKNws2hAYs3QxfyiwNvag7Kj6lDuRCO8Q//eepSA5XTcU7u9qqJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641129; c=relaxed/simple;
	bh=YT4/gLrVVH+gsP3u2nMRhIFWzwtDPemMZ4ONnGjaVGA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLm3lCGSgHjH/BCQA65X1kAP+NdLbjSLEd3KQI824Q2+Cql/o5PrYsdPWOceeKkRjF2SuhoxliIzcnJuYq2njIgpw7O65adxpSNrNuCc0DDflD3ycF0PMsqtKj3lxlLmFxDNuaGPy5mH5u08h4PJTO6+otgf8PxhByNSi9tjM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrwxfDkG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760641126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OzPX3lW8vqrNQb7NmlkzBTj8ETamZDMo0KjBuBi+VMs=;
	b=TrwxfDkGqWCd/M9t4dUEnJs5qDxtdXPgqK3BNSAge+2l0JlByGYgPTmeWRDlejQvCix6uh
	mXKBrHisANRQowerHBqxJaqHOKbNqvpwZnEagPE3Heq1S8AIdr/RUunoVEosDg3NH/lVFW
	xeOguCEa1vj6XxPJYHivmyb2FvHlyrs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-F2D5sFA1OOqgzpKjoLwUIQ-1; Thu,
 16 Oct 2025 14:58:44 -0400
X-MC-Unique: F2D5sFA1OOqgzpKjoLwUIQ-1
X-Mimecast-MFC-AGG-ID: F2D5sFA1OOqgzpKjoLwUIQ_1760641124
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E30BD18002F7;
	Thu, 16 Oct 2025 18:58:43 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 634D11956056;
	Thu, 16 Oct 2025 18:58:43 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 0/6] iomap, xfs: improve zero range flushing and lookup
Date: Thu, 16 Oct 2025 15:02:57 -0400
Message-ID: <20251016190303.53881-1-bfoster@redhat.com>
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

Now that the folio_batch bits are headed into -next here is the next
phase of cleanups. Most of this has been previously discussed at one
point or another. Zhang Yi had reported a couple outstanding issues
related to the conversion of ext4 over to iomap. One had to do with the
context of the folio_batch dynamic allocation and another is the flush
in the the non-unwritten mapping case can cause problems.

This series attempts to address the former issue in patch 1 by using a
stack allocated folio_batch and iomap flag, eliminating the need for the
dynamic allocation. The non-unwritten flush case only exists as a
band-aid for wonky XFS behavior, so patches 2-6 lift this logic into XFS
and work on it from there. Ultimately, the flush is relocated to insert
range where it appears to be needed and the iomap begin usage is
replaced with another use of the folio batch mechanism.

This has survived testing so far on XFS in a handful of different
configs and arches. WRT patch 3, I would have liked to reorder the
existing insert range truncate and flush in either direction rather than
introduce a new flush just for EOF, but neither seemed obviously clean
enough to me as I was looking at it with the current code factoring. So
rather than go back and forth on that on my own I opted to keep the
patch simple to start and maybe see what the folks on the XFS list
think.

Note that this applies on top of the pending folio_batch series [1].
Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20251003134642.604736-1-bfoster@redhat.com/

Brian Foster (6):
  iomap: replace folio_batch allocation with stack allocation
  iomap, xfs: lift zero range hole mapping flush into xfs
  xfs: flush eof folio before insert range size update
  xfs: look up cow fork extent earlier for buffered iomap_begin
  xfs: only flush when COW fork blocks overlap data fork holes
  xfs: replace zero range flush with folio batch

 fs/iomap/buffered-io.c | 49 +++++++++++++--------
 fs/iomap/iter.c        |  6 +--
 fs/xfs/xfs_file.c      | 17 ++++++++
 fs/xfs/xfs_iomap.c     | 98 +++++++++++++++++++++++++++++-------------
 include/linux/iomap.h  |  8 +++-
 5 files changed, 125 insertions(+), 53 deletions(-)

-- 
2.51.0


