Return-Path: <linux-fsdevel+bounces-48636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CDAAB1A36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FF81B65EFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3B2367DA;
	Fri,  9 May 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg6v/O29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2522D4FD;
	Fri,  9 May 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807204; cv=none; b=nOR0xE8xuOSgEuyojFAVADzmATbN2cqDlZc3HlTlWSDogprZaur6v47WHYvS6/SdXdvtp6eyLre9iQfNUyhBzR+XyKwJxgA0AniNqRuo4DbbZ+1YN6kI20SN27ey3TLbm5I+BMilUITonbptUD4CygCmPjDyquGdaEs5rc5iCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807204; c=relaxed/simple;
	bh=90WLMcjZaIacrXRziNVygPsGLxcvNTB/TqZUVJKgH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjeX9QgXDZInVEhrZ4XH8fwi+8dK33MazgfMZh+sIDtlXA7ZUwSocQ4iFV+kIoV2RHo1stj+x2CRw0iy7x7cRXvepf9FNAvZar08Q+5vmCF0PoJyZJjODol+k5opaSlwMHaLN1g9vIwY3sY94aVWZbYLQQvmYh59f6okEXIu4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg6v/O29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839FEC4CEE4;
	Fri,  9 May 2025 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807204;
	bh=90WLMcjZaIacrXRziNVygPsGLxcvNTB/TqZUVJKgH44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hg6v/O29HMpNA5LynknPfbR7Jzd0aPeq7YIiIAiy9O+1kWoEUj/BwVOpNWfPshrTg
	 T3nj7Ca/OgY4Syrhu1SYrf9nyc1pgSVvImGTQ+zWRRbJqH1Ac0m88PeJUuhDl1MaPs
	 GO+td8v60SirbtsGf2FhP0aPU1TM8tnPm0FfzTGxYoud6oSYH6hGy0dq80OwUxIwLi
	 sybpdFa8W36A12ebvr2uBmItdXLoxwswAF3X2GBG4LItxeBA8AYDoHTgWVK3H/VQKJ
	 yAx8cL70zc3WY5MTmZfEQZTvkgrkSkaudQ7ksKsneuYfVydjegvFFlaqIa/zjUO4RM
	 RCghvCno/b1tw==
Date: Fri, 9 May 2025 09:13:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 09/12] sysctl: move cad_pid into kernel/pid.c
Message-ID: <aB4polMnZXRCqcDD@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-9-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-9-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:13PM +0200, Joel Granados wrote:
> Move cad_pid as well as supporting function proc_do_cad_pid into
> kernel/pic.c. Replaced call to __do_proc_dointvec with proc_dointvec
> inside proc_do_cad_pid which requires the copy of the ctl_table to
> handle the temp value.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

