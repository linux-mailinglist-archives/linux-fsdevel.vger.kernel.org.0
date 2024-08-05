Return-Path: <linux-fsdevel+bounces-25036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9B9481F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4248D2814AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9715F418;
	Mon,  5 Aug 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g+/OqHXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9491D540
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884074; cv=none; b=mXE8O61YHbW53t/MeGV4n1h3+XDAqhdq2SLMYYYH/Vw7faArDb7AtEWgOjaZcx1gpahCCSLeBoPyE8yf0bfS9QgHxmMpUHmquddl2VJrq/Nr7yEVbS+mUjDMyazAzTG27J/9UuNveJHfFR6uyoEOwHJULuLkR7/xxu/U38lUaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884074; c=relaxed/simple;
	bh=IMvD36BxnPsmWHWQMsOoyA59sFwEXJwvuasIiJsLfEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqCJBLqQMxK/ztnYUSwKxYDKL380sQN41FLq5IL1axb8hF4/1iOH4a3VooCjbdUtqlYcozKI8r0b4SHW14OG5d/byQQG5PALteeaWOISrPHjsJq3nlKJn/ECvm1MLFH5dRV99C1M9Eg/7e0V2q2LnymOXkkiYKX1FopdZPziB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g+/OqHXx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LLu01/QXzdOjOjiFCPKY1FxifOgTfLND7uFdzLg4E8k=; b=g+/OqHXxlz/Phenh8T7h1njmEt
	ljnEGElovs0ZUTBgsCDGOq4IRqLs36zalCPX3+JtOGVYAp2Xk9LedEHtuAmQjAU4Dk/BH//GPQx87
	92iot5NLsQe33/UK+UeEf42WUu4x41G6Ndrj2fndfZr5Vk5iKLxz0gaW1P/V0zhuQFwI4M4xZQRtC
	+EffhA9FJh2XWWzq2GEecyQb8dwfou3AvBt2Wmcpcalgdz0a/gFCrSc5XFPvheoLl29qL1YCIy4Gy
	LtmZOkkOkD5hxp7RluFho0rVOxOCQ7l5XLyUwO9T7lt5y0eaGq/Yp1vJL4nRIYGWfNiEytgEIXgAn
	OzsP4r0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sb2qj-00000001l3k-153a;
	Mon, 05 Aug 2024 18:54:29 +0000
Date: Mon, 5 Aug 2024 19:54:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240805185429.GH5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <20240805-modisch-anstreben-dc6f70ad6d3e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805-modisch-anstreben-dc6f70ad6d3e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 05, 2024 at 09:22:08AM +0200, Christian Brauner wrote:

> Really, it doesn't have to be pretty but these repros in there really
> have been helpful finding such corruptions when run with a proper k*san
> config.

See below; so far it survives beating (and close_range_test passes with
the patch, while failing the last test on mainline).  BTW, EXPECT_...
alone is sufficient for it to whine, but it doesn't actually fail the
test, so don't we need exit(EXIT_FAILURE) on (at least some of) the
previous tests?  Hadn't played with the kselftest before, so...

diff --git a/fs/file.c b/fs/file.c
index a11e59b5d602..655338effe9c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -46,27 +46,23 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
 #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
 #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
 
+#define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
 /*
  * Copy 'count' fd bits from the old table to the new table and clear the extra
  * space if any.  This does not copy the file pointers.  Called with the files
  * spinlock held for write.
  */
-static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
-			    unsigned int count)
+static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
+			    unsigned int copy_words)
 {
-	unsigned int cpy, set;
-
-	cpy = count / BITS_PER_BYTE;
-	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
-	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
-	memset((char *)nfdt->open_fds + cpy, 0, set);
-	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
-	memset((char *)nfdt->close_on_exec + cpy, 0, set);
-
-	cpy = BITBIT_SIZE(count);
-	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
-	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
-	memset((char *)nfdt->full_fds_bits + cpy, 0, set);
+	unsigned int nwords = fdt_words(nfdt);
+
+	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
+			copy_words, nwords);
 }
 
 /*
@@ -84,7 +80,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	memcpy(nfdt->fd, ofdt->fd, cpy);
 	memset((char *)nfdt->fd + cpy, 0, set);
 
-	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
+	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
 /*
@@ -379,7 +375,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		open_files = sane_fdtable_size(old_fdt, max_fds);
 	}
 
-	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
+	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
 
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 8c4768c44a01..d3b66d77df7a 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -270,6 +270,18 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
 		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
 }
 
+static inline void bitmap_copy_and_extend(unsigned long *to,
+					  const unsigned long *from,
+					  unsigned int count, unsigned int size)
+{
+	unsigned int copy = BITS_TO_LONGS(count);
+
+	memcpy(to, from, copy * sizeof(long));
+	if (count % BITS_PER_LONG)
+		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
+	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
+}
+
 /*
  * On 32-bit systems bitmaps are represented as u32 arrays internally. On LE64
  * machines the order of hi and lo parts of numbers match the bitmap structure.
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 991c473e3859..12b4eb9d0434 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -589,4 +589,39 @@ TEST(close_range_cloexec_unshare_syzbot)
 	EXPECT_EQ(close(fd3), 0);
 }
 
+TEST(close_range_bitmap_corruption)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	/* get the first 128 descriptors open */
+	for (int i = 2; i < 128; i++)
+		EXPECT_GE(dup2(0, i), 0);
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* unshare and truncate descriptor table down to 64 */
+		if (sys_close_range(64, ~0U, CLOSE_RANGE_UNSHARE))
+			exit(EXIT_FAILURE);
+
+		ASSERT_EQ(fcntl(64, F_GETFD), -1);
+		/* ... and verify that the range 64..127 is not
+		   stuck "fully used" according to secondary bitmap */
+		EXPECT_EQ(dup(0), 64)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 TEST_HARNESS_MAIN

