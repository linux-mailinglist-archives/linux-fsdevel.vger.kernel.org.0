Return-Path: <linux-fsdevel+bounces-48658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0568AB1CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445CC189A03A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486A241687;
	Fri,  9 May 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwpnNoBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E922D4CE;
	Fri,  9 May 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817048; cv=none; b=Vbo5r7E9apSVhySSjpPMCARfKwigQNxMj2BMpVWf8a63SrKQPaJBdZh0++wIkObfhlE5IM1vp3LI+Jb7gD6CMTmG3ivhI0td8NdDJPhF1C7Z9XKbkLZcVUvPUBabPgj9IziYaaTUj56kamwp/WZkcDZ+0zeUcdO8AwZY6Xx+KRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817048; c=relaxed/simple;
	bh=ZD0aaIrPowahZc0pDsydY92jojx2QtXYHD6gkSt51b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhlpvKPoVfr2tOr/BfmEsfptaHhIfwVgGd+BtD7vpFbVlyg4xEkYAhC/PA0p8BfHMjgR1GWUo3YpJSIbpzqlt2JyoNEHPMquA/DzavJ4TYTVPZ52b3p+qwFuCxFH2qleL9Z+txy0XdaIXGEkwznlusgBjwg5IoAbydagaxonAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwpnNoBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214F1C4CEE4;
	Fri,  9 May 2025 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817048;
	bh=ZD0aaIrPowahZc0pDsydY92jojx2QtXYHD6gkSt51b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwpnNoBV/D0ppHEuYnXOrofAQpJczBo+sLjSMdl+k22vz51E910wsCTGGXTgSAZcZ
	 0tKLcP37Cq1SosGVbonoHobYbelMlARNcbQxxkRFl8yMmLi2KFMSvNO6+9u+0pGbA8
	 y3paOxtteNpewlJyy11KMEztu7RERWf+POeIlK3eQmYxlx6lBxZcV/y5qSlLV+1dx0
	 CRgVMpqqwUkURbu3pzBqy6m5JXZshQuPUiWflz13f5Fe/IsWojsRrtKPhD1njJoMz+
	 7cSNiGscPqp3boQGNn+MZZEJnm7N3iR0fYXAMm6pv/aNaznBi0vvG+UGaSJpvHkm0P
	 ShlOrK8Lo7F9A==
Date: Fri, 9 May 2025 11:57:25 -0700
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
Subject: Re: [PATCH 12/12] sysctl: Remove superfluous includes from
 kernel/sysctl.c
Message-ID: <202505091157.C9A906F@keescook>
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

This is very nice! :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

