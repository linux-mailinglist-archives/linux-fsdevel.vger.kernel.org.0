Return-Path: <linux-fsdevel+bounces-48635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EF6AB1A28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528E5167DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F581235BEE;
	Fri,  9 May 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfwFHQ75"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A518DF8D;
	Fri,  9 May 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807180; cv=none; b=WqVmGmtd75eM29hDCO40mLx2BY7KguyD8EzqP0ScZIXrao/UzQCIF2MyHly/wm61CY+g6joYOFV4tqjPqrvYt4rYhDUN3hamqbwudgvq1gGRZVcwYUHyYo4r4AYSMFYusQH2Qw1Wj2whM7yKRUN1xQ1dU65KBFNfbdFaoGA8ZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807180; c=relaxed/simple;
	bh=KvFVbBZKMEEzgkn+ju6i49wV/DSgXVrOXZUutqy3pcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYtqeInvJeqabOTJCgmYLHdBD/tC9qYWZYtmUzEJ+6Bb+jGv30xZWk2xXty/ED6SXjy94Vr0pDfMXPrIEedUqk3oRyNhXKkTzzicVq360vI6NpGNIjF8ZjBjVxpSuIkwJrWlyVacENHb8LSE9InLi7JD//NldvHXmPHq7kny4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfwFHQ75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A19DC4CEE4;
	Fri,  9 May 2025 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807179;
	bh=KvFVbBZKMEEzgkn+ju6i49wV/DSgXVrOXZUutqy3pcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfwFHQ7579tnAf+BucCg+rcQjbXUlAALdMDmVOLpkyb3eNinjFQpm9MQOsFZ3cBzn
	 dR9ZQuCeFkSv2mMDK8OaSY0e5O2sG1SbRiAKdNcZh0x0MKbD/KBWZKsSMtLoWhw2Wd
	 w2liSNawXm2C6YIEW5MVcDQR4ErSBw4TKZeqA2Y/S+dR85yHXvvWwpLPr/5qlb6cG5
	 P/WzUrmIttHGCSHGU/LhJE/szVJNrvqCF6b8614XIUMHYiXW5+T5KP5cwo9XQQqujO
	 nKZmIiCsiqjtdrqQLnWZ4ESxzVbSv595Ez5OByvAJRY8+rm9Vrm9bTuT4GyEuDN5hW
	 N5QHBOsyBxatw==
Date: Fri, 9 May 2025 09:12:57 -0700
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
Subject: Re: [PATCH 08/12] sysctl: Move tainted ctl_table into kernel/panic.c
Message-ID: <aB4piT844_bxd9eq@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-8-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-8-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:12PM +0200, Joel Granados wrote:
> Move the ctl_table with the "tainted" proc_name into kernel/panic.c.
> With it moves the proc_tainted helper function.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

