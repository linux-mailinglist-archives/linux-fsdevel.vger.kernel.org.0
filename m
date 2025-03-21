Return-Path: <linux-fsdevel+bounces-44684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F99A6B5C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE013B76EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32A1EF087;
	Fri, 21 Mar 2025 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IniCyGxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F379EA;
	Fri, 21 Mar 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544630; cv=none; b=IS93wfXAJB9eyeYl2+teSd/tj2DbkAEykpt/6Egt4eD7trpWh0u/0/fY3RcYEOxV2MJJVpH8ySKaOSv7zyubquGrtwqo4CvrbnGNSeb6tKbpXxcBzNzTVQRwvV0rJNBqOwylwKKghSDV6ylbcCeaDLClytlVn5zTHN5D18U/bWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544630; c=relaxed/simple;
	bh=CewbNIIS6U+waYSVoQrgh6okwCFZo0yqerVt8T81p3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU9uQbaZG1N2ZXO/Z8oDCEJ6/gTs/ucBj0Vio1IetoHjxMpUaO+PcCT5CpTpUl7Ui4Nk/83aqGyd1bQBMq61sPuXSUttnoKnd2k1NmSlgTHX++mpuLO9GMa9WZeUWFZXpvuy6B5YBsEJSAiVqGwSGXg2gK2ThPkOCnwOAzWQEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IniCyGxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B03AC4CEE3;
	Fri, 21 Mar 2025 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742544629;
	bh=CewbNIIS6U+waYSVoQrgh6okwCFZo0yqerVt8T81p3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IniCyGxckzZtWj+2dlbb0v64OvYg+bqfKE3IRnc0vd40Sch4Ao4rCs4gqE9RWBRmk
	 agZy2UJsw0/6iXUdOtguUQIwjnkhzHR1T/8wjKqQqXeY5rmTsXmZsnGmhLewHWziqs
	 S8okXkG1Zo0sS3kUSx/dV6erJKLVt6sV2gv9NNT7N4vAg2MKFJ2sudPOpC8gWE+ffR
	 ogp+s89hcRX5EDW6CyTE2QYwczzCWfRdvLTsS8AJD76nvB8GHLgR7FL5BRdcxFAYWY
	 GpPC4cCSkGuB6W1tFn28/gf96wrZDPkePQWPKLH+SvbOZO6B7Xw284VGdl5pmDamVS
	 96L2717LMZRJA==
Date: Fri, 21 Mar 2025 01:10:26 -0700
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <202503210019.F3C6D324@keescook>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321014423.GA2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321014423.GA2023217@ZenIV>

On Fri, Mar 21, 2025 at 01:44:23AM +0000, Al Viro wrote:
> On Thu, Mar 20, 2025 at 01:09:38PM -0700, Kees Cook wrote:
> 
> > What I can imagine here is two failing execs racing a fork:
> > 
> > 	A start execve
> > 	B fork with CLONE_FS
> > 	C start execve, reach check_unsafe_exec(), set fs->in_exec
> > 	A bprm_execve() failure, clear fs->in_exec
> > 	B copy_fs() increment fs->users.
> > 	C bprm_execve() failure, clear fs->in_exec
> > 
> > But I don't think this is a "real" flaw, though, since the locking is to
> > protect a _successful_ execve from a fork (i.e. getting the user count
> > right). A successful execve will de_thread, and I don't see any wrong
> > counting of fs->users with regard to thread lifetime.
> > 
> > Did I miss something in the analysis? Should we perform locking anyway,
> > or add data race annotations, or something else?
> 
> Umm...  What if C succeeds, ending up with suid sharing ->fs?

I still can't quite construct it -- fs->users is always correct, I
think?

Below would be the bad set of events, but it's wrong that "fs->users==1".
If A and C are both running with CLONE_FS then fs->users==2. A would need to
exit first, but it can't do that and also set fs->in_exec=0

A execve, reaches bprm_execve() failure path
B fork with CLONE_FS, reaches copy_fs()
C execve, reaches check_unsafe_exec()
C takes fs->lock, counts, finds safe fs->users==1, sets in_exec=1, unlocks
A sets fs->in_exec=0
B takes fs->lock, sees in_exec==0, does fs->users++, unlocks
C goes setuid, sharing fs with unpriv B

Something still feels very weird, though. Does fs->in_exec not matter at
all? Hmm, no, it stops fs->users++ happening after it was validated to be 1.

-- 
Kees Cook

