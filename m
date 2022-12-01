Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B84563F3B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiLAPW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiLAPW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9BA51AB
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 07:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669908113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGz2b8trUO56N8uhbP/fyzH5fYuchkw+/Evt2EIW9bM=;
        b=BgLFc8B0ghPEhUBA9nd9Y/ikSwxfnsubqe9ZaR9fYcqs7K7a/nnahmMUGti83rQHZKJhnP
        hW11ubwWyoZ0F+7vQDmFAcCRwYiTWOSJere+WvvZ1QrSikUMqhb7YybW+gMt67fDLDA+dP
        5VJrtWX1NfgD6aeS3mQ6qKDFh7pKV9M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-ZW6SEHzROJ6AZ8c1qme2Ng-1; Thu, 01 Dec 2022 10:21:52 -0500
X-MC-Unique: ZW6SEHzROJ6AZ8c1qme2Ng-1
Received: by mail-pl1-f198.google.com with SMTP id x11-20020a170902ec8b00b00189986d9381so2662251plg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 07:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGz2b8trUO56N8uhbP/fyzH5fYuchkw+/Evt2EIW9bM=;
        b=jd+HFliKGTsZHCTslQoPTQ6aQdqmbmwal6Vue/ixwFeeb+sJ+ymiflJv1cxFYuGye1
         6k0mxNMLTNb2xIT7CyHYWN+/Yy+9GDfHjzEbhJSeMZWqQWG7mnadBM/bvSYO81My0m/R
         MvBZvzBKbRJTVB7c39J7AwDMlXlXq3lSZqX1EnY6Y76fYh6vfge6AHli71irroihkPhi
         b3Fqzk5pYAm1m9rGOub/qEN0kF88owQ13WOoap54+46VSzwEKUAWEBJAs3K90dCm0R1U
         EMI14yjEzRStntIhgeC97BTf7zsH7FbM5Mi/zmzgHLRY7FCTGhCP+e2vJGwyj1w1VZh1
         Qwaw==
X-Gm-Message-State: ANoB5pnRYik6Yi8tFb5oLvFbOlKco7PSCYjbZrhGyQ6Af/Nkp9VLX8sg
        kcdIp2vhn/Eyak90ougBlIwfNa09IcPEnb5SGK6kW5xHLIZ9tOmipmUmhEDGhE8d3T+1usBngo4
        H1Vth6Amc96fMcckqXU0d2pVnZA==
X-Received: by 2002:a17:90a:2dc9:b0:219:6dd6:b698 with SMTP id q9-20020a17090a2dc900b002196dd6b698mr6378155pjm.124.1669908111443;
        Thu, 01 Dec 2022 07:21:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4zYEtnNM+4IYKfQmRgQ4HrD17we3swhUujDwqsVpxkDobxnENjNlSr122/kx8OMnU6RArZnw==
X-Received: by 2002:a17:90a:2dc9:b0:219:6dd6:b698 with SMTP id q9-20020a17090a2dc900b002196dd6b698mr6378118pjm.124.1669908110921;
        Thu, 01 Dec 2022 07:21:50 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b0017c37a5a2fdsm3773359plg.216.2022.12.01.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:21:50 -0800 (PST)
Date:   Thu, 1 Dec 2022 23:21:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wen.gang.wang@oracle.com,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC PATCH] xfs: regression test for writeback corruption bug
Message-ID: <20221201152145.eer3lffiq6m4b256@zlang-mailbox>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3XWf5j1zVGvV4@magnolia>
 <Y4VejsHGU/tZuRYs@magnolia>
 <Y4aAOn7CUTr9tUBN@magnolia>
 <20221130173447.52eribihqfiptw3r@zlang-mailbox>
 <Y4epMqdZmL/NX1YI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4epMqdZmL/NX1YI@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:04:18AM -0800, Darrick J. Wong wrote:
