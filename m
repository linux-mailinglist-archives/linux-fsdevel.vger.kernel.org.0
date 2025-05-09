Return-Path: <linux-fsdevel+bounces-48661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461CAAB1CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE6D173907
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52697241687;
	Fri,  9 May 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClZQMtxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DC238172;
	Fri,  9 May 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817319; cv=none; b=HzJ3Z86tOJS6ka57u+bMmckvhvB1Oh4J3gfNkDAam4BqSHh5rOp6n2V5JjO9U37JT3TfQ55crMFLrRG3xVVmSNA7Nyj3o6myNkJg2yBVlwGYv4/wWoI3eIrqSoXt6veCwvU3fad31azYJ+QAqSG6P5HkNE2cReFyNOubNmZGfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817319; c=relaxed/simple;
	bh=ibf7sm2Sj4nAOEQRinBYhKRXmV4AoyAwgkzUM/Lkp9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2Dndk5nVylxMBwCrNQBl2Xw8l3EAeCxP056zSN6sLI0945iGSnZTSrTHjx+hZkIrJS5FtvFewoWzO0GXassErwspT1LFLSXM6zO7vHYnOwAmkyxyrptJCRsGWLTt5oXjhC9IutZNuX6gNsWsGGJkadvh3KPjMlmExbheG9OpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClZQMtxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9675C4CEE4;
	Fri,  9 May 2025 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817319;
	bh=ibf7sm2Sj4nAOEQRinBYhKRXmV4AoyAwgkzUM/Lkp9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClZQMtxwANpCja0FT3VbE+VHTeLXumCgTUdNtr3pv6bpDntBBKqkLtFqu6ymW3mMH
	 RZjycN9fS+lfQxI2BgPPz8723lasnxL0nfFYhp7pVWqfD+RwVWwWVi3D9qNgXVJm2r
	 SdPfFlMOq/EaTrd2kH6cyCEKy/yeGvk0Y6/iH5syM6+h5qS9V1Ko6BBVSN2jiEIGPI
	 KAdGoyCHbHOs/BSOPbUG+C3f2suSc8SO9rG0GMXIpolZYj4YKmhPB7s85+DQatXrD2
	 Kq6QNbXkpYa3O/ISgQAs3gpZ897eAlmHtyEp7yMc+0LOagal70nfc8sf8pdsOU4s95
	 FiYMZUpQ2TOTA==
Date: Fri, 9 May 2025 12:01:55 -0700
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
Subject: Re: [PATCH 06/12] fork: mv threads-max into kernel/fork.c
Message-ID: <202505091201.3CD106D02E@keescook>
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

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

