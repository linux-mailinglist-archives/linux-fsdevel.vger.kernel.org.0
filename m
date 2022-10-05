Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694D05F4D68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 03:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJEBeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 21:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJEBeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:34:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC352FD2;
        Tue,  4 Oct 2022 18:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11485B81BEF;
        Wed,  5 Oct 2022 01:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14E1C433D6;
        Wed,  5 Oct 2022 01:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664933655;
        bh=TP+ALQ1hUofg0uUja0tZQU5t+Py+T4UqsG3Yoj4f9Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKesNXnnWv9HJQCLUWtF1bcjGskK5ndBBd7BNxAd2aQhOayUPKoo/iQWl+afjqnJq
         Dnp6u+fJiRwW8g7dTkcvdvxzQifVP+L/NvYiDiWj+KMlvkgRoRP0gLik93liEDWYkx
         g2Mbcrx7ciwC2PcvCFWJ3pF8m2vkuoGNWDdbl0r+jLZkcb8zvfaHKM9p37SS6W2wwX
         kF32g31HTmNlw8VV2CS81IuvPbCS700fAd2ymYwY11R7a2cXS8K5koqhryIAY4AyVJ
         R8SsrKRKOHmB2FihHYVBsDSL+X6AkeOBNgAOUO0LxmD+FKNsfi9kHEwOJ+vix4xap+
         2QVAEo4N/kMdw==
Date:   Tue, 4 Oct 2022 18:34:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Frank Sorenson <frank@tuxrocks.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <YzzfF/o695eRpOhY@magnolia>
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-3-david@fromorbit.com>
 <YyvaAY6UT1gKRF9U@magnolia>
 <20220923000403.GW3600936@dread.disaster.area>
 <YzPTg8jrDiNBU1N/@magnolia>
 <20220929014534.GE3600936@dread.disaster.area>
 <d00aff43-2bdc-0724-1996-4e58e061ecfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00aff43-2bdc-0724-1996-4e58e061ecfd@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:34:03PM -0500, Frank Sorenson wrote:
> 
> 
> On 9/28/22 20:45, Dave Chinner wrote:
> > On Tue, Sep 27, 2022 at 09:54:27PM -0700, Darrick J. Wong wrote:
> 
> > > Btw, can you share the reproducer?
> 
> > Not sure. The current reproducer I have is 2500 lines of complex C
> > code that was originally based on a reproducer the original reporter
> > provided. It does lots of stuff that isn't directly related to
> > reproducing the issue, and will be impossible to review and maintain
> > as it stands in fstests.
> 
> Too true.  Fortunately, now that I understand the necessary conditions
> and IO patterns, I managed to prune it all down to ~75 lines of bash
> calling xfs_io.  See below.
> 
> Frank
> --
> Frank Sorenson
> sorenson@redhat.com
> Principal Software Maintenance Engineer
> Global Support Services - filesystems
> Red Hat
> 
> ###########################################
> #!/bin/bash
> #	Frank Sorenson <sorenson@redhat.com>, 2022
> 
> num_files=8
> num_writers=3
> 
> KiB=1024
> MiB=$(( $KiB * $KiB ))
> GiB=$(( $KiB * $KiB * $KiB ))
> 
> file_size=$(( 500 * $MiB ))
> #file_size=$(( 1 * $GiB ))
> write_size=$(( 1 * $MiB ))
> start_offset=512
> 
> num_loops=$(( ($file_size - $start_offset + (($num_writers * $write_size) - 1)) / ($num_writers * $write_size) ))
> total_size=$(( ($num_loops * $num_writers * $write_size) + $start_offset ))
> 
> cgroup_path=/sys/fs/cgroup/test_write_bug
> mkdir -p $cgroup_path || { echo "unable to create cgroup" ; exit ; }
> 
> max_mem=$(( 40 * $MiB ))
> high_mem=$(( ($max_mem * 9) / 10 ))
> echo $high_mem >$cgroup_path/memory.high
> echo $max_mem >$cgroup_path/memory.max

Hmm, so we setup a cgroup a very low memory limit, and then kick off a
lot of threads doing IO... which I guess is how you ended up with a long
write to an unwritten extent that races with memory reclaim targetting a
dirty page at the end of that unwritten extent for writeback and
eviction.

I wonder, if we had a way to slow down iomap_write_iter, could we
simulate the writeback and eviction with sync_file_range and
madvise(MADV_FREE)?

(I've been playing with a debug knob to slow down writeback for a
different corruption problem I've been working on, and it's taken the
repro time down from days to a 5 second fstest.)

Anyhow, thanks for the simplified repo, I'll keep thinking about this. :)

--D

> mkdir -p testfiles
> rm -f testfiles/expected
> xfs_io -f -c "pwrite -b $((1 * $MiB)) -S 0x40 0 $total_size" testfiles/expected >/dev/null 2>&1
> expected_sum=$(md5sum testfiles/expected | awk '{print $1}')
> 
> echo $$ > $cgroup_path/cgroup.procs || exit # put ourselves in the cgroup
> 
> do_one_testfile() {
> 	filenum=$1
> 	cpids=""
> 	offset=$start_offset
> 
> 	rm -f testfiles/test$filenum
> 	xfs_io -f -c "pwrite -b $start_offset -S 0x40 0 $start_offset" testfiles/test$filenum >/dev/null 2>&1
> 
> 	while [[ $offset -lt $file_size ]] ; do
> 		cpids=""
> 		for i in $(seq 1 $num_writers) ; do
> 			xfs_io -f -c "pwrite -b $write_size -S 0x40 $(( ($offset + (($num_writers - $i) * $write_size)  ) )) $write_size" testfiles/test$filenum >/dev/null 2>&1 &
> 			cpids="$cpids $!"
> 		done
> 		wait $cpids
> 		offset=$(( $offset + ($num_writers * $write_size) ))
> 	done
> }
> 
> round=1
> while [[ 42 ]] ; do
> 	echo "test round: $round"
> 	cpids=""
> 	for i in $(seq 1 $num_files) ; do
> 		do_one_testfile $i &
> 		cpids="$cpids $!"
> 	done
> 	wait $cpids
> 
> 	replicated="" # now check the files
> 	for i in $(seq 1 $num_files) ; do
> 		sum=$(md5sum testfiles/test$i | awk '{print $1}')
> 		[[ $sum == $expected_sum ]] || replicated="$replicated testfiles/test$i"
> 	done
> 
> 	[[ -n $replicated ]] && break
> 	round=$(($round + 1))
> done
> echo "replicated bug with: $replicated"
> echo $$ > /sys/fs/cgroup/cgroup.procs
> rmdir $cgroup_path
