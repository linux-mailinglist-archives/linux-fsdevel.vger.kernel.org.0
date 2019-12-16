Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEB121631
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 19:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbfLPS1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 13:27:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfLPS1b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:27:31 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB2020674;
        Mon, 16 Dec 2019 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520851;
        bh=b7Zp+m/Ds/ef6McCgYGXwFpr6eOhigKmMCfpL2V5pcU=;
        h=From:To:Cc:Subject:Date:From;
        b=jo2ByGw83eCwSN9pPuEYe9csRAGVRIV0Dl4pLna2CCBBMcXaF0gkHChJKXSFAMJDk
         Ds1OfC4E1Tkngf25ebedwFUZHvuBMuUzs92CpDodtVPXsmY09d2LA/0lRZYHbH4J8b
         dsW42sN6kAfJErOvaEcrlJ5ydgLQbmsZiBlKKuko=
From:   fdmanana@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] Allow deduplication of the eof block when it is safe to do so
Date:   Mon, 16 Dec 2019 18:26:54 +0000
Message-Id: <20191216182656.15624-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Hi,

This short series allows deduplication of the last block of a file when
the eof is not aligned to the sector size, as long as the range's end
offset matches the eof of the destination file.

This is a safe case unlike the case where we attempt to clone the block in
the middle of a file (which results in a corruption I found last year and
affected both btrfs and xfs).

This is motivated by btrfs users reporting lower deduplication scores
starting with kernel 5.0, which was the kernel release where btrfs was
changed to use the generic VFS helper generic_remap_file_range_prep().
Users observed that the last block was no longer deduplicated when a
file's size is not block size aligned.  For btrfs this is specially
important because references are kept per extent and not per block, so
not having the last block deduplicated means the entire extent is kept
allocated, making the deduplication not effective and often pointless in
many cases.

Thanks.

Filipe Manana (2):
  fs: allow deduplication of eof block into the end of the destination
    file
  Btrfs: make deduplication with range including the last block work

 fs/btrfs/ioctl.c |  3 ++-
 fs/read_write.c  | 10 ++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.11.0

