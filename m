Return-Path: <linux-fsdevel+bounces-32669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085229ACC04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C80A286186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA81BD004;
	Wed, 23 Oct 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsQ4BbDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA41BB6BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692845; cv=none; b=ckokT7BQ5i80bgjzXdKNSZHrMzNcb9Ro6Ui/dggYynlGRBm+MeYYfZQ6ciuGxwDGWy4SpD7mANRJ8CqnUMDY8aFl3eCw+kPQV1GY8gHql81H0f3c3f/nWEda1R0D0/2+ro27FKf0vZbJEswmOOPCsKlHm8WQEE5/NyD7M/urKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692845; c=relaxed/simple;
	bh=e5lfgz9uob4k1uyFDQD3okYiID40ELTcQ6BULB07Cwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQTRvAn8zbOjqTMd55+eHqKDJBWNeEcRfUcf9I4+0G71d8UVhRhc/0SuPDs1hWKr7LNtAf4M4QwvCalOHo1hpyKZpH26E5izef5Jr72PMsOK2ThkKeZUzBUaxwwdBqHO+s4H06dJjsUKc9gPQfmMQls9P9bcatCGVInU47vl/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsQ4BbDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729692841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nI/0JofbsRUc5jiX0lc5WWWG5OVrjpTvPysCApLQIp4=;
	b=DsQ4BbDFu9ftIQ9WAiYeJtwvdGAk/ejNj9FlSfHNQ9l+2dtlJiRFzcqqEppZcSUMkUfx0O
	Xy7yMdSWyHKRhbfEenM5Pu7judnAenxxHGqWepuKUN+ncscDNxkI2WxHq4388FMtM5cID4
	2WYew+CYXG18m47h84f61Pq3PdF4g/0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-rVLAevbrP12kSKshpNraxw-1; Wed,
 23 Oct 2024 10:13:57 -0400
X-MC-Unique: rVLAevbrP12kSKshpNraxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D920019059B4;
	Wed, 23 Oct 2024 14:13:54 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.135])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51E661956054;
	Wed, 23 Oct 2024 14:13:52 +0000 (UTC)
Date: Wed, 23 Oct 2024 10:15:19 -0400
From: Brian Foster <bfoster@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iomap]  c5c810b94c:
 stress-ng.metamix.ops_per_sec -98.4% regression
Message-ID: <ZxkE93Vz3ZQaAFO1@bfoster>
References: <202410141536.1167190b-oliver.sang@intel.com>
 <Zw1IHVLclhiBjDkP@bfoster>
 <Zw7jwnvBaMwloHXG@dread.disaster.area>
 <Zw_gDDlIEgZbApU_@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw_gDDlIEgZbApU_@bfoster>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Oct 16, 2024 at 11:47:24AM -0400, Brian Foster wrote:
> On Wed, Oct 16, 2024 at 08:50:58AM +1100, Dave Chinner wrote:
> > On Mon, Oct 14, 2024 at 12:34:37PM -0400, Brian Foster wrote:
> > > On Mon, Oct 14, 2024 at 03:55:24PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed a -98.4% regression of stress-ng.metamix.ops_per_sec on:
> > > > 
> > > > 
> > > > commit: c5c810b94cfd818fc2f58c96feee58a9e5ead96d ("iomap: fix handling of dirty folios over unwritten extents")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > testcase: stress-ng
> > > > config: x86_64-rhel-8.3
> > > > compiler: gcc-12
> > > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > > > parameters:
> > > > 
> > > > 	nr_threads: 100%
> > > > 	disk: 1HDD
> > > > 	testtime: 60s
> > > > 	fs: xfs
> > > > 	test: metamix
> > > > 	cpufreq_governor: performance
> > > > 
> > > > 
> > > > 
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202410141536.1167190b-oliver.sang@intel.com
> > > > 
> > > > 
> > > > Details are as below:
> > > > -------------------------------------------------------------------------------------------------->
> > > > 
> > > > 
> > > > The kernel config and materials to reproduce are available at:
> > > > https://download.01.org/0day-ci/archive/20241014/202410141536.1167190b-oliver.sang@intel.com
> > > > 
> > > 
> > > So I basically just run this on a >64xcpu guest and reproduce the delta:
> > > 
> > >   stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> > > 
> > > The short of it is that with tracing enabled, I see a very large number
> > > of extending writes across unwritten mappings, which basically means XFS
> > > eof zeroing is calling zero range and hitting the newly introduced
> > > flush. This is all pretty much expected given the patch.
> > 
> > Ouch.
> > 
> > The conditions required to cause this regression are that we either
> > first use fallocate() to preallocate beyond EOF, or buffered writes
> > trigger specualtive delalloc beyond EOF and they get converted to
> > unwritten beyond EOF through background writeback or fsync
> > operations. Both of these lead to unwritten extents beyond EOF that
> > extending writes will fall into.
> > 
> > All we need now is the extending writes to be slightly
> > non-sequential and those non-sequential extending writes will not
> > land at EOF but at some distance beyond it. At this point, we
> > trigger the new flush code. Unfortunately, this is actually a fairly
> > common workload pattern.
> > 
> > For example, experience tells me that NFS server processing of async
> > sequential write requests from a client will -always- end up with
> > slightly out of order extending writes because the incoming async
> > write requests are processed concurrently. Hence they always race to
> > extend the file and slightly out of order file extension happens
> > quite frequently.
> > 
> > Further, the NFS client will also periodically be sending a write
> > commit request (i.e. server side fsync), the
> > NFS server writeback will convert the speculative delalloc that
> > extends beyond EOF into unwritten extents beyond EOF whilst the
> > incoming extending write requests are still incoming from the
> > client.
> > 
> > Hence I think that there are common workloads (e.g. large sequential
> > writes on a NFS client) that set up the exact conditions and IO
> > patterns necessary to trigger this performance regression in
> > production systems...
> > 
> 
> It's not clear to me that purely out of order writeback via NFS would
> produce the same sort of hit here because we'd only flush on write
> extensions. I think the pathological case would have to be something
> like reordering such that every other write lands sequentially to
> maximize the number of post-eof write extensions, and then going back
> and filling in the gaps. That seems rather suboptimal to start, and
> short of that the cost of the flushes will start to amortize to some
> degree (including with commit requests, etc.).
> 
> That said, I don't have much experience with NFS and I think this is a
> reasonable enough argument to try and optimize here. If you or anybody
> has an NFS test/workload that might exacerbate this condition, let me
> know and I'll try to play around with it.
> 
> > > I ran a quick experiment to skip the flush on sub-4k ranges in favor of
> > > doing explicit folio zeroing. The idea with that is that the range is
> > > likely restricted to single folio and since it's dirty, we can assume
> > > unwritten conversion is imminent and just explicitly zero the range. I
> > > still see a decent number of flushes from larger ranges in that
> > > experiment, but that still seems to get things pretty close to my
> > > baseline test (on a 6.10 distro kernel).
> > 
> > What filesystems other than XFS actually need this iomap bandaid
> > right now?  If there are none (which I think is the case), then we
> > should just revert this change it until a more performant fix is
> > available for XFS.
> > 
> 
> I think that's a bit hasty. I had one or two ideas/prototypes to work
> around this sort of problem before the flush patches even landed, it
> just wasn't clear to me they were worth the extra logic. I'd prefer to
> try and iterate on performance from a baseline of functional correctness
> rather than the other way around, if possible.
> 
> A quick hack to test out some of that on latest master brings the result
> of this test right back to baseline in my local env. Let me play around
> with trying to work that into something more production worthy before we
> break out the pitchforks.. ;)
> 

