Return-Path: <linux-fsdevel+bounces-48640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA8AB1A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE691898AFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7FF1EEF9;
	Fri,  9 May 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPNwRUP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599502356B0;
	Fri,  9 May 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807447; cv=none; b=LF0/xsYK/dIBmOFQMoQt3TCOe1PsmLuoGaTnJcSIbOKGLMz9xi8wGttV3oRXmsdaPNAFxJnZ2L55ltAw8qUtzTGRCWH8y7huHBK9eL3oX+Vf1RyLWKtEzhpjfIMJVe1g00kPT9aVE5v6eLXobUo7KhpB/dmU7cszm8jPRxRGQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807447; c=relaxed/simple;
	bh=JvmifVntTROuG4HNctyOU2SJlSH36OpMWY3roz323xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL8LBmLa+bWrmDRq7VrcRaBIPUmelfiI26YttfDGhaDaLNrYkCN7tTHCegbmHot8UOpOwhRtoISWHGPJ+8aGHgzFie2PeU2DgmZttE8gawsznWCG35xsaBqo9zWBgenUS40NP1CRfF7qmhlBKy+XRmM5cRzXudYYREDU5lntW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPNwRUP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06512C4CEE4;
	Fri,  9 May 2025 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807446;
	bh=JvmifVntTROuG4HNctyOU2SJlSH36OpMWY3roz323xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPNwRUP2MGA2UIlCItZX/6casE8468VMUCJPL6CJfpyiag7b/hUtikz7wMYy/Y2ig
	 Xc2anaQJ/fLONYqf+Fsx27Ww8EVQCMLdG8m6FwLEcTl6HbSrhZqSn4/N1mpT4aEVnl
	 PQeVDxJPeVlznU5tjEDBFw1gk7IKdnGKSRAs7hOR3KDIuoSfpQuZrZAyGG2Ec0Chn3
	 LPIiiak9oaaIlbupCSlvXwQBxEtLx/IKfsPpxLQwikS0OJDpgqWbPpfCTSNa7sCovd
	 KIs3ogp8/+GrCJDvwrwTZKjwDKmg/8uGpPS/PdVqLdOFb8c35MMOlmlZfDiosBHyDv
	 nSI9+9Hv/rxlw==
Date: Fri, 9 May 2025 09:17:24 -0700
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
Subject: Re: [PATCH 03/12] rcu: Move rcu_stall related sysctls into
 rcu/tree_stall.h
Message-ID: <aB4qlJ7EKu-XjIO3@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-3-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-3-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:07PM +0200, Joel Granados wrote:
> Move sysctl_panic_on_rcu_stall and sysctl_max_rcu_stall_to_panic into
> the kernel/rcu subdirectory. Make these static in tree_stall.h and
> removed them as extern from panic.h as their scope is now confined into
> one file.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis

