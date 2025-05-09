Return-Path: <linux-fsdevel+bounces-48637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD17AB1A47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353031C6033B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87550235BF4;
	Fri,  9 May 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdYlK9AE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC50021ABDB;
	Fri,  9 May 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807299; cv=none; b=uW6WuDrrsh+MD2QpdxjqS4tolC2uCzwN+XAeaeorTHm7M1DerXA+/ltKHjGYWEEDlSWqvkCydspuRSVWTRhL8II2Sg8UEEZjNDWNpjKjqr5zXKGu17nS02NriNgvNqVuozGYhsLry9sf1k46iCaSXmf4dXsLSyskSbSIRTMD4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807299; c=relaxed/simple;
	bh=qfGfA/lDYVUq9cNM/Ap9jQkrniTOHGXmbD9TLuuU7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftkd7CSJcmqgrx1h/F68oO2U3RyJZ/+5vDHzvMhnOQA9Ac9fVlB9oC5jaF2QWBT7gVRQ627JaFOF/xgQYTrI+xXNS/gpWRagrFRmVIdnK5bN1p3lbPldpbJaOe6FueDfaqSZ97hUDwAh8D3sZPdHagI4z6/yaSU4BqZgQjxUpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdYlK9AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE3DC4CEE4;
	Fri,  9 May 2025 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807299;
	bh=qfGfA/lDYVUq9cNM/Ap9jQkrniTOHGXmbD9TLuuU7Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdYlK9AE99gS56xVvhOU7ONt2nkIOGIMqdB9kTlHA3NIs6oeGubEYqedbnZyI6y2y
	 5kbil/ar47mJgy1Langth3DgdDGoxZT5ppDbFgl1lOc7a9jGXY0wbv91g6ruWgvOVB
	 ZtnuPE9++KsxuckqLQLFogzCJEd6TB4rEc1WqGHHn20kls4UHTyot+8Qd/tyj4Kp++
	 7/aA2vUqLqSSGMHRzjbaFgWkLoGdHY0sbzQ+MAaHK4EVuhpetkg79tcXCF/YfVHzPj
	 mhpNtKZuLL6kLf0jZfE+jAw3NCwMg9R6QL4bZVGgW2eqy/LLcbLNkl5l/Q7nS0SgrF
	 CIIaHPj4MP6Pw==
Date: Fri, 9 May 2025 09:14:56 -0700
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
Subject: Re: [PATCH 06/12] fork: mv threads-max into kernel/fork.c
Message-ID: <aB4qAMaSedFvUXlp@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-6-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-6-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:10PM +0200, Joel Granados wrote:
> make sysctl_max_threads static as it no longer needs to be exported into
> sysctl.c.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis

