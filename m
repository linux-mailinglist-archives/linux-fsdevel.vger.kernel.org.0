Return-Path: <linux-fsdevel+bounces-33734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7F9BE39D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1CB2877C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D21DE4C5;
	Wed,  6 Nov 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHO6hjlz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358401DDA15;
	Wed,  6 Nov 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887577; cv=none; b=upPLsyfNVGEBXGWITnv+lcL4dZC0vYVhI2eLM2HU8WWlDSRupGb3RIBM9+tI59fH4c5wakwFnfwOdSDyFtTWDwpuvpiP4Mkpc7prqNEYMyEkwDF84QMi7GYpg4CQjGUJHYpx3abv8ro2BafdGpe4tnPbxAcfDKWqTqN/tTjK75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887577; c=relaxed/simple;
	bh=sLdEEwKwMLxWdWdZL65wb/2gBWurtCr+YBjQaRMnIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX0jNGbiPgpAJ8+sXvoo6LVCtfe55/7ajnC1uXS0pgecJk5Efth9paMsfT2BzpP3Ll8c77lH0EGgxoL0apvLIcM30gZauRrY5jkFdzwkVLMgp6RNFWMPNewFzv6bBQdaYKVVsLEsMTV/Of1PrBfQUjEDybZgLz+Qkj+nujx3I1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHO6hjlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C432C4CED4;
	Wed,  6 Nov 2024 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730887576;
	bh=sLdEEwKwMLxWdWdZL65wb/2gBWurtCr+YBjQaRMnIDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHO6hjlz+1cwRAj11Z0BXNSd3Yq6BnEvTZZoGBv1qhp1x7HGDkemndDVxEVMG7J51
	 Gdz8SwuQ/BfwAbWyCiYidSR2UDQ8QAqPcH9HdtDm/2jxHoLBUzwTVRM7XcSbmTizht
	 zFfSspDks1KDLvwhuUv/HuWhPE3wHyi9+vVVOVF8kNgqdHL8TT40qZKa8oUL4EBss+
	 tPpud4BB3rowu/lvm+SvsrUDIiyFr5FClJMP8DTtafe3fbi9ktfvQz/3x7HXc1hfeg
	 aXZFxzbBZ3tECD9sDCGGU5caeLzmpy2hjygUe9YclZaeK8hYsEZn2fVE0Ae5Yz51zO
	 rZA0wkMlJdM/Q==
Date: Wed, 6 Nov 2024 11:06:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241106-neukauf-befugnis-a54d08ac9b4b@brauner>
References: <20241030203732.248767-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030203732.248767-1-tycho@tycho.pizza>

On Wed, Oct 30, 2024 at 02:37:31PM -0600, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
> 
> Change exec path to fix up /proc/pid/comm in the case where we have
> allocated one of these synthetic paths in bprm_init(). This way the actual
> exec machinery is unchanged, but cosmetically the comm looks reasonable to
> admins investigating things.
> 
> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
> ---

We finally went full circle back to what was originally proposed :)

Reviewed-by: Christian Brauner <brauner@kernel.org>

