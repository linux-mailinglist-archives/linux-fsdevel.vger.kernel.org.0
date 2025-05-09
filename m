Return-Path: <linux-fsdevel+bounces-48665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89030AB1CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A766B239AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E02417C8;
	Fri,  9 May 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEAki/RY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3321DE4D8;
	Fri,  9 May 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817405; cv=none; b=t5W8GPM6ys0b8Ax09VwcS2fUEox0tUDGFBl+Q7AVtNjvc9J6O9AsZpNpIZqxdKf2lMmPnqRl6E3Z/ehspxK5K1JgAH42uiJvrkXG1akO3Io6D+J10fea76k21ulxM4W3bpZl6W9UB8vaY06Y0yI/LnqnCEbBYmL9XySvwakQiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817405; c=relaxed/simple;
	bh=W2NoV5ZI3o86lBhRg03bG1iPC4hkJQ4zqlaLRujWNDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjFJ8IjcObrIAcKUb95GXc1oVzDgE2fgNP+3mQuo0PYe5K1mBb07H/eE++3ubdgj9G4+BE7IIu6FM5hCcwL1BVlPuVjju/AB0e/Ngx6gh96Eoe5iFU/6ZpWIEnv6gtY+olbVrLDxJohq0pcp0KJzDNch0rywulU5UvcCc3c2a+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEAki/RY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5475BC4CEE4;
	Fri,  9 May 2025 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817404;
	bh=W2NoV5ZI3o86lBhRg03bG1iPC4hkJQ4zqlaLRujWNDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEAki/RYkfHmL6+I3PQYm2xT1Dvips82K236jWpv9L41cN8DIFZJFOWqb8j0qDEGq
	 E+mDvMc+WK0Jlxfam5ajEooJ2ZLNR5lCMrqqYtVqsqfxPAjfXhlCavFDY45rOATzbt
	 gavWJeR77q3YSGyPTvsP9Bu9+aUsCgo1HOgJ1dEjG2uoYHyW2RgizC2QFKh+kTl4Nd
	 sZhebP7N9yXcYp4TghMBiessyIhGQZpCYzroZzdjmXTieUZBwOCTAMsDW+Xjed73Zs
	 y4KsaAXxQO9PhKrdDN257VGlJRNLSFkRXfZkdtnUlubtr6CAi4FQbnonvQRo6cceiy
	 o81T9qzsmkryg==
Date: Fri, 9 May 2025 12:03:21 -0700
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
Subject: Re: [PATCH 03/12] rcu: Move rcu_stall related sysctls into
 rcu/tree_stall.h
Message-ID: <202505091203.962B37BAF@keescook>
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

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

