Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFFB689F59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 17:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjBCQfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 11:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBCQfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:35:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECE10D4;
        Fri,  3 Feb 2023 08:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66E861F6F;
        Fri,  3 Feb 2023 16:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1656EC433D2;
        Fri,  3 Feb 2023 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675442114;
        bh=LAFGFgePgf3ook4iBuOc/zox8M9eHm7XWKurXaYi9tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roStwUNZB17qeESPC5wt3x03laInHjWwbx3Ss06y3w9LYsMErvt627S9H7FpxMb1m
         Og+GQc4Hpj5HsAu8K4dXX0QoT+twn1yLxlSE6JLBp+LjSpNqETOFOCz/KUcqkkQu97
         2IIYFkvcWCfmrPXr+dppMqQUN7rSSUDrzje8gJz9RqamD68la3WroR4sjygBsewLvj
         sXxDhRD0pcMI1Lp6yacKN1H0Jq8ak1v01dQ78Ov4xC3Z7W6BAqFbq+DwgO6x7BiP0R
         mYKw1rfnsJ76aTMAA2yWAI4ZhazhlVOj5D4s+GY4aIaJKi81C2punu2APFLsVghkBa
         sf7gha6q7Wi6Q==
Date:   Fri, 3 Feb 2023 08:35:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 6/5] generic: test ftruncate zeroes bytes after EOF
Message-ID: <Y903wcB2kAWwyR+2@magnolia>
References: <20230202204428.3267832-1-willy@infradead.org>
 <20230202204428.3267832-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202204428.3267832-7-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 08:44:28PM +0000, Matthew Wilcox (Oracle) wrote:
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/ftruncate.html
> specifies that "If the file size is increased, the extended area shall
> appear as if it were zero-filled."  Many filesystems do not currently
> do this for the portion of the page after EOF.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/truncate-zero.c   | 50 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/707     | 31 +++++++++++++++++++++++++++
>  tests/generic/707.out |  2 ++
>  5 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 src/truncate-zero.c
>  create mode 100755 tests/generic/707
>  create mode 100644 tests/generic/707.out
> 
> diff --git a/.gitignore b/.gitignore
> index a6f433f1..6aa5bca9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -169,6 +169,7 @@ tags
>  /src/test-nextquota
>  /src/testx
>  /src/trunc
> +/src/truncate-zero
>  /src/truncfile
>  /src/unwritten_mmap
>  /src/unwritten_sync
> diff --git a/src/Makefile b/src/Makefile
> index afdf6b30..83ca11ac 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino
> +	t_mmap_cow_memory_failure fake-dump-rootino truncate-zero
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/truncate-zero.c b/src/truncate-zero.c
> new file mode 100644
> index 00000000..67f53912
> --- /dev/null
> +++ b/src/truncate-zero.c
> @@ -0,0 +1,50 @@

Needs to have a SPDX header and the customary Oracle copyright.

> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +int main(int argc, char **argv)
> +{
> +	char *buf;
> +	int i, fd;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Usage: %s <file>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	fd = open(argv[1], O_RDWR | O_CREAT, 0644);
> +	if (fd < 0) {
> +		perror(argv[1]);
> +		return 1;
> +	}
> +
> +	if (ftruncate(fd, 1) < 0) {
> +		perror("ftruncate");
> +		return 1;
> +	}
> +
> +	buf = mmap(NULL, 1024, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("mmap");
> +		return 1;
> +	}
> +
> +	memset(buf, 'a', 10);
> +
> +	if (ftruncate(fd, 5) < 0) {
> +		perror("ftruncate");
> +		return 1;
> +	}
> +
> +	if (memcmp(buf, "a\0\0\0\0", 5) == 0)
> +		return 0;
> +
> +	fprintf(stderr, "Truncation did not zero new bytes:\n");
> +	for (i = 0; i < 5; i++)
> +		fprintf(stderr, "%#x ", buf[i]);
> +	fputc('\n', stderr);
> +
> +	return 2;
> +}
> diff --git a/tests/generic/707 b/tests/generic/707
> new file mode 100755
> index 00000000..ddc82a9a
> --- /dev/null
> +++ b/tests/generic/707
> @@ -0,0 +1,31 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Matthew Wilcox for Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 707
> +#
> +# Test whether we obey this part of POSIX-2017 ftruncate:
> +# "If the file size is increased, the extended area shall appear as if
> +# it were zero-filled"
> +#
> +. ./common/preamble
> +_begin_fstest auto quick posix
> +
> +_supported_fs generic
> +_require_test
> +_require_test_program "truncate-zero"
> +
> +test_file=$TEST_DIR/test.$seq
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $test_file
> +}
> +
> +$here/src/truncate-zero $test_file > $seqres.full 2>&1 ||
> +	_fail "truncate zero failed!"

Omit the _fail here because any extra stdout/stderr output that is not
in the .out file suffices to record the test as failed.

_fail is only useful if you need to exit the shell script immediately.

> +
> +echo "Silence is golden"

It's customary (though not required) to put "silence is golden" before
"but my eyes still see"^W^W^W^W^Wthe test starts running programs.

Other than those minor things, this looks reasonable to me.

--D

> +status=0
> +exit
> diff --git a/tests/generic/707.out b/tests/generic/707.out
> new file mode 100644
> index 00000000..8e57a1d8
> --- /dev/null
> +++ b/tests/generic/707.out
> @@ -0,0 +1,2 @@
> +QA output created by 707
> +Silence is golden
> -- 
> 2.35.1
> 
