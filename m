Return-Path: <linux-fsdevel+bounces-44690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E2A6B644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A67486809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FB1EFFB0;
	Fri, 21 Mar 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3i3J29x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F68BEE;
	Fri, 21 Mar 2025 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546967; cv=none; b=TrDUJGNU+/oYWtgkZqXAOgnI5DiVwq16gdItceRvXjKvwBkpQ4tTi8/gvwJMYjTD5l5HoJMXCQ7mhS1sggjZFVg4+AxhrxqA+8u47Eu2kTx7oKq2Wa97yzvnCzJ9U2brKDyJ3BqlHvVZQXVfoYfW9CySRUjxwTd6Z1fLhRlpZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546967; c=relaxed/simple;
	bh=5tlGgGOCOEOLWJ760wOpsG4r1f3W2XkvMyV+/1s6GOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PksVeNcYSjkiIv69upS9HQ3qSMmlm/V/MsbrjhVQgQ9xK9gcvtyAmuB+j96ERVjbmYKKUE6YrTIVbjNKc+tH9Fr7t6apOvXLJ+dqrz346eWrMRrlMBpa4jkPwv6xyGAs4WMjAFVG8yRwQ6JhVT/sv7k4tUANdQQDcqWdln174Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3i3J29x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2079C4CEE3;
	Fri, 21 Mar 2025 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742546967;
	bh=5tlGgGOCOEOLWJ760wOpsG4r1f3W2XkvMyV+/1s6GOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3i3J29xLh9feBsXQsFiKfXEO1feWq+/yRnT/MwgquJeNQnQNNExeJOFxMPSwy/fa
	 a6P6AQ4kdl7wnGdn/BNYNBvIxAjJvFgOPEmttCLCmRSvt9Ti/Y2TYFzDpSa5YupiNE
	 kiUXH5Oz1raV0Zar7sCOFbTl5qelxyM3NyD66YEoWu2jxQRvNwR/3dmhgrdwWeVv3a
	 mDn/70ckUyPjO2w5YcOd8gPK/6QNiSitxvlGEBHtIPD5WqxpN1yNPic4tAyM1h4S+N
	 5OwZ6K7r9i7cycDAAUJZfiYQPD38rFaHaFa+jcsn2+tA4psIGfLwQVIcqFNkPGLlIm
	 LLMz5mH0Nq3Ow==
Date: Fri, 21 Mar 2025 09:49:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250321-languste-farbig-e68aef9f4ac8@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321014423.GA2023217@ZenIV>
 <202503210019.F3C6D324@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202503210019.F3C6D324@keescook>

On Fri, Mar 21, 2025 at 01:10:26AM -0700, Kees Cook wrote:
> On Fri, Mar 21, 2025 at 01:44:23AM +0000, Al Viro wrote:
> > On Thu, Mar 20, 2025 at 01:09:38PM -0700, Kees Cook wrote:
> > 
> > > What I can imagine here is two failing execs racing a fork:
> > > 
> > > 	A start execve
> > > 	B fork with CLONE_FS
> > > 	C start execve, reach check_unsafe_exec(), set fs->in_exec
> > > 	A bprm_execve() failure, clear fs->in_exec
> > > 	B copy_fs() increment fs->users.
> > > 	C bprm_execve() failure, clear fs->in_exec
> > > 
> > > But I don't think this is a "real" flaw, though, since the locking is to
> > > protect a _successful_ execve from a fork (i.e. getting the user count
> > > right). A successful execve will de_thread, and I don't see any wrong
> > > counting of fs->users with regard to thread lifetime.
> > > 
> > > Did I miss something in the analysis? Should we perform locking anyway,
> > > or add data race annotations, or something else?
> > 
> > Umm...  What if C succeeds, ending up with suid sharing ->fs?
> 
> I still can't quite construct it -- fs->users is always correct, I
> think?
> 
> Below would be the bad set of events, but it's wrong that "fs->users==1".
> If A and C are both running with CLONE_FS then fs->users==2. A would need to
> exit first, but it can't do that and also set fs->in_exec=0
> 
> A execve, reaches bprm_execve() failure path
> B fork with CLONE_FS, reaches copy_fs()
> C execve, reaches check_unsafe_exec()
> C takes fs->lock, counts, finds safe fs->users==1, sets in_exec=1, unlocks
> A sets fs->in_exec=0
> B takes fs->lock, sees in_exec==0, does fs->users++, unlocks
> C goes setuid, sharing fs with unpriv B
> 
> Something still feels very weird, though. Does fs->in_exec not matter at
> all? Hmm, no, it stops fs->users++ happening after it was validated to be 1.

This is a harmless data race afaict. See my other mail.

