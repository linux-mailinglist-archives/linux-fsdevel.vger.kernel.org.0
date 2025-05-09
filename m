Return-Path: <linux-fsdevel+bounces-48639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E4AB1A53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AD51888C91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B842367DF;
	Fri,  9 May 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuKjVZbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B9235BF1;
	Fri,  9 May 2025 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807413; cv=none; b=m/koeOlRhnUGoNQP0Fp3369sPMmQCEJ/frBmh4l/7ZAul2gz3WOrligCQUoqvWbZgVWqwJoaJMzVer2vAv0sVhFHBIe27PaTN5kIAy+cDd1Q/mOi2eAcKK98oNyCVJ1NgQeDrz//PJ8s9xxmdQcJE72IG+viiX7qautGWb/4P9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807413; c=relaxed/simple;
	bh=9LQ7U1q484EMBGzcv2NLb3WZTde10mn4MnfvrW94KnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCmUVtgQZ8Mhq7Ijy88yQFv/XeznBgowKrxYF07erIVCRP4xMuXJWvlTtGseH4ZkwdWLXiPnrIfsir+tCZg1J0OFEuUO+lwcwm8k0o6QAFE8vGeJBvhNBIQAKOg/lsXzmOJk3yW7C3qCmUypTfFrkVZJNxkD3fUzpUtXk1ogD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuKjVZbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0EDC4CEE4;
	Fri,  9 May 2025 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807412;
	bh=9LQ7U1q484EMBGzcv2NLb3WZTde10mn4MnfvrW94KnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuKjVZbX3m+XkLcmmq4SMw/O6/AcM7cZmvVJNNInHmmG4amWUIEefBJ2vTCf9fMVh
	 EA14kx+EoQty/caFt2uvocikYqE2iddJOAbSOfYghvOzUfsuOUbpunu5sqvNKU7dQt
	 vjs3XFiaJMAMCRXRv54Ral5dkbC7r0ekW6r196GTUol0WaSf+lKNAa13I7zoxh7Iiq
	 XZvMx7WJZyNipq7abnxLWuAkzGFn5CZ3o1SIMA95HkXCG5se/r6kSNOOjciBKi6lSE
	 49XjDBgOQhM/8but/tkucCB36MVG+zKfUkH3QBFAMuibGgyitbJopW8NuEhNkA9b31
	 EIDAKh8qJ4i5A==
Date: Fri, 9 May 2025 09:16:50 -0700
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
Subject: Re: [PATCH 04/12] mm: move randomize_va_space into memory.c
Message-ID: <aB4qclsUbZVVs9xq@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-4-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-4-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:08PM +0200, Joel Granados wrote:
> Move the randomize_va_space variable together with all its sysctl table
> elements into memory.c. Register it to the "kernel" directory by
> adding it to the subsys initialization calls
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