> On Thu, Dec 01, 2022 at 01:34:47AM +0800, Zorro Lang wrote:
> > On Tue, Nov 29, 2022 at 01:57:14PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > This is a regression test for a data corruption bug that existed in XFS'
> > > copy on write code between 4.9 and 4.19.  The root cause is a
> > > concurrency bug wherein we would drop ILOCK_SHARED after querying the
> > > CoW fork in xfs_map_cow and retake it before querying the data fork in
> > > xfs_map_blocks.  See the test description for a lot more details.
> > > 
> > > Cc: Wengang Wang <wen.gang.wang@oracle.com>
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  common/rc         |   15 ++++
> > >  common/tracing    |   69 +++++++++++++++++
> > >  tests/xfs/924     |  215 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/xfs/924.out |    2 
> > >  4 files changed, 301 insertions(+)
> > >  create mode 100644 common/tracing
> > >  create mode 100755 tests/xfs/924
> > >  create mode 100644 tests/xfs/924.out
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index d71fc0603f..b1b7a3e553 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3625,6 +3625,21 @@ _check_xflag()
> > >  	fi
> > >  }
> > >  
> > > +# Make sure the given file access mode is set to use the pagecache.  If
> > > +# userspace or kernel don't support statx or STATX_ATTR_DAX, we assume that
> > > +# means pagecache.  The sole parameter must be a directory.
> > > +_require_pagecache_access() {
> > > +	local testfile="$1/testfile"
> > > +
> > > +	touch "$testfile"
> > > +	if ! _check_s_dax "$testfile" 0 &>> $seqres.full; then
> > > +		rm -f "$testfile"
> > > +		_notrun 'test requires pagecache access'
> > > +	fi
> > > +
> > > +	rm -f "$testfile"
> > > +}
> > > +
> > >  # Check if dax mount options are supported
> > >  #
> > >  # $1 can be either 'dax=always' or 'dax'
> > > diff --git a/common/tracing b/common/tracing
> > > new file mode 100644
> > > index 0000000000..35e5ed41c2
> > > --- /dev/null
> > > +++ b/common/tracing
> > > @@ -0,0 +1,69 @@
> > > +##/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > +#
> > > +# Routines for dealing with ftrace (or any other tracing).
> > > +
> > > +_require_ftrace() {
> > > +	local ftrace_dir="/sys/kernel/debug/tracing/instances/"
> > > +	test -d "$ftrace_dir" || _notrun "kernel does not support ftrace"
> > > +
> > > +	# Give this fstest its own ftrace buffer so that we don't mess up
> > > +	# any other tracers that might be running.
> > > +	FTRACE_DIR="$ftrace_dir/fstests.$seq"
> > > +	test -d "$FTRACE_DIR" && rmdir "$FTRACE_DIR"
> > > +}
> > > +
> > > +_ftrace_cleanup() {
> > > +	if [ -d "$FTRACE_DIR" ]; then
> > > +		_ftrace_ignore_events
> > > +		# Removing an ftrace buffer requires rmdir, even though the
> > > +		# virtual directory contains children.
> > > +		rmdir "$FTRACE_DIR"
> > > +	fi
> > > +}
> > > +
> > > +# Intercept the given events.  Arguments may be regular expressions.
> > > +_ftrace_record_events() {
> > > +	local pwd="$PWD"
> > > +
> > > +	test -n "$FTRACE_DIR" || _fail "_require_ftrace not run?"
> > > +	mkdir "$FTRACE_DIR"
> > > +	cd "$FTRACE_DIR/events/" || _fail "$FTRACE_DIR: ftrace not set up?"
> > > +
> > > +	for arg in "$@"; do
> > > +		for tp in */${arg}; do
> > > +			# Replace slashes with semicolons per ftrace convention
> > > +			echo "${tp////:}" >> ../set_event
> > > +		done
> > > +	done
> > > +	cd "$pwd"
> > 
> > Is the relative path necessary, can we use absolute path at here?
> 
> Hm.  I suppose that inner loop could be replaced by:
> 
> 		find "$FTRACE_DIR/events/ -type d -name "$arg" -printf '%P\n' | \
> 			tr '/' ':' >> "$FTRACE_DIR/set_event"
> 
> and then we don't need all this cd'ing insanity.  I'll try that and
> report back.
> 
> > > +}
> > > +
> > > +# Stop intercepting the given events.  If no arguments, stops all events.
> > > +_ftrace_ignore_events() {
> > > +	local pwd="$PWD"
> > > +
> > > +	test -n "$FTRACE_DIR" || _fail "_require_ftrace not run?"
> > > +	cd "$FTRACE_DIR/events/" || _fail "$FTRACE_DIR: ftrace not set up?"
> > > +
> > > +	if [ "$#" -eq 0 ]; then
> > > +		echo > ../set_event
> > > +	else
> > > +		for arg in "$@"; do
> > > +			for tp in */${arg}; do
> > > +				# Replace slashes with semicolons per ftrace convention
> > > +				echo "!${tp////:}" >> ../set_event
> > > +			done
> > > +		done
> > > +	fi
> > > +
> > > +	cd "$pwd"
> > 
> > Same at here
> > 
> > > +}
> > > +
> > > +# Dump whatever was written to the ftrace buffer since the last time this
> > > +# helper was called.
> > > +_ftrace_dump() {
> > > +	test -n "$FTRACE_DIR" || _fail "_require_ftrace not run?"
> > > +	(cd "$FTRACE_DIR" && cat trace)
> > 
> > Why not "cat $FTRACE_DIR/trace" ?
> 
> Fixed.
> 
> > > +}
> > > diff --git a/tests/xfs/924 b/tests/xfs/924
> > > new file mode 100755
> > > index 0000000000..81f8ba2743
> > > --- /dev/null
> > > +++ b/tests/xfs/924
> > > @@ -0,0 +1,215 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 924
> > > +#
> > > +# This is a regression test for a data corruption bug that existed in XFS' copy
> > > +# on write code between 4.9 and 4.19.  The root cause is a concurrency bug
> > > +# wherein we would drop ILOCK_SHARED after querying the CoW fork in xfs_map_cow
> > > +# and retake it before querying the data fork in xfs_map_blocks.  If a second
> > > +# thread changes the CoW fork mappings between the two calls, it's possible for
> > > +# xfs_map_blocks to return a zero-block mapping, which results in writeback
> > > +# being elided for that block.  Elided writeback of dirty data results in
> > > +# silent loss of writes.
> > > +#
> > > +# Worse yet, kernels from that era still used buffer heads, which means that an
> > > +# elided writeback leaves the page clean but the bufferheads dirty.  Due to a
> > > +# naïve optimization in mark_buffer_dirty, the SetPageDirty call is elided if
> > > +# the bufferhead is dirty, which means that a subsequent rewrite of the data
> > > +# block will never result in the page being marked dirty, and all subsequent
> > > +# writes are lost.
> > > +#
> > > +# It turns out that Christoph Hellwig unwittingly fixed the race in commit
> > > +# 5c665e5b5af6 ("xfs: remove xfs_map_cow"), and no testcase was ever written.
> > > +# Four years later, we hit it on a production 4.14 kernel.  This testcase
> > > +# relies on a debugging knob that introduces artificial delays into writeback.
> > > +#
> > > +# Before the race, the file blocks 0-1 are not shared and blocks 2-5 are
> > > +# shared.  There are no extents in CoW fork.
> > > +#
> > > +# Two threads race like this:
> > > +#
> > > +# Thread 1 (writeback block 0)     | Thread 2  (write to block 2)
> > > +# ---------------------------------|--------------------------------
> > > +#                                  |
> > > +# 1. Check if block 0 in CoW fork  |
> > > +#    from xfs_map_cow.             |
> > > +#                                  |
> > > +# 2. Block 0 not found in CoW      |
> > > +#    fork; the block is considered |
> > > +#    not shared.                   |
> > > +#                                  |
> > > +# 3. xfs_map_blocks looks up data  |
> > > +#    fork to get a map covering    |
> > > +#    block 0.                      |
> > > +#                                  |
> > > +# 4. It gets a data fork mapping   |
> > > +#    for block 0 with length 2.    |
> > > +#                                  |
> > > +#                                  | 1. A buffered write to block 2 sees
> > > +#                                  |    that it is a shared block and no
> > > +#                                  |    extent covers block 2 in CoW fork.
> > > +#                                  |
> > > +#                                  |    It creates a new CoW fork mapping.
> > > +#                                  |    Due to the cowextsize, the new
> > > +#                                  |    extent starts at block 0 with
> > > +#                                  |    length 128.
> > > +#                                  |
> > > +#                                  |
> > > +# 5. It lookup CoW fork again to   |
> > > +#    trim the map (0, 2) to a      |
> > > +#    shared block boundary.        |
> > > +#                                  |
> > > +# 5a. It finds (0, 128) in CoW fork|
> > > +# 5b. It trims the data fork map   |
> > > +#     from (0, 1) to (0, 0) (!!!)  |
> > > +#                                  |
> > > +# 6. The xfs_imap_valid call after |
> > > +#    the xfs_map_blocks call checks|
> > > +#    if the mapping (0, 0) covers  |
> > > +#    block 0.  The result is "NO". |
> > > +#                                  |
> > > +# 7. Since block 0 has no physical |
> > > +#    block mapped, it's not added  |
> > > +#    to the ioend.  This is the    |
> > > +#    first problem.                |
> > > +#                                  |
> > > +# 8. xfs_add_to_ioend usually      |
> > > +#    clears the bufferhead dirty   |
> > > +#    flag  Because this is skipped,|
> > > +#    we leave the page clean with  |
> > > +#    the associated buffer head(s) |
> > > +#    dirty (the second problem).   |
> > > +#    Now the dirty state is        |
> > > +#    inconsistent.
> > > +#
> > > +# On newer kernels, this is also a functionality test for the ifork sequence
> > > +# counter because the writeback completions will change the data fork and force
> > > +# revalidations of the wb mapping.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick clone
> > > +
> > > +# Import common functions.
> > > +. ./common/reflink
> > > +. ./common/inject
> > > +. ./common/tracing
> > > +
> > > +# real QA test starts here
> > > +_cleanup()
> > > +{
> > > +	_ftrace_cleanup
> > > +	cd /
> > > +	rm -r -f $tmp.* $sentryfile $tracefile
> > > +}
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs xfs
> > > +_fixed_by_kernel_commit 5c665e5b5af6 "xfs: remove xfs_map_cow"
> > > +_require_ftrace
> > > +_require_error_injection
> > > +_require_scratch_reflink
> > > +_require_cp_reflink
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount >> $seqres.full
> > > +
> > > +# This is a pagecache test, so try to disable fsdax mode.
> > > +$XFS_IO_PROG -c 'chattr -x' $SCRATCH_MNT &> $seqres.full
> > > +_require_pagecache_access $SCRATCH_MNT
> > > +
> > > +knob="$(_find_xfs_mountdev_errortag_knob $SCRATCH_DEV "wb_delay_ms")"
> > > +test -w "$knob" || _notrun "Kernel does not have wb_delay_ms error injector"
> > 
> > Can `_require_xfs_io_error_injection` help that?
> > 
> > > +
> > > +blksz=65536
> > > +_require_congruent_file_oplen $SCRATCH_MNT $blksz
> > > +
> > > +# Make sure we have sufficient extent size to create speculative CoW
> > > +# preallocations.
> > > +$XFS_IO_PROG -c 'cowextsize 1m' $SCRATCH_MNT
> > > +
> > > +# Write out a file with the first two blocks unshared and the rest shared.
> > > +_pwrite_byte 0x59 0 $((160 * blksz)) $SCRATCH_MNT/file >> $seqres.full
> > > +_pwrite_byte 0x59 0 $((160 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
> > > +sync
> > > +
> > > +_cp_reflink $SCRATCH_MNT/file $SCRATCH_MNT/file.reflink
> > > +
> > > +_pwrite_byte 0x58 0 $((2 * blksz)) $SCRATCH_MNT/file >> $seqres.full
> > > +_pwrite_byte 0x58 0 $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
> > > +sync
> > > +
> > > +# Avoid creation of large folios on newer kernels by cycling the mount and
> > > +# immediately writing to the page cache.
> > > +_scratch_cycle_mount
> > > +
> > > +# Write the same data to file.compare as we're about to do to file.  Do this
> > > +# before slowing down writeback to avoid unnecessary delay.
> > > +_pwrite_byte 0x57 0 $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
> > > +_pwrite_byte 0x56 $((2 * blksz)) $((2 * blksz)) $SCRATCH_MNT/file.compare >> $seqres.full
> > > +sync
> > > +
> > > +# Introduce a half-second wait to each writeback block mapping call.  This
> > > +# gives us a chance to race speculative cow prealloc with writeback.
> > > +wb_delay=500
> > > +echo $wb_delay > $knob
> > 
> > Oh, you'd like to avoid depending on xfs_io ?
> 
> Oops, this was leftover from before I ported the xfs_errortag.h changes
> to xfsprogs.
> 
> > > +curval="$(cat $knob)"
> > > +test "$curval" -eq $wb_delay || echo "expected wb_delay_ms == $wb_delay"
> > > +
> > > +_ftrace_record_events 'xfs_wb*iomap_invalid'
> > > +
> > > +# Start thread 1 + writeback above
> > > +$XFS_IO_PROG -c "pwrite -S 0x57 0 $((2 * blksz))" \
> > > +	-c 'bmap -celpv' -c 'bmap -elpv' \
> > 
> > I didn't find the "bmap -c" option, is it a new option? Won't it break the
> > golden image if a system doesn't support it?
> 
> -c is a deliberately undocumented option to the bmap command; it's been
> there since the introduction of reflink.

But when I tried that on rhel8 with a varietal ersion of xfsprogs 5.0.0
(xfsprogs-5.0.0-10.el8), I got below error output:

# xfs_io -c "bmap -celpv" testfile >/dev/null
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["testfile"]: Invalid argument
# xfs_io -c "bmap -c" testfile >/dev/null
xfs_io: xfsctl(XFS_IOC_GETBMAPX) iflags=0x28 ["testfile"]: Invalid argument
# xfs_io -c "bmap -elpv" testfile >/dev/null
(no error output)

So, maybe, if you don't need this output to be golden image, how about filter
out the error output to $seqres.full too? Or any better idea?

Thanks,
Zorro

> 
> > > +	-c 'fsync' $SCRATCH_MNT/file >> $seqres.full &
> > > +sleep 1
> > > +
> > > +# Start a sentry to look for evidence of the XFS_ERRORTAG_REPORT logging.  If
> > > +# we see that, we know we've forced writeback to revalidate a mapping.  The
> > > +# test has been successful, so turn off the delay.
> > > +sentryfile=$TEST_DIR/$seq.sentry
> > > +tracefile=$TEST_DIR/$seq.ftrace
> > > +wait_for_errortag() {
> > > +	while [ -e "$sentryfile" ]; do
> > > +		_ftrace_dump | grep iomap_invalid >> "$tracefile"
> > > +		if grep -q iomap_invalid "$tracefile"; then
> > > +			echo 0 > "$knob"
> > > +			_ftrace_ignore_events
> > > +			break;
> > > +		fi
> > > +		sleep 0.5
> > > +	done
> > > +}
> > > +touch $sentryfile
> > > +wait_for_errortag &
> > 
> > Should we *wait* background processes in cleanup after removing $sentryfile.
> 
> Yes.
> 
> > > +
> > > +# Start thread 2 to create the cowextsize reservation
> > > +$XFS_IO_PROG -c "pwrite -S 0x56 $((2 * blksz)) $((2 * blksz))" \
> > > +	-c 'bmap -celpv' -c 'bmap -elpv' \
> > > +	-c 'fsync' $SCRATCH_MNT/file >> $seqres.full
> > > +rm -f $sentryfile
> > > +
> > > +cat "$tracefile" >> $seqres.full
> > > +grep -q iomap_invalid "$tracefile"
> > > +saw_invalidation=$?
> > > +
> > > +# Flush everything to disk.  If the bug manifests, then after the cycle,
> > > +# file should have stale 0x58 in block 0 because we silently dropped a write.
> > > +_scratch_cycle_mount
> > > +
> > > +if ! cmp -s $SCRATCH_MNT/file $SCRATCH_MNT/file.compare; then
> > > +	echo file and file.compare do not match
> > > +	$XFS_IO_PROG -c 'bmap -celpv' -c 'bmap -elpv' $SCRATCH_MNT/file >> $seqres.full
> > > +	echo file.compare
> > > +	od -tx1 -Ad -c $SCRATCH_MNT/file.compare
> > > +	echo file
> > > +	od -tx1 -Ad -c $SCRATCH_MNT/file
> > > +elif [ $saw_invalidation -ne 0 ]; then
> > > +	# The files matched, but nothing got logged about the revalidation?
> > > +	echo "Expected to hear about writeback iomap invalidations?"
> > > +fi
> > > +
> > > +echo Silence is golden
> > > +status=0
> > > +exit
> > > diff --git a/tests/xfs/924.out b/tests/xfs/924.out
> > > new file mode 100644
> > > index 0000000000..c6655da35a
> > > --- /dev/null
> > > +++ b/tests/xfs/924.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 924
> > > +Silence is golden
> > > 
> > 
> 

