Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842A01A7A42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439805AbgDNMEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 08:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439798AbgDNMEL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:04:11 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850382075E;
        Tue, 14 Apr 2020 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865851;
        bh=qk8/5tffuCZyikBXS0nEYbIy3MZRyj3WjOSOuxvOA0g=;
        h=From:To:Cc:Subject:Date:From;
        b=i+4LFEdVjPzr/lqUfVKMLBInvN4r/7vjZzXuLk037ViyzTzrDL9UoYmDCmUGGMIAj
         lKbQ6aFmNjP572bSccdFugLcbjPzzYAW5zTifExQoKXo6jtgZxRHYVieeb3J2HY0rP
         geWt4N9CES7fcOAVpz9jRJqHykvlt24TTqYbzSY0=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v4 RESEND 0/2] vfs: have syncfs() return error when there are writeback errors
Date:   Tue, 14 Apr 2020 08:04:07 -0400
Message-Id: <20200414120409.293749-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I sent the original v4 set on February 13th. There have been no changes
since then (other than a clean rebase onto master). I'd like to see this
go into v5.8 if this looks reasonable. Original v4 cover letter follows:

-----------------8<---------------

v4:
- switch to dedicated errseq_t cursor in struct file for syncfs
- drop ioctl for fetching the errseq_t without syncing

This is the fourth posting of this patchset. After thinking about it
more, I think multiplexing file->f_wb_err based on O_PATH open is just
too weird. I think it'd be better if syncfs() "just worked" as expected
no matter what sort of fd you use, or how you multiplex it with fsync.

Also (at least on x86_64) there is currently a 4 byte pad at the end of
the struct so this doesn't end up growing the memory utilization anyway.
Does anyone object to doing this?

I've also dropped the ioctl patch. I have a draft patch to expose that
via fsinfo, but that functionality is really separate from returning an
error to syncfs. We can look at that after the syncfs piece is settled.

Jeff Layton (2):
  vfs: track per-sb writeback errors and report them to syncfs
  buffer: record blockdev write errors in super_block that it backs

 drivers/dax/device.c    |  1 +
 fs/buffer.c             |  2 ++
 fs/file_table.c         |  1 +
 fs/open.c               |  3 +--
 fs/sync.c               |  6 ++++--
 include/linux/fs.h      | 16 ++++++++++++++++
 include/linux/pagemap.h |  5 ++++-
 7 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.25.2

