Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2704D195AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0QPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 12:15:41 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:50090 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0QPk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:15:40 -0400
X-Greylist: delayed 1080 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 12:15:39 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 02RFmKIC087291;
        Fri, 27 Mar 2020 17:57:37 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 2yw7g51wc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 17:57:37 +0200
Received: from localhost (178.194.224.123) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Mar
 2020 17:57:36 +0200
From:   Simon Gander <simon@tuxera.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, Simon Gander <simon@tuxera.com>,
        Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH] hfsplus: Fix crash and filesystem corruption when deleting files
Date:   Fri, 27 Mar 2020 16:55:40 +0100
Message-ID: <20200327155541.1521-1-simon@tuxera.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.194.224.123]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_05:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 malwarescore=0 suspectscore=1
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When removing files containing extended attributes, the hfsplus driver
may remove the wrong entries from the attributes b-tree, causing major
filesystem damage and in some cases even kernel crashes.

To remove a file, all its extended attributes have to be removed as well.
The driver does this by looking up all keys in the attributes b-tree with
the cnid of the file. Each of these entries then gets deleted using the
key used for searching, which doesn't contain the attribute's name when it
should. Since the key doesn't contain the name, the deletion routine will
not find the correct entry and instead remove the one in front of it. If
parent nodes have to be modified, these become corrupt as well. This causes
invalid links and unsorted entries that not even macOS's fsck_hfs is able
to fix.

To fix this, modify the search key before an entry is deleted from the
attributes b-tree by copying the found entry's key into the search key,
therefore ensuring that the correct entry gets removed from the tree.

Signed-off-by: Simon Gander <simon@tuxera.com>
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
---
 fs/hfsplus/attributes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index e6d554476db4..eeebe80c6be4 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -292,6 +292,10 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 		return -ENOENT;
 	}
 
+	/* Avoid btree corruption */
+	hfs_bnode_read(fd->bnode, fd->search_key,
+			fd->keyoffset, fd->keylength);
+
 	err = hfs_brec_remove(fd);
 	if (err)
 		return err;
-- 
2.26.0

