Return-Path: <linux-fsdevel+bounces-30004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848E984CF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 23:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C032B21F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE60413D8B4;
	Tue, 24 Sep 2024 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1wU9e5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572613B792;
	Tue, 24 Sep 2024 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213834; cv=none; b=ASarooNAgzQsNvfj88hkO1I7ZOa9wf6GqyRV1wON3rgu4IhKYszDuxUH9RUQC8fx9v93gQJQ4TysXtodCdAQ+a6RigyaP33yRNxVip3+Rs22XoWv5c6U0B/F5k5Wjucu0v18rBQHCSe2V/UMCaSoqjPAyD/a+oo1HDZNUGSe1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213834; c=relaxed/simple;
	bh=NtcrugAuxPs+bS2qbXsCsi/0ivuoPlB+E91MIF93xHM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mddBwf6HsVXbYvCKZoTrNvBX9VLoMwoALh8Z0OpB2fo/nZpGqvaQzPlQF0Rb5HfhwDUJuwuvt70MJG54w0q7njlSkdtPXd96cc4R760ehHKbabGxQgyrlkve9VBfft4T32opQVN4+WfU6HdBH65O0cJaaOY3chkr4Rqp2LOs7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1wU9e5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D76C4CEC4;
	Tue, 24 Sep 2024 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727213833;
	bh=NtcrugAuxPs+bS2qbXsCsi/0ivuoPlB+E91MIF93xHM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=E1wU9e5+Uxs1EPbT3y1RQHBRU4n8g2E0EpNj535Lxwq4CeSfBXXuCqWXpuvOmkZ9K
	 HsVfsDabyS+BRUlmrfhayYio9AhH3Q4iFQ5JN4BzMg1WJXRiu7uvNsn9cMi0XIKslQ
	 YHWgyJbyH6fSVsRn+4ryQy0bnFuy8E/NSTuq51hnTNQBpdKF+viHNgxj5xLAdsrIcw
	 kfWYhhwHre4ROvWcDWkP0dT5Ty9XH0lni8CFkd+wSjYZ2k8z0asV513mjpcBrrqa/M
	 DsJsSQDmxfjF1wXIG01zLkuTkbAl8AFhaQvNHsVWa0fkxTLb4/5+HpFEKqIghLbZhz
	 wwNoqesepyRag==
Date: Tue, 24 Sep 2024 14:37:13 -0700
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Tycho Andersen <tycho@tycho.pizza>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Tycho Andersen <tandersen@netflix.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
User-Agent: K-9 Mail for Android
In-Reply-To: <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
References: <20240924141001.116584-1-tycho@tycho.pizza> <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
Message-ID: <8D545969-2EFA-419A-B988-74AD0C26020C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 24, 2024 10:39:35 AM PDT, "Eric W=2E Biederman" <ebiederm@xmi=
ssion=2Ecom> wrote:
>Tycho Andersen <tycho@tycho=2Epizza> writes:
>
>> From: Tycho Andersen <tandersen@netflix=2Ecom>
>>
>> Zbigniew mentioned at Linux Plumber's that systemd is interested in
>> switching to execveat() for service execution, but can't, because the
>> contents of /proc/pid/comm are the file descriptor which was used,
>> instead of the path to the binary=2E This makes the output of tools lik=
e
>> top and ps useless, especially in a world where most fds are opened
>> CLOEXEC so the number is truly meaningless=2E

And just to double check: systemd's use would be entirely cosmetic, yes?

>>
>> This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
>> contents of argv[0], instead of the fdno=2E
>
>The kernel allows prctl(PR_SET_NAME, =2E=2E=2E)  without any permission
>checks so adding an AT_ flat to use argv[0] instead of the execed
>filename seems reasonable=2E
>
>Maybe the flag should be called AT_NAME_ARGV0=2E

If we add an AT flag I like this name=2E

>
>
>That said I am trying to remember why we picked /dev/fd/N, as the
>filename=2E
>
>My memory is that we couldn't think of anything more reasonable to use=2E
>Looking at commit 51f39a1f0cea ("syscalls: implement execveat() system
>call") unfortunately doesn't clarify anything for me, except that
>/dev/fd/N was a reasonable choice=2E
>
>I am thinking the code could reasonably try:
>	get_fs_root_rcu(current->fs, &root);
>	path =3D __d_path(file->f_path, root, buf, buflen);
>
>To see if a path to the file from the current root directory can be
>found=2E  For files that are not reachable from the current root the code
>still need to fallback to /dev/fd/N=2E
>
>Do you think you can investigate that and see if that would generate
>a reasonable task->comm?
>
>If for no other reason than because it would generate a usable result
>for #! scripts, without /proc mounted=2E
>
>
>It looks like a reasonable case can be made that while /dev/fd/N is
>a good path for interpreters, it is never a good choice for comm,
>so perhaps we could always use argv[0] if the fdpath is of the
>form /dev/fd/N=2E

I haven't had a chance to go look closely yet, but this was the same thoug=
ht I had when I first read this RFC=2E Nobody really wants a dev path in co=
mm=2E Can we do this unconditionally? (And if argv0 is empty, use dev path=
=2E=2E=2E)

>All of that said I am not a fan of the implementation below as it has
>the side effect of replacing /dev/fd/N with a filename that is not
>usable by #! interpreters=2E  So I suggest an implementation that affects
>task->comm and not brpm->filename=2E

Also agreed=2E There is already enough fiddly usage of the bprm filename/i=
nterpreter/fdpath members -- the argv0 stuff should be distinct=2E Perhaps =
store a pointer to argv0 during arg copy? I need to go look but I'm still A=
FK/OoO=2E=2E=2E

-Kees

--=20
Kees Cook

