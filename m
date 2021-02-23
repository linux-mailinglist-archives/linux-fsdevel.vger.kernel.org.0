Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473DE322B29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 14:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhBWNHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 08:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232588AbhBWNHN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:07:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 781F364E31;
        Tue, 23 Feb 2021 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614085592;
        bh=H0ZuxAlx9Sqw7HRYzR0VEIUpSiqd1zY+9kWfHyBQQ/k=;
        h=From:To:Cc:Subject:Date:From;
        b=E99XEtwEA9GbmQ6iGKb/HD/Et9vtw80s8iltoJ7LjAIX8PrtqHk+piIlJ42Re2RRY
         pMzfruOZlAenC+qrFTo6SdCQuOUKIW78K1aZpao0BSIy34Twf+Unpv1RRVqejTTsnB
         uXNJVS8Yl6seqQukUcAHteVBVJ+SILGPHXdecaLzqPR/2YC1QlJ5BO8dCSBZvhV8VO
         USImhYeUfnZ8qeUDrUDpjzBc7FLhHhNcoh6da83O08RaFe15vkTaJpBFbYr19h0LvE
         AwTXHph2DjVVyo8X8Vhib17VU0B9tAInfqmCcMdPX/y/pnU7o1qdMW/HblmQ33T62q
         vTuis4y2RAbKQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiubli@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v3 0/6] ceph: convert to netfs helper library
Date:   Tue, 23 Feb 2021 08:06:23 -0500
Message-Id: <20210223130629.249546-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the third posting of this patchset. The main differences between
this one and the last are some bugfixes, and cleanups:

- rebase onto David's latest fscache-netfs-lib set
- unify the netfs_read_request_ops into one struct
- fix inline_data handling in write_begin
- remove the now-unneeded i_fscache_gen field from ceph_inode_info
- rename gfp_flags to gfp in releasepage
- pass appropriate was_async flag to netfs_subreq_terminated

This set is currently sitting in the ceph-client/testing branch, so
it should get good testing coverage over the next few weeks via in
the teuthology lab.

Jeff Layton (6):
  ceph: disable old fscache readpage handling
  ceph: rework PageFsCache handling
  ceph: fix fscache invalidation
  ceph: convert readpage to fscache read helper
  ceph: plug write_begin into read helper
  ceph: convert ceph_readpages to ceph_readahead

 fs/ceph/Kconfig |   1 +
 fs/ceph/addr.c  | 541 +++++++++++++++++++-----------------------------
 fs/ceph/cache.c | 125 -----------
 fs/ceph/cache.h | 101 +++------
 fs/ceph/caps.c  |  10 +-
 fs/ceph/inode.c |   1 +
 fs/ceph/super.h |   2 +-
 7 files changed, 242 insertions(+), 539 deletions(-)

-- 
2.29.2

