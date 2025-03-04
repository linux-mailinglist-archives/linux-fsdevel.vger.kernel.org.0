Return-Path: <linux-fsdevel+bounces-43120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D2A4E4FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000A319C2EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD12980AB;
	Tue,  4 Mar 2025 15:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B5290BD0;
	Tue,  4 Mar 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102744; cv=none; b=W2o66X9rdfXoPNxeQhC+te00w+kwKzZxk3/rc5o7M3AqU6MmAKXlYojRdA3FKF7jsE0hcylMAoBh2GKgIFGOOK6NiQgFg37kfH32st10AdQBp87+YBm3RPHpCNI1TWsQOvVbinoy8qrGEE3pnXfqcVbC9V8Fx61WRJVpetem/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102744; c=relaxed/simple;
	bh=6HgwrSjLCzomZbkJhXnmgrDy7Sm9jKUjliKEcXcaDyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0wHaWlg9L3gGzxQry8qHBfWyZ5Ip3v/Mtz53uC7MTnB4UmI6bHYq15bLSgrLN7qqptQ7WJ9GtrwhJzzeynrLzXY7NTy93U7j6uSK1YYCImnsDWme7cNZWkB+A3gSUDz0O/QEiljwgzHBvGCQJmTY9OfyG5JI4AcFRk8WpEPJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0796C4CEE7;
	Tue,  4 Mar 2025 15:39:02 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:39:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: tj@kernel.org, jack@suse.cz, brauner@kernel.org, willy@infradead.org,
 akpm@linux-foundation.org, mhiramat@kernel.org, ast@kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] writeback: Let trace_balance_dirty_pages() take
 struct dtc as parameter
Message-ID: <20250304103957.08c79da0@gandalf.local.home>
In-Reply-To: <20250304110318.159567-2-yizhou.tang@shopee.com>
References: <20250304110318.159567-1-yizhou.tang@shopee.com>
	<20250304110318.159567-2-yizhou.tang@shopee.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 19:03:16 +0800
Tang Yizhou <yizhou.tang@shopee.com> wrote:

> @@ -664,16 +660,16 @@ TRACE_EVENT(balance_dirty_pages,
>  	),
>  
>  	TP_fast_assign(
> -		unsigned long freerun = (thresh + bg_thresh) / 2;
> +		unsigned long freerun = (dtc->thresh + dtc->bg_thresh) / 2;
>  		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
>  
>  		__entry->limit		= global_wb_domain.dirty_limit;
>  		__entry->setpoint	= (global_wb_domain.dirty_limit +
>  						freerun) / 2;
> -		__entry->dirty		= dirty;
> +		__entry->dirty		= dtc->dirty;
>  		__entry->bdi_setpoint	= __entry->setpoint *
> -						bdi_thresh / (thresh + 1);
> -		__entry->bdi_dirty	= bdi_dirty;
> +						dtc->wb_thresh / (dtc->thresh + 1);
> +		__entry->bdi_dirty	= dtc->wb_dirty;
>  		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
>  		__entry->task_ratelimit	= KBps(task_ratelimit);
>  		__entry->dirtied	= dirtied;

I don't know how much of a fast path these tracepoints are in, but instead
of doing the divisions above, why not just save the values in the ring
buffer, and do the divisions in the TP_printk() section, which is done when
the user reads it and not when the code is executing?

-- Steve

