Return-Path: <linux-fsdevel+bounces-48662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02973AB1CE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92D2A02963
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EDC2417C4;
	Fri,  9 May 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/HjSPQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3231C8620;
	Fri,  9 May 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817343; cv=none; b=PsC7SUZZ/0kWaobT9ohG7h8t5u3z6cmh+evy4YBYFKdECfzfgt+R33lgTMz8QyA9u2YXfUQuR7Nue4+UicNi/BjibHcSHwzGY+iWZSgfr4TI1lSNOtCnqchLyKmLV4SjaxZYtp3zqHfOqw8BKeElGQ8gWV+RV9xuH8r7gb5iON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817343; c=relaxed/simple;
	bh=AAqQgiJ5YARn3Bgiem3J1o5ZgVsulvdMecl0c+F9Tdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAcic3segwLMs2ovGdPLbu79dJ9/QayclL91YJnLYVWbkE1lZ9QCPDF0tBdU6HoEHUI8BZhoIu61d65zdyJ0x95txK6CAalmEQVU/KCtKzss1iadh5vvf00VocqAoRYHsosIPuTEENZud90BVy69N855E5sjZNlEqHExU3NoL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/HjSPQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B866C4CEE4;
	Fri,  9 May 2025 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817343;
	bh=AAqQgiJ5YARn3Bgiem3J1o5ZgVsulvdMecl0c+F9Tdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/HjSPQgnoxEKUQID2pJukbLl60SbHMRAhU8IBsrsGh9vA+lnZFpLC1cVrEvvVryJ
	 1fQryXCi8M+DFJcsVxXhFjAAok49447OCbJmjFkdcJxcfSWjzc92PKOiJCXCalltZm
	 7kRhkYCcR6OSaz9nUqvYW/RgF65mub/To91ccnFFq6kaqkAmeFReimJH1TdZbu06Cy
	 UVeqVyaN1PQWRwIsrJIsu+ptUQlhhDEu5UjLfP17UHV9jhyYPHKQD7gTYNQToL58ff
	 yaptIvK4Ic5Nqqh3GcEY+sKtuouf4WiWnF0dAiQR1GGFnsLrRTavLjjm1TR0czjMF1
	 L6PW/awiu14UA==
Date: Fri, 9 May 2025 12:02:19 -0700
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
Subject: Re: [PATCH 05/12] parisc/power: Move soft-power into power.c
Message-ID: <202505091202.411055FAEE@keescook>
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

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

