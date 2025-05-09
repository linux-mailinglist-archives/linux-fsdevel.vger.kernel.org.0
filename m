Return-Path: <linux-fsdevel+bounces-48634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8BAB1A22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94374C1204
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0123816D;
	Fri,  9 May 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF1YwsbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84722FF58;
	Fri,  9 May 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807128; cv=none; b=jyHkIlNR96hN/AaC9daUMAQZRRSHyPKTko6s3EIf9uB3h7PE+V7aaEnmSXAFHqF9qNnhw2CI9CX1NrR3P9+CvVoLEpHLhma/euu2/vDv5ynYhRAzlS8zfpFTxel3ojQdflSK0hxKNgs25YGUnXR7ByIUly9Uhk4q+H99iXCEhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807128; c=relaxed/simple;
	bh=FAZbGYBloQLXltv1jVW7+wuf9Nj+qiCN4u3kE549nNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP/VJVj0soWStNtLW1E/nAPxAr2TdcDW+iXWNu9YmqgeVTUrDfWLYeGvDYBYLzg6ClL4ioU7eD8Nvh+8GnrDE5AQhnh60zhljou5RTK5GZxh8VTaTT+qG6sEEUBURd9akgKMAWDpD0K/ZPP/aW37bb55jcabPMlk7udoLA//q6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF1YwsbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE4C4CEEF;
	Fri,  9 May 2025 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807126;
	bh=FAZbGYBloQLXltv1jVW7+wuf9Nj+qiCN4u3kE549nNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pF1YwsbFiscNJvBf+oklkmV160BbhXa1LMOkngmGCl5dU0hKYEmiJazHuL/jTniz6
	 e2n52nh/bTQQ9GeBQeo6k0CZJcGVYnygkBMKIeFUhbdkp1lbSrcdkB6wfkBoWbVX5Q
	 avwYf9aVHOiGvxTv2bdONIti9QBi7fzS134RAlsqLY7XWcJcsqpTDkhTPp2WeVuM1j
	 YZLPO6+7kScenSdE6CgnXoyzBZ7Y1WMEn/Wgu1d2WyjdHlalMQIBY6+QDePJ6Q0AHb
	 vi+ZDVHuFfx+YGm1FJPrQHkfHtFPUcXk1g6BelhYNpDaGEszgPSdeUPdB816Q923XN
	 LpOugat+O9mcA==
Date: Fri, 9 May 2025 09:12:04 -0700
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
Subject: Re: [PATCH 12/12] sysctl: Remove superfluous includes from
 kernel/sysctl.c
Message-ID: <aB4pVOsZr4pXz6dH@bombadil.infradead.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-12-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-12-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:16PM +0200, Joel Granados wrote:
> Remove the following headers from the include list in sysctl.c.
> 
> * These are removed as the related variables are no longer there.
>   ===================   ====================
>   Include               Related Var
>   ===================   ====================
>   linux/kmod.h          usermodehelper
>   asm/nmi.h             nmi_watchdoc_enabled
>   asm/io.h              io_delay_type
>   linux/pid.h           pid_max_{,min,max}
>   linux/sched/sysctl.h  sysctl_{sched_*,numa_*,timer_*}
>   linux/mount.h         sysctl_mount_max
>   linux/reboot.h        poweroff_cmd
>   linux/ratelimit.h     {,printk_}ratelimit_state
>   linux/printk.h        kptr_restrict
>   linux/security.h      CONFIG_SECURITY_CAPABILITIES
>   linux/net.h           net_table
>   linux/key.h           key_sysctls
>   linux/nvs_fs.h        acpi_video_flags
>   linux/acpi.h          acpi_video_flags
>   linux/fs.h            proc_nr_files
> 
> * These are no longer needed as intermediate includes
>   ==============
>   Include
>   ==============
>   linux/filter.h
>   linux/binfmts.h
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

 Luis

