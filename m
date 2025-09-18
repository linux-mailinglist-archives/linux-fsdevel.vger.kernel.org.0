Return-Path: <linux-fsdevel+bounces-62137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146DEB85551
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3487C2C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B921DDE9;
	Thu, 18 Sep 2025 14:47:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D03081C9;
	Thu, 18 Sep 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206826; cv=none; b=Io6MbjyoQn4vD2RDn9LqMscnNc3CUCOTA3kzOuwitMHM6oYj5LEbM8ScMN5pWNGyIbPS8q8OM2kxY25M0p9D/3yp344Zqp2xJxAyna+hMA7GbWx1GSKEkRgkvL/SVsTIiJ8sR4jav2heMEw5D4JKADmIRmmj0EYVbbmr7nc4Bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206826; c=relaxed/simple;
	bh=Phbsv2jhN6fEOF+S4y+OloNs3QjT7JaNWwAATBrlCI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tklEND5cis41bjX9iriUO6SCpBI/2XxW876mO8Li2QWIsvnSs00OdzZWNnjnNB0KtPrhfKUJ9Gc9fUIWbzubhs2cFPDTg5tX7QOip9hYBtBZO0epj5QkMLVL7gULYQa6u+nBA/RrKd3622uRS1uffYvItSYkZCL2ITUlJ6F7uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id B0F07C01D8;
	Thu, 18 Sep 2025 14:46:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 64C5F20026;
	Thu, 18 Sep 2025 14:46:52 +0000 (UTC)
Date: Thu, 18 Sep 2025 10:48:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
 minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, kernel-team@android.com,
 android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded
 trace event
Message-ID: <20250918104800.18682dcb@gandalf.local.home>
In-Reply-To: <6x64jf7szyy52gug6qoixhhjq6vsrcqpozqj4ambsehh2jprj2@qeye6qevem4g>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-8-kaleshsingh@google.com>
	<20250915194158.472edea5@gandalf.local.home>
	<CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
	<20250916115220.4a90c745@batman.local.home>
	<6x64jf7szyy52gug6qoixhhjq6vsrcqpozqj4ambsehh2jprj2@qeye6qevem4g>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: adgcp5z5zfgkt6e8r6e3qyg7u774zqmz
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 64C5F20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SPmSGyI4YAHSVF4EBeZrT9fbg8i0D60w=
X-HE-Tag: 1758206812-260855
X-HE-Meta: U2FsdGVkX18tsNvH9bJDAyFjkOT2HA8ufoSMnckqu/PF/TMziwSBt6ub3HcDiaqCsBki4oHrVzGzWJgZN2TMafKiXzJFbwxNCtcijv/2L7usqvNreFB5cSMdaUx+V14enzYHmfTtY0OvIOF0Vg0J0H/94xSJuSaXEO3o9ykMJ9ZLZMPvBdMDl5Ws5yhHI1hjp0jHnj2XG/BfWP9WMn0eexomyP+td/1fW9VFhOT1kcCBFbRB7Afnn3ByETKi3Xwoxn8m29j0Wlt7indu64ikhql9bauxeS3wdvSqX0FmZNfQAUSyAjpZi3dQYT+/3fmf

On Thu, 18 Sep 2025 12:38:56 +0100
Pedro Falcato <pfalcato@suse.de> wrote:

> Isn't the usual problem with that approach, that of static functions/static
> inline functions? I was tracing through a problem a few months ago, and man
> I really did think "wouldn't it be nice to have a tracepoint instead of fishing
> around for kprobe spots".
> 
> Not that I particularly think a tracepoint is super worth it in this case, but,
> y'know.

Yes, it would be useful. The issue is that tracepoints are not free. They
do increase the I$ hit and take up memory.

If you're going to inject a tracepoint somewhere, at least extract some
useful information from that spot. If you can't think of anything to track,
then it's not worth a tracepoint.

If one really wants a way to track something, they could add a static
branch that would call a function when enabled that could be traced. They
would also need a way to enable that static branch.

-- Steve

