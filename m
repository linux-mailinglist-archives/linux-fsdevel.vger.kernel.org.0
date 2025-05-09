Return-Path: <linux-fsdevel+bounces-48631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB32AB19F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F87B2662D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB6239594;
	Fri,  9 May 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj9Vh6d8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC42356A4;
	Fri,  9 May 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806987; cv=none; b=mLlxBW0gFOECWjDu5DRwxAqCGpfsax0AE20JV4mlv5+thYxshiLpP8owF19o2d943r8//KHThJFKdOmzN2IIKlmpBFJIymtB9J3OQYTqSR+6tglVayYBraIlOKo5jMQ9Jzap8F7ZdVakEMDNJMINrzBBiaN2XqhwwX6hBnkuLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806987; c=relaxed/simple;
	bh=Zx9q53OQA04c5qmcm0DsdpJC9W96D9D2DyB30Y/gQSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBmYtyEpf6jk6Xcllr0OoP8sLuL6/ddcGkbf8bNmSElppTbezv47it6weZ7DhkJa5iCiH6qbYlOPWQ9RoIqHM38soewUWJrCh9uH8lBbRQC8id+pFGGIfS0W/4v1wArvzug0vyzYo/4cr+gzq3jMnqaCSdxNlUbMSApJqQQ398E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj9Vh6d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BCCC4CEE4;
	Fri,  9 May 2025 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806986;
	bh=Zx9q53OQA04c5qmcm0DsdpJC9W96D9D2DyB30Y/gQSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jj9Vh6d8aZ3F7OG5lDvoVMttOWKZaPPKIalxI97k/c3EO70+j54kHabw7t/ZrGoNS
	 zrQteMjPuFQ6I8S8tIpySjMKb3PuIuBtC1BHE4w+ws+84ltQRhnM3QR3LosBoXXZ3H
	 B6fgLxE2y40MC3ZhcfhRa+pf6qbEi+y38YjqVR1GV1p56MJWu/08UNbehTSA5ky+an
	 iOu0l0EUXCdZM+8s8zZtK80qZUOfd6PgUInGfEwSU6Am9GvV+QzRyII9EHLDxWRm/A
	 wmBhOtaea+Ve9EDNILiLlKDlpIqDJ3eumwOOS2UoFgZnZPckifxdwODvxcM1wnrFCG
	 CgI54YXFKVorw==
Date: Fri, 9 May 2025 09:09:44 -0700
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
Subject: Re: [PATCH 01/12] module: Move modprobe_path and modules_disabled
 ctl_tables into the module subsys
Message-ID: <aB4oyFBMH4PKjJn0@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:05PM +0200, Joel Granados wrote:
> diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
> index 25f25381251281a390b273cd8a734c92b960113a..5701629adc27b4bb5080db75f0e69f9f55e9d2ad 100644
> --- a/kernel/module/kmod.c
> +++ b/kernel/module/kmod.c
> @@ -60,7 +60,7 @@ static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
>  /*
>  	modprobe_path is set via /proc/sys.
>  */
> -char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
> +static char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
>  
>  static void free_modprobe_argv(struct subprocess_info *info)
>  {
> @@ -177,3 +177,33 @@ int __request_module(bool wait, const char *fmt, ...)
>  	return ret;
>  }
>  EXPORT_SYMBOL(__request_module);
> +
> +#ifdef CONFIG_MODULES

kernel/Makefile:

obj-$(CONFIG_MODULES) += module/

And so you can drop this ifdef.

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis


