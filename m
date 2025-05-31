Return-Path: <linux-fsdevel+bounces-50253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D843AAC99D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 09:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66334A0238
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BC235354;
	Sat, 31 May 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqnCQjCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB2EED7;
	Sat, 31 May 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748675810; cv=none; b=tGc7k4bwiFOxJvNqW0bvfEF0t4NW6OUHXh7TlLBYuTDjU50EmPpRDQ7Wgq+c/bunBphYXciyU+6vmo7sXGZHyFuj/wwri8LkKDarjrXd5o761POn0y+fbatKniMAGuyrYtihqkkN7lXvBeFdBQJlySRreErYya55ZGzTwxCKke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748675810; c=relaxed/simple;
	bh=zYe1+sXdqUMmr98YnXHwFBRq+aXOFiQG6wruVnbdSlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPS/tS4GqpWgRQY2y4u147ScQHBBt6NCg/IXkVpwsE+6VHhM0phBHKWNuwDFuAgyd/1nbkzaNGeIS3t0iLV82EuQXv3jv7hDV5XvcYXuIvhc0JSPOm8NGX0BGUJtXSrJlNl7hOT1OPDTHhsb77vryTQaQpSrhk7WpPLVRNoyPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqnCQjCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95955C4CEE3;
	Sat, 31 May 2025 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748675809;
	bh=zYe1+sXdqUMmr98YnXHwFBRq+aXOFiQG6wruVnbdSlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqnCQjCiCD2PbdPMeu84qfvj3Nx7yg7/rzrJ2htLvMM+rP8AmTcuFww7uFsPlBgb6
	 5BxKRXheiIHLHM8HR27gVsdgqIhowEPm2lDDSt8sGqBtixIkypSI/iLBIu89/MuvXV
	 Mkyc0eQhfUkyLpRFEWir3/XVPEGCuDKPWaC1/5kJIW7HIE3YyRWt6FWIlFT595E/DZ
	 Od8df52QJx0jo/LUPW2H1bJELKIDCwk+WRLadZBn/p16U8yvyjsGvuQJH3ePnn6MAG
	 5WZzuVvFtAjIgkW59InOd959UEMCxUuSC5FH/5MRtYIt9cyWd0L8SyxKHtlPekWcr+
	 eFtvjLAdNQXAg==
Date: Sat, 31 May 2025 09:16:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Bo Li <libo.gcs85@bytedance.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
	kees@kernel.org, akpm@linux-foundation.org, david@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	peterz@infradead.org, dietmar.eggemann@arm.com, hpa@zytor.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	jannh@google.com, pfalcato@suse.de, riel@surriel.com,
	harry.yoo@oracle.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com, dengliang.1214@bytedance.com,
	xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com, yuanzhu@bytedance.com,
	chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
Message-ID: <aDqs0_c_vq96EWW6@gmail.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>


* Bo Li <libo.gcs85@bytedance.com> wrote:

> # Performance
> 
> To quantify the performance improvements driven by RPAL, we measured 
> latency both before and after its deployment. Experiments were 
> conducted on a server equipped with two Intel(R) Xeon(R) Platinum 
> 8336C CPUs (2.30 GHz) and 1 TB of memory. Latency was defined as the 
> duration from when the client thread initiates a message to when the 
> server thread is invoked and receives it.
> 
> During testing, the client transmitted 1 million 32-byte messages, and we
> computed the per-message average latency. The results are as follows:
> 
> *****************
> Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
>  Message count: 1000000, Average latency: 19616 cycles
> With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
>  Message count: 1000000, Average latency: 1703 cycles
> *****************
> 
> These results confirm that RPAL delivers substantial latency 
> improvements over the current epoll implementation—achieving a 
> 17,913-cycle reduction (an ~91.3% improvement) for 32-byte messages.

No, these results do not necessarily confirm that.

19,616 cycles per message on a vanilla kernel on a 2.3 GHz CPU suggests 
a messaging performance of 117k messages/second or 8.5 usecs/message, 
which is *way* beyond typical kernel interprocess communication 
latencies on comparable CPUs:

  root@localhost:~# taskset 1 perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 2.790 [sec]

       2.790614 usecs/op
         358344 ops/sec

And my 2.8 usecs result was from a kernel running inside a KVM sandbox 
...

( I used 'taskset' to bind the benchmark to a single CPU, to remove any 
  inter-CPU migration noise from the measurement. )

The scheduler parts of your series simply try to remove much of 
scheduler and context switching functionality to create a special 
fast-path with no FPU context switching and TLB flushing AFAICS, for 
the purposes of message latency benchmarking in essence, and you then 
compare it against the full scheduling and MM context switching costs 
of full-blown Linux processes.

I'm not convinced, at all, that this many changes are required to speed 
up the usecase you are trying to optimize:

  >  61 files changed, 9710 insertions(+), 4 deletions(-)

Nor am I convinced that 9,700 lines of *new* code of a parallel 
facility are needed, crudely wrapped in 1970s technology (#ifdefs), 
instead of optimizing/improving facilities we already have...

So NAK for the scheduler bits, until proven otherwise (and presented in 
a clean fashion, which the current series is very far from).

I'll be the first one to acknowledge that our process and MM context 
switching overhead is too high and could be improved, and I have no 
objections against the general goal of improving Linux inter-process 
messaging performance either, I only NAK this particular 
implementation/approach.

Thanks,

	Ingo

