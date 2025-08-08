Return-Path: <linux-fsdevel+bounces-57098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49FB1EA87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D974F178717
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFC27FB26;
	Fri,  8 Aug 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVcHni5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1427FB25
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664083; cv=none; b=A+GjK5BjKStkrpYXwN52uwnuCQ/b/83ueS7d8k0XLE7R5loD4EkbFPDa9yFB5A6uxvZsZb1D4O9toKPj8o2/YpM0HIsYApeSmNkP5thMl7JLPhm3xIu0A0HPVOvca/cYVoG8veaX4LGmLo8noecyRrzxg1BVEfPsFsQvLmaeZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664083; c=relaxed/simple;
	bh=qd2MUsflHlZ/tZVMWNcFSyxtl05BNFiVeTGXc3N54Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8mYyjMxGgNUoqRhl10esJQna2WERHwembNlUtlw1zMjtBIX8uEaFxxvwcwe3kn4z3B1dAeR86vaQP/UDvmPv6Ktmv5q2R6Vc0ehZuAkMunZzWI3Xjbsh6NmDXt8Xo0Kj42askl9YhLK0B7cQblts7mETXagG0Tats83VTp6P/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVcHni5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754664081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVbXlbyZjsINekjOptSlbtwiYMjqyKFTkplWxm4uz+w=;
	b=DVcHni5JPhpUXMWb4xvEtq6WVo8tue4maR4fdQtWA1X/H+WZFR4zmp9HiGmmiBr9R9HNlx
	Te6Cbg3gCTWPfycbC0BCpS99wCE36LH0F0azPdwQ/hCqDpMUDxGPQYVDsgb/XPnXkXmDEj
	gXUbBOczj208C3eMc5EjRtmkjEPJr/Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-raJ6zeyFMcWE-g_6SowfgQ-1; Fri,
 08 Aug 2025 10:41:17 -0400
X-MC-Unique: raJ6zeyFMcWE-g_6SowfgQ-1
X-Mimecast-MFC-AGG-ID: raJ6zeyFMcWE-g_6SowfgQ_1754664073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CA0619560B5;
	Fri,  8 Aug 2025 14:41:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8DD2A180029D;
	Fri,  8 Aug 2025 14:40:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  8 Aug 2025 16:39:59 +0200 (CEST)
Date: Fri, 8 Aug 2025 16:39:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/9] freezer: set default freeze priority for
 PF_SUSPEND_TASK processes
Message-ID: <20250808143943.GB21685@redhat.com>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <20250807121418.139765-6-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807121418.139765-6-zhangzihuan@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/07, Zihuan Zhang wrote:
>
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -147,6 +147,7 @@ int freeze_processes(void)
>
>  	pm_wakeup_clear(0);
>  	pm_freezing = true;
> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);

But why?

Again, freeze_task() will return false anyway, this process is
PF_SUSPEND_TASK.

> @@ -218,6 +219,7 @@ void thaw_processes(void)
>  	WARN_ON(!(curr->flags & PF_SUSPEND_TASK));
>  	curr->flags &= ~PF_SUSPEND_TASK;
>
> +	freeze_set_default_priority(current, FREEZE_PRIORITY_NORMAL);
>  	usermodehelper_enable();

What if current->freeze_priority was changed via
/proc/pid/freeze_priority you add in 9/9 ?

Oleg.


