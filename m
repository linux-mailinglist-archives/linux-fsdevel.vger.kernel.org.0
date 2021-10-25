Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF8439779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhJYN1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 09:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhJYN1Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6DA060724;
        Mon, 25 Oct 2021 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635168294;
        bh=7Hhyk6q3EuL8t6Ditlpa37mRN7GRwOvOyf4ieFiMVIE=;
        h=From:To:Cc:Subject:Date:From;
        b=f6KEwj+5JMN9YQUR5Vj1XTx/fp7LmrqW+SX9gbt1pGI2XoBPjymEblViW/zPnk3Q3
         4CveVW68dvuuRueDQ2gkkQhoWHy2HwdW+ImUiPbuumlDZhz6GcH2mwRx4eP7z9c6y/
         T5GxZrgnNJxfEOucQUtbzdPWs8mUN00KrmmY5HA8/8KMhHlW2yZ8JqZ+cLSOm9E9n+
         ZPQNh3llaNyjqLrI0+RLDa4hM1nJntIfOBhNbibWbZ8i86rz9pkRsWZrcCOOwrNvbO
         JtB97HndVeMJr/RZddzF4Dmwx4t8AAuq+QThY3z1IilOs7iWkpxarr4evJ0bz50V5N
         cBBpvc2LUProQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ceph: conversion to fscache API rewrite
Date:   Mon, 25 Oct 2021 09:24:50 -0400
Message-Id: <20211025132452.101591-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last week, David Howells posted a set of patches to modernize fscache
and cachefiles [1] (and in the process fix a ton of bugs). The patches
in this set convert ceph over to use the new API.

The first patch in this series switches ceph over to use the new API.
The second patch adds support for caching files that are open for write.

I've tested caching and non-caching setups with xfstests and it seems to
work well. The only remaining issue I see is that sometimes fsstress
will cause the cachefiles backend fs to fill up. When this happens, the
cache goes offline, but everything otherwise keeps working.

This is still an improvement over the existing code, however, and I
think that problem may be solveable by a more aggressive culling cycle.

[1]: https://lore.kernel.org/ceph-devel/CAHk-=wi7K64wo4PtROxq_cLhfq-c-3aCbW5CjRfnKYA439YFUw@mail.gmail.com/T/#t

Jeff Layton (2):
  ceph: conversion to new fscache API
  ceph: add fscache writeback support

 fs/ceph/Kconfig |   2 +-
 fs/ceph/addr.c  |  98 +++++++++++++++++++-----
 fs/ceph/cache.c | 196 +++++++++++++++++++++---------------------------
 fs/ceph/cache.h |  96 +++++++++++++++++-------
 fs/ceph/caps.c  |   3 +-
 fs/ceph/file.c  |  13 +++-
 fs/ceph/inode.c |  22 ++++--
 fs/ceph/super.c |  10 +--
 fs/ceph/super.h |   4 +-
 9 files changed, 263 insertions(+), 181 deletions(-)

-- 
2.31.1

