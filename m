Return-Path: <linux-fsdevel+bounces-40407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D1A2326D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4FA188679F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8C1EEA4B;
	Thu, 30 Jan 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+97Ds2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F52770C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256862; cv=none; b=HyHB/zrbysyLb3WvCXtytEYY3v7Z+efJDwU9b9sQcziwVAmpLn+KsgcIMdK09z0Py35JPw4jJxpu5ZDVYvxHYdoQQwj1f76msKnuQsGXMj2moqzBjrwdjGmdp2vhpL0lBFwlNupdXuTU/dzwaAHgjNF+BiIX83Ff1O3U8VFKAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256862; c=relaxed/simple;
	bh=T/ZKadxqlT/WPKi7ENfkXyDqONHLjXhZfgWmAfvTXt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FaLT+EA9sL+TGHwz+g77iv6hokBA4gWH+QY1aVIpH01cvOHubrHJ0WthrJxr8SL5rqUEvKh7cKKMmz4XY7bAPZPUveTDz4m5D6HbBbhnmv7rpMQxpJw/FkCHa8N+i/DNS8rmuGLV1GtX4Hve80pKRRB0fPq4x5LV2Hs0NvarWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+97Ds2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738256860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PyqssSTExJ7uhqBsvsQDF+KWc9uqtax77RL1lFKD9r0=;
	b=V+97Ds2/Pp7gEmYcqYwxqOZ1wNSeWfigAwDU4RN7qRHH8P05Rre33BU/+bgR6i3wWKfwHz
	a7D16cQjMclBWPgrBS7EzZqJY55J2zxXMlZFk0sptl8R2AEGNtBn3kaQwYtvsDxXnWFD2i
	Gd1QfNrbtevQ09BBTq/e/5DiV6rN3bQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-Nhqgw7G7PC-y9g9ekdjDgg-1; Thu,
 30 Jan 2025 12:07:37 -0500
X-MC-Unique: Nhqgw7G7PC-y9g9ekdjDgg-1
X-Mimecast-MFC-AGG-ID: Nhqgw7G7PC-y9g9ekdjDgg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21FF41955D81;
	Thu, 30 Jan 2025 17:07:36 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 286A030001BE;
	Thu, 30 Jan 2025 17:07:35 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 0/7] iomap: incremental per-operation iter advance
Date: Thu, 30 Jan 2025 12:09:41 -0500
Message-ID: <20250130170949.916098-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi all,

Here's v3 of the iomap incremental advance series. The most notable
changes in this version are some type fixups that lead to a tweak of
iomap_iter_advance() semantics and folding in a couple more advances in
unshare and zero range that were missed previously.

I also briefly considered a new iomap_iter_advance_full() or some such
helper for cases that have no use for the length variable, but I'm
deferring that because switching back to an s64 return for
iomap_iter_advance() would probably eliminate the need for that.

Christoph,

I dropped the R-b tag for patch 3 because the code changed enough that
it might be worth a second look, but otherwise I don't think the logic
has really changed. With the error passthru removed I think the advance
call from iomap_iter() can ultimately go away when remaining ops are
switched over. This should be able to eventually just check for an error
return, a (non-stale) failure to advance, or otherwise proceed or not
based on iter->len.

Thoughts, reviews, flames appreciated.

Brian

v3:
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

Brian Foster (7):
  iomap: split out iomap check and reset logic from iter advance
  iomap: factor out iomap length helper
  iomap: refactor iter and advance continuation logic
  iomap: support incremental iomap_iter advances
  iomap: advance the iter directly on buffered writes
  iomap: advance the iter directly on unshare range
  iomap: advance the iter directly on zero range

 fs/iomap/buffered-io.c |  67 +++++++++++++--------------
 fs/iomap/iter.c        | 103 ++++++++++++++++++++++++++---------------
 include/linux/iomap.h  |  27 +++++++++--
 3 files changed, 120 insertions(+), 77 deletions(-)

-- 
2.47.1


