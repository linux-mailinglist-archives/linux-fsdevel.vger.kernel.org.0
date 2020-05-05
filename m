Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0B1C5994
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgEEOav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 10:30:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEEOav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 10:30:51 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MekvT-1ixkId0Wnd-00alx9; Tue, 05 May 2020 16:30:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsnotify: avoid gcc-10 zero-length-bounds warning
Date:   Tue,  5 May 2020 16:30:09 +0200
Message-Id: <20200505143028.1290686-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9CGfPlqsG6O+oqtr6wXagl79sSxl+5NaR402II1ViR7OGlFLFXt
 gDq2dWYsZe9jg0JqXfL2kkPQaQankYkttOr/wMmrFL1LXnFD0j9yv/ymgK4fjkFdSrl8rKb
 fq8AZ10hG1w2k89O1s0Sx1KKiU0NDXM/Jsdwfi0RmT5VNEOvIqrYy9UlG3YJFn/bjt2nE0y
 JYInF2O7ydt7/pKK/ABHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpl6YuOemig=:CEPjLM6gYwSsxt3gW2LLE5
 iEspgsAILOPW2a0YSImo4XL582Kl1O58MX9Qnt+UJY4kGkV+qwBvmDnTBkylEP+gwwvcHDSl+
 nzyOsyHbnivwh9msNSA8BTNCPHNEJe7q6ShgrAq3TUcLzVgB3fDzhYkT0ed9K5jP1ZXF9bPi4
 ckTwcIo6dRDqUPt2FwG0hIcEFGCfFLPq7Ih+REQmcEQ/xmecWU0z4k43bqP4BOg+xArBfPE4I
 lSgOyyIYkcb3IjNzRY/OQh1fOX/9fs3CADa3FDbDQuQ6DiSU9CWEIiRDSvU0UonhXESYHWf1n
 7GJ/3VR+rNAsd0RRT5Ixq298kKd9lDff9RxuWL8I9ilC2159YPOl6w3bnTB2h7pcumqvmhXFY
 TAwCNKmE7EiUkDtbvCmovZj1X/+Ujysirbgw6Kl0lXsko415d97wQPUL7KjXUKfWs0EJYKwh+
 jtP/8WgOV2dP5bz2VdLcjU/clPf7ComHYuda+2QyNCyJ8k3u+kyBkTfD5vUNpI60/MLDiMDPf
 m6IGHWzzVjTYMiKLSdtBTAFLJu4zE7XVKecMUiPpbnB1xf56U7Rv+zf6VvJCocsWRyeL9+kTL
 hOnyL/F+cchp4PiKDA431ig8W534gYFASQ0G74KxsL5yM4ALK8xVfgjSSOmvn0c5exwuhGfZM
 NN+meiHg9+5S37ohizLgmVPaHju9iPb7sd0KgBFDuF5+qX0Y+zo0D/INbwCWOfj2J5lRpTZ1K
 hHcmmtJ9p7Gy8QvQs9kJUksrS9ULFeR+vjr2jGNFSHjy5YsKbV5o8piRY07klN8MYXq+jauRG
 B6Wdp4uhWu3TZuV2gvX7LqhobB5garPiziWq1fUAQ0le4/Dki0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

gcc-10 warns about accesses into the f_handle[] zero-length array.

fs/notify/fdinfo.c: In function 'show_mark_fhandle':
fs/notify/fdinfo.c:66:47: error: array subscript 'i' is outside the bounds of an interior zero-length array 'unsigned char[0]' [-Werror=zero-length-bounds]
   66 |   seq_printf(m, "%02x", (int)f.handle.f_handle[i]);
      |                              ~~~~~~~~~~~~~~~~~^~~
In file included from fs/notify/fdinfo.c:3:
include/linux/fs.h:988:16: note: while referencing 'f_handle'
  988 |  unsigned char f_handle[0];
      |                ^~~~~~~~

This is solved by using a flexible array instead.

Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Gustavo has done the same thing as part of a treewide change, but keeping
this separate lets us backport it to stable kernels more easily later.
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8690dc56e883..b229c55a8232 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -986,7 +986,7 @@ struct file_handle {
 	__u32 handle_bytes;
 	int handle_type;
 	/* file identifier */
-	unsigned char f_handle[0];
+	unsigned char f_handle[];
 };
 
 static inline struct file *get_file(struct file *f)
-- 
2.26.0

