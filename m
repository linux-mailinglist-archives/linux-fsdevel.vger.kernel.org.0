Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F85D79F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfJOPjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJOPjh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:39:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89F4A801682;
        Tue, 15 Oct 2019 15:39:37 +0000 (UTC)
Received: from Liberator-6.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D86610018F8;
        Tue, 15 Oct 2019 15:39:37 +0000 (UTC)
To:     fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: iomap: use SECTOR_SIZE instead of 512 in iomap_page definition
Message-ID: <123556d7-968c-70a6-1049-38b2f279f5a1@redhat.com>
Date:   Tue, 15 Oct 2019 10:39:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 15 Oct 2019 15:39:37 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_page_create() initializes the uptodate bitmap using the SECTOR_SIZE
macro, so use that in the definition as well, for consistency and safety.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

Last time there was a concern about pulling in blkdev.h just for this,
but that's already been done now, so try again.

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7aa5d6117936..9cd1db007a0d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -139,7 +139,7 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 struct iomap_page {
 	atomic_t		read_count;
 	atomic_t		write_count;
-	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
+	DECLARE_BITMAP(uptodate, PAGE_SIZE / SECTOR_SIZE);
 };
 
 static inline struct iomap_page *to_iomap_page(struct page *page)

