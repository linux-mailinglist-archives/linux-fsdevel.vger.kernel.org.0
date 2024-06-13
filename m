Return-Path: <linux-fsdevel+bounces-21678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB91907DDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 23:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9102859A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9F13DBB1;
	Thu, 13 Jun 2024 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NdYumvUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70913B787;
	Thu, 13 Jun 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313048; cv=none; b=SBq99f15kwagh2mwT5ZdY789tUenlQpp2vj2OQn2sen51BdaVuigu5o6BkIr41/ugNYdBSDzVVcRXW94fG75kK8kuGuDcPYbmFATR9UooHM6R0WYVnWjvOyj0VgIzOfdCmLiw2KRizm8EpLEHZQt9xi4qB4hgFRoMU3wrT9BbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313048; c=relaxed/simple;
	bh=DMwJg3RL9loVdZPRP5gxZP7zz6zAhPb4S/W/4bglxrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW4qsVU/CWgFWQyernHrJvvJRPf8TPhUyRtvlC4uJMSRPxtqG5/X52h3LZzSh65L6OLnExGM5Bqsn/rp5Gf1ZcnwbN1X9js7lvk3bFx3qBg86c1qHlBjjWDmux6PnpFr1/mVNIogAesb1hw+u1slkIhhf3tvClw4LAlBEmU4SMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NdYumvUV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0HALQjHlXOL6+WTYDn4qLGcW9dgjlpY1wKU66kRI+YQ=; b=NdYumvUVsJQZ9dm/svHJBAsMl1
	FZdv0vNdmhDdlfWs2gOZhDxs2Szp+j59WUlMwBcxaqgXKhyRV6j7j5dLoWhv1OMrn3hfXAndskAQc
	7H6t2QsZuJLki7Mv18C6rIEGzJB4XXtHA0XLirntWt/C2yaSazpSYj5mRaWrxZ0j8fWS8zRfgfVRo
	NMRBW1Tmmfsrb8SfxHrOskx9iWm7WRoVhr/FaW7f25N2RYIAkupO2bpSjlQROb02vi9pwoFJmqsrh
	BO/pAagTc1bM0pmVEBnff2vbzW2+WouAi0icO1FOuLvo/ajc2fP46vi9A2CS60sobc8tiI6uZEQhV
	XMh1JH1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHriU-00000000V0D-0Y84;
	Thu, 13 Jun 2024 21:10:42 +0000
Date: Thu, 13 Jun 2024 14:10:42 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 3/5] fstests: add fsstress + compaction test
Message-ID: <ZmtgUgJzMATP-xkg@bombadil.infradead.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-4-mcgrof@kernel.org>
 <20240612080048.dnbc3rzmeo7jtubv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612080048.dnbc3rzmeo7jtubv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jun 12, 2024 at 04:00:48PM +0800, Zorro Lang wrote:
> On Mon, Jun 10, 2024 at 08:02:00PM -0700, Luis Chamberlain wrote:
> > Running compaction while we run fsstress can crash older kernels as per
> > korg#218227 [0], the fix for that [0] has been posted [1] that patch
> > was merged on v6.9-rc6 fixed by commit d99e3140a4d3 ("mm: turn
> > folio_test_hugetlb into a PageType"). However even on v6.10-rc2 where
> > this kernel commit is already merged we can still deadlock when running
> > fsstress and at the same time triggering compaction, this is a new
> > issue being reported now this through patch, but this patch also
> > serves as a reproducer with a high confidence. It always deadlocks.
> > If you enable CONFIG_PROVE_LOCKING with the defaults you will end up
> > with a complaint about increasing MAX_LOCKDEP_CHAIN_HLOCKS [1], if
> > you adjust that you then end up with a few soft lockup complaints and
> > some possible deadlock candidates to evaluate [2].
> > 
> > Provide a simple reproducer and pave the way so we keep on testing this.
> > 
> > Without lockdep enabled we silently deadlock on the first run of the
> > test without the fix applied. With lockdep enabled you get a splat about
> > the possible deadlock on the first run of the test.
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=218227
> > [1] https://gist.github.com/mcgrof/824913b645892214effeb1631df75072
> > [2] https://gist.github.com/mcgrof/926e183d21c5c4c55d74ec90197bd77a
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  common/rc             |  7 +++++
> >  tests/generic/750     | 62 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/750.out |  2 ++
> >  3 files changed, 71 insertions(+)
> >  create mode 100755 tests/generic/750
> >  create mode 100644 tests/generic/750.out
> > 
> > diff --git a/common/rc b/common/rc
> > index e812a2f7cc67..18ad25662d5c 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -151,6 +151,13 @@ _require_hugepages()
> >  		_notrun "Kernel does not report huge page size"
> >  }
> >  
> > +# Requires CONFIG_COMPACTION
> > +_require_vm_compaction()
> > +{
> > +	if [ ! -f /proc/sys/vm/compact_memory ]; then
> > +	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
> > +	fi
> > +}
> >  # Get hugepagesize in bytes
> >  _get_hugepagesize()
> >  {
> > diff --git a/tests/generic/750 b/tests/generic/750
> > new file mode 100755
> > index 000000000000..334ab011dfa0
> > --- /dev/null
> > +++ b/tests/generic/750
> > @@ -0,0 +1,62 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
> > +#
> > +# FS QA Test 750
> > +#
> > +# fsstress + memory compaction test
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto rw long_rw stress soak smoketest
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $runfile
> > +	rm -f $tmp.*
> > +	kill -9 $trigger_compaction_pid > /dev/null 2>&1
> > +	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> > +
> > +	wait > /dev/null 2>&1
> > +}
> > +
> > +# Import common functions.
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +
> > +_require_scratch
> > +_require_vm_compaction
> > +_require_command "$KILLALL_PROG" "killall"
> > +
> > +# We still deadlock with this test on v6.10-rc2, we need more work.
> > +# but the below makes things better.
> > +_fixed_by_git_commit kernel d99e3140a4d3 \
> > +	"mm: turn folio_test_hugetlb into a PageType"
> > +
> > +echo "Silence is golden"
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_scratch_mount >> $seqres.full 2>&1
> > +
> > +nr_cpus=$((LOAD_FACTOR * 4))
> > +nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
> > +fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
> > +
> > +# start a background trigger for memory compaction
> > +runfile="$tmp.compaction"
> > +touch $runfile
> > +while [ -e $runfile ]; do
> > +	echo 1 > /proc/sys/vm/compact_memory
> > +	sleep 5
> > +done &
> > +trigger_compaction_pid=$!
> > +
> > +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> > +
> > +$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> > +wait > /dev/null 2>&1
> 
> Won't this "wait" wait forever (except a ctrl+C), due to no one removes
> the $runfile?

Odd, pretty sure I tested it and it didn't wait forever, but I'll add
the rm after the FSSTRESS call.

  Luis

