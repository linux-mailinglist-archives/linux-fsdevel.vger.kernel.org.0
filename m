Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B47A6CE55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfGRM4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 08:56:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRM4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:56:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPXxi-1i1nLB3om2-00MY3T; Thu, 18 Jul 2019 14:55:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
Date:   Thu, 18 Jul 2019 14:55:01 +0200
Message-Id: <20190718125509.775525-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fYyPEEJ/6NJ+zJ5owzzApq3jp7UZMtX7HEEZzIzdqq8KSAMWsnh
 3psNUFCs5XMvOrSShZEXlpdG88Gk4YRFrDL0q2RpFyt/dRpbmTNbMUlJ3NUXm8k9B0ZyWVM
 xhm1BwUhV4WXRDLaGEG5P4Qiv300giFieJNupaLYe66j0zu/hBBf5OmPL1DoFjVRobdA/6t
 tY0Jnhou4TYKpux1AzD2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W05Qfkw4Zxw=:2VPGQzIHjmhFJUTjaduOol
 glg6ZoBIjxvjEIfBdrL3DdZd6r24yamiE3AfxLbPi5Y0V/lFau+4KxlsJQM/ILwvNrv7if+pb
 Ae0dgmxjLZ6CVvkQmjmWjIkvCq+gPkdfdV8JFhRN048CQ1JoH5qJpUqZBudZJjlC9ixZl6im1
 11AryixtiGVNIpDDBLo0UPNy2AzezJrIvVz9yCHEl842U9sqZh8SE0GeK5UD5uZaX8/WnTq4i
 FnWugILOEKacSf1/B+h2a1F0TLLTH9vEnRUaXi4AfDZ1M7LQRB29kIsym7YaGJxoOdDTAIndJ
 oaUwoQPURFHh/krkFfTWnqXeBhl5oSVOzilRBk0vfHdqWHQtpYo7Ni798FiAOmhrByzN0xu+L
 83sujb6oVePBnHX2Hfo8J05LnIYug7pQcWZwil9ZVNXh27cziRvPtWi+/YOqKBIh1rBy026Ci
 uiVO9dYhhu8/wpGErNNz6NVNxVK4yGA98r3ZHjOtOX72wG9c69r1o/aVfjGsr+KIa4xs6C9/t
 sJHOi5MJGjdOQkoTMZxIRAjqeDGuEc9QkEX31W+LsI3519sPNRTgYWWEfpdWDlAFV3iBRkgEP
 vQ1CGu20Hke1Fgs0LkmFzM16SJ+BSo2DXpLLNdsCy5HLAmG3QFVs4k3m1lLudyFNFjOiZr7sn
 gH+fiTFUbW/ldL9YuJnHaFiAKcH7dCeZRVtmASSrAJbcsw/22cFT10A3z0UWYfbUJq1DZbmo2
 /MNEax1GpiBeyZ96AhI8M3U+GRyNQhjrq2TRSw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When CONFIG_BLOCK is disabled, SECTOR_SHIFT is unknown:

In file included from <built-in>:3:
include/linux/iomap.h:76:48: error: use of undeclared identifier 'SECTOR_SHIFT'
        return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;

Since there are no callers in this case, just hide the function in
the same ifdef.

Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/iomap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..bb07f31e3b6f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -70,11 +70,13 @@ struct iomap {
 	const struct iomap_page_ops *page_ops;
 };
 
+#ifdef CONFIG_BLOCK
 static inline sector_t
 iomap_sector(struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
+#endif
 
 /*
  * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
-- 
2.20.0

