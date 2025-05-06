Return-Path: <linux-fsdevel+bounces-48262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37763AAC937
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEC63BFB63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB92836B9;
	Tue,  6 May 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZHWO0Xo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914802820AD;
	Tue,  6 May 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544580; cv=none; b=XZ1XSNl0vz2vUynkEj65fTpIl0DG2nVws8BUgsQCmCLS/C2KVFp067HfvVNyAkj2NSbdkOHvKwuUxiQeHlWCftgfkE3gT+xhzcpF0dkMw2hEYxkd7bltSbzhgmFHiM7vgUOJ9mPP9rUDadxZFU8CxUEirwVgDQvmnc9r5Z0TAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544580; c=relaxed/simple;
	bh=naRIGT9bNmnyTwCeYsDh26MXmT+E8I5q52WbiTq7jDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqxa2yaMTWaiHzNTVp2+0rlrWFdW18dYIuPK4BSVH1re8r6DII2wttwAemx8wMsCBgBaBcSf4jsbTbRDeR864+YzsxI29Gmcg02xnpX1EBuSwZXyu3RHBzj58DV7Bf17Vd9R0bXf1VsvcA7RTs2XxOPYh8l+HmjD7F9PcNab7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZHWO0Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C126AC4CEE4;
	Tue,  6 May 2025 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746544580;
	bh=naRIGT9bNmnyTwCeYsDh26MXmT+E8I5q52WbiTq7jDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZHWO0XozeoojF9UoUCYbQyQ2FQ4xWRYcrK044hkRHan4feYYOV6LyOER+Fqx/nl/
	 ivRry4m80z+BRFZ5SGbzwx3YqhOhJWOLOU/wVMOZa+wmUTpDAPiodp8WaFB7H1iMoZ
	 lLzChHbyRGgA+PyevcK02CTEZasoRQEMLqkOJHIirfeyvmJmBGDMgmROiDDjZDudPr
	 +GSmvqmh9hdCPUJLVBQ6xODHKygrlI+TGIhOiP1QzsJW8+vrnFT9aL3lPOvBNfiT0u
	 8qngz+axQ7vMWI63VtCQ/9k++i1mnsxI+DkLDaINiAY7OIaqfNF3fIY8/PqssVNHU/
	 UphYrlGrHl/pQ==
Date: Tue, 6 May 2025 17:16:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alexander@mihalicyn.com, 
	bluca@debian.org, daan.j.demeyer@gmail.com, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, oleg@redhat.com, 
	pabeni@redhat.com, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow
 coredumping tasks to connect to coredump socket
Message-ID: <20250506-buchmacher-gratulant-9960af036671@brauner>
References: <20250505193828.21759-1-kuniyu@amazon.com>
 <20250505194451.22723-1-kuniyu@amazon.com>
 <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>
 <20250506-zertifikat-teint-d866c715291a@brauner>
 <CAG48ez25gm3kgrS_q3jPiN0k6+-AMbNG4p9MPAD4E1WByc=VBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez25gm3kgrS_q3jPiN0k6+-AMbNG4p9MPAD4E1WByc=VBA@mail.gmail.com>

On Tue, May 06, 2025 at 04:51:25PM +0200, Jann Horn wrote:
> On Tue, May 6, 2025 at 9:39 AM Christian Brauner <brauner@kernel.org> wrote:
> > > ("a kernel socket" is not necessarily the same as "a kernel socket
> > > intended for core dumping")
> >
> > Indeed. The usermodehelper is a kernel protocol. Here it's the task with
> > its own credentials that's connecting to a userspace socket. Which makes
> > this very elegant because it's just userspace IPC. No one is running
> > around with kernel credentials anywhere.
> 
> To be clear: I think your current patch is using special kernel
> privileges in one regard, because kernel_connect() bypasses the
> security_socket_connect() security hook. I think it is a good thing
> that it bypasses security hooks in this way; I think we wouldn't want
> LSMs to get in the way of this special connect(), since the task in
> whose context the connect() call happens is not in control of this
> connection; the system administrator is the one who decided that this
> connect() should happen on core dumps. It is kind of inconsistent
> though that that separate security_unix_stream_connect() LSM hook will
> still be invoked in this case, and we might have to watch out to make
> sure that LSMs won't end up blocking such connections... which I think

Right, it is the same as for the usermode helper. It calls
kernel_execve() which invokes at least security_bprm_creds_for_exec()
and security_bprm_check(). Both of which can be used to make the
usermodehelper execve fail.

Fwiw, it's even the case for dumping directly to a file as in that case
it's subject to all kinds of lookup and open security hooks like
security_file_open() and then another round in do_truncate().

All of that happens fully in the task's context as well via
file_open()/file_open_root() or do_truncate().

So there's nothing special here.

