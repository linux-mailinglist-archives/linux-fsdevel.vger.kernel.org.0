Return-Path: <linux-fsdevel+bounces-25847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0BD951157
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 03:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5541C229C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09303B64C;
	Wed, 14 Aug 2024 01:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YdLi6oxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB7A953;
	Wed, 14 Aug 2024 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597408; cv=none; b=CbunFdqZh9w5oBp9C+KTM3pnClc0PPCTL0mSe/xvF7CBIDDX9PrN26sfuFYr1UXIMgpwXnG+TOI/JAul/zwZ1gKHQyBgN6viPxyt+SY5pt/oLbsdAWU0OCAnIFBJQGVIaAcekVqV2A7EBS63Iw63AqK5TEugYg30apQvBT1k7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597408; c=relaxed/simple;
	bh=X2cjWhK91yZUd8NfItDNnRujO8ZZmUojRLMU3NX+WNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frbk228vmLv9szyP8Pbon/GtS3mWHMRnFVXQmfckr82GZmxKJPt5MKMzeBKQbkVbbsaEFKKWMjxsoYKIeE8f3SUlq+84Dj+aC4I+nr6xBNKIAYq3gztpEdetLLch0sdERa8Dot7ax5ijHtsDH9Asg7eIdG+zqkzh2aMna7kO4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YdLi6oxI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oN93NLjR7WOWPcVE9mK5Uy/eGRzf8KT3MmZMXRntGOM=; b=YdLi6oxISNoUTQxrG04ftHXe8r
	NW3tq1v1j8+8IbQ7Hg3ZL2jck1M3shoxFjeNV8WKgPVDzCQFatXPx3rK+a5ZbtKv/28LJd0Ja5PBL
	/zr7uECMSSgA8yuP0aYxDsr5MZSbJ394ufzre3a78VXreT3tRujtHDihSTZ7C9v8vXAnwgnIJ8t3/
	xiThBxLmRXmMpmjsGvdKFuqp8FqoXlFsX332Dy0i+DvWj/rnyR0afYvJ054EquCA0DzWgDrSkg0te
	SATpP/saXzq+j9ZD24AoXTODje0R+whTKh06Expl4I1ZHXKWytaUG5E3jqqqSPGpFKk6OCKeRjLHE
	5bqlbdkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se2Q5-00000001TwP-44X1;
	Wed, 14 Aug 2024 01:03:22 +0000
Date: Wed, 14 Aug 2024 02:03:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [viro-vfs:work.fdtable 13/13] kernel/fork.c:3242 unshare_fd()
 warn: passing a valid pointer to 'PTR_ERR'
Message-ID: <20240814010321.GL13701@ZenIV>
References: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
 <20240813181600.GK13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813181600.GK13701@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 13, 2024 at 07:16:00PM +0100, Al Viro wrote:
> On Tue, Aug 13, 2024 at 11:00:04AM +0300, Dan Carpenter wrote:
> > 3f4b0acefd818e Al Viro           2024-08-06  3240  		if (IS_ERR(*new_fdp)) {
> > 3f4b0acefd818e Al Viro           2024-08-06  3241  			*new_fdp = NULL;
> > 3f4b0acefd818e Al Viro           2024-08-06 @3242  			return PTR_ERR(new_fdp);
> >                                                                                ^^^^^^^^^^^^^^^^
> > 	err = PTR_ERR(*new_fdp);
> > 	*new_fdp = NULL;
> > 	return err;
> 
> Argh...  Obvious braino, but what it shows is that failures of that
> thing are not covered by anything in e.g. LTP.  Or in-kernel
> self-tests, for that matter...

FWIW, this does exercise that codepath, but I would really like to
have kselftest folks to comment on the damn thing - I'm pretty sure
that it's _not_ a good style for those.

diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
index ce262d097269..8e99f87f5d7c 100644
--- a/tools/testing/selftests/core/Makefile
+++ b/tools/testing/selftests/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := close_range_test
+TEST_GEN_PROGS := close_range_test unshare_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
new file mode 100644
index 000000000000..7fec9dfb1b0e
--- /dev/null
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <sys/resource.h>
+#include <linux/close_range.h>
+
+#include "../kselftest_harness.h"
+#include "../clone3/clone3_selftests.h"
+
+TEST(unshare_EMFILE)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+	int fd;
+	ssize_t n, n2;
+	static char buf[512], buf2[512];
+	struct rlimit rlimit;
+	int nr_open;
+
+	fd = open("/proc/sys/fs/nr_open", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	n = read(fd, buf, sizeof(buf));
+	ASSERT_GT(n, 0);
+	ASSERT_EQ(buf[n - 1], '\n');
+
+	ASSERT_EQ(sscanf(buf, "%d", &nr_open), 1);
+
+	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
+
+	/* bump fs.nr_open */
+	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
+	lseek(fd, 0, SEEK_SET);
+	write(fd, buf2, n2);
+
+	/* bump ulimit -n */
+	rlimit.rlim_cur = nr_open + 1024;
+	rlimit.rlim_max = nr_open + 1024;
+	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	/* get a descriptor past the old fs.nr_open */
+	EXPECT_GE(dup2(2, nr_open + 64), 0) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	EXPECT_GE(pid, 0) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	if (pid == 0) {
+		int err;
+
+		/* restore fs.nr_open */
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
+		err = unshare(CLONE_FILES);
+		EXPECT_EQ(err, -1)
+			exit(EXIT_FAILURE);
+		EXPECT_EQ(errno, EMFILE)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST_HARNESS_MAIN

