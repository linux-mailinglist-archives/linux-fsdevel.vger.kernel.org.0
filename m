Return-Path: <linux-fsdevel+bounces-48411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E5AAE7B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 19:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725D97BCECE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD028C5D1;
	Wed,  7 May 2025 17:22:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017561C84CD;
	Wed,  7 May 2025 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638577; cv=none; b=bP5RkfdOB0fqUP7mmGarvXAMT7oa/GgnucADeGpK+rYGhY/NG1NE4qt238mJJBpE8FDHxK+ILkWwWAe5lao1y4IVY2PlDqFgIUujn/NvhFR6hwGaMMTAMeZy9tqRQ2Z1eLnau+XmV6peA0z2xfTc6sEByl8x9uDlpd53bRpWgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638577; c=relaxed/simple;
	bh=HDKb7V+WEAJmo+d8rM98LMTW0jk6VzUQLJc9CgRtF5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MI59bPT48AKUVCZhPvb+BDZxH/eUnd2E+SZdz2jegD3EFtcF3gfyCJtQ2VXgyGE2Zeiz8WMe5duMO8MRPNG66LqBwdDL5I2P2Wi9JAEqhGhcbP23PWuEjMCkf4iH2DQTUmcePY6TWRmAlf12LF+7NAvMBVPNforuGwBaBSXD0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFB3C4CEE2;
	Wed,  7 May 2025 17:22:52 +0000 (UTC)
Date: Wed, 7 May 2025 13:23:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Message-ID: <20250507132302.4aed1cf0@gandalf.local.home>
In-Reply-To: <aBtYDGOAVbLHeTHF@pathway.suse.cz>
References: <20250507110444.963779-1-bhupesh@igalia.com>
	<20250507110444.963779-4-bhupesh@igalia.com>
	<aBtYDGOAVbLHeTHF@pathway.suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 14:54:36 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > To fix the same, Linus suggested in [1] that we can add the
> > following union inside 'task_struct':
> >        union {
> >                char    comm[TASK_COMM_LEN];
> >                char    real_comm[REAL_TASK_COMM_LEN];
> >        };  
> 
> Nit: IMHO, the prefix "real_" is misleading. The buffer size is still
>       limited and the name might be shrinked. I would suggest

Agreed.

>       something like:
> 
> 	char    comm_ext[TASK_COMM_EXT_LEN];
> or
> 	char    comm_64[TASK_COMM_64_LEN]

I prefer "comm_ext" as I don't think we want to hard code the actual size.
Who knows, in the future we may extend it again!

-- Steve

