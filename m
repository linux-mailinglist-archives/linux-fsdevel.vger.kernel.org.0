Return-Path: <linux-fsdevel+bounces-57289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9101B2041C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678FF3B80C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D832DEA7A;
	Mon, 11 Aug 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bea8b8L2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6B2DE707
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905471; cv=none; b=SXaA4volLu1pCb78+NzmBXSPUo2Ou0FZN+1e3B4qwfDzCkiIhregpdw7h9mMXfe7HJ6ZJnV8TpdRuNIr+U6X0yjIEWQsYIregoLMBYNOteMsJBEjwqdM9viuaZBJEPTMV6Rpunpv+0U5I2FAUmvDNpauf3z5LxsyZqXLi+zM83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905471; c=relaxed/simple;
	bh=/C+FRlGjQPtfUyOjnLRRzxn89zl6SzjGkixLNr8a/bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThsIyKLFrZt8vnvKBzOLw0lx9t4OMVHYSmWPh5nqS5gYeEhfDUWQrL2RKG7viT8cCx04gJuZ1R3IMGrJmWNmXvMSyjYOBq94KQ4e6M7orVfMSwAITxz/2s6E1yEgytHAeAXlbtwLOqyKkPjZyPHqxvDhZ+w7ba6UiruV8mTkT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bea8b8L2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754905469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWAq+VNH88+5aD3C80O8tNZjd996k0N5ELPJ0iNyg+I=;
	b=bea8b8L26z8OhsX2ReRqwKnHBY6zdFCgIW50ivwLYpsQc203Wkp/wSPNVno1RKpoNrBieo
	yBDnESS+V9kDagij1jj6D7M8/V8XJtTmKPXUQhDXIW/5iSIYtKSuXgmLMoXSsj81VsA6WG
	DaXOk8qVTdwwgj9fH/kz7yBPhazm/iA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-kNXTe3OnPpetNzzlStmxMQ-1; Mon,
 11 Aug 2025 05:44:25 -0400
X-MC-Unique: kNXTe3OnPpetNzzlStmxMQ-1
X-Mimecast-MFC-AGG-ID: kNXTe3OnPpetNzzlStmxMQ_1754905462
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A061195608F;
	Mon, 11 Aug 2025 09:44:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 173C519560AD;
	Mon, 11 Aug 2025 09:44:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Aug 2025 11:43:08 +0200 (CEST)
Date: Mon, 11 Aug 2025 11:42:53 +0200
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
Subject: Re: [RFC PATCH v1 6/9] freezer: Set default freeze priority for
 zombie tasks
Message-ID: <20250811094252.GC11928@redhat.com>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <20250807121418.139765-7-zhangzihuan@kylinos.cn>
 <20250808142948.GA21685@redhat.com>
 <393a4509-9b05-45b8-8496-699ace9a5438@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <393a4509-9b05-45b8-8496-699ace9a5438@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/11, Zihuan Zhang wrote:
> 
> 在 2025/8/8 22:29, Oleg Nesterov 写道:
> >On 08/07, Zihuan Zhang wrote:
> >>@@ -6980,6 +6981,7 @@ void __noreturn do_task_dead(void)
> >>  	current->flags |= PF_NOFREEZE;
> >>
> >>  	__schedule(SM_NONE);
> >>+	freeze_set_default_priority(current, FREEZE_PRIORITY_NEVER);
> >>  	BUG();
> >But this change has no effect?
> >
> >Firstly, this last __schedule() should not return, note the BUG() we have.
> >
> >Secondly, this zombie is already PF_NOFREEZE, freeze_task() will return
> >false anyway.
> Sorry, but in our tests with a large number of zombie tasks, returning early
> reduced the overhead. Even though freeze_task() would return false for
> PF_NOFREEZE, skipping the extra path still saved time in our suspend/freezer

https://lore.kernel.org/all/20250707084214.GD1613200@noisy.programming.kicks-ass.net/

Anyway the patch makes no sense in its current form, see my note
about __schedule() above.

Oleg.


