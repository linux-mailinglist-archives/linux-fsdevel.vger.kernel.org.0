Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50871F78F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 03:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjFBBOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 21:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBBN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE3F2;
        Thu,  1 Jun 2023 18:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F63F64B3A;
        Fri,  2 Jun 2023 01:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAADFC433EF;
        Fri,  2 Jun 2023 01:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685668437;
        bh=dZokQfanmUMbMooWGmABkTk7dcehukvFrZB+EjzexAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLPp0uWMuh+Dxd/vlG9k1EgD+eEflhT1HtMuCLxW5ZMIYFVra4wPscOUoClIbrJ94
         5qtm8XbFhN+2oxOfMSGRa8uP3Y1i9a3QpCaOZD3sYfBK/0mZk5aPav01cZbbizbYeL
         Bwf6+u+u5MZ1pciYVaa1jmy3uUrQPRGhxffYMjbQUuZJJ8Vzd4nlKvxaeLQAQARK3x
         EUCqo4kIN1sN+ss1Zm8EgcygtEQh46g7H9ExH4fPoE0FPP/MUTrkpSYKOASTM5PebZ
         Skk/6PxdD2o9QmDtqkL1Xv9vNouOfKlGAsCzIR7A+DWgYBgiMYLlO8ccqd7TNt00WL
         UrXX2gBZloJ1Q==
Date:   Thu, 1 Jun 2023 18:13:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
Message-ID: <20230602011355.GA16848@frogsfrogsfrogs>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> 
> 
> I created a bcachefs volume on a single disk (metadata and data checksums 
> were turned off) and mounted it on dm-flakey. I got:
> 
> crash: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash1.txt
> deadlock: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash2.txt
> infinite loop: https://people.redhat.com/~mpatocka/testcases/bcachefs/crash3.txt
> 
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

Hey, that's really neat!

Any chance you'd be willing to get the dm-flakey changes merged into
upstream so that someone can write a recoveryloop fstest to test all the
filesystems systematically?

:D

--D

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
> 
> 
> Bcachefs gives not much usefull error messages, like "Fatal error: Unknown 
> error 2184" or "Error in recovery: cannot allocate memory" or "mount(2) 
> system call failed: Unknown error 2186." or "rm: cannot remove 
> '/mnt/test/xfstests-dev/tools/fs-walk': Unknown error 2206".
> 
> Mikulas
> 
