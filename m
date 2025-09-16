Return-Path: <linux-fsdevel+bounces-61767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A712B599E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5287D521671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1C338F54;
	Tue, 16 Sep 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZmjL6RjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835251078F;
	Tue, 16 Sep 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032418; cv=none; b=aWWGDc/ruSasPIParLoXU5A1Crb6QBaQLNw9YWkYbEcrZI89ko+yI05Yc15mlT8jgR4vjKqa4+YftWdftCD4ynnQY4txrWiiyglLdtfzHtcOstv0UqME1Kq6C7YnA0oqsR5v9ckUJ9zZovYXID3NiNkUiksedRCjAvxLon4G8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032418; c=relaxed/simple;
	bh=gxDtgHz7G1qQsGNenAHFPQ0Z2+aX6Y9VV1cwAM/Bx0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HTyM+OWagcmXP9a77A4Dw/wLqFTpzMGsdjpg20w7K4ZvS9ppNYzanCZc/9ZZDA86HYDYTGH5w11AJly7ZIlyMgHsTebJukeslwgUXpGGchvGH+TpCIn9QpHIsNXC1DdcZoqqjTyZl8yk+4210DK1XqB2mMU+Dxk9fT7LX5C/OJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZmjL6RjW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F8B140506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758032415; bh=zYbUqQqq5gBAL5NIx7a64DWZNoB49w8Fp0Gj3T0pxnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZmjL6RjWsOZ3eAjNFWsOuzjJ0Ru9j9OUpBRNBMRLLKNfG48ZXDy7L1DBpuUggW6Sb
	 Kchk7t0p0giMOvQ+nErBhBHHuOMLmgD2X0Os32s4ZIHYuaOxRxO95RmmZmombPAI6x
	 VnU5WL1lASRpwAuGmchNSyDbfhNSbjgWo95ypTGez30DhV5nm91BcgQrda0Fc34U/0
	 X14t+pZGhwYrqfWabPVAD1U+rr8gEiYrdFwLfCtkOMSSbfMIOyv5m5HgVyts62/am/
	 E1zv0QBP7UDkqON3AtqWjJI0Wa2A6d5d4VTIaaxZMvOTJYdeTACO+Jawj+JyfdW1fg
	 eH5UgPsER07pA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6F8B140506;
	Tue, 16 Sep 2025 14:20:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh
 <kaleshsingh@google.com>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
 kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar
 <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn
 <jannh@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
In-Reply-To: <20250915153642.7f46974a536a3af635f49a89@linux-foundation.org>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-2-kaleshsingh@google.com>
 <20250915153642.7f46974a536a3af635f49a89@linux-foundation.org>
Date: Tue, 16 Sep 2025 08:20:14 -0600
Message-ID: <87v7lifpi9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 15 Sep 2025 09:36:32 -0700 Kalesh Singh <kaleshsingh@google.com> wrote:
>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> lol.
>
> x1:/usr/src/25> grep "Fixes.*1da177e4c3f4" ../gitlog|wc -l
> 661
>
> we really blew it that time!

A few years back I made a list of the most-fixed commits in the kernel
history; unsurprisingly that one (I call it the "original sin") came out
on top:

  https://lwn.net/Articles/914632/

Perhaps the time has come to update that analysis.

jon

