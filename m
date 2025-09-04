Return-Path: <linux-fsdevel+bounces-60251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E53B4323C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EE13AE8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3E25FA34;
	Thu,  4 Sep 2025 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQ29M/xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19325A326;
	Thu,  4 Sep 2025 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966940; cv=none; b=OGv6gHra92uuyRvOtxZL1epJ6iUm939e/x9xaSeyFMhEMiCT3hGVJMeCXtVdhhO7gqVUIYHhr10fLqzpV5bUJn0lXDgR9ng3Lo6Ch5PUfZ9jp5p4TX1a17KL3aw/w95wWKyOv/xJ4z+WaPaDZE7XZlfV8l63jD5wS4VKX8PFO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966940; c=relaxed/simple;
	bh=4gkG1uQk8lWw9rbqJBG1qb0f1uOkOI0jK2sCgnyNfbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCWHVVOWc/IWNpnVfe1F3cMAWVLrTMlH7j1j+fP3ffTT4AYKrZKizcVWEWIYq7Y4mboW064dCohIUDOmNZKItlhX1EgM9fT5C+WUYHnGEw7m+/7oZal916xPM185FwcvUEX3CJ724g3qI8Wzw8ZldVfpNkAOC6Wg0xuVVqFy9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQ29M/xj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lvF9s1nrRUArY5JJjxvX+LxPs3kFn+zwehWVSSbnB/0=; b=XQ29M/xjdUFRrP1V73XyhALtKC
	CX+7fu+3C2OuT6HWbNZKBKI+bPJlf5IPTK4z9UUsKRoF4OIw5pvArpD0K8ungf1BDH95pLtb0Zs0A
	SD+pd+t4OnBYprF6LGY4EyY9ZxrU2IBqP/s1CzEcaqpanlg4Ln8Q7y2i41fspIq4htFp35jn/FsjB
	CL2TCDJ4GcY3WcetjN/Qt+DBho+9/M296UkXmvB5mgjZtOP/ZL4tVsNQRDxueMpBpRXvXQFaUsSce
	E+ZKvRgWEV+2C25grTAgDfZv4pIJ/FIgWXEckbUkBfyMCq5UkdB40CKQGbUBiX0yUuu4zYHWCj4xZ
	phsb0yaw==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3MO-00000009Ue5-1Loe;
	Thu, 04 Sep 2025 06:22:16 +0000
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
Subject: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
Date: Wed,  3 Sep 2025 23:22:15 -0700
Message-ID: <20250904062215.2362311-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't define the AT_RENAME_* macros at all since the kernel does not
use them nor does the kernel need to provide them for userspace.
Leave them as comments in <uapi/linux/fcntl.h> only as an example.

The AT_RENAME_* macros have recently been added to glibc's <stdio.h>.
For a kernel allmodconfig build, this made the macros be defined
differently in 2 places (same values but different macro text),
causing build errors/warnings (duplicate definitions) in both
samples/watch_queue/watch_test.c and samples/vfs/test-statx.c.
(<linux/fcntl.h> is included indirecty in both programs above.)

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
---
 include/uapi/linux/fcntl.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20250819.orig/include/uapi/linux/fcntl.h
+++ linux-next-20250819/include/uapi/linux/fcntl.h
@@ -155,10 +155,16 @@
  * as possible, so we can use them for generic bits in the future if necessary.
  */
 
+/*
+ * Note: This is an example of how the AT_RENAME_* flags could be defined,
+ * but the kernel has no need to define them, so leave them as comments.
+ */
 /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+/*
 #define AT_RENAME_NOREPLACE	0x0001
 #define AT_RENAME_EXCHANGE	0x0002
 #define AT_RENAME_WHITEOUT	0x0004
+*/
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for

