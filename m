Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C508472EAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhLMOTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhLMOTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:19:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF47C061574;
        Mon, 13 Dec 2021 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5vnU8e5AS4nStISRD6IYeCDVX2BtnznV8f0BSShzTvE=; b=W7qzKXSnP8lJ/4+OiSulB5utLp
        xee8A5lvQVuNPRSjLct1uqexXjS6E9xhBv9Hbrn6qBTGBz7F3wziPABrVelsAWeylVUGiGUu79TkJ
        UVx/8SIy/G94eK5XBzmWSm4pvIxkvCFChlfe86sA0CDUWYuWqlSALruMsDDG9+ozTxXY9JN9HNbOH
        AS9LxyXLoQbFlyEERQ+I2P8vWnH9FrUvIcA6J30ZTD83Zu7ENpucmr8PIdoT25YTUzFtgZtYasiTK
        rqnGAcNEwoiystVvKU+HQ0TAuAqytH27ljeFhFA3bVjU8jJYJaHUjLNzy3PTC/sPOyFN/iGPbaPLc
        XcgimdOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmAX-00CrBg-Cq; Mon, 13 Dec 2021 14:19:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/3] Convert vmcore to use an iov_iter
Date:   Mon, 13 Dec 2021 14:19:04 +0000
Message-Id: <20211213141907.3064347-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some reason several people have been sending bad patches to fix
compiler warnings in vmcore recently.  Here's how it should be done.
Compile-tested only on x86.  As noted in the first patch, s390 should
take this conversion a bit further, but I'm not inclined to do that
work myself.

v2:
 - Removed unnecessary kernel-doc
 - Included uio.h to fix compilation problems
 - Made read_from_oldmem_iter static to avoid compile warnings during the
   conversion
 - Use iov_iter_truncate() (Christoph)

Matthew Wilcox (Oracle) (3):
  vmcore: Convert __read_vmcore to use an iov_iter
  vmcore: Convert read_from_oldmem() to take an iov_iter
  iov-kaddr

 arch/x86/kernel/crash_dump_64.c |   7 +-
 fs/9p/vfs_dir.c                 |   5 +-
 fs/9p/xattr.c                   |   6 +-
 fs/proc/vmcore.c                | 119 ++++++++++++--------------------
 include/linux/crash_dump.h      |  10 ++-
 include/linux/uio.h             |   9 +++
 lib/iov_iter.c                  |  32 +++++++++
 7 files changed, 97 insertions(+), 91 deletions(-)

-- 
2.33.0

