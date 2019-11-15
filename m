Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53415FE27C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKOQR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:17:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:36786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727520AbfKOQR1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C486EAC4A;
        Fri, 15 Nov 2019 16:17:25 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com
Subject: btrfs direct-io using iomap
Date:   Fri, 15 Nov 2019 10:16:53 -0600
Message-Id: <20191115161700.12305-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an effort to use iomap for direct I/O in btrfs. This would
change the call from __blockdev_direct_io() to iomap_dio_rw().

The main objective is to lose the buffer head and use bio defined by
iomap code, and hopefully to use more of generic-FS codebase.

I have tested it against xfstests. The performance seems to be nearly
the same on my VMs.

-- 
Goldwyn

 fs/btrfs/ctree.h      |    1 
 fs/btrfs/extent_io.c  |    8 ++-
 fs/btrfs/file.c       |   67 +++++++++++++++++++++++++-
 fs/btrfs/inode.c      |  128 +++++++++++++++++++++-----------------------------
 fs/iomap/direct-io.c  |   14 +++--
 include/linux/fs.h    |    2 
 include/linux/iomap.h |    2 
 mm/filemap.c          |   13 ++---
 8 files changed, 147 insertions(+), 88 deletions(-)

