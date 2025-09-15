Return-Path: <linux-fsdevel+bounces-61318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504B5B5790F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBD61A2214C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E151C3C11;
	Mon, 15 Sep 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfH8Xy+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A0301460;
	Mon, 15 Sep 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937036; cv=none; b=HHlUd1qg2ESLouU513ega11W7nUu3NghFSYHvJCIrtztCUh5klIdE14KXty2GIVdc5uQVwaROeddSmqyzyR9MhSBHxTwKQ9dC4VJyhYLZBDWPHQfxorHfqUxZFRKR0eXHUQ7tytN3oiw69LxSLYnfbSd+cD9DnW5VRoYQVDqstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937036; c=relaxed/simple;
	bh=2VaqIyuam4kU7DFcOCvZ8f8xGds0bPgQQzi/Q7t16Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRnmvg9XigksfAOlwUkYJE3pUz5FYc6Ju/aGkrhbqJXu5Mgypj4BxTpKSQhudliUcVM2iNP2d8yJZy2cloIDW1mxY9VE/MQtpCdP0YXjTdY9srvtlP6oZ34CoGA2Sziazrq5dsNGVjt3NxGahzUvkdp+nttHlRvS9Q13Pvz2GWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfH8Xy+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37414C4CEF1;
	Mon, 15 Sep 2025 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937036;
	bh=2VaqIyuam4kU7DFcOCvZ8f8xGds0bPgQQzi/Q7t16Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RfH8Xy+s50K7mIJDGFPMdzipV59x+5zApYhemQSS/j19xsKXzV4kTw9LCyzz6VECX
	 I/VGJVA7lsozChsyDUPoxh5u40RGuD0Wi7af/vbg/a02GlvUoCi7vfGXZFjipPwCfO
	 H6ws+8vo9YdXQ+ZJIUa/vtK7Hrd0fGQT02QdGsA+LwrKqIOGFEW/nfsF3aBruVosrC
	 rRICODksAO7m/OdijrBwVp0fGrwv8YFS5YPmTH3/p4MWV5oxfHr7OOQsPyPF/66NhC
	 MkG/g8KehJUgwq66+47URJyKydBgzEO+zvVyDAwytaZKfYruQckuLVyaUzjJjjvmnG
	 9JKWs5Pzbze9Q==
Date: Mon, 15 Sep 2025 13:50:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/3] fs: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-ID: <20250915-abgearbeitet-servolenkung-d0c60406b94e@brauner>
References: <20250905090214.102375-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905090214.102375-1-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 11:02:11AM +0200, Marco Crivellari wrote:
> Hi!
> 
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an isolated
> CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
> 
> This will be handled by __queue_work() that will queue the work item on the
> current local (isolated) CPU, while:
> 
>         schedule_delayed_work(, 1);
> 
> Will move the timer on an housekeeping CPU, and schedule the work there.
> 
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> === Plan and future plans ===
> 
> This patchset is the first stone on a refactoring needed in order to
> address the points aforementioned; it will have a positive impact also
> on the cpu isolation, in the long term, moving away percpu workqueue in
> favor to an unbound model.
> 
> These are the main steps:
> 1)  API refactoring (that this patch is introducing)
>     -   Make more clear and uniform the system wq names, both per-cpu and
>         unbound. This to avoid any possible confusion on what should be
>         used.
> 
>     -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
>         introduced in this patchset and used on all the callers that are not
>         currently using WQ_UNBOUND.
> 
>         WQ_UNBOUND will be removed in a future release cycle.
> 
>         Most users don't need to be per-cpu, because they don't have
>         locality requirements, because of that, a next future step will be
>         make "unbound" the default behavior.
> 
> 2)  Check who really needs to be per-cpu
>     -   Remove the WQ_PERCPU flag when is not strictly required.
> 
> 3)  Add a new API (prefer local cpu)
>     -   There are users that don't require a local execution, like mentioned
>         above; despite that, local execution yeld to performance gain.
> 
>         This new API will prefer the local execution, without requiring it.
> 
> === Introduced Changes by this series ===
> 
> 1) [P 1-2] Replace use of system_wq and system_unbound_wq
> 
>         system_wq is a per-CPU workqueue, but his name is not clear.
>         system_unbound_wq is to be used when locality is not required.
> 
>         Because of that, system_wq has been renamed in system_percpu_wq, and
>         system_unbound_wq has been renamed in system_dfl_wq.
> 
> 2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users
> 
>         Every alloc_workqueue() caller should use one among WQ_PERCPU or
>         WQ_UNBOUND. This is actually enforced warning if both or none of them
>         are present at the same time.
> 
>         WQ_UNBOUND will be removed in a next release cycle.
> 
> === For Maintainers ===
> 
> There are prerequisites for this series, already merged in the master branch.
> The commits are:
> 
> 128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
> system_dfl_wq")
> 
> 930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")

What is this based on? This doesn't apply to any v6.17-rc* tag so I
can't merge it.

