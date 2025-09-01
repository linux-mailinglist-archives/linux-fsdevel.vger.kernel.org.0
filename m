Return-Path: <linux-fsdevel+bounces-59923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7FAB3F14C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 01:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F4B189FE67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6628726E;
	Mon,  1 Sep 2025 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0MtS/cRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF615E8B;
	Mon,  1 Sep 2025 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756768502; cv=none; b=WJb/jFcqCK2aIdBWcTFFaBembNy2oPX+4lKeXL1BRsYh4ZrIuZN1PUjnP/xffvhddTLINvJpWyXNddmRfB25KssWSNO40GzDd0HzO7qU2fSfrfkAsAvPpzrgPiHa5QPID523c3JRCe9tafwdmC+1++vcLhNxQe+f0DZ8jt7SNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756768502; c=relaxed/simple;
	bh=ygKnE+IltxOXIp5p79x9wfHQd5zLgcG1Wm046Dcjfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dj//do4XsX/gq3rHj9GEtIHstpLkHJ0VJnW3Qgq2T5Ah6EIbUmN/2EI94E3fK0d1parQBl05lHYyg2Wqfst866RygRgBLXFEvLi/2Rgtms4zgVxe8rZMGF0gMt/zBO7SqNfaDulpNWgx0wXWb7AtHraOI9T0dm6ACmA4g966fY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0MtS/cRE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=R3Kh8a0W/CYcl61SRfKWoq4jyctXtMxOD0GfEp0yocA=; b=0MtS/cRE96LOUdZSLn/kUsCqvY
	GttpkhXRe49qWV0+3n7YhDmOThAweZniCOkrxQhAPgLdYPniiRIIrVHBxgZkFKp5yUxFqMRL1NQ+d
	NSJ+pijCTO8MdJyK7i8/ph9th/EnNqN0dKLpILrWx37CFa0Fq5AjhwI6H1FRFG3U18XAeDdJlvO+N
	dsxolIlgmDk+o5SzvrKGqp9GkjLBhb75kKKutHCL58XqOAgC1wS5BO65JgCwTpwFTKrdsQbKMQPl8
	4pDQwzHTiurKzPqCMRKjZT823DnSh8RR+JLtkQPu6Jobo0xwCd3M9el2ryl66Sk9vqtFGxNCTiNh0
	SHpWtShA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utDjm-0000000EHK5-2ST3;
	Mon, 01 Sep 2025 23:14:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	linux-api@vger.kernel.org
Subject: [PATCH v2] uapi/fcntl: define RENAME_* and AT_RENAME_* macros
Date: Mon,  1 Sep 2025 16:14:48 -0700
Message-ID: <20250901231457.1179748-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define the RENAME_* and AT_RENAME_* macros exactly the same as in
recent glibc <stdio.h> so that duplicate definition build errors in
both samples/watch_queue/watch_test.c and samples/vfs/test-statx.c
no longer happen. When they defined in exactly the same way in
multiple places, the build errors are prevented.

Defining only the AT_RENAME_* macros is not sufficient since they
depend on the RENAME_* macros, which may not be defined when the
AT_RENAME_* macros are used.

Build errors being fixed:

for samples/vfs/test-statx.c:

In file included from ../samples/vfs/test-statx.c:23:
usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
  159 | #define AT_RENAME_NOREPLACE     0x0001
In file included from ../samples/vfs/test-statx.c:13:
/usr/include/stdio.h:171:10: note: this is the location of the previous definition
  171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
  160 | #define AT_RENAME_EXCHANGE      0x0002
/usr/include/stdio.h:173:10: note: this is the location of the previous definition
  173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
  161 | #define AT_RENAME_WHITEOUT      0x0004
/usr/include/stdio.h:175:10: note: this is the location of the previous definition
  175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT

for samples/watch_queue/watch_test.c:

In file included from usr/include/linux/watch_queue.h:6,
                 from ../samples/watch_queue/watch_test.c:19:
usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
  159 | #define AT_RENAME_NOREPLACE     0x0001
In file included from ../samples/watch_queue/watch_test.c:11:
/usr/include/stdio.h:171:10: note: this is the location of the previous definition
  171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
  160 | #define AT_RENAME_EXCHANGE      0x0002
/usr/include/stdio.h:173:10: note: this is the location of the previous definition
  173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
  161 | #define AT_RENAME_WHITEOUT      0x0004
/usr/include/stdio.h:175:10: note: this is the location of the previous definition
  175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT

Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be allocated")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>
CC: linux-api@vger.kernel.org
To: linux-fsdevel@vger.kernel.org

 include/uapi/linux/fcntl.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-next-20250819.orig/include/uapi/linux/fcntl.h
+++ linux-next-20250819/include/uapi/linux/fcntl.h
@@ -156,9 +156,12 @@
  */
 
 /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
-#define AT_RENAME_NOREPLACE	0x0001
-#define AT_RENAME_EXCHANGE	0x0002
-#define AT_RENAME_WHITEOUT	0x0004
+# define RENAME_NOREPLACE (1 << 0)
+# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
+# define RENAME_EXCHANGE (1 << 1)
+# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
+# define RENAME_WHITEOUT (1 << 2)
+# define AT_RENAME_WHITEOUT RENAME_WHITEOUT
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for

