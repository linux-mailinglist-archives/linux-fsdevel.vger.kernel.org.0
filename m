Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5A44FD1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 03:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKOC1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 21:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKOC1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:27:33 -0500
Received: from smtp02.aussiebb.com.au (smtp02.aussiebb.com.au [IPv6:2403:5800:3:25::1002])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACFBC061746;
        Sun, 14 Nov 2021 18:24:22 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp02.aussiebb.com.au (Postfix) with ESMTP id 55A4F102D7A;
        Mon, 15 Nov 2021 13:24:18 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp02.aussiebb.com.au
Received: from smtp02.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp02.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XtXQ1N5wrVTJ; Mon, 15 Nov 2021 13:24:18 +1100 (AEDT)
Received: by smtp02.aussiebb.com.au (Postfix, from userid 116)
        id 40E3F102D70; Mon, 15 Nov 2021 13:24:18 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        smtp02.aussiebb.com.au
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=10.0 tests=RDNS_NONE autolearn=disabled
        version=3.4.2
Received: from mickey.themaw.net (unknown [100.72.131.210])
        by smtp02.aussiebb.com.au (Postfix) with ESMTP id 8C850102D6D;
        Mon, 15 Nov 2021 13:24:16 +1100 (AEDT)
Subject: [PATCH 2 0/2] xfs: fix inline link path race
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
Date:   Mon, 15 Nov 2021 10:24:16 +0800
Message-ID: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the inode of an inline symlink is released (dropped) while a path walk
that is in rcu-walk mode is occuring the inode ->get_link() method can be
NULL when VFS dereferences it causing a crash. But, since the release can
occur at any time there's a small but finite possibility the link path
text could be freed while it's being used.

Changes since v1:
- don't bother trying to rcu-free the link path since there could
  be side effects from the xfs reclaim code.
---

Ian Kent (2):
      vfs: check dentry is still valid in get_link()
      xfs: make sure link path does not go away at access


 fs/xfs/xfs_iops.c | 3 +++
 1 file changed, 3 insertions(+)

--
Ian

