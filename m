Return-Path: <linux-fsdevel+bounces-57310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F8B206EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FA37B44BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6CB289807;
	Mon, 11 Aug 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fyfqeBAd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6457289356
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909925; cv=none; b=AwqtWogGoTEuPlFiLxf/LYKb6augHbAujuanJP/Lts7D1KeucSCaO5UKYJoWJO9EgYsouEKMyMYqnfE9fVtbNHQuEqkShmbx7PeHn+TazsgD/J0qJc9xRkgd84kay3qqR1cDmFce7X3oDQ7mTy/seOViBgV/De9TXaDWnlpQbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909925; c=relaxed/simple;
	bh=fK4jfWxAxG8hhrtguRsi7TtKPjAL7Pn0DSb61hYO1/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj55TmGN+6luYcmfFIB700aHRatmDiLKjCpb4o4i9L+LM/A2SGZeHrgABCTL5+M9OTbEAkBwgIp3E59pWor+TtnXlxNthl7o4Dqc+jG8o2EcQ89J2rTExkOgXD9hCfES0E4oqQNbiWOlSEneCslEbVXkUy5VSs36CR802pYqUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fyfqeBAd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458c063baeaso23373435e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754909921; x=1755514721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2eDfsoEqJXD8CkPjgI5wPgXdl/c/jHhszq1yFHNlj5s=;
        b=fyfqeBAdLauFQlbJ5kIubn3oekJOKh17SaO+8Gyc7rdnhzE94ts9jzCnxmT8dhWmyK
         d+pmOLv4nAWXBiVZEUDPudcHVWhYfSxa+xXCbDJUkaTkhoA9CLtyJ4dA7JVPzfdXvjYg
         gLVuLIYBYXWUlZoknVTMq3uCLlxiQUJMBAwIxCAlpEJukSMgRg+m2sFaRvXF8K8To75K
         ZrlrlSJRXkIME54dny/jdnGbDwFhqQhM1TeULiRDI2+YII4nYeIdJC74dR14gKEAz3UV
         PHLhfrksSnDD57zMZSF/zJsievt3ThOZH6IbqXncG+VLMfpdUDnDkLLwAapWZCG3M6sx
         WtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909921; x=1755514721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eDfsoEqJXD8CkPjgI5wPgXdl/c/jHhszq1yFHNlj5s=;
        b=Nuhdm7n2jPs6TBFZdDn00oo7z9Kq6pxxsph8tz427rIRmAPzg6md4OCuQ6rkYwO79k
         zibpINb6mbOhQSq8x4VJNU/AFMEFgobiWQY8k6kdvQ8wBhmain3NeeKNKPAY5iBfiKxX
         t6t7+gUnkZtaRhgt6SLkahdUBHW0P0i5XkvTv6yVGczRBcOmTAsoTWYaIYAkelEJfgnt
         8qrq+kTWQLZNBsN8xu9NDENaNwYon361KBd2IPqTQe1k9ZCFqEsfg/veST5I9xN6mWop
         /6UaYeyael5Ej7wcSvCnSRWcDJKGu2gp+aXMVzLf4v6rgC5yQPBON37Dz4uDnoFE6k3Q
         MbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9BOlaKciAtpl4M3QTj00JBoI+OhyG1FCfSj+eq0HObyLvXfDoH+wzl+2NGlU7TZiTU7x3wOgOtEACV58z@vger.kernel.org
X-Gm-Message-State: AOJu0YxeixcBtpLyjJNZzF0o6uHEPEaXmPMImvwhNobMEMloI3k0U9Yb
	/r/FHvHRWz842wrjwLmUZ0Eu56+DfZkJF0k/byYnPK8GIhgch1WuzbZz10D7N2G7eXs=
X-Gm-Gg: ASbGncthpeIVu5w7EauWmo/epvBD1AmoC05R6Nni5qZskT+d13OF+jgXG5vvWWR9Bcj
	nHu8LgagpPVfFQmNUfiqYC9d2TWXZfKfkxRYQGBUwzEO4mrGW8u8tIoIFNFUWCC45lCdlxjLRHj
	fT8ZCuutuKow5AVfLWoFPLOjIoEeepSvxzPwEj9OYjpqtcjP/lfHvC5iJ6CjCnLmYsUiE2qN9NT
	W7oaOq0xkGtuleIHDoPL9/OOowZ17vQ45Imkq5jwisXC+ZxkZAhK8d+I4Rb67RnbcN8n7bj9GBU
	dZ1Y5eFoPTlP8G4FmypEWdcfXwwDpki6ehVqCLeaJfBtnoaBb03xzmDUXS8lh7lud5adaB+3Puh
	fPj3Am1YMSHIu7o1oYl3Dm3U8gfoQ8C+G
X-Google-Smtp-Source: AGHT+IFbmWJMYJQaNs4CcNQms0cyi9FBgsOYAQyUhMd4iBen9JAGKCb/WkfFa3wB/d3Zu4x8mcv7UA==
X-Received: by 2002:a05:600c:5254:b0:456:13d8:d141 with SMTP id 5b1f17b1804b1-459f4f282damr96805005e9.27.1754909920821;
        Mon, 11 Aug 2025 03:58:40 -0700 (PDT)
Received: from localhost (109-81-30-31.rct.o2.cz. [109.81.30.31])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c48105csm40496846f8f.64.2025.08.11.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:58:40 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:58:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
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
Message-ID: <aJnM32xKq0FOWBzw@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
 <aJWglTo1xpXXEqEM@tiehlicka>
 <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
 <aJW8NLPxGOOkyCfB@tiehlicka>
 <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>

On Mon 11-08-25 17:13:43, Zihuan Zhang wrote:
> 
> 在 2025/8/8 16:58, Michal Hocko 写道:
[...]
> > Also the interface seems to be really coarse grained and it can easily
> > turn out insufficient for other usecases while it is not entirely clear
> > to me how this could be extended for those.
>  We recognize that the current interface is relatively coarse-grained and
> may not be sufficient for all scenarios. The present implementation is a
> basic version.
> 
> Our plan is to introduce a classification-based mechanism that assigns
> different freeze priorities according to process categories. For example,
> filesystem and graphics-related processes will be given higher default
> freeze priority, as they are critical in the freezing workflow. This
> classification approach helps target important processes more precisely.
> 
> However, this requires further testing and refinement before full
> deployment. We believe this incremental, category-based design will make the
> mechanism more effective and adaptable over time while keeping it
> manageable.

Unless there is a clear path for a more extendable interface then
introducing this one is a no-go. We do not want to grow different ways
to establish freezing policies.

But much more fundamentally. So far I haven't really seen any argument
why different priorities help with the underlying problem other than the
timing might be slightly different if you change the order of freezing.
This to me sounds like the proposed scheme mostly works around the
problem you are seeing and as such is not a really good candidate to be
merged as a long term solution. Not to mention with a user API that
needs to be maintained for ever.

So NAK from me on the interface.

> > I believe it would be more useful to find sources of those freezer
> > blockers and try to address those. Making more blocked tasks
> > __set_task_frozen compatible sounds like a general improvement in
> > itself.
> 
> we have already identified some causes of D-state tasks, many of which are
> related to the filesystem. On some systems, certain processes frequently
> execute ext4_sync_file, and under contention this can lead to D-state tasks.

Please work with maintainers of those subsystems to find proper
solutions.

-- 
Michal Hocko
SUSE Labs

