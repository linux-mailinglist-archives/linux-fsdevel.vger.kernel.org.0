Return-Path: <linux-fsdevel+bounces-57290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1953B20450
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15692A0041
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31B22A4F1;
	Mon, 11 Aug 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEW3i2Ng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B61EF0B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905714; cv=none; b=P1odY73J4DUI/ofjQQRCMTd3yDhUAVAZnYhQscATYEr5ZRbfET+4x8bHta08Vh3eIHzQu+flU4LQk5659T2K4FGdTH2DbRMfSVDixDZw6tLOaFQtZWUOu0pG5kDdOCXLzENQ0t0ApTVdQe9lCpbvJ1WsUOJ2kRmJpxez5ZXEb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905714; c=relaxed/simple;
	bh=0OPcsD/DaGgHciGnZkdoOwhQvX8AaP4eY2Vbszy4FwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwRFUhFaWZReTKpT9t4ZVX+JTQgynIArBwW54qDRwN8MPLwj57HwkOcfFK/XTNCT5U2OSEPJzYde0YWSlOn9/2S4C8hrQhEGGfjX3U2TlSC4L0Xy/F84O0xU/uY3u4L+/18J+JZTPQz0OSjyeIW/YdskM+/zytVyalkB+ByR8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEW3i2Ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754905711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kICfAp24qHgM+A4GcAjqf86phj/suI1wu/9/TRfKonI=;
	b=WEW3i2NgU8S3SHbowVfxc911w/aSbg0aEvA1qynB38yDLtI4Yn5JwqZZ5Jzm7dpjTFb2+7
	m4GZxQ92qwub8vvvwxm/g1KGJeYHAthnfC2+5QDtLyQRgMQmkMJdalTvURMjODDISjhnZM
	JQ4e3QmSZupttrp2UdQLYEZ4w84YP6k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-kvLj1JhNMtOyQe4g1LJ22A-1; Mon,
 11 Aug 2025 05:48:28 -0400
X-MC-Unique: kvLj1JhNMtOyQe4g1LJ22A-1
X-Mimecast-MFC-AGG-ID: kvLj1JhNMtOyQe4g1LJ22A_1754905704
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C16A0195608E;
	Mon, 11 Aug 2025 09:48:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 24DE11955F16;
	Mon, 11 Aug 2025 09:48:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Aug 2025 11:47:09 +0200 (CEST)
Date: Mon, 11 Aug 2025 11:46:52 +0200
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
Message-ID: <20250811094651.GD11928@redhat.com>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <20250807121418.139765-6-zhangzihuan@kylinos.cn>
 <20250808143943.GB21685@redhat.com>
 <0754e3e3-9c47-47d5-81d9-4574e5b413bc@kylinos.cn>
 <20250811093216.GB11928@redhat.com>
 <428beb0d-2484-4816-86c3-01e91bd7715a@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <428beb0d-2484-4816-86c3-01e91bd7715a@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/11, Zihuan Zhang wrote:
> 
> 在 2025/8/11 17:32, Oleg Nesterov 写道:
> >On 08/11, Zihuan Zhang wrote:
> >>在 2025/8/8 22:39, Oleg Nesterov 写道:
> >>>On 08/07, Zihuan Zhang wrote:
> >>>>--- a/kernel/power/process.c
> >>>>+++ b/kernel/power/process.c
> >>>>@@ -147,6 +147,7 @@ int freeze_processes(void)
> >>>>
> >>>>  	pm_wakeup_clear(0);
> >>>>  	pm_freezing = true;
> >>>>+	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
> >>>But why?
> >>>
> >>>Again, freeze_task() will return false anyway, this process is
> >>>PF_SUSPEND_TASK.
> >>I  think there is resaon put it here. For example, systemd-sleep is a
> >>user-space process that executes the suspend flow.
> >>
> >>  If we don’t set its freeze priority explicitly, our current code may end up
> >>with this user process being the last one that cannot freeze.
> >How so? sorry I don't follow.
>
> The problem is in this part:
>
> +            if (user_only && !(p->flags & PF_KTHREAD) && round <
> p->freeze_priority)
> +                continue;
>
> PF_SUSPEND_TASK is a user process, so it meets the “needs freezing”
> condition and todo gets incremented.
            ^^^^^^^^^^^^^^^^^^^^^^^^^

No.
	if (p == current || !freeze_task(p))
		continue;

	todo++;

Again, again, freeze_task(p) returns false.

> But it actually doesn’t need to freeze,
> so resulting in an infinite loop

I don't think so.

Oleg.


