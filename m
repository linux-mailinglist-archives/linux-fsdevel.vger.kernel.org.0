Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6062303F9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 15:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404188AbhAZNlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 08:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391883AbhAZNlp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:41:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB44D2223D;
        Tue, 26 Jan 2021 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611668465;
        bh=ZJUfk71tJJObelOZ4J7SPYTL7fPCNv6NgKzes1GIDU0=;
        h=From:To:Cc:Subject:Date:From;
        b=qGrXHRDgg6fn6UIvd5UXnK2vx7ilw/jbjvq547ROl/sVTrutXmjlrY+nTMJa3Qlgw
         Y4/FTmRl0yECXaT8waVMb6YVf/oY+TstT4KxVHYisK3W7QL1+7AkXP8YX1D5Hyi81M
         HcxP6zgXNFRTjKIdo9Nz3OWoJAoha8iw9cKi0NcbH9Pa4IKMyduT12t0ku9ZoLNj/l
         QmYtp6vzgU88iU0DL/VOdCIiH9K9PdRcB74SSozL1HIp8x9pRnAdSR8ROWJZB/TanB
         dyFjESqnBngldgr+cLe1RCUGb2WUi8c78vUINnnbHO4TWHeHXOJFn/mZ+3K/r30GTF
         R8nXUbGnwFqPQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com, dhowells@redhat.com
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 0/6] ceph: convert to new netfs read helpers
Date:   Tue, 26 Jan 2021 08:40:57 -0500
Message-Id: <20210126134103.240031-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset converts ceph to use the new netfs readpage, write_begin,
and readahead helpers to handle buffered reads. This is a substantial
reduction in code in ceph, but shouldn't really affect functionality in
any way.

Ilya, if you don't have any objections, I'll plan to let David pull this
series into his tree to be merged with the netfs API patches themselves.
I don't see any conflicts with what's currently in the testing or master
branches. Alternately, we could pull his patches into the ceph master
branch and then put these on top. Let me know what you'd prefer.

Thanks,
Jeff

Jeff Layton (6):
  ceph: disable old fscache readpage handling
  ceph: rework PageFsCache handling
  ceph: fix fscache invalidation
  ceph: convert readpage to fscache read helper
  ceph: plug write_begin into read helper
  ceph: convert ceph_readpages to ceph_readahead

 fs/ceph/Kconfig |   1 +
 fs/ceph/addr.c  | 535 +++++++++++++++++++-----------------------------
 fs/ceph/cache.c | 123 -----------
 fs/ceph/cache.h | 101 +++------
 fs/ceph/caps.c  |  10 +-
 fs/ceph/inode.c |   1 +
 6 files changed, 236 insertions(+), 535 deletions(-)

-- 
2.29.2

