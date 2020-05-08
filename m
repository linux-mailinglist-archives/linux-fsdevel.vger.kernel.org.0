Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28EF1CAA77
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHMXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:16 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34478 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbgEHMXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:16 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2AB602E1582;
        Fri,  8 May 2020 15:23:13 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id GRzGm9PEUB-NAXOq1Xu;
        Fri, 08 May 2020 15:23:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940593; bh=xT0Ek5AkKTFr9RUmYGBGy2702WCzdU/iKo4/jW8l2rI=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=uTuF1hAnXddRW2jNQcBypMq/F8E3wbskTSGE96DZ5cfc8XuqDEaCUTmqeEixb7w42
         3eQg/bCp2nZvhZJ6gGDyFjPWXD9M6ixwGt8VcyWiQDyPD2jmlfrQFbAxg/TAuwhv3J
         RobvhWmmc/CuBPWyOVo5xxxVBrB2bd/c5eu8Xhhw=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id EvmtYS4l9K-NAWuaFi6;
        Fri, 08 May 2020 15:23:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 0/8] dcache: increase poison resistance
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:09 +0300
Message-ID: <158893941613.200862.4094521350329937435.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For most filesystems result of every negative lookup is cached, content of
directories is usually cached too. Production of negative dentries isn't
limited with disk speed. It's really easy to generate millions of them if
system has enough memory.

Getting this memory back ins't that easy because slab frees pages only when
all related objects are gone. While dcache shrinker works in LRU order.

Typical scenario is an idle system where some process periodically creates
temporary files and removes them. After some time, memory will be filled
with negative dentries for these random file names.

Simple lookup of random names also generates negative dentries very fast.
Constant flow of such negative denries drains all other inactive caches.

Negative dentries are linked into siblings list along with normal positive
dentries. Some operations walks dcache tree but looks only for positive
dentries: most important is fsnotify/inotify. Hordes of negative dentries
slow down these operations significantly.

Time of dentry lookup is usually unaffected because hash table grows along
with size of memory. Unless somebody especially crafts hash collisions.

This patch set solves all of these problems:

Move negative denries to the end of sliblings list, thus walkers could
skip them at first sight (patches 3-6).

Keep in dcache at most three unreferenced negative denties in row in each
hash bucket (patches 7-8).

---

Konstantin Khlebnikov (8):
      dcache: show count of hash buckets in sysctl fs.dentry-state
      selftests: add stress testing tool for dcache
      dcache: sweep cached negative dentries to the end of list of siblings
      fsnotify: stop walking child dentries if remaining tail is negative
      dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
      dcache: stop walking siblings if remaining dentries all negative
      dcache: push releasing dentry lock into sweep_negative
      dcache: prevent flooding with negative dentries


 fs/dcache.c                                   | 144 +++++++++++-
 fs/libfs.c                                    |  10 +-
 fs/notify/fsnotify.c                          |   6 +-
 include/linux/dcache.h                        |   6 +
 tools/testing/selftests/filesystems/Makefile  |   1 +
 .../selftests/filesystems/dcache_stress.c     | 210 ++++++++++++++++++
 6 files changed, 370 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/dcache_stress.c

--
Signature
