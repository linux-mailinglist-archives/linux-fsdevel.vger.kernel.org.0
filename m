Return-Path: <linux-fsdevel+bounces-62402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7BB9164A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E665423D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CDB30C36A;
	Mon, 22 Sep 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvUtezjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660D308F3D;
	Mon, 22 Sep 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547658; cv=none; b=fA9JdbP9StYhW71DY8Dv8skQHKUq6DBhVq8y+HTdhc5TekrvH2dMuSwAPyMckadA8wCH4SsdPoV1sqoyAHesI/sMo20WsF6eQeg4xySim4Q4+2dZbSfd7p228MEuTSczj1dcwsauFkKuVv7FcvK75ISQg/VYWmSh9iPVHcZKw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547658; c=relaxed/simple;
	bh=iQB2tK5oYzwUb0lzFNB9gF3mWy0XefIMzKvfpWvOgFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB8AfXhF/pYaeAuM7AKymtHbgSwT0RXezLb37Q2K20fTeBoREHDRI97fS7tVh3jN8CgDnbg4pDJ1bdvO+VsfBerJVUm2Dy9NJpaNzmOO+Bt8nJAzz9ZgVpMYJF9Qo/aqi6CcLULkqxAjY+H83gaZ6acNFt5uHBVCxeimjFMJtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JvUtezjp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gXn0i45i0GYDvNjhiWGuOVxIDrx7s+sedk7SXIkVUzE=; b=JvUtezjpXOH71dwV5MTcx8BcpE
	W8+nsZtN0Y+tt8r/IxTGc5aaZygIsPO7ewbBOAEtgAJfhZC79vXIYibQKl+1Th7nbwckfxnkgyuxw
	caeP1ZJ2LukrZIUrcJZsJocH1FlLVSV+LEu0dw/QDEmX/wCLzdCwkzbYDdxLNPaQgz09XlcvAuzL+
	8nmXpiGxZewmrpzRZtZkuaK9rUSvfb04I5lnukfMHwihlNpdN6gIWGws5hXD+tYJopNwriNHOxGbK
	zNENcOiQQIXo4/EGkZPVOd+KK2tHaoEiIqSlGeYP5NLEsfYMv+20bA7Azf0MuNMtsSgtrhgbOf/u3
	455y7F3g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0gZb-00000008YFW-3dqC;
	Mon, 22 Sep 2025 13:27:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A73303001F0; Mon, 22 Sep 2025 15:27:18 +0200 (CEST)
Date: Mon, 22 Sep 2025 15:27:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, akpm@linux-foundation.org,
	lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <20250922132718.GB49638@noisy.programming.kicks-ass.net>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>

On Mon, Sep 22, 2025 at 05:41:43PM +0800, Julian Sun wrote:
> As suggested by Andrew Morton in [1], we need a general mechanism 
> that allows the hung task detector to ignore unnecessary hung 
> tasks. This patch set implements this functionality.
> 
> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
> which enable the hung task detector to ignore hung tasks caused by these
> wait events.
> 
> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
> teardown to eliminate the hung task warning.
> 
> Julian Sun (3):
>   sched: Introduce a new flag PF_DONT_HUNG.
>   writeback: Introduce wb_wait_for_completion_no_hung().
>   memcg: Don't trigger hung task when memcg is releasing.

This is all quite terrible. I'm not at all sure why a task that is
genuinely not making progress and isn't killable should not be reported.

