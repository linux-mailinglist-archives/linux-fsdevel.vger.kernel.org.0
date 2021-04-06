Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9B3553F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbhDFMd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 08:33:59 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:38069 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238115AbhDFMd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:33:58 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 90F9E1AE6EA;
        Tue,  6 Apr 2021 22:33:48 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lTktv-00Cq7S-Sz; Tue, 06 Apr 2021 22:33:47 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1lTktv-007ImW-JS; Tue, 06 Apr 2021 22:33:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] vfs: convert inode cache to hlist-bl
Date:   Tue,  6 Apr 2021 22:33:40 +1000
Message-Id: <20210406123343.1739669-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=3YhXtTcJ-WEA:10 a=oVvoxvwLNVPEuiSh1sgA:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

Recently I've been doing some scalability characterisation of
various filesystems, and one of the limiting factors that has
prevented me from exploring filesystem characteristics is the
inode hash table. namely, the global inode_hash_lock that protects
it.

This has long been a problem, but I personally haven't cared about
it because, well, XFS doesn't use it and so it's not a limiting
factor for most of my work. However, in trying to characterise the
scalability boundaries of bcachefs, I kept hitting against VFS
limitations first. bcachefs hits the inode hash table pretty hard
and it becaomse a contention point a lot sooner than it does for
ext4. Btrfs also uses the inode hash, but it's namespace doesn't
have the capability to stress the indoe hash lock due to it hitting
internal contention first.

Long story short, I did what should have been done a decade or more
ago - I converted the inode hash table to use hlist-bl to split up
the global lock. This is modelled on the dentry cache, with one
minor tweak. That is, the inode hash value cannot be calculated from
the inode, so we have to keep a record of either the hash value or a
pointer to the hlist-bl list head that the inode is hashed into so
taht we can lock the corect list on removal.

Other than that, this is mostly just a mechanical conversion from
one list and lock type to another. None of the algorithms have
changed and none of the RCU behaviours have changed. But it removes
the inode_hash_lock from the picture and so performance for bcachefs
goes way up and CPU usage for ext4 halves at 16 and 32 threads. At
higher thread counts, we start to hit filesystem and other VFS locks
as the limiting factors. Profiles and performance numbers are in
patch 3 for those that are curious.

I've been running this in benchmarks and perf testing across
bcachefs, btrfs and ext4 for a couple of weeks, and it passes
fstests on ext4 and btrfs without regressions. So now it needs more
eyes and testing and hopefully merging....

Cheers,

Dave.


