Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADEE213828
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGCJxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 05:53:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgGCJxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593770012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0PGiJVpJLRg1xkJmVjcLSvVDlRTvj62k3+35QdFjYI8=;
        b=YJdhd8P/g0mqVQmGYUVSssFN2n9HiSRVj8wZAJ0FTtK95cdLNpes0Ge27IkiCYTa5IZHQZ
        5/BRh9X/FceP8BMMeWLBElYpM08XlQUS0cEqWDNRUDUgwVV6ObFX+VkGDnSrEk1m1L7u6Y
        Vc8gV79XwJmyKehqI5bP/PGTro3ima0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-lP1u1ZQFMk6FNoHo3j0ckA-1; Fri, 03 Jul 2020 05:53:30 -0400
X-MC-Unique: lP1u1ZQFMk6FNoHo3j0ckA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E24DF800401;
        Fri,  3 Jul 2020 09:53:28 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED9C6111F;
        Fri,  3 Jul 2020 09:53:26 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC v2 0/2] Fix gfs2 readahead deadlocks
Date:   Fri,  3 Jul 2020 11:53:23 +0200
Message-Id: <20200703095325.1491832-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's an improved version.  If the IOCB_NOIO flag can be added right
away, we can just fix the locking in gfs2.

Thanks,
Andreas

Andreas Gruenbacher (2):
  fs: Add IOCB_NOIO flag for generic_file_read_iter
  gfs2: Rework read and page fault locking

 fs/gfs2/aops.c     | 45 +--------------------------------------
 fs/gfs2/file.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  1 +
 mm/filemap.c       | 17 +++++++++++++--
 4 files changed, 67 insertions(+), 48 deletions(-)

-- 
2.26.2

