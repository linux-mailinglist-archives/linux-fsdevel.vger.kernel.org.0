Return-Path: <linux-fsdevel+bounces-66847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F97C2D61D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 18:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E544F203A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945631A06F;
	Mon,  3 Nov 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMW8zha/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC622ACEB;
	Mon,  3 Nov 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189693; cv=none; b=jBo2jLFwf7HEwEjY4PlrMunKVZyshGVT9YZHDMViHiuqGJraDzUytjBKEo7LwrMmcR2FOr2Yl2PIiTkTpUqt4foPZWNMFf8crVjGl180PndfjJMwytXZXAisHQ6YP+I11zhRrd+rZWxV7yONOnmVRvvtcsR6/QYrkrc69ncp440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189693; c=relaxed/simple;
	bh=R4htJzSMPqKUheWFqD30DrfQ176o4Yn8IJrGpqBlr/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUbZsHELn12LPa9hiMKGzdEOi/36HSqtc4jA/quePOfd/PLZWrUB6vkrZXsxlcENDvnScUNCHWHOvbHhJPl2d83BKN5TbUacWpIVzm8ucfHouqdyvGkMFt4vhqh7OBzAb/dTuzK1s1KN7zXxp+8RAGkdkokimflFyRW9ptV+ycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMW8zha/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB9BC4CEE7;
	Mon,  3 Nov 2025 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189692;
	bh=R4htJzSMPqKUheWFqD30DrfQ176o4Yn8IJrGpqBlr/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QMW8zha/pnUwa3tfZUaFK2bT4lDcoBh/DY32ySXAvx11GfxnxoQT76C+mWa83vMqn
	 5dgf8xFQbeRRXfbsboE5M/KFKQz47hbPo+EnqmXiHpYBYZT/iaCMtvy2d2ha8kC2jD
	 kgCM8jiflgzODz8WMWnAkyrMK8wZZiWSJ/y3RPWdIflBININGH3XfgJt3QlL3aOh04
	 VQeOoh5daKWcZcWfgeCKy1wVXRC06BIkFwwa+6zb6ouw5miTUoZ6wRq1INFRkKwBf7
	 9vBqWHAjIFRuHZBjJkRpVvwlCaqTdHMs8ANOEvnniMBCsaiTXLvOqKY52FCYC86mjb
	 KIPEY48x9nSeg==
Message-ID: <28a5b824-f415-461c-af88-cb474ed37df1@kernel.org>
Date: Mon, 3 Nov 2025 18:08:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] mm: Document lenient map_count checks
To: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com,
 android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251028212528.681081-1-kaleshsingh@google.com>
 <20251028212528.681081-2-kaleshsingh@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251028212528.681081-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 22:24, Kalesh Singh wrote:
> Add comments to the map_count limit checks in do_mmap() and
> do_brk_flags() to clarify their intended behavior.
> 
> The use of a strict inequality ('>') in these checks is intentional but
> non-obvious. It allows these functions to succeed when the VMA count is
> exactly at the sysctl_max_map_count limit. This historical behavior
> accounts for cases where the operation might not create a new VMA, but
> instead merge with or expand an existing one, in which case the VMA
> count does not increase.
> 
> These comments clarify the long-standing behavior and will help prevent
> future misinterpretation as an off-by-one error.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---


Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

