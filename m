Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB829ECCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 14:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgJ2NX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 09:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgJ2NX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603977838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qfgXUPg8o+db+z0aYzq++pRsh1Ln28O6z6C8zbe7Ul4=;
        b=VROyJ6TaA+Z9amVxysGw4OlRLnC8RnA9b8SFMUJ7Ho1UOWO/E+1o6aBnZoQTw/PJisklJ1
        GXG5+t82v8irc2m0VtmbZQ983oetLyw+4JX3qiYKYXMcZuz945e88I0pPM05uwYUspOJX0
        ycC1xBnUpdHR/fvaSnQfyk3iAT+BN4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-OrdeR1mdOmSX2rerw3M2lw-1; Thu, 29 Oct 2020 09:23:55 -0400
X-MC-Unique: OrdeR1mdOmSX2rerw3M2lw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64BBB7D7A;
        Thu, 29 Oct 2020 13:23:26 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 892A95C1C4;
        Thu, 29 Oct 2020 13:23:26 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH v2 0/3] misc iomap/xfs writeback fixes
Date:   Thu, 29 Oct 2020 09:23:22 -0400
Message-Id: <20201029132325.1663790-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Patch 1 is actually a repost of the original fix I posted[1] for the
truncate down zeroing issue. Patch 2 has some minor tweaks based on
feedback on v1 from Christoph. Patch 3 is new and fixes up some of the
remaining broken iomap writepage error handling logic (also discussed in
the v1 thread). Thoughts, reviews, flames appreciated.

Brian 

v2:
- Repost original XFS truncate down post-EOF zeroing fix.
- Pass file offset to iomap ->discard_page() callback.
- Add patch 3 to fix up iomap writepage error handling.
v1: https://lore.kernel.org/linux-xfs/20201026182019.1547662-1-bfoster@redhat.com/

[1] https://lore.kernel.org/linux-xfs/20201007143509.669729-1-bfoster@redhat.com/

Brian Foster (3):
  xfs: flush new eof page on truncate to avoid post-eof corruption
  iomap: support partial page discard on writeback block mapping failure
  iomap: clean up writeback state logic on writepage error

 fs/iomap/buffered-io.c | 30 ++++++++++--------------------
 fs/xfs/xfs_aops.c      | 13 +++++++------
 fs/xfs/xfs_iops.c      | 10 ++++++++++
 include/linux/iomap.h  |  2 +-
 4 files changed, 28 insertions(+), 27 deletions(-)

-- 
2.25.4

