Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CDE7A5997
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjISFv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjISFvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:51:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95B100;
        Mon, 18 Sep 2023 22:51:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c44a25bd0bso20886555ad.0;
        Mon, 18 Sep 2023 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695102708; x=1695707508; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcRXRyK1fCDW06SwtVVU/3oEtJExRi+6ONE5drucKAM=;
        b=mA6YZIax2/6IhqYBXbqLyU/0yMYYQ9G4/Fc+Jbk5r88niqjXextat2EhvYLN8hZPU8
         HXg6ki2sjugDY+tSJuJOcWHQT8UJfQqsXdy7hRU/qPgN+C1jBi4OXMTsa99vK5NOgeNg
         DKzPKcaDHjjRhIYjgM5Whf0BqNyTT5VlLCJfut4WwaTFY7pChvi9jKJQ48fA6R1VIWP+
         1wbcWXIQe5qcQu3GTlvGcFmDpd01vm3Gy+xLWFvNMwgaaxx9vpHOZ88mj1i/Oe8PwlP+
         aAYa1rDr5VifC3RboKYB9JAhwJFJ9diH3kDlR3hNeUvFjVA/XOMD585bfPKQLMmCWBl0
         87RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102708; x=1695707508;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcRXRyK1fCDW06SwtVVU/3oEtJExRi+6ONE5drucKAM=;
        b=X2XRcuGWTptWliQ2AVQODocNN4+4bQE7sSchrhX7E1bi2X25QPnKfm8w9WnA1yM37f
         vrCBHl1o7sxlumPRZRJg9ZE6ldZukTEikyV0kXQkq7ZjVNJCLt8jfbMZozgwuc+oab6M
         AI8W/sRw41I9YYotsTICsoh4IMEqKCCCLSlHmMJqbOQ/Ltzj4IATQBpG9jZDL+OJ2DUr
         qsAQ4ia2jPTHMeT/84TUSJi/7HC++qQjyyvhelIfCRurZ1lv3ICpmqAbT14XNDhk9aDE
         2dwfhQE3mZAkaY4wW2xrqXtzS3ZpR6yPqkUWzRACq07tTi4CWqWjisCbz6ufjPfJ3V6C
         UivA==
X-Gm-Message-State: AOJu0Yx5kyXnExrmw0bPyDJMTh4rUIno5tp3jdiBpAZ4jk2PzL+IyL6L
        ilQoJM2VW4qBcNVd2c0GjQTUDC1VuR4=
X-Google-Smtp-Source: AGHT+IGKXTpHw1PNtYXexI1NOlFzP7qnV1XSzLKtvTgqcbt/cosMDxjTFjMSsmDI2NjxJjKADe9Lmw==
X-Received: by 2002:a17:902:d504:b0:1bc:2fe1:1821 with SMTP id b4-20020a170902d50400b001bc2fe11821mr2348665plg.17.1695102707803;
        Mon, 18 Sep 2023 22:51:47 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001bdc664ecd3sm5739767plc.307.2023.09.18.22.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:51:47 -0700 (PDT)
Date:   Tue, 19 Sep 2023 11:21:43 +0530
Message-Id: <87led27lsg.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/2] fstests: test FALLOC_FL_UNSHARE when pagecache is not loaded
In-Reply-To: <20230918231945.GC348018@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> Add a regression test for funsharing uncached files to ensure that we
> actually manage the pagecache state correctly.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/1936     |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1936.out |    4 ++
>  2 files changed, 92 insertions(+)
>  create mode 100755 tests/xfs/1936
>  create mode 100644 tests/xfs/1936.out

1936? I am not sure how that works though. 
./new I guess automatically gives the testcase no. for a new testcase right.

>
> diff --git a/tests/xfs/1936 b/tests/xfs/1936
> new file mode 100755
> index 0000000000..bcf9b6b478
> --- /dev/null
> +++ b/tests/xfs/1936
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1936
> +#
> +# This is a regression test for the kernel commit noted below.  The stale
> +# memory exposure can be exploited by creating a file with shared blocks,
> +# evicting the page cache for that file, and then funshareing at least one
> +# memory page's worth of data.  iomap will mark the page uptodate and dirty
> +# without ever reading the ondisk contents.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick unshare clone
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.* $testdir
> +}
> +
> +# real QA test starts here
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +. ./common/reflink
> +
> +_fixed_by_git_commit kernel XXXXXXXXXXXXX \
> +	"iomap: don't skip reading in !uptodate folios when unsharing a range"
> +
> +# real QA test starts here
> +_require_test_reflink
> +_require_cp_reflink
> +_require_xfs_io_command "funshare"
> +
> +testdir=$TEST_DIR/test-$seq
> +rm -rf $testdir
> +mkdir $testdir
> +
> +# Create a file that is at least four pages in size and aligned to the
> +# file allocation unit size so that we don't trigger any unnecessary zeroing.
> +pagesz=$(_get_page_size)
> +alloc_unit=$(_get_file_block_size $TEST_DIR)
> +filesz=$(( ( (4 * pagesz) + alloc_unit - 1) / alloc_unit * alloc_unit))
> +
> +echo "Create the original file and a clone"
> +_pwrite_byte 0x61 0 $filesz $testdir/file2.chk >> $seqres.full
> +_pwrite_byte 0x61 0 $filesz $testdir/file1 >> $seqres.full
> +_cp_reflink $testdir/file1 $testdir/file2
> +_cp_reflink $testdir/file1 $testdir/file3
> +
> +_test_cycle_mount
> +
> +cat $testdir/file3 > /dev/null
> +
> +echo "Funshare at least one pagecache page"
> +$XFS_IO_PROG -c "funshare 0 $filesz" $testdir/file2
> +$XFS_IO_PROG -c "funshare 0 $filesz" $testdir/file3
> +_pwrite_byte 0x61 0 $filesz $testdir/file2.chk >> $seqres.full

We don't need to write the bytes again to file2.chk. We already wrote above.
Otherwise looks right to me. Nice testcase indeed.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> +
> +echo "Check contents"
> +
> +# file2 wasn't cached when it was unshared, but it should match
> +if ! cmp -s $testdir/file2.chk $testdir/file2; then
> +	echo "file2.chk does not match file2"
> +
> +	echo "file2.chk contents" >> $seqres.full
> +	od -tx1 -Ad -c $testdir/file2.chk >> $seqres.full
> +	echo "file2 contents" >> $seqres.full
> +	od -tx1 -Ad -c $testdir/file2 >> $seqres.full
> +	echo "end bad contents" >> $seqres.full
> +fi
> +
> +# file3 was cached when it was unshared, and it should match
> +if ! cmp -s $testdir/file2.chk $testdir/file3; then
> +	echo "file2.chk does not match file3"
> +
> +	echo "file2.chk contents" >> $seqres.full
> +	od -tx1 -Ad -c $testdir/file2.chk >> $seqres.full
> +	echo "file3 contents" >> $seqres.full
> +	od -tx1 -Ad -c $testdir/file3 >> $seqres.full
> +	echo "end bad contents" >> $seqres.full
> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1936.out b/tests/xfs/1936.out
> new file mode 100644
> index 0000000000..c7c820ced5
> --- /dev/null
> +++ b/tests/xfs/1936.out
> @@ -0,0 +1,4 @@
> +QA output created by 1936
> +Create the original file and a clone
> +Funshare at least one pagecache page
> +Check contents
