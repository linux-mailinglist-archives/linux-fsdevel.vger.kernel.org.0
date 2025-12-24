Return-Path: <linux-fsdevel+bounces-72058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23385CDC4A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D92308CD9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A3331215;
	Wed, 24 Dec 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxNhUCGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007833168E1;
	Wed, 24 Dec 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580925; cv=none; b=Jz0gmWdfQ6xHQ6tdSBa+KyQv8d7iYThjiFM1W62GO/2gCjIs+6NANt4dn+dOWXQzX/ISC8FtIO+JWvnDGjQ6TNgqt1q/VC02BiTHPAgYorxN0hSqNOBB+y3aVRrM1gDti21oHUEEnXno0C66dkp+FHv+rQD91T6qXBBBZa9APGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580925; c=relaxed/simple;
	bh=HV+jkR2aJYrANOhevyxDonjSyw59TeocYws8AvK7aww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzTf54aLFxnsw9yKoLy0aNBpEUzm+2bLuMvvKcO0WCVi0p3KDLwfyJJy78DHuFTfRdwLNngUzR6octELJjXSVqhYSbN5Lh5X4AMVKxlQLVp4P05U/O+TWmql+4/dDVSclYDU0QqOfQ7bgZFwqpTF9m+YsGgSv0A+X6cWq8HLNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxNhUCGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A3CC4CEFB;
	Wed, 24 Dec 2025 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766580924;
	bh=HV+jkR2aJYrANOhevyxDonjSyw59TeocYws8AvK7aww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxNhUCGHVmDGgFhy8UcCl8YjGtq7s/BkH+GSC/QKIYiOGj5NZV1R+y0tEgFbKCwCG
	 VId+7xjJqon3iigh1x+LzLPl8Hyo4DgZbsL/W3PiTR8G5nGBUwZEcIEPi9BgB/NzIa
	 LpqzfUolC3ZZ9bWMB3PFZo9l/BUw1h+tER7KZt9QPJPDJQfSMDvn9ozUMF9lT0pfw7
	 2YEZxRn/JeJ9dKLab7cTLHcigf2Wh5u32V0mWerkrfbZXmyMlzY8vqmWVJVpukpIXb
	 FMHOQT7ySmU5IV5B5E3mAxySP7AfPcd08QYWFbyFexBS8PzkTO3VrGJ6OzgHsnVcP7
	 iHW/Poce03KJQ==
Date: Wed, 24 Dec 2025 13:55:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Dan Klishch <danilklishch@gmail.com>, 
	containers@lists.linux-foundation.org, ebiederm@xmission.com, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <20251224-glasbruch-mahnmal-ef7e9e10bceb@brauner>
References: <aT_elfmyOaWuJRjW@example.org>
 <20251215144600.911100-1-danilklishch@gmail.com>
 <aUAiIkNPgied0Tyf@example.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUAiIkNPgied0Tyf@example.org>

On Mon, Dec 15, 2025 at 03:58:42PM +0100, Alexey Gladkov wrote:
> On Mon, Dec 15, 2025 at 09:46:00AM -0500, Dan Klishch wrote:
> > On 12/15/25 5:10 AM, Alexey Gladkov wrote:
> > > On Sun, Dec 14, 2025 at 01:02:54PM -0500, Dan Klishch wrote:
> > >> On 12/14/25 11:40 AM, Alexey Gladkov wrote:
> > >>> But then, if I understand you correctly, this patch will not be enough
> > >>> for you. procfs with subset=pid will not allow you to have /proc/meminfo,
> > >>> /proc/cpuinfo, etc.
> > >>
> > >> Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
> > >> tree to the sandboxed programs (empirically, this is enough for most of
> > >> programs you want sandboxing for). With that in mind, this patch and a
> > >> FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
> > >> /proc/cpuinfo / a small kernel patch with a new mount option for procfs
> > >> to expose more static files still look like a clean solution to me.
> > > 
> > > I don't think you'll be able to do that. procfs doesn't allow itself to
> > > be overlayed [1]. What should block mounting overlayfs and fuse on top
> > > of procfs.
> > > 
> > > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/proc/root.c#n274
> > 
> > This is why I have been careful not to say overlayfs. With [2] (warning:
> > zero-shot ChatGPT output), I can do:
> > 
> > $ ./fuse-overlay target --source=/proc
> > $ ls target
> > 1   88   194   1374    889840  908552
> > 2   90   195   1375    889987  908619
> > 3   91   196   1379    890031  908658
> > 4   92   203   1412    890063  908756
> > 5   93   205   1590    890085  908804
> > 6   94   233   1644    890139  908951
> > 7   96   237   1802    890246  909848
> > 8   97   239   1850    890271  909914
> > 10  98   240   1852    894665  909924
> > 13  99   243   1865    895854  909926
> > 15  100  244   1888    895864  910005
> > 16  102  246   1889    896030  acpi
> > 17  103  262   1891    896205  asound
> > 18  104  263   1895    896508  bus
> > 19  105  264   1896    896544  driver
> > 20  106  265   1899    896706  dynamic_debug
> > <...>
> > 
> > [2] https://gist.github.com/DanShaders/547eeb74a90315356b98472feae47474
> > 
> > This requires a much more careful thought wrt magic symlinks
> > and permission checks. The fact that I am highly unlikely to 100%
> > correctly reimplement the checks and special behavior of procfs makes me
> > not want to proceed with the FUSE route.
> > 
> > On 12/15/25 6:30 AM, Christian Brauner wrote:
> > > The standard way of making it possible to mount procfs inside of a
> > > container with a separate mount namespace that has a procfs inside it
> > > with overmounted entries is to ensure that a fully-visible procfs
> > > instance is present.
> > 
> > Yes, this is a solution. However, this is only marginally better than
> > passing --privileged to the outer container (in a sense that we require
> > outer sandbox to remove some protections for the inner sandbox to work).
> > 
> > > The container needs to inherit a fully-visible instance somehow if you
> > > want nesting. Using an unprivileged LSM such as landlock to prevent any
> > > access to the fully visible procfs instance is usually the better way.
> > > 
> > > My hope is that once signed bpf is more widely adopted that distros will
> > > just start enabling blessed bpf programs that will just take on the
> > > access protecting instead of the clumsy bind-mount protection mechanism.
> > 
> > These are big changes to container runtimes that are unlikely to happen
> > soon. In contrast, the patch we are discussing will be available in 2
> > months after the merge for me to use on ArchLinux, and in a couple more
> > months on Ubuntu.
> > 
> > So, is there any way forward with the patch or should I continue trying
> > to find a userspace solution?
> 
> I still consider these patches useful. I made them precisely to remove
> some of the restrictions we have for procfs because of global files in
> the root of this filesystem.
> 
> I can update and prepare a new version of patchset if Christian thinks
> it's useful too.

Let's see it at least! No need to preemptively dismiss it. :)

