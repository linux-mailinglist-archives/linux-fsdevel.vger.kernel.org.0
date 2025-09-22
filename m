Return-Path: <linux-fsdevel+bounces-62433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A31B93667
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 23:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC9344141B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 21:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907EC2F1FD3;
	Mon, 22 Sep 2025 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IytNp5BD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2AF25A34F;
	Mon, 22 Sep 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577848; cv=none; b=l5KcL9h5QsKEQcAVkhBXwZAZfQQR+2o5JiCzjR7ec9e7C7YNSDr4eGZwn2ORXzcuS9xn8GYHW6FiRI2M3i6lESnzVE57Y41XFpetvZ9eZG+qWbUhPVdofXMgvEvjIhrxRS3vVBzVrkKovKpclx79QO0yVBpoSWbAH4iOzeO2yVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577848; c=relaxed/simple;
	bh=Wnwabh09vJY+JBDnN56wOIT6Td8s6X5xjEdl0uoI3g4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PmVLAhhm4eCPiLB8CI+AVwSXCXA79Z4FdfmzzuQfYGZ8OTFj3mVlaRXMWw8vA+FC1Ji93YPGZYohwT4Wxy0fkRSkXOvrRPZOV5rCc6uTDCogHCXAvhuiHs84/+5xBWa8QhjTOVlpR9q2nsyz+73Qc2CQweck9DPSPRn00jVNikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IytNp5BD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B08C4CEF0;
	Mon, 22 Sep 2025 21:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758577847;
	bh=Wnwabh09vJY+JBDnN56wOIT6Td8s6X5xjEdl0uoI3g4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IytNp5BDrWaycWN995gdHM+Tb958Qi+N5X2CNhHgCLevtaw5gbSIBX3GexKUYA+D/
	 Qw+/oyhmq6ulvmZRA6OUiwRDRjPqyUUr/L0n6r1gvYlXSQXjCtJ53NRZRXltlr5+QG
	 tjljsy9C4funtVRrgEA1Mm76FqKpJuJ/jkJJ8yMQ=
Date: Mon, 22 Sep 2025 14:50:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Julian Sun
 <sunjunchao@bytedance.com>, cgroups@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, lance.yang@linux.dev,
 mhiramat@kernel.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-Id: <20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>
In-Reply-To: <aNGQoPFTH2_xrd9L@infradead.org>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
	<20250922132718.GB49638@noisy.programming.kicks-ass.net>
	<aNGQoPFTH2_xrd9L@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 11:08:32 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > > Julian Sun (3):
> > >   sched: Introduce a new flag PF_DONT_HUNG.
> > >   writeback: Introduce wb_wait_for_completion_no_hung().
> > >   memcg: Don't trigger hung task when memcg is releasing.
> > 
> > This is all quite terrible. I'm not at all sure why a task that is
> > genuinely not making progress and isn't killable should not be reported.
> 
> The hung device detector is way to aggressive for very slow I/O.
> See blk_wait_io, which has been around for a long time to work
> around just that.  Given that this series targets writeback I suspect
> it is about an overloaded device as well.

Yup, it's writeback - the bug report is in
https://lkml.kernel.org/r/20250917212959.355656-1-sunjunchao@bytedance.com

Memory is big and storage is slow, there's nothing wrong if a task
which is designed to wait for writeback waits for a long time.

Of course, there's something wrong if some other task which isn't
designed to wait for writeback gets stuck waiting for the task which
*is* designed to wait for writeback, but we'll still warn about that.


Regarding an implementation, I'm wondering if we can put a flag in
`struct completion' telling the hung task detector that this one is
expected to wait for long periods sometimes.  Probably messy and it
only works for completions (not semaphores, mutexes, etc).  Just
putting it out there ;)


