Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C469C44FD21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 03:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKOC1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 21:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhKOC1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:27:46 -0500
Received: from smtp02.aussiebb.com.au (smtp02.aussiebb.com.au [IPv6:2403:5800:3:25::1002])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C63C061746;
        Sun, 14 Nov 2021 18:24:46 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp02.aussiebb.com.au (Postfix) with ESMTP id D3C1D102D82;
        Mon, 15 Nov 2021 13:24:29 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp02.aussiebb.com.au
Received: from smtp02.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp02.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UqFNLGMF9cvO; Mon, 15 Nov 2021 13:24:29 +1100 (AEDT)
Received: by smtp02.aussiebb.com.au (Postfix, from userid 116)
        id B36D3102D70; Mon, 15 Nov 2021 13:24:29 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp02.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp02.aussiebb.com.au (Postfix) with ESMTP id 3E3B6102D70;
        Mon, 15 Nov 2021 13:24:28 +1100 (AEDT)
Subject: [PATCH 2 2/2] xfs: make sure link path does not go away at access
From:   Ian Kent <raven@themaw.net>
To:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Nov 2021 10:24:28 +0800
Message-ID: <163694306800.229789.11812765289669370510.stgit@mickey.themaw.net>
In-Reply-To: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
References: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When following an inline symlink in rcu-walk mode it's possible to
succeed in getting the ->get_link() method pointer but the link path
string be deallocated while it's being used.

This is becuase of the xfs inode reclaim mechanism. While rcu freeing
the link path can prevent it from being freed during use the inode
reclaim could assign a new value to the field at any time outside of
the path walk and result in an invalid link path pointer being
returned. Admittedly a very small race window but possible.

The best way to mitigate this risk is to return -ECHILD to the VFS
if the inline symlink method, ->get_link(), is called in rcu-walk mode
so the VFS can switch to ref-walk mode or redo the walk if the inode
has become invalid.

If it's discovered that staying in rcu-walk mode gives a worth while
performance improvement (unlikely) then the link path could be freed
under rcu once potential side effects of the xfs inode reclaim
sub-system have been analysed and dealt with if needed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/xfs/xfs_iops.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a607d6aca5c4..0a96183c5381 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -520,6 +520,9 @@ xfs_vn_get_link_inline(
 	struct xfs_inode	*ip = XFS_I(inode);
 	char			*link;
 
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
 	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);
 
 	/*


