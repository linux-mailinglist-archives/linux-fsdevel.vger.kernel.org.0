Return-Path: <linux-fsdevel+bounces-50633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1150CACE27D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602F83A67DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7FE1EE03D;
	Wed,  4 Jun 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X30HERd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C931EB5C9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056090; cv=none; b=N++Tb0fcM1TBldnGB6du8DfCRUbc6cQBVZhPdCmVyQ6o6uXO9GLwmImpoNHHY85cN+u4g5gIg9JLMyxKZLNMwcaDfc2ozXV25QVH6bWWKhpBPd4zCItAnu5VzvWlAOcVnUY7ulxxl38AQIp9KOEp5qzaNLXIEKZTNd13V7b7rmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056090; c=relaxed/simple;
	bh=S5D0xR40f/10NsdU7h3f038LLDftKbp2RstcgeDGaAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYdSDW8rzDMDA8DJbO5qeidC33RJ45wUb6OHjvqI4wj7/4f7XgzsO4HS7SO3JGsvMYlPPG+Dgoon7M94avj195UiagN09IlwGcnRuZl2Oe3IT3/xlokSHg5kMofgnbHCuuD74mKt/MynGSirww7njtUX0UFeCF1256q9hLXCHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X30HERd1; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Jun 2025 09:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749056075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RP8vXXqZC1dV9MZzM2sbviKeH5etUynIrbvM5lyh9U4=;
	b=X30HERd1QENPJC6P5RkbkC+iyoz6/q62YbxfyhIYVHzrfpu4OENJdT7gw4sIZmyEynEj0Y
	ElYtY3ieSk8/+c25AF/yARE8YRQtYc/05JK0i+w48d4ntt7CbqL6zG3YnQCsmYbKLiMNaA
	A1bGPTJuPCIohQ/KyrnIZ/uwBVJY81s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com, 
	aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
Message-ID: <nohu552nfqkfumrj3zc7akbdrq3bzwexle3i6weyta76dltppv@txizmvtg3swd>
References: <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
 <aD6vHzRhwyTxBqcl@tiehlicka>
 <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
 <aD7OM5Mrg5jnEnBc@tiehlicka>
 <7307bb7a-7c45-43f7-b073-acd9e1389000@linux.alibaba.com>
 <aD8LKHfCca1wQ5pS@tiehlicka>
 <obfnlpvc4tmb6gbd4mw7h7jamp3kouyhnpl4cusetyctswznod@yr6dyrsbay6w>
 <250ec733-8b2d-4c56-858c-6aada9544a55@linux.alibaba.com>
 <1aa7c368-c37f-4b00-876c-dcf51a523c42@suse.cz>
 <d2b76402-7e1a-4b2d-892a-2e8ffe1a37a9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b76402-7e1a-4b2d-892a-2e8ffe1a37a9@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 04, 2025 at 10:16:18PM +0800, Baolin Wang wrote:
> 
> 
> On 2025/6/4 21:46, Vlastimil Babka wrote:
> > On 6/4/25 14:46, Baolin Wang wrote:
> > > > Baolin, please run stress-ng command that stresses minor anon page
> > > > faults in multiple threads and then run multiple bash scripts which cat
> > > > /proc/pidof(stress-ng)/status. That should be how much the stress-ng
> > > > process is impacted by the parallel status readers versus without them.
> > > 
> > > Sure. Thanks Shakeel. I run the stress-ng with the 'stress-ng --fault 32
> > > --perf -t 1m' command, while simultaneously running the following
> > > scripts to read the /proc/pidof(stress-ng)/status for each thread.
> > 
> > How many of those scripts?
> 
> 1 script, but will start 32 threads to read each stress-ng thread's status
> interface.
> 
> > >   From the following data, I did not observe any obvious impact of this
> > > patch on the stress-ng tests when repeatedly reading the
> > > /proc/pidof(stress-ng)/status.
> > > 
> > > w/o patch
> > > stress-ng: info:  [6891]          3,993,235,331,584 CPU Cycles
> > >            59.767 B/sec
> > > stress-ng: info:  [6891]          1,472,101,565,760 Instructions
> > >            22.033 B/sec (0.369 instr. per cycle)
> > > stress-ng: info:  [6891]                 36,287,456 Page Faults Total
> > >             0.543 M/sec
> > > stress-ng: info:  [6891]                 36,287,456 Page Faults Minor
> > >             0.543 M/sec
> > > 
> > > w/ patch
> > > stress-ng: info:  [6872]          4,018,592,975,968 CPU Cycles
> > >            60.177 B/sec
> > > stress-ng: info:  [6872]          1,484,856,150,976 Instructions
> > >            22.235 B/sec (0.369 instr. per cycle)
> > > stress-ng: info:  [6872]                 36,547,456 Page Faults Total
> > >             0.547 M/sec
> > > stress-ng: info:  [6872]                 36,547,456 Page Faults Minor
> > >             0.547 M/sec
> > > 
> > > =========================
> > > #!/bin/bash
> > > 
> > > # Get the PIDs of stress-ng processes
> > > PIDS=$(pgrep stress-ng)
> > > 
> > > # Loop through each PID and monitor /proc/[pid]/status
> > > for PID in $PIDS; do
> > >       while true; do
> > >           cat /proc/$PID/status
> > > 	usleep 100000
> > 
> > Hm but this limits the reading to 10 per second? If we want to simulate an
> > adversary process, it should be without the sleeps I think?
> 
> OK. I drop the usleep, and I still can not see obvious impact.
> 
> w/o patch:
> stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles
> 67.327 B/sec
> stress-ng: info:  [6848]          1,616,524,844,832 Instructions
> 24.740 B/sec (0.367 instr. per cycle)
> stress-ng: info:  [6848]                 39,529,792 Page Faults Total
> 0.605 M/sec
> stress-ng: info:  [6848]                 39,529,792 Page Faults Minor
> 0.605 M/sec
> 
> w/patch:
> stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles
> 68.382 B/sec
> stress-ng: info:  [2485]          1,615,101,503,296 Instructions
> 24.750 B/sec (0.362 instr. per cycle)
> stress-ng: info:  [2485]                 39,439,232 Page Faults Total
> 0.604 M/sec
> stress-ng: info:  [2485]                 39,439,232 Page Faults Minor
> 0.604 M/sec

Is the above with 32 non-sleeping parallel reader scripts?

