Return-Path: <linux-fsdevel+bounces-25082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C42948BFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37EF28662A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935FD1BD507;
	Tue,  6 Aug 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIz2+oCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A41B9B4E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935471; cv=none; b=h/Os8MOKqRUMss7BWRsth/ZpN9Xa1MTCol+idW6e19OSMjbh43uZqsUnzNGlVnm95HL+L0jR819qYfkxNHYDW9kbmCrHGWmTgIcaH9XrbYe5IEMyRLNDffrgDNCT4l7A2Wm4LDEHJJx/nwJNxa2BqPT/60SqZi1zz1X1Q9CPwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935471; c=relaxed/simple;
	bh=/LXnopceb0XyXWy2N956eSajEfINdy0BufKmr4ESbgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiXMh3xzL4fcuk/VYtF5joJsQsA4gB+6bF+OC6uHWJQd/+Ak7UMyZfOe9cu/H/7Igb5VQ0Pk/IkgU2jGTPHKPclkRxQqfQwG66TUHWHg6fq8fB1B4u5mAPG3ybZ4mqhZSNPn6DSt680ihw12DWp/bcU4RiDQiT4tpyYG76GPrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIz2+oCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E149C32786;
	Tue,  6 Aug 2024 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722935469;
	bh=/LXnopceb0XyXWy2N956eSajEfINdy0BufKmr4ESbgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIz2+oCuORgJHBNWj+odScM0zng9jw6Iq4i7QgSlKx+PBhFmot2r+w0k8b793YJNC
	 AqHh2g5H99k9GxF14qyshB1TJQlMlEUdZ20sIB4GMjOV4s/Mwvz5GaEvv+q+Bv+Mnr
	 manFtmCBlaoj0OeN5nTJQdH4PpwU4obQSgLm9j67LpLW4pTQoaLFV9KXipZ+OpA/qR
	 LtoNg1BLd7HSIg01giiJ0mHTivW4ykOapj9vMWp3Y3E+YCltus8PHkWkBj4GcdbUvv
	 4R/ZfsgtdZ8Ob7vh2LK2rJeTzZvJYPWXURPaaRxkLrU0JPAo2/4ipiBoY6XW+PGL09
	 ftTVlEJCDV74Q==
Date: Tue, 6 Aug 2024 11:11:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240806-bildhaft-farbschichten-bee7f7c20125@brauner>
References: <20240803225054.GY5334@ZenIV>
 <20240805-modisch-anstreben-dc6f70ad6d3e@brauner>
 <20240805185429.GH5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805185429.GH5334@ZenIV>

On Mon, Aug 05, 2024 at 07:54:29PM GMT, Al Viro wrote:
> On Mon, Aug 05, 2024 at 09:22:08AM +0200, Christian Brauner wrote:
> 
> > Really, it doesn't have to be pretty but these repros in there really
> > have been helpful finding such corruptions when run with a proper k*san
> > config.
> 
> See below; so far it survives beating (and close_range_test passes with
> the patch, while failing the last test on mainline).  BTW, EXPECT_...
> alone is sufficient for it to whine, but it doesn't actually fail the
> test, so don't we need exit(EXIT_FAILURE) on (at least some of) the
> previous tests?  Hadn't played with the kselftest before, so...

The selftest infrastrcuture is a bit weird and I'm no expert myself.
So any failure in EXPECT_*() will cause the test to fail but will
continue running the whole test.
Using ASSERT_*() instead of EXPECT_*() will also cause the test to fail
but will also stop the test immediately.

So really no matter if EXPEC_*() or ASSERT_*() the end result should be
that the test run fails:

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 991c473e3859..3f7257487b85 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -37,6 +37,8 @@ TEST(core_close_range)
        int i, ret;
        int open_fds[101];

+       EXPECT_NE(0, 0);
+
        for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
                int fd;


> ./close_range_test
TAP version 13
1..7
# Starting 7 tests from 1 test cases.
#  RUN           global.core_close_range ...
# close_range_test.c:40:core_close_range:Expected 0 (0) != 0 (0)
# core_close_range: Test failed
#          FAIL  global.core_close_range
not ok 1 global.core_close_range
#  RUN           global.close_range_unshare ...
#            OK  global.close_range_unshare
ok 2 global.close_range_unshare
#  RUN           global.close_range_unshare_capped ...
#            OK  global.close_range_unshare_capped
ok 3 global.close_range_unshare_capped
#  RUN           global.close_range_cloexec ...
#            OK  global.close_range_cloexec
ok 4 global.close_range_cloexec
#  RUN           global.close_range_cloexec_unshare ...
#            OK  global.close_range_cloexec_unshare
ok 5 global.close_range_cloexec_unshare
#  RUN           global.close_range_cloexec_syzbot ...
#            OK  global.close_range_cloexec_syzbot
ok 6 global.close_range_cloexec_syzbot
#  RUN           global.close_range_cloexec_unshare_syzbot ...
#            OK  global.close_range_cloexec_unshare_syzbot
ok 7 global.close_range_cloexec_unshare_syzbot
# FAILED: 6 / 7 tests passed.
# Totals: pass:6 fail:1 xfail:0 xpass:0 skip:0 error:0

