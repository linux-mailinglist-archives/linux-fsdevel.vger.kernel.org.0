Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D300C28FCF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 05:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394237AbgJPDiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 23:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394231AbgJPDiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:38:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29721C061755;
        Thu, 15 Oct 2020 20:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9aEY4RTYZqQRzr7uyYpynN+nBEKkXzKUKmXjKVOYXN4=; b=IcYVkeXWh7FXe4QoDSa3EY7lfh
        9DN5/EDp5xtMsytOa+EputSxHPbYAW3my0bXTSd1d2dMXJQEe629alhUbsjN6m44KeGypoxJ8Ao4U
        x5hflHR89U1GH2ixLhnRundf4VVvabG4opsFW7IKqsj4zDMmRANgrDQoZJfDqN3jeM8aav7zjWXWI
        iVD7Iqa0zhxRJOnB1RBeQUymjjT23F8KJANJDjubmCK6JnVSeTY8KXzxc4RjIwS+yFZSy9O484McU
        0HHm8yNs9GMStsKiisW2Qmf2q0SjzBQLLrrjxOQ7m79hfOjX6AzcUgnkparZwUPA0/nGd28OxLJIy
        a6ArUcRA==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTGZE-0007af-9Q; Fri, 16 Oct 2020 03:38:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/2] Documentation: add eventpoll to fs api-summary book
Date:   Thu, 15 Oct 2020 20:38:05 -0700
Message-Id: <20201016033805.13784-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add fs/eventpoll.c to the filesystem api-summary book.

Fix kernel-doc warnings in eventpoll.c:

../fs/eventpoll.c:1132: warning: Function parameter or member 'new' not described in 'list_add_tail_lockless'
../fs/eventpoll.c:1132: warning: Function parameter or member 'head' not described in 'list_add_tail_lockless'
../fs/eventpoll.c:1172: warning: Function parameter or member 'epi' not described in 'chain_epi_lockless'

Also remove kernel-doc begin notation (/**) from reverse_path_check()
and some other comment blocks.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/api-summary.rst |    6 ++++++
 fs/eventpoll.c                            |    6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

--- linux-next-20201013.orig/Documentation/filesystems/api-summary.rst
+++ linux-next-20201013/Documentation/filesystems/api-summary.rst
@@ -125,6 +125,12 @@ Events based on file descriptors
 .. kernel-doc:: fs/eventfd.c
    :export:
 
+eventpoll (epoll) interfaces
+============================
+
+.. kernel-doc:: fs/eventpoll.c
+   :internal:
+
 The Filesystem for Exporting Kernel Objects
 ===========================================
 
--- linux-next-20201013.orig/fs/eventpoll.c
+++ linux-next-20201013/fs/eventpoll.c
@@ -1106,7 +1106,7 @@ struct file *get_epoll_tfile_raw_ptr(str
 }
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 
-/**
+/*
  * Adds a new entry to the tail of the list in a lockless way, i.e.
  * multiple CPUs are allowed to call this function concurrently.
  *
@@ -1159,7 +1159,7 @@ static inline bool list_add_tail_lockles
 	return true;
 }
 
-/**
+/*
  * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
  * i.e. multiple CPUs are allowed to call this function concurrently.
  *
@@ -1419,7 +1419,7 @@ static int reverse_path_check_proc(void
 	return error;
 }
 
-/**
+/*
  * reverse_path_check - The tfile_check_list is list of file *, which have
  *                      links that are proposed to be newly added. We need to
  *                      make sure that those added links don't add too many
