Return-Path: <linux-fsdevel+bounces-48659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE3AB1CD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24437ACE22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31492417FA;
	Fri,  9 May 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b11OPmzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C272417DE;
	Fri,  9 May 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817215; cv=none; b=NIAfZA3v/tld8+dkj6FI7ekfUhZuhliNl66PJ953OnVgbWyR/LtewZdIbKPLw9abWOaYgTcDZQ65veE3xQkY0qW16V1rn9SL6ccJmAHG6dB5HrSzmsLNluJN2ar2+Hh72+mbs0yYhPs1uRQD20qf0rspzxg2tKCBdfPUu+Vwxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817215; c=relaxed/simple;
	bh=+34HNPEUj+p5uVPbJVtQH6X/OyK2KbD04zwbGTKrMJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlfAhRZBodF+4jYwERZ0ICwZIi+EX5nMVGAvUiTfI/NJyRzzJZv82v2U7MZ3qptqMUYXde5g8u0ec443t2kOUVicfg0uu/JfjybKG8t9berj+rEUiGq8wLAavFE4cqTywpz96ZlXCMAqA+VY7Dxro2K8dFdJl4fT8D6myrccz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b11OPmzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541BDC4CEE4;
	Fri,  9 May 2025 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817214;
	bh=+34HNPEUj+p5uVPbJVtQH6X/OyK2KbD04zwbGTKrMJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b11OPmzKdUzVTGgQSAh6M0bVyEdjiG1qUs49izPnBDGpFqvktevOyQNAuloaSPyVA
	 73sX2u5QtCHM7x3aIwQWqFlcT2oQMnSNVWBxymLOFWreEF+HNQSWfUmfoWrKLqrqux
	 R7LbGvpx8NvPD0idmU85xolZ2w7J6M4N1dWSRAVsJhM54+iadih/vRo0vQn/EaDduS
	 226ADQATxQUtOPOPdiSjb350tnu61idQaV9rDctF1tndjMyn96bkQnNYZktJ7R3cgs
	 O3GPuk+NYatdpOSwF4ztsL6sUavjhUOQE363YfunS7uH1FnBRMmbSvEeHuNCQNgrJx
	 I5tLTxIKxBDAA==
Date: Fri, 9 May 2025 12:00:11 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
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
Message-ID: <202505091200.34A24BF5C@keescook>
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

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

