Return-Path: <linux-fsdevel+bounces-32692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB549ADC05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 08:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D22280EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8B189BBB;
	Thu, 24 Oct 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0MOEJToA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74117DFE4;
	Thu, 24 Oct 2024 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750843; cv=none; b=eJGy41AUNkCKJ7k/gG64biH97RFwSE6Kl20RfXUXG5gK4/ttG662LXIlgVqRfPlmAn/P4OyrX2GVo1CNKBqCUUpxrookz5QREkIafU2i7rkTy+b7+izMyBDUHoI0COGwmJLcuNFdw5k8kq4ferus4A/MV9jk+qEUsxm2Qf4fhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750843; c=relaxed/simple;
	bh=WW9PgPsnqcDzIffnfJD1Py5dy0Ccv98TUzLrTwmO1qA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qoz/pcCjnZRaz7ytlfmPpNuatd1aqsagqfWU9oB7DSdowBFo6OPlmkPpG/ZqxOeyLL7iCblJW7OK7PZzH55n14JpEys5aALadHtk/fscG5gettc6zCpTE0FWB+0AoLsCDXoyrs85B73kpTPq5sHGx8mvuLFjPIvhfhNWodqYpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0MOEJToA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8C4C4CEC7;
	Thu, 24 Oct 2024 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729750843;
	bh=WW9PgPsnqcDzIffnfJD1Py5dy0Ccv98TUzLrTwmO1qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0MOEJToANGliD0YolmgJcJXC9yn+OX9C/FndXOYO7mTiIoQTB8k6jiGeOhn5CIGHM
	 FFarEC4V3U7At5iYGLHNvtodV0GLNTCmn+AFJ6Hpc4P+u3wOU5m7Za7w32ZhVVoQVW
	 iCIDrMl1/z7WPHj3Fl6l1Eqta58dDmxqPpH2DxRk=
Date: Wed, 23 Oct 2024 23:20:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-Id: <20241023232042.f9373f9f826ceae2a4f4da35@linux-foundation.org>
In-Reply-To: <20241024060954.443574-1-jimzhao.ai@gmail.com>
References: <20241023162447.2bf480b4ce590fdeb8b6c52d@linux-foundation.org>
	<20241024060954.443574-1-jimzhao.ai@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 14:09:54 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:

> > On Wed, 23 Oct 2024 18:00:32 +0800 Jim Zhao <jimzhao.ai@gmail.com> wrote:
> 
> > > With the strictlimit flag, wb_thresh acts as a hard limit in
> > > balance_dirty_pages() and wb_position_ratio(). When device write
> > > operations are inactive, wb_thresh can drop to 0, causing writes to
> > > be blocked. The issue occasionally occurs in fuse fs, particularly
> > > with network backends, the write thread is blocked frequently during
> > > a period. To address it, this patch raises the minimum wb_thresh to a
> > > controllable level, similar to the non-strictlimit case.
> 
> > Please tell us more about the userspace-visible effects of this.  It
> > *sounds* like a serious (but occasional) problem, but that is unclear.
> 
> > And, very much relatedly, do you feel this fix is needed in earlier
> > (-stable) kernels?
> 
> The problem exists in two scenarios:
> 1. FUSE Write Transition from Inactive to Active
> 
> sometimes, active writes require several pauses to ramp up to the appropriate wb_thresh.
> As shown in the trace below, both bdi_setpoint and task_ratelimit are 0, means wb_thresh is 0. 
> The dd process pauses multiple times before reaching a normal state.
> 
> dd-1206590 [003] .... 62988.324049: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259360 dirty=454 bdi_setpoint=0 bdi_dirty=32 dirty_ratelimit=18716 task_ratelimit=0 dirtied=32 dirtied_pause=32 paused=0 pause=4 period=4 think=0 cgroup_ino=1
> dd-1206590 [003] .... 62988.332063: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259453 dirty=454 bdi_setpoint=0 bdi_dirty=33 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> dd-1206590 [003] .... 62988.340064: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259526 dirty=454 bdi_setpoint=0 bdi_dirty=34 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> dd-1206590 [003] .... 62988.348061: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259531 dirty=489 bdi_setpoint=0 bdi_dirty=35 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> dd-1206590 [003] .... 62988.356063: balance_dirty_pages: bdi 0:51: limit=295073 setpoint=259531 dirty=490 bdi_setpoint=0 bdi_dirty=36 dirty_ratelimit=18716 task_ratelimit=0 dirtied=1 dirtied_pause=0 paused=0 pause=4 period=4 think=4 cgroup_ino=1
> ...
> 
> 2. FUSE with Unstable Network Backends and Occasional Writes
> Not easy to reproduce, but when it occurs in this scenario, 
> it causes the write thread to experience more pauses and longer durations.

Thanks, but it's still unclear how this impacts our users.  How lenghty
are these pauses?


