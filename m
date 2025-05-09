Return-Path: <linux-fsdevel+bounces-48620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83733AB17B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E31A3B01CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E5231851;
	Fri,  9 May 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0hUZ5Ed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080321ABC9;
	Fri,  9 May 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802181; cv=none; b=sb7vsT7eVIKS4GGToi6ecIBeuMvudfpM0gTYKzsLfGhNkTC5CLbI7u5d5bCRw3fU1kxIQU9lLl8AL4DSDz55svcGrgsJkdjSdIYiXW9ueEeinODR0K7HSNqfa8SfIJsTikYzd6iSChd3kCfoDZUFx5lpBNdZYS3WOMQruwlJyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802181; c=relaxed/simple;
	bh=gGdOF/gEQWgew/HXHrjutcqpvcvaJtkPg4JwuG5uiak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfdgeg+GQG68RmaNmG3c+5t9a95HIKjtk3zF3qzbNep4Zh5EVbf+KebxfxJXVBPl/WVna+jGKumZ2MKATCjes0jeSdmdJWdirUiFPa/a0Nn90H6YI1lNNDMxB8sH2zYYNUr+hMzBhWj+rd98iUu4YjnW3ZNszmo+/xEwAXc2WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0hUZ5Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65305C4CEE4;
	Fri,  9 May 2025 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746802180;
	bh=gGdOF/gEQWgew/HXHrjutcqpvcvaJtkPg4JwuG5uiak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0hUZ5EdSyLDJCBhJ5SNSc14A9+lLvOpmSPKdzfb0KuJsAQUzl5nNxTc5MID5/aDN
	 MO68D2WF9sFPPJ/RL3bByKzfhC7gBCWA/PuBWJRg/hsFmhfluDV8o0Pbr1juXKFyEa
	 f5MPWPllM1AWjmmYp1m0zTDfVu6yrczte0FzZoPs=
Date: Fri, 9 May 2025 16:47:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
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
	Helge Deller <deller@gmx.de>, Jiri Slaby <jirislaby@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 07/12] Input: sysrq: mv sysrq into drivers/tty/sysrq.c
Message-ID: <2025050947-override-pulp-cc9f@gregkh>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-7-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-7-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:11PM +0200, Joel Granados wrote:
> Move both sysrq ctl_table and supported sysrq_sysctl_handler helper
> function into drivers/tty/sysrq.c. Replaced the __do_proc_dointvec in
> helper function with do_proc_dointvec as the former is local to
> kernel/sysctl.c.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  drivers/tty/sysrq.c | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c     | 30 ------------------------------
>  2 files changed, 38 insertions(+), 30 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

