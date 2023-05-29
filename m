Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971EB7150FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjE2VoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 17:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE2VoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 17:44:01 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DFCF
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 14:43:59 -0700 (PDT)
Date:   Mon, 29 May 2023 17:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685396637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9LV2x82sc6A+Ucb7bsrgYQlKFVDBatiYh9r3a/voOU=;
        b=icbVg3aiJm3WrNrdXGgum3GzwV53yb1ocwOV8Y6vBmnjiy9FibXB9foRC6mHPgNv9jrgES
        Nwn5No/pNNOaNDhpEABuXs22j2L+NVU/Av5S0XKgeIqIUun0qEEsu4iClZ+W7QNKxK0Nzq
        AdWAOEkLGFCue6lfLzu2ecN8evc7IIY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
Message-ID: <ZHUcmeYrUmtytdDU@moria.home.lan>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
> Hi
> 
> I improved the dm-flakey device mapper target, so that it can do random 
> corruption of read and write bios - I uploaded it here: 
> https://people.redhat.com/~mpatocka/testcases/bcachefs/dm-flakey.c
> 
> I set up dm-flakey, so that it corrupts 10% of read bios and 10% of write 
> bios with this command:
> dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"

I've got some existing ktest tests for error injection:
https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest#n200
https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/replication.ktest#n491

I haven't looked at dm-flakey before, I take it you're silently
corrupting data instead of just failing the IOs like these tests do?

Let's add what you're doing to ktest, and see if we can merge it with
the existing tests.

> I created a bcachefs volume on a single disk (metadata and data checksums 
> were turned off) and mounted it on dm-flakey. I got:
> 
> crash: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash1.txt
> deadlock: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash2.txt
> infinite loop: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash3.txt

Fun!

> Here I uploaded an image that causes infnite loop when we run bcachefs 
> fsck on it or when we attempt mount it:
> https://people.redhat.com/~mpatocka/testcases/bcachefs/inf-loop.gz
> 
> 
> I tried to run bcachefs on two block devices and fuzzing just one of them 
> (checksums and replication were turned on - so bcachefs shold correct the 
> corrupted data) - in this scenario, bcachefs doesn't return invalid data, 
> but it sometimes returns errors and sometimes crashes.
> 
> This script will trigger an oops on unmount:
> 	https://people.redhat.com/~mpatocka/testcases/bcachefs/crash4.txt
> or nonsensical errors returned to userspace:
> 	rm: cannot remove '/mnt/test/test/cmd_migrate.c': Unknown error 2206
> or I/O errors returned to userspace:
> 	diff: /mnt/test/test/rust-src/target/release/.fingerprint/bch_bindgen-f0bad16858ff0019/lib-bch_bindgen.json: Input/output error
> 
> #!/bin/sh -ex
> umount /mnt/test || true
> dmsetup remove_all || true
> rmmod brd || true
> SRC=/usr/src/git/bcachefs-tools
> while true; do
>         modprobe brd rd_size=1048576
>         bcachefs format --replicas=2 /dev/ram0 /dev/ram1
>         dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` linear /dev/ram0 0"
>         mount -t bcachefs /dev/mapper/flakey:/dev/ram1 /mnt/test
>         dmsetup load flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
>         dmsetup suspend flakey
>         dmsetup resume flakey
>         cp -a "$SRC" /mnt/test/test
>         diff -r "$SRC" /mnt/test/test
>         echo 3 >/proc/sys/vm/drop_caches
>         diff -r "$SRC" /mnt/test/test
>         echo 3 >/proc/sys/vm/drop_caches
>         diff -r "$SRC" /mnt/test/test
>         echo 3 >/proc/sys/vm/drop_caches
>         rm -rf /mnt/test/test
>         echo 3 >/proc/sys/vm/drop_caches
>         cp -a "$SRC" /mnt/test/test
>         echo 3 >/proc/sys/vm/drop_caches
>         diff -r "$SRC" /mnt/test/test
>         umount /mnt/test
>         dmsetup remove flakey
>         rmmod brd
> done
> 
> The oops happens in set_btree_iter_dontneed and it is caused by the fact 
> that iter->path is NULL. The code in try_alloc_bucket is buggy because it 
> sets "struct btree_iter iter = { NULL };" and then jumps to the "err" 
> label that tries to dereference values in "iter".

Good catches on all of them. Darrick's been on me to get fuzz testing
going, looks like it's definitely needed :)

However, there's two things I want in place first before I put much
effort into fuzz testing:

 - Code coverage analysis. ktest used to have integrated code coverage
   analysis, where you'd tell it a subdirectory of the kernel tree
   (doing code coverage analysis for the entire kernel is impossibly
   slow) and it would run tests and then give you the lcov output.

   However, several years ago something about kbuild changed, and the
   method ktest was using for passing in build flags for a specific
   subdir on the command line stopped working. I would like to track
   down someone who understands kbuild and get this working again.

 - Fault injection

   Years and years ago, when I was still at Google and this was just
   bcache, we had fault injection that worked like dynamic debug: you
   could call dynamic_fault("type of fault") anywhere in your code,
   and it returned a bool indicating whether that fault had been enabled
   - and faults were controllable at runtime via debugfs, we had tests
   that iterated over e.g. faults in the initialization path, or memory
   allocation failures, and flipped them on one by one and ran
   $test_workload.

   The memory allocation profiling stuff that Suren and I have been
   working on includes code tagging, which is for (among other things) a
   new and simplified implementation of dynamic fault injection, which
   I'm going to push forward again once the memory allocation profiling
   stuff gets merged.

The reason I want this stuff is because fuzz testing tends to be a
heavyweight, scattershot approach.

I want to be able to look at the code coverage analysis first to e.g.
work on a chunk of code at a time and make sure it's tested thoroughly,
instead of jumping around in the code at random depending on what fuzz
testing finds, and when we are fuzz testing I want to be able to add
fault injection points and write unit tests so that we can have much
more targeted, quicker to run tests going forward.

Can I get you interested in either of those things? I'd really love to
find someone to hand off or collaborate with on the fault injection
stuff in particular.

> Bcachefs gives not much usefull error messages, like "Fatal error: Unknown 
> error 2184" or "Error in recovery: cannot allocate memory" or "mount(2) 
> system call failed: Unknown error 2186." or "rm: cannot remove 
> '/mnt/test/xfstests-dev/tools/fs-walk': Unknown error 2206".

Those are mostly missing bch2_err_str()/bch2_err_class() calls:
 - bch2_err_str(), to print error string for our private error code
 - bch2_err_class(), to convert private error code to standard error
   code before returning it to outside bcachefs code

except error in recovery, cannot allocate memory - that's ancient code
that still squashes to -ENOMEM
