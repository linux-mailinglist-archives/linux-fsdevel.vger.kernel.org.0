Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2780F212A56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGBQv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:51:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726630AbgGBQv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593708687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AS1biAZZYrc6DCalhh6zy/9YtnCnXv1oypGIRKow0Tc=;
        b=QmvJf2X/YUbQo00Zm3znJUBFZaoMsq5MQ21OkZv0mgRgug0MJYJ1KcrPMbFdeF27FB2FnL
        Fr/AS1Rll9fcm0t1eb46bM12wNcPPII2TfZrcWMKDdA7O/5HHv/A99YbAWeK+fJyheQoM8
        XVPQbbQYxXRs03m7cqXNfI3dq03WtKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ySEhn9NpMCaMKedzkGkJtQ-1; Thu, 02 Jul 2020 12:51:25 -0400
X-MC-Unique: ySEhn9NpMCaMKedzkGkJtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94898107ACF5;
        Thu,  2 Jul 2020 16:51:24 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7822379231;
        Thu,  2 Jul 2020 16:51:22 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC 0/4] Fix gfs2 readahead deadlocks
Date:   Thu,  2 Jul 2020 18:51:16 +0200
Message-Id: <20200702165120.1469875-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

commit d4388340ae0b ("fs: convert mpage_readpages to mpage_readahead")
converted gfs2 and other filesystems from the ->readpages to the
->readahead address space operation.  Due to gfs2 doing its locking in
the ->readpage and ->readahead address space operations rather than at a
higher level, this is leading to deadlocks.  Switching to a trylock
operation in ->readahead improves things but doesn't eliminate all
deadlocks; the only reasonable fix seems to be to lift gfs2's locking to
the ->fault vm operation and ->read_iter file operation.

However, gfs2 includes an optimization that allows reads to be served
out of the page cache without any filesystem locking.  This optimization
is important in concurrent read scenarios.  The best way we could find
to preserve this optimization is by introducing a new IOCB_NOIO flag for
generic_file_read_iter.

Introducing this new flag may be too big a change for 5.8.  So this
patch queue takes a different approach:  it first walks back gfs2's
conversion to ->readahead.  Then it introduces IOCB_NOIO, fixes the
locking, and re-applies the readahead conversion.

Of this patch queue, either only the first patch or all four patches can
be applied to fix gfs2's current issues in 5.8.  Please let me know what
you think.

Thanks,
Andreas

Andreas Gruenbacher (4):
  gfs2: Revert readahead conversion
  fs: Add IOCB_NOIO flag for generic_file_read_iter
  gfs2: Rework read and page fault locking
  gfs2: Reinstate readahead conversion

 fs/gfs2/aops.c     | 45 +------------------------------------
 fs/gfs2/file.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 16 ++++++++++++--
 4 files changed, 69 insertions(+), 48 deletions(-)

-- 
2.26.2

