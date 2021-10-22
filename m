Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446F2437F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhJVURl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:17:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhJVURl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:17:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B0D81FD61;
        Fri, 22 Oct 2021 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634933722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rq8HbjLBNcuj5Y+rDUERbP3x4jBlExy8N6+dOyBNy1c=;
        b=CA3h9owT3mQp9SOGGhHRLQhCSAHXVfAY9ssoIJbhrn1Cwe/RW3JfWTx8rh7cjhu0Hq+ILg
        Zm8kNxnL564YCa1OJ6Ry+jyU9ZUMvmVKVTfj2Kct/UMvZKbDMgPZphATV2JXVMrsFQU7E0
        D4yQtWbAs7Xq2oCV2yLC+dA3NBnImZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634933722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rq8HbjLBNcuj5Y+rDUERbP3x4jBlExy8N6+dOyBNy1c=;
        b=T0WM7bLdUtZpqVV97hTsJl8/fRxniNCJMQNUm8+0bzeeaFRXxeacYVDftdr7XyXiQOg4zX
        0Ox4MwUpSNDwA4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0D11348D;
        Fri, 22 Oct 2021 20:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LO/I9gbc2HUdgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 22 Oct 2021 20:15:20 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 0/5] Shared memory for shared extents
Date:   Fri, 22 Oct 2021 15:15:00 -0500
Message-Id: <cover.1634933121.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is an attempt to reduce the memory footprint by using a shared
page(s) for shared extent(s) in the filesystem. I am hoping to start a
discussion to iron out the details for implementation.

Abstract
If mutiple files share an extent, reads from each of the files would
read individual page copies in the inode pagecache mapping, leading to
waste of memory. Instead add the read pages of the filesystem to
underlying device's bd_inode as opposed to file's inode mapping. The
cost is that file offset to device offset conversion happens early in
the read cycle.

Motivation:
 - Reduce memory usage for shared extents
 - Ease DAX implementation for shared extents
 - Reduce Container memory utilization

Implementation
In the read path, pages are read and added to the block_device's
inode's mapping as opposed to the inode's mapping. This is limited
to reads, while write's (and read before writes) still go through
inode's i_mapping. The path does check the inode's i_mapping before
falling back to block device's i_mapping to read pages which may be
dirty. The cost of the operation is file_to_device_offset() translation
on reads. The translation should return a valid value only in case
the file is CoW.

This also means that page->mapping may not point to file's mapping.

Questions:
1. Are there security implications for performing this for read-only
pages? An alternate idea is to add a "struct fspage", which would be
pointed by file's mapping and would point to the block device's page.
Multiple files with shared extents have their own independent fspage
pointing to the same page mapped to block device's mapping.
Any security parameters, if required, would be in this structure. The
advantage of this approach is it would be more flexible with respect to
CoW when the page is dirtied after reads. With the current approach, a
read for write is an independent operation so we can end up with two
copies of the same page. This implementation got complicated too quickly.

2. Should pages be dropped after writebacks (and clone_range) to avoid
duplicate copies?

Limitations:
1. The filesystem have exactly one underlying device.
2. Page size should be equal to filesystem block size

Goldwyn Rodrigues (5):
  mm: Use file parameter to determine bdi
  mm: Switch mapping to device mapping
  btrfs: Add sharedext mount option
  btrfs: Set s_bdev for btrfs super block
  btrfs: function to convert file offset to device offset

 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/file.c    | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/super.c   |  7 +++++++
 include/linux/fs.h |  7 ++++++-
 mm/filemap.c       | 34 ++++++++++++++++++++++++++--------
 mm/readahead.c     |  3 +++
 6 files changed, 83 insertions(+), 11 deletions(-)

-- 
2.33.1

