Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6684B21B95D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGJPXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 11:23:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbgGJPXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594394616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9XYubToR8gPoZKz3xGIe2POziR6ztexd5h4TTQatCvU=;
        b=iY4geAz91oK9zFnvVqaj5KuWSt9HgeHH4m1q6MGtZZk962dc3FTCkLT1etAzphsKygngr3
        pcNPljI+kPslT60pXv3ujvFu0u1TePIZciDWXpf0K8WaQzDvJ7EIEtvYAQv9yiYNNRQpNI
        pERhWsLBrdXZFihTWtXCt9p6yMdiz4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-7OaH5TUHNFiPDTpOCZ2kMA-1; Fri, 10 Jul 2020 11:23:34 -0400
X-MC-Unique: 7OaH5TUHNFiPDTpOCZ2kMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE051106B243;
        Fri, 10 Jul 2020 15:23:32 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 300715C1BD;
        Fri, 10 Jul 2020 15:23:26 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] Fix gfs2 readahead deadlocks
Date:   Fri, 10 Jul 2020 17:23:24 +0200
Message-Id: <20200710152324.1690683-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

could you please pull the following two commits to fix the gfs2
deadlocks resulting from the conversion to ->readahead in commit
d4388340ae0b ("fs: convert mpage_readpages to mpage_readahead")?

The first commit adds a new IOCB_NOIO flag to generic_file_read_iter.

In the previous version [1] which you've acked [2] and Matthew Willcox
has reviewed [3], ->readpage could still be called even when IOCB_NOIO
was set, so I've added an additional check above that call and I've
dropped the ack and reviewed-by tags.  In addition, bit 8 is now left
unused for the new IOCB_WAITQ flag in the block tree per Jens Axboe's
request.

[1] https://lore.kernel.org/linux-fsdevel/CAHc6FU6LmR7m_8UHmB_77jUpYNo-kgCZ-1YTLqya-PPqvvBy7Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/CAHk-=whBk-jYM6_HBXbu6+gs7Gtw3hWg4iSLncQ0QTwShm6Jaw@mail.gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20200703114108.GE25523@casper.infradead.org/

Thanks a lot,
Andreas


The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.8-rc4.fixes

for you to fetch changes up to 20f829999c38b18e3d17f9e40dea3a28f721fac4:

  gfs2: Rework read and page fault locking (2020-07-07 23:40:12 +0200)

----------------------------------------------------------------
Fix gfs2 readahead deadlocks

----------------------------------------------------------------
Andreas Gruenbacher (2):
      fs: Add IOCB_NOIO flag for generic_file_read_iter
      gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 45 +--------------------------------------------
 fs/gfs2/file.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 23 +++++++++++++++++++++--
 4 files changed, 73 insertions(+), 48 deletions(-)

