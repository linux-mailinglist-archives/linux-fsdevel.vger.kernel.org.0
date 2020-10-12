Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9528B9DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390736AbgJLOEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 10:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388781AbgJLOD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602511435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jtT8YVgg8rW+zJBwTtvzYMDWf/69tJh2n5OKKDjNoQw=;
        b=UozBeUEyQZMuWmEn/3im1gX3Bnrivh4vr8LkGYnejbR1RuL09kAzK5C9q+/BKCvsQ4tIVr
        Ql4bf9abfdpHUMesjNiKEzZ2K4AgzOa1AZ7Xv6dztgNKM6g6enWM8jTE5vD7HRlcijzV/6
        Si43Y4jwEBlZnZs2/fC72htyHXFF7c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-KwfY8z8jMyGFvAwAMnuJbA-1; Mon, 12 Oct 2020 10:03:52 -0400
X-MC-Unique: KwfY8z8jMyGFvAwAMnuJbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E7064085;
        Mon, 12 Oct 2020 14:03:51 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7A4260C07;
        Mon, 12 Oct 2020 14:03:50 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 0/2] iomap: zero dirty pages over unwritten extents
Date:   Mon, 12 Oct 2020 10:03:48 -0400
Message-Id: <20201012140350.950064-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This is an alternate/iomap based variant of the XFS fix posted here:

https://lore.kernel.org/linux-xfs/20201007143509.669729-1-bfoster@redhat.com/

This addresses a post-eof stale data exposure problem that can occur
when truncate down races with writeback of the new EOF page and the new
EOF block happens to be unwritten. Instead of explicitly flushing the
new EOF page in XFS, however, this variant updates iomap zero range to
check for and zero preexisting dirty pages over unwritten extents. This
reuses the dirty page checking that seek data/hole already implements
for unwritten extents. Patch 1 is technically not required, but fixes an
odd behavior I noticed when playing around with zero range. Without it,
a zero range (with patch 2) over a large, cached (but clean), unwritten
mapping would unnecessarily zero pages that aren't otherwise dirty. I
don't think this is actually a problem in practice today as most large
zero range requests are truncates over post-eof space (which shouldn't
have page cache), but it seemed odd regardless.

Thoughts, reviews, flames appreciated.

Brian

Brian Foster (2):
  iomap: use page dirty state to seek data over unwritten extents
  iomap: zero cached pages over unwritten extents on zero range

 fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++++++++++++++++--
 fs/iomap/seek.c        |  7 ++++---
 include/linux/iomap.h  |  2 ++
 3 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.25.4

