Return-Path: <linux-fsdevel+bounces-13581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B538871876
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FA21C21F54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BBA2E40B;
	Tue,  5 Mar 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0QoQcRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D24D9F9
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628152; cv=none; b=fnxhlJuxsR5JOz/67PCxj06awjUXGs5ZVPW60LH6zLczUyz7k9LbUutVBiuIEKsC7hHNXCGzX8RZM7SvvjRxW3H1gWJLp6+7HrGh3Ek+p4No7oBZVuVh7+vBSuzGQ4aHxcMXkEPp5Dz8ZiL/JKmL2pb99VmREIjIT9+83K6vJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628152; c=relaxed/simple;
	bh=uoo3zKerEHzMgEHlrnPwSr6IBKYesoBCdKdQ1mTQyFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfpccZjQVfFOL4MjZfuP8ry/C23Dqh1VberlMjNy4kEDGNLyAfs6Mzz5xY+E8WjYb5cMXH3fxu+2HVU8B/8KtxNsDFbe5buXO0K4gDZq4hWUAYm9Lf3h0ZCQqUjkuhgu+hYbhF1Yix3XAq358UyphtiEv7eM4cEOVq49VZt3YAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0QoQcRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14442C433F1;
	Tue,  5 Mar 2024 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709628151;
	bh=uoo3zKerEHzMgEHlrnPwSr6IBKYesoBCdKdQ1mTQyFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0QoQcRcsy8PoOylzJNBfp483uR0YHLu3b7a3mt0nHRsOipYeHo3BCRkYsM8eC3b1
	 cbJzqJrd9fNXd9dTUGulYuOjouAtORBDtHfsBUM8kZj0CFrvNTyTX7CVpy9+KC23Jt
	 BQSK1qmCJhZ0PD84pcpVcPb9Qy04y2F1JrKAtpBWdDBRCzQPYDLmWfpXk7OwxU8Z2N
	 /RBOt+EBYy+LU4AOSUDYb5IrMpQFo5hZcz89ZKY8dO2FjGHeqK4J7byRUZ153b9dXT
	 f4Q91kQzDdi3y4BsdPXvHW9G6VNDWUBIFuwlbgXrR5bFa30AABX823vzMNNJ5r8JMQ
	 pd1+EE2FOohNg==
Date: Tue, 5 Mar 2024 09:42:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <20240305-abgas-tierzucht-1c60219b7839@brauner>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>

On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> Hi
> 
> I have a program that sets up a periodic timer with 10ms interval. When
> the program attempts to call fallocate on tmpfs, it goes into an infinite
> loop. fallocate takes longer than 10ms, so it gets interrupted by a
> signal and it returns EINTR. On EINTR, the fallocate call is restarted,
> going into the same loop again.
> 
> fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> 
> Should there be fatal_signal_pending instead of signal_pending in the
> shmem_fallocate loop?
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  mm/shmem.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/mm/shmem.c
> ===================================================================
> --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
>  		 * Good, the fallocate(2) manpage permits EINTR: we may have
>  		 * been interrupted because we are using up too much memory.
>  		 */
> -		if (signal_pending(current))
> +		if (fatal_signal_pending(current))

I think that's likely wrong and probably would cause regressions as
there may be users relying on this?

