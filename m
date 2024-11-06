Return-Path: <linux-fsdevel+bounces-33730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59E9BE2D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A493F283F23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0481DB534;
	Wed,  6 Nov 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt32r2/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271F1D9329;
	Wed,  6 Nov 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885972; cv=none; b=p3cAN7spdWJ3L7EGwv+h6bjbTFhBsPhRHYoJfkXYSMhG99x+WxEEGFhfZ1jy3k8NeKvJYtqJI0IxL5zYQoC5n4iLLWC4mrPTLNaQlkqaPLX8POqr/EMhtZUctTB5bisXHVjhAR5k3rINmTxftfqGG141dnMxAj0sad3Gh785eIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885972; c=relaxed/simple;
	bh=FU5AlX4RjaYJQlbyiNQ8jSLr6xTKlU0haYRHKYTKbpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljw9ESIoEgY+ljU0MZ1rATOwICuQArNp8F9RNG4VToQTYxv7aDPpSrEjSmRzKHG3YI2n0yHPqLm86+YaOzq9nx+/trU3t/MHyTq4xnQgSfCnMIAD/eDheC2qpZ30nsUt9Ak78WlE0n2jR5P8RY7PDkLn1zsPteudvzCJMWqGWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt32r2/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FC0C4CECD;
	Wed,  6 Nov 2024 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730885972;
	bh=FU5AlX4RjaYJQlbyiNQ8jSLr6xTKlU0haYRHKYTKbpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kt32r2/jMsGs06RLAAi7ZO6XvgJUf/urcz/7ldxqPdV6rhxIK7w6n4C5IaqGNx350
	 /qo/awgFtXMTvTRlCIY8fYkXn1xShDUM800/915kEtBHt/ifPO7fbriXr7ZYl1RjIa
	 +9koIdf2WmuSWFYVXrvXul/usZWf6aOXpj/ok+LVua3AuRg4CN09dojuiPY0WEFDLG
	 Pg4u1GHLptMHrXJpIjJrNsR7iGmNfWg49E8YPmnsn9gJhYA1smCkJZjEWTWJ4zBzgm
	 8C86GtloqWFIe/U11YnUWQSHjt+kwo/nsmS9Xey5CL/pupmPHqPwp80ZLIxeCrk0HM
	 L0U3758w7ZD6w==
Date: Wed, 6 Nov 2024 10:39:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Tycho Andersen <tandersen@netflix.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: NULL out bprm->argv0 when it is an ERR_PTR
Message-ID: <20241106-balsam-untragbar-1aa86b2bb7bb@brauner>
References: <20241105181905.work.462-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105181905.work.462-kees@kernel.org>

On Tue, Nov 05, 2024 at 10:19:11AM -0800, Kees Cook wrote:
> Attempting to free an ERR_PTR will not work. ;)
> 
>     process 'syz-executor210' launched '/dev/fd/3' with NULL argv: empty string added
>     kernel BUG at arch/x86/mm/physaddr.c:23!
> 
> Set bprm->argv0 to NULL if it fails to get a string from userspace so
> that bprm_free() will not try to free an invalid pointer when cleaning up.
> 
> Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6729d8d1.050a0220.701a.0017.GAE@google.com
> Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

