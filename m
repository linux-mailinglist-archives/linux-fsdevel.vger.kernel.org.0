Return-Path: <linux-fsdevel+bounces-61460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E3B58795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F8B3AA972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B192D594D;
	Mon, 15 Sep 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XD41Em6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA6221282;
	Mon, 15 Sep 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975805; cv=none; b=XNV3FmujvbxFpVeWTOLSx6ShGchfC+LWciwNRTkV7aMEB88iGDdL95ekENB8g1zMJlz1gqDLpYbtQZBD9hUacbQSm6ftPS04SlXLhnnMUw+xCN9dbxEfQ9yGKtIDQG69C6Hhr3t6eTJ+IFJ/t43pFvCRaLkTqT8uZWuk4/srrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975805; c=relaxed/simple;
	bh=ylWCf7mn++QEdplcms6pMXryBGpylSj+eyDc/Pa9P1s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jLY/IjV/w9HtOqRRnwZY3XAX9dwJFFUiqu8ywoubfGB2oLoYe67bM8yO+B1qn4GrGIDTa89FpJKdhP/ykST6SHfFO8b3BEshIs4rtp5FMYzm6cWQWpux4onFf3h+h43lzlJ6rKCxRzPhTXVOePaMtUGNV86dyvjOu2fGu16HElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XD41Em6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39092C4CEF1;
	Mon, 15 Sep 2025 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757975804;
	bh=ylWCf7mn++QEdplcms6pMXryBGpylSj+eyDc/Pa9P1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XD41Em6OmVs/HoC8kKF4blvfGChKvN0hV2kHafNbdfw7lxTmLwGmw/DqpX6A5BsrR
	 HUDbr829kBnmqQtUMiyeZGsD9I3AGTqn13vd4Lod1ocker4JYMSk1Z/HoSLo4sATDE
	 MZ77dRrPipxfDZKn4KoHAdPIpv1J26ShiMCw8YHs=
Date: Mon, 15 Sep 2025 15:36:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
 kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn
 <jannh@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit
 checks
Message-Id: <20250915153642.7f46974a536a3af635f49a89@linux-foundation.org>
In-Reply-To: <20250915163838.631445-2-kaleshsingh@google.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-2-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 09:36:32 -0700 Kalesh Singh <kaleshsingh@google.com> wrote:

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

lol.

x1:/usr/src/25> grep "Fixes.*1da177e4c3f4" ../gitlog|wc -l
661

we really blew it that time!


