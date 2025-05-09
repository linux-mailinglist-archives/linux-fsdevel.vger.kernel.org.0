Return-Path: <linux-fsdevel+bounces-48657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF2AB1CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 20:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B59E18994FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20824166F;
	Fri,  9 May 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjILh/km"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E822D4CE;
	Fri,  9 May 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817028; cv=none; b=H64hN4bCxVr+rjS8Aksmyew7xPiXx+FR83Zo+4klE7NUJU2l50IqqIqbVTcChZmNaKqlQhfyoVwt6u9OeT64XmywYJ3T/1A+xTwtgYrS4gyXF+0QP2U1/RISxNs4HiuYZSMlbap09oTqyk99qzuvZDTeUuTmNj/DOGnjQBe+pS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817028; c=relaxed/simple;
	bh=SjHpOpwx7VyrcE5WAzxK32N8jab6WMrI+1mEBU3Cx7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+LGHtXEB4zJCU7Q735SEHB9QZkA6pDi5RG+Kjria1UIuKqNNMNo06UMa8gBF4dicdPYiKR7lxM2t8QyJoGibxTjxLmg/gIQ1kxofVrxVUtwZm/4CU3y/K9jJq1881XdVunFvwkbnDmSTS5iuaDBjoPSBKuMYU3aLBkhYkxZpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjILh/km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F37FC4CEE4;
	Fri,  9 May 2025 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817028;
	bh=SjHpOpwx7VyrcE5WAzxK32N8jab6WMrI+1mEBU3Cx7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjILh/kmOSAsGdXX7Cvu6QZJtz/h0H2DlAB6icZFwLQxiA2nRecwvOafoCJWu4isg
	 3vBNAms0uwlsRACoHcen5BH7RhTaSzXK8v+E/6lYasqteK/ZZOxuT3TKP3jPi+orKr
	 D0Z8RBtbz481POgg/KfZ57r9snOeyq+353+Y3G58CDSc9mmH5qNeCdiTBb8RbcBNop
	 QkALVfN6GfYEpBDhfotMt67cQePBO3tGP8efM/pbpGUCmIzxu8VxCuvy8dcVqxJyq7
	 8xwzxNGFIxKNMSVN6j4Sj47m/4ElVuipYI0AEb2HrNPNuLAF5R8xqB6WoQf/0OKjP/
	 DDscYq+1ZZCTA==
Date: Fri, 9 May 2025 11:57:05 -0700
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
Subject: Re: [PATCH 11/12] sysctl: Remove (very) old file changelog
Message-ID: <202505091157.2DF56988@keescook>
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

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

