Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183F4300A64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbhAVRwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbhAVRwB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5DFC23A79;
        Fri, 22 Jan 2021 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337881;
        bh=aXohzE1fQDUVmRxIyf/Y3FvhHEDTX6DSYkej4pWfR0U=;
        h=From:To:Cc:Subject:Date:From;
        b=JAev7YRmy/xfSN9o/HFB2t4m0B8FzqwnnFmt9R06LKkLn5aF/FbLnYJM27kHekq00
         RqGa4Zqos8yRvI/QboBQMFUDFsgLnjLSubzzLM95wzWj7spe5lN0YhzkbLab1vLcSM
         yfgh/bnOyOS6Ftud8OBQxx5MrWBPgE3Y5ytgyWcoUN3u9JCqOj62NPL/pSHD4wQNSs
         1yxp0L+4BK0iiOJRlrStQCIlTfpA7zWo1wCyY/1n8zhi9Dyj2q23f5HNQ0Q+luZCfB
         LfSbj8BOHuqmXtZnkNF1NFv00teZuNXNjoWY/ilIqatdnAp/jEY3kI7VUihZxSfzF4
         SVDdI/4KFuKZg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        willy@infradead.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] ceph: convert buffered read codepaths to new netfs API
Date:   Fri, 22 Jan 2021 12:51:12 -0500
Message-Id: <20210122175119.364381-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset coverts ceph to use the new netfs API that David Howells
has proposed [1]. It's a substantial reduction in code in the ceph layer
itself, but the main impetus is to allow the VM, filesystem and fscache
to better work together to optimize readahead on network filesystems.

I think the resulting code is also easier to understand, and should be
more maintainable as a lot of the pagecache handling is now done at the
netfs layer.

This has been lightly tested with xfstests. With fscache disabled, I saw
no regressions. With fscache enabled, I still hit some bugs down in the
fscache layer itself, but those seem to be present without this set as
well. This doesn't seem to make any of that worse.

[1]: https://lore.kernel.org/ceph-devel/1856291.1611259704@warthog.procyon.org.uk/T/#t

Jeff Layton (6):
  ceph: disable old fscache readpage handling
  ceph: rework PageFsCache handling
  ceph: fix invalidation
  ceph: convert readpage to fscache read helper
  ceph: plug write_begin into read helper
  ceph: convert ceph_readpages to ceph_readahead

 fs/ceph/Kconfig |   1 +
 fs/ceph/addr.c  | 536 +++++++++++++++++++-----------------------------
 fs/ceph/cache.c | 123 -----------
 fs/ceph/cache.h | 101 +++------
 fs/ceph/caps.c  |  10 +-
 fs/ceph/inode.c |   1 +
 6 files changed, 236 insertions(+), 536 deletions(-)

-- 
2.29.2

