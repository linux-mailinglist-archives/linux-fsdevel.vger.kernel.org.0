Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A8B1BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfIMK6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 06:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfIMK6I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:58:08 -0400
Received: from tleilax.poochiereds.net.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 350942084F;
        Fri, 13 Sep 2019 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568372287;
        bh=ldS8lh69hUAkwyEhqE71DBPKMkO/1ut48xJKA2xOv0k=;
        h=From:To:Cc:Subject:Date:From;
        b=oxgBz/nN2hwCbPhXHNYgU7KCZi56gVNcYdymzuw1YDcSGNWpYCDzoZCQEWl2YYJpN
         H/1bewfeBFa6JTy8cIiLeRplMhZEAyQETLEmG4L/ME5+sUrdcMAcMbf5Lx7+Q5yv3+
         MrVsz0RqyIUI73mEpOoz2E+YQU+hk412SlT4tl/E=
From:   Jeff Layton <jlayton@kernel.org>
To:     coreutils@gnu.org
Cc:     adilger@dilger.ca, dhowells@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [coreutils PATCH v2 0/2] ls: convert to using statx when available
Date:   Fri, 13 Sep 2019 06:58:03 -0400
Message-Id: <20190913105805.24669-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2:
- add wrappers for stat_for_ino and fstat_for_ino, don't factor out loop
  detection
- style cleanups

Sending to a wider distribution list this time, as this may encourage
other filesystem maintainers to flesh out their statx implementations
to take advantage of this.

Original patch description follows:

This patchset converts the ls command to use statx instead of stat when
available. This allows ls to indicate interest in only certain inode
metadata.

This is potentially a win on networked/clustered/distributed
filesystems. In cases where we'd have to do a full, heavyweight stat()
call we can now do a much lighter statx() call.

As a real-world example, consider a filesystem like CephFS where one
client is actively writing to a file and another client does an
ls --color in the same directory. --color means that we need to fetch
the mode of the file.

Doing that with a stat() call means that we have to fetch the size and
mtime in addition to the mode. The MDS in that situation will have to
revoke caps in order to ensure that it has up-to-date values to report,
which disrupts the writer.

This has a measurable affect on performance. I ran a fio sequential
write test on one cephfs client and had a second client do "ls --color"
in a tight loop on the directory that held the file:

Baseline -- no activity on the second client:

  WRITE: bw=76.7MiB/s (80.4MB/s), 76.7MiB/s-76.7MiB/s (80.4MB/s-80.4MB/s), io=4600MiB (4824MB), run=60016-60016msec

Without this patch series, we see a noticable performance hit:

  WRITE: bw=70.4MiB/s (73.9MB/s), 70.4MiB/s-70.4MiB/s (73.9MB/s-73.9MB/s), io=4228MiB (4433MB), run=60012-60012msec

With this patch series, we gain most of that ground back:

  WRITE: bw=75.9MiB/s (79.6MB/s), 75.9MiB/s-75.9MiB/s (79.6MB/s-79.6MB/s), io=4555MiB (4776MB), run=60019-60019msec

Jeff Layton (2):
  stat: move struct statx to struct stat conversion routines to new
    header
  ls: use statx instead of stat when available

 src/ls.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
 src/stat.c  |  32 +---------------
 src/statx.h |  54 ++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 38 deletions(-)
 create mode 100644 src/statx.h

-- 
2.21.0

