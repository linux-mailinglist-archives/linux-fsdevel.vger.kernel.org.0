Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05634E436C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiCVP5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiCVP5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:57:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C518945058;
        Tue, 22 Mar 2022 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=v97JQb/s6I9ln6w/L26b2TZ1/z0lqM+qyN/n6zSZlCI=; b=2KkZ4VlhPnQnZkHiGX6mvFPlcH
        UWtPfcacUiBmMOaAMqV75TB6p2EPPpExSk+bnJUYLPKcCj8w0ePSDlxDuvhczrqgPndykKvsKS7w0
        TgkYm4YkTXGCBKeNsYel77z9p4WAwjG41y3p5mHIBqgpzPqYFwDKLrWLOqAaDR1/PqxdRkdRh3cGF
        1mWvzAvGHaANeGu/hQmxphQtQd81t0RpT0UvkP9Epbzt3IpEsSyXWSVCaea7kq0O58UE25aVgbsJ6
        1VgnqlQ8OwfHvu31diYQw8kToEnn/333p3+KjBnD8TogUO/K/ORJlKqHMfm5NsUuYKOceHtYmrrN6
        GPJTINmQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgrh-00Bab8-1P; Tue, 22 Mar 2022 15:56:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: RFC: cleanup btrfs bio handling
Date:   Tue, 22 Mar 2022 16:55:26 +0100
Message-Id: <20220322155606.1267165-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series started out as an attempt to move btrfs to use the new
as of 5.18 bio interface, which then turned into cleaning up a lot
of the surrounding areas.  It can be roughly divided into 4 sub-series:

 - patches 1 to 4 are bug fixes for bugs found during code inspection.
   It might be a good idea if experienced btrfs developers could help
   review them or correct me if I misunderstood something
 - patches 5 to 22 are general cleanups on how bios are used and
   surrounding code
 - patches 23 to 29 clean up various extra memory allocations in the
   bio I/O path.  With I/Os that go to a single device (like all
   reads) only need the btrfs_bio memory allocation and not additional
   object.
 - patches 30 to 40 integrate the btrfs dio code more tightly with
   iomap and avoid the extra dio_private allocation and bio clone

All this is pretty rough.  It survices a xfstests auto group run on
a default file system config, though.

The tree is based on Jens' for-next tree as it started with the bio
cleanups, and will need a rebase once 5.18-rc1 is out.

A git tree is available here:

   git://git.infradead.org/users/hch/misc.git btrfs-bio-cleanup

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-bio-cleanup

Diffstat:
 fs/btrfs/btrfs_inode.h     |   25 -
 fs/btrfs/check-integrity.c |  165 +++++------
 fs/btrfs/check-integrity.h |    8 
 fs/btrfs/compression.c     |   54 +--
 fs/btrfs/ctree.h           |    6 
 fs/btrfs/disk-io.c         |  272 +++---------------
 fs/btrfs/disk-io.h         |   21 -
 fs/btrfs/extent_io.c       |  210 ++++++--------
 fs/btrfs/extent_io.h       |   17 -
 fs/btrfs/file.c            |    6 
 fs/btrfs/inode.c           |  661 ++++++++++++++++++---------------------------
 fs/btrfs/raid56.c          |  156 ++++------
 fs/btrfs/scrub.c           |   92 ++----
 fs/btrfs/super.c           |   11 
 fs/btrfs/volumes.c         |  392 +++++++++++++++-----------
 fs/btrfs/volumes.h         |   60 ++--
 fs/iomap/direct-io.c       |   29 +
 fs/iomap/iter.c            |   13 
 include/linux/iomap.h      |   23 +
 19 files changed, 963 insertions(+), 1258 deletions(-)
