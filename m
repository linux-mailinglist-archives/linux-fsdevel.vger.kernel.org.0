Return-Path: <linux-fsdevel+bounces-57040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A2B1E3FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64973189098C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D462253954;
	Fri,  8 Aug 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID4MZMxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8324BD03
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639975; cv=none; b=AZf8OhUjePAN3LC+Zb7541Eh3kHGUtIyv5Pggnh63sJJaQqMuc2zjc/v85OuCgks1MiCB7B3KjC6jXdz/vNBiC7mzhLIUSdWS5OAWS9dVuE8+9JKj3Nw8XVXT6Gu2Gn+0zSLGyXekis9Mlk5Ur0yCwUzttejENuuvYZJUaYawYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639975; c=relaxed/simple;
	bh=aV0E+W7TpF7ScFUrIhlu67F3pDF1bA8Hd4KFXigqUCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR+OH0G0/3XfmrwqOM6b+iJaPxy30qWaHI/vfRv9YmBb74er4frR+XaL5C6S0Irar/2mT6HL5Q6qMHYh3rrCaeVOMAOX2dGxP2jP8bGjk2d3mzcEwTkTm3L61qvK8l1tyNaa1j9WAzpvrx7l5t+St2OBhYZyxvwGC9qiuOouXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID4MZMxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754639973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aV0E+W7TpF7ScFUrIhlu67F3pDF1bA8Hd4KFXigqUCs=;
	b=ID4MZMxVmStntNbz7jP+tqjTIz7BMN5ZE5EFrmxxmh+ZW8FfAv+wAuKzcEbqYYTmxhbOq5
	HLhPOB6YEzOUySY2A4Jz0svhKz5xR0RRxQ5BL8tlYni8QqUvoJQqnVgIDskznKSkhLOS11
	THOfhn4Hn8/CSzfIMkMl7HSFmaSNJ2U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-UNIuuF62OhurBbbx6qeMxQ-1; Fri,
 08 Aug 2025 03:59:29 -0400
X-MC-Unique: UNIuuF62OhurBbbx6qeMxQ-1
X-Mimecast-MFC-AGG-ID: UNIuuF62OhurBbbx6qeMxQ_1754639965
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7991C1800446;
	Fri,  8 Aug 2025 07:59:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 24BB41954185;
	Fri,  8 Aug 2025 07:59:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  8 Aug 2025 09:58:12 +0200 (CEST)
Date: Fri, 8 Aug 2025 09:57:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <20250808075753.GB29612@redhat.com>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/08, Zihuan Zhang wrote:
>
> 在 2025/8/7 21:25, Michal Hocko 写道:
> >If they are running in the userspace and e.g. sleeping while not
> >TASK_FREEZABLE then priority simply makes no difference. And if they are
> >TASK_FREEZABLE then the priority doens't matter either.
> >
> >What am I missing?

I too do not understand how can this series improve the freezer.

> under ideal conditions, if a userspace task is TASK_FREEZABLE, receives the
> freezing() signal, and enters the refrigerator in a timely manner,

Note that __freeze_task() won't even send a signal to a sleeping
TASK_FREEZABLE task, __freeze_task() will just change its state to
TASK_FROZEN.

Oleg.


