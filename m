Return-Path: <linux-fsdevel+bounces-24928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E569946B60
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 00:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED32820F3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298434D8B1;
	Sat,  3 Aug 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l/4zf5iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B39EEC3
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722725459; cv=none; b=tlDRwTplOqpEeVDKI8SOg6H2dqB4Wl3Ygn7uYcwQoDCBZqRZJ+taVXciHFflyh5U355fl8zmegaq9d1vHX2LTA1psYdzsksRZai1piwax8+2nHt2E31/HFrYI9u5Y6ikUFIp223nGCe4HO/iP20LKLUg8du1xd9yrQSw71n0i/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722725459; c=relaxed/simple;
	bh=nUysVZm9hMntwUBUjs6D/pQbwmubwd4sYrO+X6Brt9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L/NQHqRqfVWC0me1pHy+Afyzs9k0IohwZGZyjEUdPcZjdeAcVmjm9Px1j9XD5p8NKIpIhfeDbHW7cudFWqGSSwN/4H5VjR2xsYPsex5+2bS6arcSWOnglYoAWnNMx04W9thZp4eI2j28rJ2sMzbEiT4vrYlszHDIt5G1uu9vCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l/4zf5iD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Wq4/Ps8PxnDGwp7IokWbmltEfy9nI/IhQqO1pl2WUoM=; b=l/4zf5iDbsVNvkYv/9cBEjoXew
	60UrlJU6ihVijWnYsIGSJ/J/zbtO32RCOmBfrIHZcGnqT+IuE+7bFuc6sZCZaaZ4oCeb0Yg9HKBP9
	2knCu+3i7+MikOBsZEWrmZpinjG0I4kXb8Jn8vg0azFAm5vMyg65PQTce/dZhLynUUbpCKk4wx8UW
	XY+jeYu1Mer+rxWXmj/CzCd+n3yHYenj0LiMd97UEnKFBZ2WzgCVz5DGgWVOdKr9wM2zfC2V0hABa
	Ii1i9oYnYSZhsfgWASN+r5Y77Cg6TKnni7OI9hp8kOpf6NTicDxUxo+0uAehDmiqLQO0LqWzUGzA8
	kSj5nkgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saNaQ-00000001QBB-1qpz;
	Sat, 03 Aug 2024 22:50:54 +0000
Date: Sat, 3 Aug 2024 23:50:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240803225054.GY5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[in vfs.git#fixes]

copy_fd_bitmaps(new, old, count) is expected to copy the first
count/BITS_PER_LONG bits from old->full_fds_bits[] and fill
the rest with zeroes.  What it does is copying enough words
(BITS_TO_LONGS(count/BITS_PER_LONG)), then memsets the rest.
That works fine, *if* all bits past the cutoff point are
clear.  Otherwise we are risking garbage from the last word
we'd copied.

For most of the callers that is true - expand_fdtable() has
count equal to old->max_fds, so there's no open descriptors
past count, let alone fully occupied words in ->open_fds[],
which is what bits in ->full_fds_bits[] correspond to.

The other caller (dup_fd()) passes sane_fdtable_size(old_fdt, max_fds),
which is the smallest multiple of BITS_PER_LONG that covers all
opened descriptors below max_fds.  In the common case (copying on
fork()) max_fds is ~0U, so all opened descriptors will be below
it and we are fine, by the same reasons why the call in expand_fdtable()
is safe.

Unfortunately, there is a case where max_fds is less than that
and where we might, indeed, end up with junk in ->full_fds_bits[] -
close_range(from, to, CLOSE_RANGE_UNSHARE) with
	* descriptor table being currently shared
	* 'to' being above the current capacity of descriptor table
	* 'from' being just under some chunk of opened descriptors.
In that case we end up with observably wrong behaviour - e.g. spawn
a child with CLONE_FILES, get all descriptors in range 0..127 open,
then close_range(64, ~0U, CLOSE_RANGE_UNSHARE) and watch dup(0) ending
up with descriptor #128, despite #64 being observably not open.

The best way to fix that is in dup_fd() - there we both can easily check
whether we might need to fix anything up and see which word needs the
upper bits cleared.
    
Reproducer follows:

#define __GNU_SOURCE
#include <linux/close_range.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <sched.h>
#include <stdio.h>
#include <stdbool.h>
#include <sys/mman.h>
    
void is_open(int fd)
{
	printf("#%d is %s\n", fd,
		fcntl(fd, F_GETFD) >= 0 ? "opened" : "not opened");
}
    
int child(void *unused)
{
	while(1) {
	}
	return 0;
}
    
int main(void)
{
	char *stack;
	pid_t pid;

	stack = mmap(NULL, 1024*1024, PROT_READ | PROT_WRITE,
		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
	if (stack == MAP_FAILED) {
		perror("mmap");
		return -1;
	}

	pid = clone(child, stack + 1024*1024, CLONE_FILES | SIGCHLD, NULL);
	if (pid == -1) {
		perror("clone");
		return -1;
	}
	for (int i = 2; i < 128; i++)
	    dup2(0, i);
	close_range(64, ~0U, CLOSE_RANGE_UNSHARE);

	is_open(64);
	printf("dup(0) => %d, expected 64\n", dup(0));

	kill(pid, 9);
	return 0;
}

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/file.c b/fs/file.c
index a11e59b5d602..7f0ab8636d7c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -380,6 +380,20 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	if (unlikely(max_fds != NR_OPEN_MAX)) {
+		/*
+		 * if there had been opened descriptors past open_files,
+		 * the last copied word in full_fds_bits might have picked
+		 * stray bits; nothing of that sort happens to open_fds and
+		 * close_on_exec, since there the part that needs to be copied
+		 * will always fall on a word boundary.
+		 */
+		unsigned int n = open_files / BITS_PER_LONG;
+		if (n % BITS_PER_LONG) {
+			unsigned long mask = BITMAP_LAST_WORD_MASK(n);
+			new_fdt->full_fds_bits[n / BITS_PER_LONG] &= mask;
+		}
+	}
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;

