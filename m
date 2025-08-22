Return-Path: <linux-fsdevel+bounces-58864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F776B32546
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F421C87CE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAC279915;
	Fri, 22 Aug 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jk9elqOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B419DF62;
	Fri, 22 Aug 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755904146; cv=none; b=nDB0WFFyc9zxxEijZ8nYuZadPfXqG3VfsFemwuaaAa1rVOhjG78fxy+dUJVt1jP/6miF184X6oOBvjk+1ZtHSH7NLHL7QzDXIZG4jIkjwMSkV3l1STjiJQx0N3cnK4buUAcKvS3BXlCDMV2MbVuaXYvU0tMRR2TUx6HL5MbbvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755904146; c=relaxed/simple;
	bh=Y/LG1VX/onM7A0Oh2oxuLnFg//L67w0I1JNhEOqetSE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fWogIQUfqADdZuymW2qozjMp6zXy/lW/JYIGvfj9l/vT1M8z20BpmvlN5QKwaFrzBUY3uySOGWVS6O+SJ6zU58VO1qs0+3C19FpOM5anLumlUpcT8iqOBQhLXUTb07Le+8Xv42cUmlbZOOD6tI0j9ipWR44mH+Z88prJziD1eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jk9elqOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C94C4CEED;
	Fri, 22 Aug 2025 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755904145;
	bh=Y/LG1VX/onM7A0Oh2oxuLnFg//L67w0I1JNhEOqetSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jk9elqOy/ZJR+vn9xxaYbWRdWcp7qtpqqZYGD/R7lwnXvzCqMaP8d/Sb2QKbvLSLE
	 VGYmk8jojSeY7B3uONS9XdhAVY4I5JoGh8zHItajT5LFaEYKTJ8mZCfTt2ikXQswrW
	 IhrPG726tFTDgjsKIZnqNm228OqBziQTdqbapasQ=
Date: Fri, 22 Aug 2025 16:09:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, wangzijie
 <wangzijie1@honor.com>, Alexey Dobriyan <adobriyan@gmail.com>, Christian
 Brauner <brauner@kernel.org>, passt-dev@passt.top, Al Viro
 <viro@zeniv.linux.org.uk>, Ye Bin <yebin10@huawei.com>, Alexei Starovoitov
 <ast@kernel.org>, "Rick P . Edgecombe" <rick.p.edgecombe@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] proc: Bring back lseek() operations for /proc/net
 entries
Message-Id: <20250822160904.6c5468bce2200cf8561970d7@linux-foundation.org>
In-Reply-To: <20250822172335.3187858-1-sbrivio@redhat.com>
References: <20250822172335.3187858-1-sbrivio@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 19:23:35 +0200 Stefano Brivio <sbrivio@redhat.com> wrote:

> Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
> as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
> entries, as shown for instance by pasta(1), a user-mode network
> implementation using those entries to scan for bound ports:
> 
>   $ strace -e openat,lseek -e s=none pasta -- true
>   [...]
>   openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
>   openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
>   lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
>   openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
>   lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
>   lseek() failed on /proc/net file: Illegal seek
>   [...]
> 
> That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
> and it's now mandatory for lseek(). In fact, flags aren't set at all
> for those entries because pde_set_flags() isn't called for them.
> 
> As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
> files") introduced flags for procfs directory entries, along with the
> pde_set_flags() helper, they weren't relevant for /proc/net entries,
> so the lack of pde_set_flags() calls in proc_create_net_*() functions
> was harmless.
> 
> Now that the calls are strictly needed for lseek() functionality,
> add them.

Thanks.  We already have
https://lkml.kernel.org/r/20250821105806.1453833-1-wangzijie1@honor.com
- does that look suitable?

