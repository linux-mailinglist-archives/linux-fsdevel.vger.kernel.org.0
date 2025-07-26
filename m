Return-Path: <linux-fsdevel+bounces-56094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD0B12D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 01:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EBB3B7C61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE422D4C8;
	Sat, 26 Jul 2025 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP6TEdb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986261A239D;
	Sat, 26 Jul 2025 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571960; cv=none; b=mpREGK8/QpPUtoLe5p2ZTRSUa4BrYYlb6ego8X72PTbuK//4lVUf0QMCMKPf6S3pW2GN15yu9e4OvfLg8t7NMkk0SUwrEWFGnMGAi8JOd/jl5cheJpZiAA+P9DAe2c51kOKqxZNIaP1j8w4rj0CCHSCge/UGsR/OTwU9Hfiy8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571960; c=relaxed/simple;
	bh=EDGIW+TH9vAlNoQvdFdR+qpWRbp6aLgiXKsAT00qYJA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mHu0LaN9YhytRD8LTby/TWycsI0+YBkW9/e44QC9ReaEomOtU452MDB5tIqlRVZ/dhTY7rnZOc1WSs0tJVaTzlQFd1lrjtDxaz+9tM2Dg6ozFEbjNr0nzvnAiaZxGNQTJYZogECnPNGGMg9VoiWFyKbTm5LKzktI3nZokj79z/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP6TEdb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D9CC4CEED;
	Sat, 26 Jul 2025 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753571960;
	bh=EDGIW+TH9vAlNoQvdFdR+qpWRbp6aLgiXKsAT00qYJA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oP6TEdb7YE2T2S8Ap9nwc/X3asue9bKewcgHIuUVA3FoCpyOmXmfThSlzYPyAK/rP
	 4QmN0JpN+rFzUZGkj7ZfF+6czDfH3GIzjeosnlj8ZOiateuLnVjtxdSz4wROmB22Fe
	 vfrhicja1vsznPCIbFme0J4tO5KEpXgaiaY+tIDY9AwqLc2dTu1wu19uR7qZEUmZ/g
	 OEgxNsGwqMrDhnvjqnWWGtfTN0rV/BICgDQCteeZ6t/gqmEDxcGxYzVjvKStGgtfOW
	 na16XywlEeyZIaWoOiS06QOBLiNnnO6YFDoUHguGw1tVAVRvr6V1alfU6Krbou9WWZ
	 q88hFGa4q31RQ==
Date: Sat, 26 Jul 2025 16:19:18 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_2/3=5D_treewide=3A_Switch_memcpy=28=29_use?=
 =?US-ASCII?Q?rs_of_=27task-=3Ecomm=27_to_a_more_safer_implementation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com> <202507241640.572BF86C70@keescook> <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
Message-ID: <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 26, 2025 10:50:55 AM PDT, Linus Torvalds <torvalds@linux-foundatio=
n=2Eorg> wrote:
>, but
>
>On Thu, 24 Jul 2025 at 16:49, Kees Cook <kees@kernel=2Eorg> wrote:
>>
>> Why not switch all of these to get_task_comm()? It will correctly handl=
e
>> the size check and NUL termination=2E
>
>I'd rather aim to get rid of get_task_comm() entirely=2E

That works for me! I just get twitchy around seeing memcpy used for string=
s=2E :) if we're gonna NUL after the memcpy, just use strscpy_pad()=2E

>And guess what? We *have* that function=2E It's called "strscpy()"=2E It
>already does the right thing, including passing in the size of a fixed
>array and just dealing with it the RightWay(tm)=2E Add '_pad()' if that
>is the behavior you want, and now you *document* the fact that the
>result is padded=2E

Exactly=2E Let's see how much we can just replace with strscpy_pad()=2E It=
 we have other use cases, we can handle those separately=2E

-Kees

--=20
Kees Cook

