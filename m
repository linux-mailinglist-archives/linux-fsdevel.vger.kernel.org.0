Return-Path: <linux-fsdevel+bounces-40460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5A0A237DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 00:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F1918865B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB51F1908;
	Thu, 30 Jan 2025 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kDjQDA34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A61BCA19;
	Thu, 30 Jan 2025 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279958; cv=none; b=bQ67QqVXdn2kmzbf0PP2v4pWy8W31him14uPlH8ZYC1r7mQ9wlpMtxDXlN8RloTarGRvU47zNiNMN4Zhw6Te31+1EOpzcmDTLjsQYV908+rmgZbN3yc05VgWSd/5z88juNeeOuwkKac+apcJXY2S0IOdMUyIAQnumYHZkHj4pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279958; c=relaxed/simple;
	bh=YAzBNh858f16eQEi0uSmSjC9dMjnfA4uRjmAO5bbijw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eR7Q8qJIs60eHyQRYJndUpvXt3vqivb7yPucrlJzfsYwVaVGudAZqKy2LGUqZLY1qpl5sc3871nyLKQrCnfvv2IXme/Sqxvq+9WafJmPeaX2kez5ulV5HZFwGZU1wfPUJFg+mT0j/M+hqSEgOHDiRiqwZIJnic6beRSiKtCAYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kDjQDA34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2DFC4CED2;
	Thu, 30 Jan 2025 23:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738279958;
	bh=YAzBNh858f16eQEi0uSmSjC9dMjnfA4uRjmAO5bbijw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kDjQDA34++J2dlg4xnSfBBzDGSZ9KV1AVth9tRi7nQM1MzdQy8IAw8MQv3TJ4dwN3
	 ajEPilD9kq7WlfiYeJZAQSc+8rX9QtpewvToUCXtKMTFy4xxZgf5H4x5RNDUmJArHO
	 1cEMsa3iGgdEttezd9z+qK8xLdpIGN2kAvjy2tiM=
Date: Thu, 30 Jan 2025 15:32:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Christian Brauner
 <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Sang
 <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny
 <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-Id: <20250130153236.198664b9a19ccfcdb24f888b@linux-foundation.org>
In-Reply-To: <CAKbZUD3w4_4MjrME-0mgRL01eFggb7et2BLa6012tzQX78KK9w@mail.gmail.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
	<20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
	<b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
	<CAKbZUD3w4_4MjrME-0mgRL01eFggb7et2BLa6012tzQX78KK9w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jan 2025 23:10:53 +0000 Pedro Falcato <pedro.falcato@gmail.com> wrote:

> On Thu, Jan 30, 2025 at 10:53 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > > The above code sequence doesn't seem at all onerous.  I'm not
> > > understanding why it's worth altering the kernel to permit this little
> > > shortcut?
> >
> > In practice it adds quite a bit of overhead for something that whatever
> > mechanism is using the pidfd can avoid.
> >
> > It was specifically intended for a real case of utilising
> > process_madvise(), using the newly extended ability to batch _any_
> > madvise() operations for the current process, like:
> >
> >         if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)) {
> >             ... error handling ...
> >         }
> >
> > vs.
> >
> >         pid_t pid = getpid();
> >         int pidfd = pidfd_open(pid, PIDFD_THREAD);
> >
> >         if (pidfd < 0) {
> >            ... error handling ...
> >         }
> >
> >         if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)) {
> >            ... cleanup pidfd ...
> >            ... error handling ...
> >         }
> >
> >         ...
> >
> >         ... cleanup pidfd ...
> >
> > So in practice, it's actually a lot more ceremony and noise. Suren has been
> > working with this code in practice and found this to be useful.
> 
> It's also nice to add that people on the libc/allocator side should
> also appreciate skipping pidfd_open's reliability concerns (mostly,
> that RLIMIT_NOFILE Should Not(tm) ever affect thread spawning or a
> malloc[1]). Besides the big syscall reduction and nice speedup, that
> is.
> 
> [1] whether this is the already case is an exercise left to the
> reader, but at the very least we should not add onto existing problems

Thanks.

Could we please get all the above spelled out much more thoroughly in
the [0/n] description (aka Patch Series Sales Brochure)?

