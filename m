Return-Path: <linux-fsdevel+bounces-22516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C45918386
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8928F1F215D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8B185E70;
	Wed, 26 Jun 2024 13:58:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE841850B8;
	Wed, 26 Jun 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410295; cv=none; b=YnBwYUEwG5l0BGWCWjEqoMb7YmbAt2x1vHZD/EQcdBKJMGujFJ2I01AtZo6/VRUvIsjwT6N724gSjQ/tWTvJeZ2jYgkHuiNt3XTMbiPx8ci+yvjIvB4K05aViKWm2Vq5Ddwf5Jza6bCwOq8dAlr3lyEbtcRv6hyAkWLw+VqTk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410295; c=relaxed/simple;
	bh=gBr8PCzn+D3ELiMEpL79fGfTNAj+Hb36Tf9km+5Pfr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKpOofSG8kij8Z+/kYAY+QN1y2oMPqASyWltCcLoDUJxpXUGt/TAV5aHqlB9hVCdvPYbQiWSc+/aTwqx7QOmZGLVCISIwCKz7xbvhGK2Ta6OnyStHnf+pDmarFnnEyj9y6KJb+qTEfruc8g1ic8j7PRt0qxS2I81vzRTA7npFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB36EC116B1;
	Wed, 26 Jun 2024 13:58:13 +0000 (UTC)
Date: Wed, 26 Jun 2024 09:58:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Takaya Saeki <takayas@chromium.org>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa
 <uekawa@chromium.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
Message-ID: <20240626095812.2c5ffb72@rorschach.local.home>
In-Reply-To: <20240626213157.e2d1b916bcb28d97620043d1@kernel.org>
References: <20240620161903.3176859-1-takayas@chromium.org>
	<20240626213157.e2d1b916bcb28d97620043d1@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 21:31:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 20 Jun 2024 16:19:03 +0000
> Takaya Saeki <takayas@chromium.org> wrote:
> 
> > To allow precise tracking of page caches accessed, add new tracepoints
> > that trigger when a process actually accesses them.
> > 
> > The ureadahead program used by ChromeOS traces the disk access of
> > programs as they start up at boot up. It uses mincore(2) or the
> > 'mm_filemap_add_to_page_cache' trace event to accomplish this. It stores
> > this information in a "pack" file and on subsequent boots, it will read
> > the pack file and call readahead(2) on the information so that disk
> > storage can be loaded into RAM before the applications actually need it.
> > 
> > A problem we see is that due to the kernel's readahead algorithm that
> > can aggressively pull in more data than needed (to try and accomplish
> > the same goal) and this data is also recorded. The end result is that
> > the pack file contains a lot of pages on disk that are never actually
> > used. Calling readahead(2) on these unused pages can slow down the
> > system boot up times.
> > 
> > To solve this, add 3 new trace events, get_pages, map_pages, and fault.
> > These will be used to trace the pages are not only pulled in from disk,
> > but are actually used by the application. Only those pages will be
> > stored in the pack file, and this helps out the performance of boot up.
> > 
> > With the combination of these 3 new trace events and
> > mm_filemap_add_to_page_cache, we observed a reduction in the pack file
> > by 7.3% - 20% on ChromeOS varying by device.
> >   
> 
> This looks good to me from the trace-event point of view.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I added my reviewed-by on the last patch, you could have added it on
this one as it didn't change as much. But anyway, here it is again:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

