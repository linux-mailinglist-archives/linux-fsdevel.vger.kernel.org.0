Return-Path: <linux-fsdevel+bounces-57542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE62B22F02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6039C16947D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB582FDC2D;
	Tue, 12 Aug 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdZLy0K7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855581FE455;
	Tue, 12 Aug 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019617; cv=none; b=f90Q5Hx4WstFjz9z8TXWsQ8j/8ESmllLdCSuZYzQ2add+dq25iwS+OqrOPW1uy8LImjEV9Zkx6sCGcYS3Sg1Kbq6hEqsIGrY8d8m3ZvEhStPVL7Nae3hK6xm5GHrXZ5AqDRrPhkDJl6zpoGBcw62pZQyVWQaYlQ7B8lmHsBzoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019617; c=relaxed/simple;
	bh=3+G+Hlu9Vk9eunN31fxV4PS7eTzvIgYXetLB/9sOOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/mkNbzQwsYNrNAzJMXuO+hQEzOUSBGxP8yHzyGWZRiwLNzmunqGEhIPieDr6v+aXVEWYwnU03/dKKPcE9uWZwtzzs6+W7r34bacvFNb4dnBo0zGgLMJZCWsOXaOxEA9NhH42EzmTnF5TnIUH/4C0M09RbdqHy3cmNhz4I2zo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdZLy0K7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DC8C4CEF0;
	Tue, 12 Aug 2025 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019616;
	bh=3+G+Hlu9Vk9eunN31fxV4PS7eTzvIgYXetLB/9sOOwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdZLy0K7i9vgcXSgUICwY8FOv2kcDgtA95nkdB2az+5P3mnY8PMt/gm0fLGWNV4ew
	 qKiFiCEYJZkW2NiH4WRaoN+ycjrlv8uHKfRoU257dRGblX4r1Wpf6WbhUh9+sq1wxj
	 vVoznPuVwXl/j41iNsQZope6uGa7jCLppaF/p1kNnTImRZgBUNcseM8/VXbrQmKSdu
	 aPn6BkWuUpVJ9IMabBUEZwBzFPx4fwHOFGQkf/AS/VLGlMKxcSCwAy6pR/NVRUU+CP
	 JW6GPzZ02Exi3LfxSiFmgiiGjRtiUB3vrbv7q2BBJVGVVmxorC/wDPRhJhStqZKCiJ
	 pLTgF/Sx1YNyQ==
Date: Tue, 12 Aug 2025 10:26:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <20250812172655.GF7938@frogsfrogsfrogs>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
 <aJWglTo1xpXXEqEM@tiehlicka>
 <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
 <aJW8NLPxGOOkyCfB@tiehlicka>
 <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>
 <aJnM32xKq0FOWBzw@tiehlicka>
 <d86a9883-9d2e-4bb2-a93d-0d95b4a60e5f@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d86a9883-9d2e-4bb2-a93d-0d95b4a60e5f@kylinos.cn>

On Tue, Aug 12, 2025 at 01:57:49PM +0800, Zihuan Zhang wrote:
> Hi all,
> 
> We encountered an issue where the number of freeze retries increased due to
> processes stuck in D state. The logs point to jbd2-related activity.
> 
> log1:
> 
> 6616.650482] task:ThreadPoolForeg state:D stack:0     pid:262026
> tgid:4065  ppid:2490   task_flags:0x400040 flags:0x00004004
> [ 6616.650485] Call Trace:
> [ 6616.650486]  <TASK>
> [ 6616.650489]  __schedule+0x532/0xea0
> [ 6616.650494]  schedule+0x27/0x80
> [ 6616.650496]  jbd2_log_wait_commit+0xa6/0x120
> [ 6616.650499]  ? __pfx_autoremove_wake_function+0x10/0x10
> [ 6616.650502]  ext4_sync_file+0x1ba/0x380
> [ 6616.650505]  do_fsync+0x3b/0x80
> 
> log2:
> 
> [  631.206315] jdb2_log_wait_log_commit  completed (elapsed 0.002 seconds)
> [  631.215325] jdb2_log_wait_log_commit  completed (elapsed 0.001 seconds)
> [  631.240704] jdb2_log_wait_log_commit  completed (elapsed 0.386 seconds)
> [  631.262167] Filesystems sync: 0.424 seconds
> [  631.262821] Freezing user space processes
> [  631.263839] freeze round: 1, task to freeze: 852
> [  631.265128] freeze round: 2, task to freeze: 2
> [  631.267039] freeze round: 3, task to freeze: 2
> [  631.271176] freeze round: 4, task to freeze: 2
> [  631.279160] freeze round: 5, task to freeze: 2
> [  631.287152] freeze round: 6, task to freeze: 2
> [  631.295346] freeze round: 7, task to freeze: 2
> [  631.301747] freeze round: 8, task to freeze: 2
> [  631.309346] freeze round: 9, task to freeze: 2
> [  631.317353] freeze round: 10, task to freeze: 2
> [  631.325348] freeze round: 11, task to freeze: 2
> [  631.333353] freeze round: 12, task to freeze: 2
> [  631.341358] freeze round: 13, task to freeze: 2
> [  631.349357] freeze round: 14, task to freeze: 2
> [  631.357363] freeze round: 15, task to freeze: 2
> [  631.365361] freeze round: 16, task to freeze: 2
> [  631.373379] freeze round: 17, task to freeze: 2
> [  631.381366] freeze round: 18, task to freeze: 2
> [  631.389365] freeze round: 19, task to freeze: 2
> [  631.397371] freeze round: 20, task to freeze: 2
> [  631.405373] freeze round: 21, task to freeze: 2
> [  631.413373] freeze round: 22, task to freeze: 2
> [  631.421392] freeze round: 23, task to freeze: 1
> [  631.429948] freeze round: 24, task to freeze: 1
> [  631.438295] freeze round: 25, task to freeze: 1
> [  631.444546] jdb2_log_wait_log_commit  completed (elapsed 0.249 seconds)
> [  631.446387] freeze round: 26, task to freeze: 0
> [  631.446390] Freezing user space processes completed (elapsed 0.183
> seconds)
> [  631.446392] OOM killer disabled.
> [  631.446393] Freezing remaining freezable tasks
> [  631.446656] freeze round: 1, task to freeze: 4
> [  631.447976] freeze round: 2, task to freeze: 0
> [  631.447978] Freezing remaining freezable tasks completed (elapsed 0.001
> seconds)
> [  631.447980] PM: suspend debug: Waiting for 1 second(s).
> [  632.450858] OOM killer enabled.
> [  632.450859] Restarting tasks: Starting
> [  632.453140] Restarting tasks: Done
> [  632.453173] random: crng reseeded on system resumption
> [  632.453370] PM: suspend exit
> [  632.462799] jdb2_log_wait_log_commit  completed (elapsed 0.000 seconds)
> [  632.466114] jdb2_log_wait_log_commit  completed (elapsed 0.001 seconds)
> 
> This is the reason:
> 
> [  631.444546] jdb2_log_wait_log_commit  completed (elapsed 0.249 seconds)
> 
> 
> During freezing, user processes executing jbd2_log_wait_commit enter D state
> because this function calls wait_event and can take tens of milliseconds to
> complete. This long execution time, coupled with possible competition with
> the freezer, causes repeated freeze retries.
> 
> While we understand that jbd2 is a freezable kernel thread, we would like to
> know if there is a way to freeze it earlier or freeze some critical
> processes proactively to reduce this contention.