> 
> diff --git a/fs/file.c b/fs/file.c
> index a11e59b5d602..655338effe9c 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -46,27 +46,23 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
>  #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
>  #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
>  
> +#define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
>  /*
>   * Copy 'count' fd bits from the old table to the new table and clear the extra
>   * space if any.  This does not copy the file pointers.  Called with the files
>   * spinlock held for write.
>   */
> -static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
> -			    unsigned int count)
> +static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
> +			    unsigned int copy_words)
>  {
> -	unsigned int cpy, set;
> -
> -	cpy = count / BITS_PER_BYTE;
> -	set = (nfdt->max_fds - count) / BITS_PER_BYTE;
> -	memcpy(nfdt->open_fds, ofdt->open_fds, cpy);
> -	memset((char *)nfdt->open_fds + cpy, 0, set);
> -	memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
> -	memset((char *)nfdt->close_on_exec + cpy, 0, set);
> -
> -	cpy = BITBIT_SIZE(count);
> -	set = BITBIT_SIZE(nfdt->max_fds) - cpy;
> -	memcpy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
> -	memset((char *)nfdt->full_fds_bits + cpy, 0, set);
> +	unsigned int nwords = fdt_words(nfdt);
> +
> +	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
> +			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
> +	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
> +			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
> +	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
> +			copy_words, nwords);
>  }
>  
>  /*
> @@ -84,7 +80,7 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
>  	memcpy(nfdt->fd, ofdt->fd, cpy);
>  	memset((char *)nfdt->fd + cpy, 0, set);
>  
> -	copy_fd_bitmaps(nfdt, ofdt, ofdt->max_fds);
> +	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
>  }
>  
>  /*
> @@ -379,7 +375,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
>  		open_files = sane_fdtable_size(old_fdt, max_fds);
>  	}
>  
> -	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
> +	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
>  
>  	old_fds = old_fdt->fd;
>  	new_fds = new_fdt->fd;
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 8c4768c44a01..d3b66d77df7a 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -270,6 +270,18 @@ static inline void bitmap_copy_clear_tail(unsigned long *dst,
>  		dst[nbits / BITS_PER_LONG] &= BITMAP_LAST_WORD_MASK(nbits);
>  }
>  
> +static inline void bitmap_copy_and_extend(unsigned long *to,
> +					  const unsigned long *from,
> +					  unsigned int count, unsigned int size)
> +{
> +	unsigned int copy = BITS_TO_LONGS(count);
> +
> +	memcpy(to, from, copy * sizeof(long));
> +	if (count % BITS_PER_LONG)
> +		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
> +	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
> +}
> +
>  /*
>   * On 32-bit systems bitmaps are represented as u32 arrays internally. On LE64
>   * machines the order of hi and lo parts of numbers match the bitmap structure.
> diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
> index 991c473e3859..12b4eb9d0434 100644
> --- a/tools/testing/selftests/core/close_range_test.c
> +++ b/tools/testing/selftests/core/close_range_test.c
> @@ -589,4 +589,39 @@ TEST(close_range_cloexec_unshare_syzbot)
>  	EXPECT_EQ(close(fd3), 0);
>  }
>  
> +TEST(close_range_bitmap_corruption)
> +{
> +	pid_t pid;
> +	int status;
> +	struct __clone_args args = {
> +		.flags = CLONE_FILES,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	/* get the first 128 descriptors open */
> +	for (int i = 2; i < 128; i++)
> +		EXPECT_GE(dup2(0, i), 0);
> +
> +	/* get descriptor table shared */
> +	pid = sys_clone3(&args, sizeof(args));
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		/* unshare and truncate descriptor table down to 64 */
> +		if (sys_close_range(64, ~0U, CLOSE_RANGE_UNSHARE))
> +			exit(EXIT_FAILURE);
> +
> +		ASSERT_EQ(fcntl(64, F_GETFD), -1);
> +		/* ... and verify that the range 64..127 is not
> +		   stuck "fully used" according to secondary bitmap */
> +		EXPECT_EQ(dup(0), 64)
> +			exit(EXIT_FAILURE);
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
>  TEST_HARNESS_MAIN

