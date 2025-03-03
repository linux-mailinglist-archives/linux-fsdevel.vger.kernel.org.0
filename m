Return-Path: <linux-fsdevel+bounces-42929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592DA4C123
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 14:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0663A48DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3B211261;
	Mon,  3 Mar 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi/zc1PB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A562CCDB;
	Mon,  3 Mar 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006809; cv=none; b=cFLA8s4YK8YvIvP2r4UeD/Fe+idammlYOf6jd9VULuz1LGFBFYevNM9JBBC4feubOulfmI3h1PZRRC8tmBYaqquV6W43K6f+Ij5LCqn7KiYLADIr6twZ68P+jdsJKM3FBqve5BenjH/H2cp35wv4yf9k7Z+6BDVe9cTyuAehQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006809; c=relaxed/simple;
	bh=7apc++eodbya1vbUNOU+RwOGlXlR756MQt8yqfopEe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdKNtvNnTEVCmeSi1mKY15rzkUyyKSmLahzHKKyN66waXy/GCHVBhd5/3jfS02ZCCMOwpAV/vCAf8XsnUkB+LAAGdmo9eWi4v21bM8A34bv9ZOtmPfBNdSVUuiCKIgQb85SZqzZN5IZG6FndelOJGEsDYyitQPhn9zZJYTvYIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi/zc1PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA81C4CED6;
	Mon,  3 Mar 2025 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006808;
	bh=7apc++eodbya1vbUNOU+RwOGlXlR756MQt8yqfopEe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi/zc1PB/808CvRt6KvPxPgnhfFiJ/yA1/CYUoQhuY7dczSo7delI+3/qDHuEo7TB
	 sROWAZ3Y87vgbx/A96buxMusKBGO2WxDe3zgu4SHdXterDbYNKJGGtcDQmHj1tvrUt
	 ML2uo6Y/6/lcGx5Z+GEMyrTH67sq8tQEYYyfIqHffgqtn7RLLmJBv14vXKx/OdsgPO
	 GWBz5yTgx4RAoiy0J1ROvTEUyVjneZ6wVppdffnnipRcuy0taz0ZRvqKJ2/hRqo30r
	 tsgsI3e+ZZpThdIgGZmda1XLnH9yzE1w9HTcva4b2UQytD7o1xRS3OP7yj5KG+Q1Wk
	 9Ui8UAldwnkrQ==
Date: Mon, 3 Mar 2025 14:00:02 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <Z8Wn0nTvevLRG_4m@example.org>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <20250225115736.GA18523@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225115736.GA18523@redhat.com>

On Tue, Feb 25, 2025 at 12:57:37PM +0100, Oleg Nesterov wrote:
> On 02/24, Oleg Nesterov wrote:
> >
> > Just in case, did you use
> >
> > 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c
> >
> > ?
> 
> Or did you use another version?
> 
> Exactly what parameters did you use?
> 
> If possible, please reproduce the hang again. How many threads/processes
> sleeping in pipe_read() or pipe_write() do you see? (you can look at
> /proc/$pid/stack).
> 
> Please pick one sleeping writer, and do
> 
> 	$ strace -p pidof_that_write
> 
> this should wake this writer up. If a missed wakeup is the only problem,
> hackbench should continue.
> 
> The more info you can provide the better ;)

I was also able to reproduce the hackbench hang with the parameters
mentioned earlier (threads and processes) on the kernel from master.

-- 
Rgrds, legion