Freeze the filesystem before you start freezing kthreads?  That should
quiesce the jbd2 workers and pause anyone trying to write to the fs.
Maybe the missing piece here is the device model not knowing how to call
bdev_freeze prior to a suspend?

That said, I think that doesn't 100% work for XFS because it has
kworkers for metadata buffer read completions, and freezes don't affect
read operations...

(just my clueless 2c)

--D

> Thanks for your input and suggestions.
> 
> 在 2025/8/11 18:58, Michal Hocko 写道:
> > On Mon 11-08-25 17:13:43, Zihuan Zhang wrote:
> > > 在 2025/8/8 16:58, Michal Hocko 写道:
> > [...]
> > > > Also the interface seems to be really coarse grained and it can easily
> > > > turn out insufficient for other usecases while it is not entirely clear
> > > > to me how this could be extended for those.
> > >   We recognize that the current interface is relatively coarse-grained and
> > > may not be sufficient for all scenarios. The present implementation is a
> > > basic version.
> > > 
> > > Our plan is to introduce a classification-based mechanism that assigns
> > > different freeze priorities according to process categories. For example,
> > > filesystem and graphics-related processes will be given higher default
> > > freeze priority, as they are critical in the freezing workflow. This
> > > classification approach helps target important processes more precisely.
> > > 
> > > However, this requires further testing and refinement before full
> > > deployment. We believe this incremental, category-based design will make the
> > > mechanism more effective and adaptable over time while keeping it
> > > manageable.
> > Unless there is a clear path for a more extendable interface then
> > introducing this one is a no-go. We do not want to grow different ways
> > to establish freezing policies.
> > 
> > But much more fundamentally. So far I haven't really seen any argument
> > why different priorities help with the underlying problem other than the
> > timing might be slightly different if you change the order of freezing.
> > This to me sounds like the proposed scheme mostly works around the
> > problem you are seeing and as such is not a really good candidate to be
> > merged as a long term solution. Not to mention with a user API that
> > needs to be maintained for ever.
> > 
> > So NAK from me on the interface.
> > 
> Thanks for the feedback. I understand your concern that changing the freezer
> priority order looks like working around the symptom rather than solving the
> root cause.
> 
> Since the last discussion, we have analyzed the D-state processes further
> and identified that the long wait time is caused by jbd2_log_wait_commit.
> This wait happens because user tasks call into this function during
> fsync/fdatasync and it can take tens of milliseconds to complete. When this
> coincides with the freezer operation, the tasks are stuck in D state and
> retried multiple times, increasing the total freeze time.
> 
> Although we know that jbd2 is a freezable kernel thread, we are exploring
> whether freezing it earlier — or freezing certain key processes first —
> could reduce this contention and improve freeze completion time.
> 
> 
> > > > I believe it would be more useful to find sources of those freezer
> > > > blockers and try to address those. Making more blocked tasks
> > > > __set_task_frozen compatible sounds like a general improvement in
> > > > itself.
> > > we have already identified some causes of D-state tasks, many of which are
> > > related to the filesystem. On some systems, certain processes frequently
> > > execute ext4_sync_file, and under contention this can lead to D-state tasks.
> > Please work with maintainers of those subsystems to find proper
> > solutions.
> 
> We’ve pulled in the jbd2 maintainer to get feedback on whether changing the
> freeze ordering for jbd2 is safe or if there’s a better approach to avoid
> the repeated retries caused by this wait.
> 

