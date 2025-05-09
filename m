Return-Path: <linux-fsdevel+bounces-48638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A9AB1A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8A4E3A47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF322367B8;
	Fri,  9 May 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3a9wvT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C421442F4;
	Fri,  9 May 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807341; cv=none; b=JlUE/qw8r9qqNsgY+OgTWTSApxeC0udnxE+TiXzCI31MA7+lns9gP2R6qnyojl0yER8J7J/SOKxTMMJF87e/3sNIRHvD6a3rhrd47oNZTHcEMVCM4m6B63AEQEpobStA1GC/3XG2jl+aDzhzGkxXBfq4jFu76/yeKN3ZT+hi57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807341; c=relaxed/simple;
	bh=XQbL8BmAFuosZaYmT/ElwQ5uw+SyRwdfAf6yqJgUZug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9WFyUoW0NQKbDI1e8xTHC63Q8KUOh6w0DSmnttmVeso64AaYuzcYTRdkbKQA8RTzaMvmWGgQzfSvzr73hFDZCNdWF0eWkUcIgmcA2V8xMp0uRt48Blac15uaP9nEbejbPftHBmmXXaAkD6CQN5Rg/nbdv0usHdccmn3c2nHvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3a9wvT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04945C4CEE4;
	Fri,  9 May 2025 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807340;
	bh=XQbL8BmAFuosZaYmT/ElwQ5uw+SyRwdfAf6yqJgUZug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3a9wvT5biurDKoNcBKnJlCuv01JpDOepyaSOAwd9lorRrm83pFmqxiLpmzPi9jM+
	 cqx9Oih5ueV7vDXlQjehSx0LA47eKhIYV13U/D8N9v6jY+vwsVE+rhoPZF5mtVxXbX
	 2UoGiOC4tNESt4sqPojj40mQpmXBcR/vyg8i7jsmjh9KZOSe9+El0Ky4KHSn/CYWM4
	 OJv1khMt/1hl9MduxJ67iGc+ACG26die+ipSEDXo1GA9A+kwaerWm1wyJw39hu9KEH
	 ytrdvYPjD5cEsoqgOmk0MMYlz44C602k8yr5JnqfmFOwz4GppwoDMB+3RNHSDjZHuR
	 AFIsZ2YR+jB1g==
Date: Fri, 9 May 2025 09:15:38 -0700
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
Subject: Re: [PATCH 05/12] parisc/power: Move soft-power into power.c
Message-ID: <aB4qKkDXoGs8EDkN@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-5-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-5-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:09PM +0200, Joel Granados wrote:
> Move the soft-power ctl table into parisc/power.c. As a consequence the
> pwrsw_enabled var is made static.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

