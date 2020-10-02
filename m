Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C02816B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbgJBPeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 11:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388233AbgJBPeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601652845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QxfKPAyKMdfWuFWKZ0NG4toCJJfCMCwJHBKpGyYVAUY=;
        b=XQT2mQl0QmwMtUruT6UHtineqsndqFoLwzH/ceGSZ3zj4fqKOriIDylZFqX0WfCjYqBVDg
        QjL31E3OC+2GyQo07YCbnaMpcYh9UVceEOW/WiHPIDrpWIztph9Fm1SipqKgvsMgP4aYuo
        +XeQiuybvHwMtPooKPSjtx5j8bPQMuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-Q0_PZqOJOr2rd8oMtFP9FA-1; Fri, 02 Oct 2020 11:34:03 -0400
X-MC-Unique: Q0_PZqOJOr2rd8oMtFP9FA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD491921FC7;
        Fri,  2 Oct 2020 15:33:58 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-114-177.rdu2.redhat.com [10.10.114.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B907E78803;
        Fri,  2 Oct 2020 15:33:57 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 0/2] iomap: avoid soft lockup warnings on large ioends
Date:   Fri,  2 Oct 2020 11:33:55 -0400
Message-Id: <20201002153357.56409-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

My understanding is that there's still no real agreement on the proper
approach to address this problem. The RFC I floated [1] intended to cap
the size of ioends to avoid any latency issues with holding so many
pages in writeback for effectively a single completion instance of a GB+
sized I/O. Instead, Christoph preferred to dump those large bios onto
the completion workqueue and use cond_resched() rather than cap the
ioend size. This series implements the latter (for XFS) since it seems
like incremental progress and should at least address the warning.
Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20200825144917.GA321765@bfoster/

Brian Foster (2):
  iomap: resched ioend completion when in non-atomic context
  xfs: kick extra large ioends to completion workqueue

 fs/iomap/buffered-io.c | 15 +++++++++------
 fs/xfs/xfs_aops.c      | 12 ++++++++++--
 include/linux/iomap.h  |  2 +-
 3 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.4

