Return-Path: <linux-fsdevel+bounces-13583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830748718D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2434F1F227D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4773658AD0;
	Tue,  5 Mar 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IME+OWbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923715813A;
	Tue,  5 Mar 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629194; cv=none; b=awtfFBMxUBQO8ScHkfpy2jQV1uzgUUfMzI9VoDmRM4eaKgRYi2PdtBoAqz6SfEMdDYYh1Vep+M/bz9tfjZmNxyb6j88/u6wrdrauoraO5aWsoUfI8DTBghH5tW4JIgwOMndqEZmMG7nFfedXfIh5Qel2zKT456281iIcfFDzPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629194; c=relaxed/simple;
	bh=XbombLgpeTpgZvWPzyytQgy9Bb7OJQiVvwNOlRi2GNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSbIftkiwDV5uBca/P3IEKlZXN0Pz/APEcj+sshdsN3YFTz0lqXJtNFCJ5ld0Ljp/szqRyF5CA5k4WP3Nk+oT7eqfUf6VEhtoorFQzMhjR69pxmJ9kHh+BDgrpJIO1nySu/28s7+t3r1q8XSXh+6TBTnH+WEcWOlYNTlnzCc/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IME+OWbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2422C433F1;
	Tue,  5 Mar 2024 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709629194;
	bh=XbombLgpeTpgZvWPzyytQgy9Bb7OJQiVvwNOlRi2GNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IME+OWbYznnhkduaofNgN4kH47icMXWIV0vPIFW9ILLoVZ4mokj3av1HVzKc0IvOS
	 RJA0HnJpq9HZBriwt7croKiHx9Whw8HUbkSD1M5zKNc/ZlZ/u9/XqYLQ3gsOPiaEpy
	 dom/JavO+Oh38iTKYwOANeEbdqoow8ORCJGy/GgzHLjLbuKl4w16AF0nrIgspbfjMU
	 XaKFv/TORv2kaiUAw2eUTjCxJSyosOnfUG0byxI48blOrVZM0hRt0IWo7Mo7C96oAz
	 lx/EkJQdf7coy39v66B0LaSHLxnA/esEaO/hV5YNBHsRbESLIb8M99d3kBbpxt9JxE
	 YbZA/JUoIrKxQ==
Date: Tue, 5 Mar 2024 09:59:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, 
	linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <20240305-attentat-robust-b0da8137b7df@brauner>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403040943.9545EBE5@keescook>

> > Uhm, this will break the seccomp notifier, no? So you can't turn on
> > SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the seccomp
> > notifier to do system call interception and rewrite memory locations of
> > the calling task, no? Which is very much relied upon in various
> > container managers and possibly other security tools.
> > 
> > Which means that you can't turn this on in any of the regular distros.
> 
> FWIW, it's a run-time toggle, but yes, let's make sure this works
> correctly.
> 
> > So you need to either account for the calling task being a seccomp
> > supervisor for the task whose memory it is trying to access or you need
> > to provide a migration path by adding an api that let's caller's perform
> > these writes through the seccomp notifier.
> 
> How do seccomp supervisors that use USER_NOTIF do those kinds of
> memory writes currently? I thought they were actually using ptrace?
> Everything I'm familiar with is just using SECCOMP_IOCTL_NOTIF_ADDFD,
> and not doing fancy memory pokes.

For example, incus has a seccomp supervisor such that each container
gets it's own goroutine that is responsible for handling system call
interception.

If a container is started the container runtime connects to an AF_UNIX
socket to register with the seccomp supervisor. It stays connected until
it stops. Everytime a system call is performed that is registered in the
seccomp notifier filter the container runtime will send a AF_UNIX
message to the seccomp supervisor. This will include the following fds:

- the pidfd of the task that performed the system call (we should
  actually replace this with SO_PEERPIDFD now that we have that)
- the fd of the task's memory to /proc/<pid>/mem

The seccomp supervisor will then perform the system call interception
including the required memory reads and writes.

There's no ptrace involved. That was the whole point of the seccomp
notifier. :)

