Return-Path: <linux-fsdevel+bounces-32126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A99A0ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87FF1F21C7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8020E03E;
	Wed, 16 Oct 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaK5VvgA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45B209F3E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093578; cv=none; b=Zw5nFQSMzEQczdiONxhI0R3njo4MxRJ7m/hYZkDCQ4t7B++NFekwKKzqZafYYzPL7jsodGlIFXBEMmbjoG0ZqU+OisaA13BebT490NiMylh6a4KYmI5nS+Z9SnUX1DkUGe9yVZcMvm0158YtNCiMYwNX0SfDGdGbtbCQVKZxRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093578; c=relaxed/simple;
	bh=5v17HX0W3McVtavPi0fHNUdsvhXZegnTOQOZGJeE6ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuHwcT7uyxYBOOttG6+m+MMiJoaIe+ZjRC6PPeULtbBwqT3goWDSLFVhsl/CJYrLjThE6LLGlE+HEW8rj1E/vnLgfAZlvbEhlFr64X5k4t99MBgPSgrCwaMrDcP6ZDEdyn75WpfzCb2dOjD5l/fTXO7lHiGMwM2FYMviRWaPCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaK5VvgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729093576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NU9Hb4g5OFv5RQv2jPUd5Yt/H5y3tYF3G31JyGCSJo=;
	b=OaK5VvgA40N78iAdahkJDtIUtNUPJJB1E9cEJy6OZLU0yqafg2Rba6q88Oc7I0kva4+ICF
	0HfNidR3SE8z0fXe6Sf9nzsKTMunBcyfMm69MtCfdUEIMtHDrZ2kVQCJlWbNgXa9zJJUbZ
	1B1wEO/qBcrUkrq9ap3ekA/LwCtzTVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-E_7IF1TFPMW9oeMIkXQcpQ-1; Wed,
 16 Oct 2024 11:46:10 -0400
X-MC-Unique: E_7IF1TFPMW9oeMIkXQcpQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BB8419560AB;
	Wed, 16 Oct 2024 15:46:06 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.74])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ABB3195607C;
	Wed, 16 Oct 2024 15:46:03 +0000 (UTC)
Date: Wed, 16 Oct 2024 11:47:24 -0400
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
Message-ID: <Zw_gDDlIEgZbApU_@bfoster>
References: <202410141536.1167190b-oliver.sang@intel.com>
 <Zw1IHVLclhiBjDkP@bfoster>
 <Zw7jwnvBaMwloHXG@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw7jwnvBaMwloHXG@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Oct 16, 2024 at 08:50:58AM +1100, Dave Chinner wrote:
> On Mon, Oct 14, 2024 at 12:34:37PM -0400, Brian Foster wrote:
> > On Mon, Oct 14, 2024 at 03:55:24PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a -98.4% regression of stress-ng.metamix.ops_per_sec on:
> > > 
> > > 
> > > commit: c5c810b94cfd818fc2f58c96feee58a9e5ead96d ("iomap: fix handling of dirty folios over unwritten extents")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > testcase: stress-ng
> > > config: x86_64-rhel-8.3
> > > compiler: gcc-12
> > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > > parameters:
> > > 
> > > 	nr_threads: 100%
> > > 	disk: 1HDD
> > > 	testtime: 60s
> > > 	fs: xfs
> > > 	test: metamix
> > > 	cpufreq_governor: performance
> > > 
> > > 
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202410141536.1167190b-oliver.sang@intel.com
> > > 
> > > 
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > > 
> > > 
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20241014/202410141536.1167190b-oliver.sang@intel.com
> > > 
> > 
> > So I basically just run this on a >64xcpu guest and reproduce the delta:
> > 
> >   stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> > 
> > The short of it is that with tracing enabled, I see a very large number
> > of extending writes across unwritten mappings, which basically means XFS
> > eof zeroing is calling zero range and hitting the newly introduced
> > flush. This is all pretty much expected given the patch.
> 
> Ouch.
> 
> The conditions required to cause this regression are that we either
> first use fallocate() to preallocate beyond EOF, or buffered writes
> trigger specualtive delalloc beyond EOF and they get converted to
> unwritten beyond EOF through background writeback or fsync
> operations. Both of these lead to unwritten extents beyond EOF that
> extending writes will fall into.
> 
> All we need now is the extending writes to be slightly
> non-sequential and those non-sequential extending writes will not
> land at EOF but at some distance beyond it. At this point, we
> trigger the new flush code. Unfortunately, this is actually a fairly
> common workload pattern.
> 
> For example, experience tells me that NFS server processing of async
> sequential write requests from a client will -always- end up with
> slightly out of order extending writes because the incoming async
> write requests are processed concurrently. Hence they always race to
> extend the file and slightly out of order file extension happens
> quite frequently.
> 
> Further, the NFS client will also periodically be sending a write
> commit request (i.e. server side fsync), the
> NFS server writeback will convert the speculative delalloc that
> extends beyond EOF into unwritten extents beyond EOF whilst the
> incoming extending write requests are still incoming from the
> client.
> 
> Hence I think that there are common workloads (e.g. large sequential
> writes on a NFS client) that set up the exact conditions and IO
> patterns necessary to trigger this performance regression in
> production systems...
> 

It's not clear to me that purely out of order writeback via NFS would
produce the same sort of hit here because we'd only flush on write
extensions. I think the pathological case would have to be something
like reordering such that every other write lands sequentially to
maximize the number of post-eof write extensions, and then going back
and filling in the gaps. That seems rather suboptimal to start, and
short of that the cost of the flushes will start to amortize to some
degree (including with commit requests, etc.).

That said, I don't have much experience with NFS and I think this is a
reasonable enough argument to try and optimize here. If you or anybody
has an NFS test/workload that might exacerbate this condition, let me
know and I'll try to play around with it.

> > I ran a quick experiment to skip the flush on sub-4k ranges in favor of
> > doing explicit folio zeroing. The idea with that is that the range is
> > likely restricted to single folio and since it's dirty, we can assume
> > unwritten conversion is imminent and just explicitly zero the range. I
> > still see a decent number of flushes from larger ranges in that
> > experiment, but that still seems to get things pretty close to my
> > baseline test (on a 6.10 distro kernel).
> 
> What filesystems other than XFS actually need this iomap bandaid
> right now?  If there are none (which I think is the case), then we
> should just revert this change it until a more performant fix is
> available for XFS.
> 

I think that's a bit hasty. I had one or two ideas/prototypes to work
around this sort of problem before the flush patches even landed, it
just wasn't clear to me they were worth the extra logic. I'd prefer to
try and iterate on performance from a baseline of functional correctness
rather than the other way around, if possible.

A quick hack to test out some of that on latest master brings the result
of this test right back to baseline in my local env. Let me play around
with trying to work that into something more production worthy before we
break out the pitchforks.. ;)

Brian

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


