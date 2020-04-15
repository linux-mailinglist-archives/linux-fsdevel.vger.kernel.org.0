Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC51A9F7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368625AbgDOMNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 08:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898108AbgDOMNC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:13:02 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C7420737;
        Wed, 15 Apr 2020 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586952782;
        bh=sqR44rkKRndArbx5WVO6OfSPnYaxS53j2raSE63bXUA=;
        h=From:To:Cc:Subject:Date:From;
        b=0sYsiYDVIV54P98SHBVm1ITyVkBa8qArzDth5PguYIZFk6IqGuE6KED3O+veY4yUm
         9h3bsGoNugcrnUcc+D+EMFFcv+jy4tn9Pxvolq0e3X+dUZZckEiZGmsUIcw0vk10o1
         m9dYgxrX5B7pW5p7mchuSuTGDxKRf5SAYRzgVFNk=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v5 0/2] vfs: have syncfs() return error when there are writeback errors
Date:   Wed, 15 Apr 2020 08:12:58 -0400
Message-Id: <20200415121300.228017-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v5:
- use RCU to ensure that bd_super doesn't go away while we're using it

This is the fifth iteration of this patchset. The main difference from
v4 is that this one uses RCU to ensure validity of the bd_super pointer
when we're marking it after a buffer_head writeback error.

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
2.25.2

