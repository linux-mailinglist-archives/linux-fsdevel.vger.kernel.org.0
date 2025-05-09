Return-Path: <linux-fsdevel+bounces-48633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AF7AB1A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4DF1C4518F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB9236435;
	Fri,  9 May 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af0B5VQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AD2356C0;
	Fri,  9 May 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807087; cv=none; b=GlF1HtPO0SIUKIPVBNyy9zRPAU8/TyBH8wInFR7U0IexKIzJm0x8yj3h/Mq+HyTpXpohjlUJOQnPwRm5Z92zzP8xsMebdfRG+emovVI/icTTddPYDMqv6RMVRQln7eKAmEwBL4Bii6O2+yr5aqtOYsElMa7gZPD7lXzUQHxehws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807087; c=relaxed/simple;
	bh=qFAmpRBipwPI762xkvJQ+WGWMAV3O9aNq/+nZjbf4jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUhrnWq9j1A6R3E1QGZC1JUjYigF/LUPmH9R9YjDtKAkppqpOT7zufTYtYQ1q6EbRTXreI4mhTJ6X5PejTX9yM/dJGDw7D+t/RGdCt79q076fXvX7QOYao0nDxngeoDY/zjBWUI6qm1RxoJn8jz/UfVJ1LbTSTRDxOeuUFBikko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af0B5VQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDF5C4CEE4;
	Fri,  9 May 2025 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807086;
	bh=qFAmpRBipwPI762xkvJQ+WGWMAV3O9aNq/+nZjbf4jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=af0B5VQyI5ZKeq9eukqrxympxNkc5AzsQSmd6IKR/FqeMYyIcnFQjGrqPPYiSwjiI
	 w0WpgmBmPUsrkz7YSrnaH9XivhYPF4yp0PhSbGtmpzD6MoiokCgWGeIzDUw9xUBytD
	 TR9OZMRnxLmsrDNAr9ujHiU9/nk+wYm75vociC/SLnTbsBM7NI7dolnVdBiBTInd2o
	 0Qv0OQH7AOLzfNtwQyDd24MsU/0nx4pEwa+MWaQmMmBhgPhH3g+bsLhQLHFYWCY6B8
	 e11wrI05s821S2/G/x+S2Y8GJlDh/mveK7gKaVzWA2EwBo6+VJawWsMoBJFOP1K56h
	 bb3l2B2RpnzEw==
Date: Fri, 9 May 2025 09:11:24 -0700
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
Subject: Re: [PATCH 11/12] sysctl: Remove (very) old file changelog
Message-ID: <aB4pLLZqv3rTbb3z@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-11-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-11-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:15PM +0200, Joel Granados wrote:
> These comments are older than 2003 and therefore do not bare any
> relevance on the current state of the sysctl.c file. Remove them as they
> confuse more than clarify.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

