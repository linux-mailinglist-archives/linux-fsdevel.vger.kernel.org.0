Return-Path: <linux-fsdevel+bounces-71308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4E8CBD7F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7FF43014ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFDD314D35;
	Mon, 15 Dec 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzuoSkBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79491DED5C;
	Mon, 15 Dec 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798244; cv=none; b=b8klh8rFh8wRJu6jggkNbS16K6UsEA0RFsffWokZtmVdljmTpEE6I9QnD4pgCGmcENsSafPRuK2fjgynBTH8NTdtxInIR4r2ifZtu+QBAkYYVBqGm4LiXgXJXgQBA5XV0VN8F2Xfa/WowZEXMd5rQltZ+u5ufpSPTRRkgl829PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798244; c=relaxed/simple;
	bh=s/38Q6D3av09sHqEtR91fHd+Gd7ulM/Gq8fa/HTIbEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCUePTyh7+JIZViDkI6UKyOWastQ3wEdYv+sZJ7Mf8PDJ8OHOTW7ldkm64smyAFBUeXOAiWKJWrLIu+rx78GIBue1spXlkttq4BYWL1XI6XSM+K7mOdUQFuBRHrOuIIC7X6guddJ4TQb8LPSmwQxGjtqBSOr8p0+ypKYT3r45uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzuoSkBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E802C4CEF5;
	Mon, 15 Dec 2025 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765798244;
	bh=s/38Q6D3av09sHqEtR91fHd+Gd7ulM/Gq8fa/HTIbEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzuoSkBjWpzFl7OPDJScFCfS+Y5pRbcre86pc5Q7WeGi8duthTkO1f7iE8VBRC0br
	 9RKIcKCZqrCGAzkp0xazh3Y6gayHVumfESltYkMzmmeXYnEUyX7iUKkNItxsljhuCo
	 8NnyB2UXeXntIEw93gH2t9mqGRoH0ECes2hTljRyZ91HxPE0NKMjMJngqVZs05Ltts
	 cOelCOUZg80ZmM5Rg+jWbJ8SrRd6fAbqhT3tTbEcCywSltRu84jRXLjbiFTBm9Gd69
	 wltuP/VCAPMn/UF3vRPyYdNy1nwsDymGeiTtKZtEs3683VFd1V175s/oIuvG5KLhLM
	 k04GfNTjZSDeA==
Date: Mon, 15 Dec 2025 12:30:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dan Klishch <danilklishch@gmail.com>
Cc: legion@kernel.org, containers@lists.linux-foundation.org, 
	ebiederm@xmission.com, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH v6 0/5] proc: subset=pid: Relax check of mount
 visibility
Message-ID: <20251215-zuzug-unklug-2b0ac36d882b@brauner>
References: <aT7ohARHhPEmFlW9@example.org>
 <20251214180254.799969-1-danilklishch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251214180254.799969-1-danilklishch@gmail.com>

On Sun, Dec 14, 2025 at 01:02:54PM -0500, Dan Klishch wrote:
> On 12/14/25 11:40 AM, Alexey Gladkov wrote:
> > But then, if I understand you correctly, this patch will not be enough
> > for you. procfs with subset=pid will not allow you to have /proc/meminfo,
> > /proc/cpuinfo, etc.
> 
> Hmm, I didn't think of this. sunwalker-box only exposes cpuinfo and PID
> tree to the sandboxed programs (empirically, this is enough for most of
> programs you want sandboxing for). With that in mind, this patch and a
> FUSE providing an overlay with cpuinfo / seccomp intercepting opens of
> /proc/cpuinfo / a small kernel patch with a new mount option for procfs
> to expose more static files still look like a clean solution to me.

The standard way of making it possible to mount procfs inside of a
container with a separate mount namespace that has a procfs inside it
with overmounted entries is to ensure that a fully-visible procfs
instance is present. This is for example what Incus does when nesting
containers is enabled. In systemd I implemented the same logic years
ago:

commit b71a0192c040f585397cfc6fc2ca025bf839733d
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Mon Nov 28 12:36:47 2022 +0100
Commit:     Christian Brauner (Microsoft) <brauner@kernel.org>
CommitDate: Mon Dec 5 18:34:25 2022 +0100

    nspawn: mount temporary visible procfs and sysfs instance

    In order to mount procfs and sysfs in an unprivileged container the
    kernel requires that a fully visible instance is already present in the
    target mount namespace. Mount one here so the inner child can mount its
    own  instances. Later we umount the temporary  instances created here
    before we actually exec the payload. Since the rootfs is shared the
    umount will propagate into the container. Note, the inner child wouldn't
    be able to unmount the  instances on its own since it doesn't own the
    originating mount namespace. IOW, the outer child needs to do this.

    So far nspawn didn't run into this issue because it used MS_MOVE which
    meant that the shadow mount tree pinned a procfs and sysfs instance
    which the kernel would find. The shadow mount tree is gone with proper
    pivot_root() semantics.

    Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> 
> >> Also, correct me if I am wrong, installing ebpf controller requires
> >> CAP_BPF in initial userns, so rootless podman will not be able to mask
> >> /proc "properly" even if someone sends a patch switching it to ebpf.

The container needs to inherit a fully-visible instance somehow if you
want nesting. Using an unprivileged LSM such as landlock to prevent any
access to the fully visible procfs instance is usually the better way.

My hope is that once signed bpf is more widely adopted that distros will
just start enabling blessed bpf programs that will just take on the
access protecting instead of the clumsy bind-mount protection mechanism.

