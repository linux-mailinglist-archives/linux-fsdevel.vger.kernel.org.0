Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496761BC03A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 15:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1Nv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 09:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgD1Nv6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:51:58 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BDA206B9;
        Tue, 28 Apr 2020 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588081918;
        bh=X2ol4rocPF2ZJBHHLlHiFYeAjC6ioYlP2NnvBhXo7o0=;
        h=From:To:Cc:Subject:Date:From;
        b=VhOq+pLLHaMiH/1tzmZo19CBTqQgxNeUYjA1sxNGSdJRmAl6Nlx1O/Jau1FpYdsJF
         5BX/NmSwvU4Yt+553IGnq+5WriTvZG+PchU1YVwpCPgRd9na9Zya+LbltarsMoBtEV
         OELKOWhNJjmA655Tt7ERhr2ZFjpqXV2USGrp/B4I=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        david@fromorbit.com
Subject: [PATCH v6 RESEND 0/2] vfs: have syncfs() return error when there are writeback errors
Date:   Tue, 28 Apr 2020 09:51:53 -0400
Message-Id: <20200428135155.19223-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a resend since this hasn't been picked up yet. No real changes
from the last set (other than adding Jan's Reviewed-bys). Latest
cover letter follows:

--------------------------8<----------------------------

v6:
- use READ_ONCE to ensure that compiler doesn't optimize away local var

The only difference from v5 is the change to use READ_ONCE to fetch the
bd_super pointer, to ensure that the compiler doesn't refetch it
afterward. Many thanks to Jan K. for the explanation!

Jeff Layton (2):
  vfs: track per-sb writeback errors and report them to syncfs
  buffer: record blockdev write errors in super_block that it backs

 drivers/dax/device.c    |  1 +
 fs/buffer.c             |  7 +++++++
 fs/file_table.c         |  1 +
 fs/open.c               |  3 +--
 fs/sync.c               |  6 ++++--
 include/linux/fs.h      | 16 ++++++++++++++++
 include/linux/pagemap.h |  5 ++++-
 7 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.26.1