So it turns out there is a little bit more going on here. The regression
is not so much the flush on its own, but the combination of the flush
and changes in commit 5ce5674187c34 ("xfs: convert delayed extents to
unwritten when zeroing post eof blocks"). This changes post-eof zero
range calls on XFS to convert delalloc extents to unwritten instead of
the prior behavior of leaving them as delalloc, zeroing in memory, and
continuing on. IOW, the regression also goes away by bypassing this
particular commit, even with flushing in place.

The prealloc change seems fairly reasonable at face value, but the
commit log description documents it as purely an i_size change bug fix
associated with an internal zero range, which AFAICT isn't relevant any
more because iomap_zero_range() doesn't update i_size AFAICS. However,
it looks like it did so in the past and this behavior also swizzled back
and forth a time or two in the same timeframe as this particular commit,
so perhaps it was a problem when this was introduced and then iomap
changed again after (or maybe I'm just missing something?).

On thinking more about this, I'd be a little concerned on whether this
will reduce effectiveness of speculative preallocation on similar sorts
of write extending workloads as this test (i.e. strided extending
writes). This changes behavior from doing in-memory zeroing between
physical allocations via the writeback path to doing physical allocation
on every write that starts beyond EOF, which feels a little like going
from one extreme to the other. Instead, I'd expect to see something
where this converts larger mappings to avoid excessive zeroing and
zeroes on smallish ranges to avoid overly frequent and unnecessarily
small physical allocations, allowing multiple speculative preallocations
to compound.

Anyways, I've not dug into this enough to know whether it's a problem,
but since this is documented purely as a bug fix I don't see any
evidence that potential impact on allocation patterns was tested either.
This might be something to evaluate more closely in XFS.

On the iomap side, it also seems like the current handling of i_size on
zero range is confused. If iomap_zero_range() doesn't update i_size,
then it basically doesn't fully support post-eof ranges. It zeroes
through buffered writes, which writeback will just drop on the floor if
beyond EOF. However, XFS explicitly calls zero range on post-eof ranges
to trigger the aforementioned conversion in its begin callback (but
never expecting to see ranges that need buffered writes).

I think this is a landmine waiting to happen. If iomap decides to be
deliberate and skip post-eof ranges, then this could break current XFS
behavior if it skips the begin callback. OTOH if XFS were to change back
to at least doing some speculative prealloc delalloc zeroing, IIUC this
now introduces a race between writeback potentially throwing away the
zeroed folios over delalloc preallocation and the subsequent write
operation extending i_size so that doesn't happen. :/ None of this is
particularly obvious. And FWIW, I'm also skeptical that i_size updates
were ever consistent across mapping types. I.e., if the size was only
ever updated via iomap_write_end() for example, then behavior is kind of
unpredictable.

Maybe this is something that should be configurable via a keepsize flag
or some such. That would at least allow for correct behavior and/or a
failure/warning if we ever fell into doing zeroing for post-eof ranges
without updating i_size. Thoughts on any of this?

Brian

> Brian
> 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 
> 
> 


