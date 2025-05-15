Return-Path: <linux-fsdevel+bounces-49145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD4CAB8989
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24D817FD05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DF1E1DE2;
	Thu, 15 May 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="QBA7431C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C41DFDAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319769; cv=none; b=tjZY+2BkxhbnQ99ueWhti69yr541wuatTYXLZKp7XefKqjn1EW6S8uTVMNc5Kn92BkHZ1TbKgcy57AaGDpmxMuZAnN/ONjD+IPItUkF6cgj9zaTxTISChjac9Xp7kS2Q9kgyQpj7b1HAnUfaepdDv9CRd25Tc4Duqus49Pn0Rdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319769; c=relaxed/simple;
	bh=LkwzEhK4YQ+y4ydj2RJEeVreHzqorQrGCeShw3Gkmrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyPI75D90nJNZYbuByAW6ji32qZZaQqQeybC4AOntcelZm+C9uLo8VKwNJvtJxDrpjZKVVeBPORRfbqOE1dVEOswnjHKpoYg8BrQIuE6lFL3REk+eE03xFFkdSxVX3MB4CA3pBeXgXGCu38CqqXG6OwYxqJCDlwFuuntRp3lA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=QBA7431C; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54998f865b8so1009376e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747319765; x=1747924565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfHo/+rR2MB5NBA0pbyumj+N88FH0xRlivNxbjV7rwA=;
        b=QBA7431CGUeD+fibjQBsXkMd6BNNd+HNMBFqif3znoO59QdgwmWwotzF2kQaSxR97u
         RFURYC+rE5GKIykbTifdwIAv8+ZDl1aCbupp9fP1AznMFXulUn0WgN8MNhaZ9/sD9IeD
         3EBcLEZ0rrq4wE8rzKENlf1b30zs1gIO413BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747319765; x=1747924565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfHo/+rR2MB5NBA0pbyumj+N88FH0xRlivNxbjV7rwA=;
        b=ndKue1tC/c4Rpj0lh4ePQkLQCnm/bkDajks7JHKUkf9E8aClOeLosZYlaeG4JBATSG
         bPALAMkQNbWyqJ4N0d8dVCdoASjiwFobcZQp7P15Z11F2fklJ2qTw+G/s63CpUTQvsH4
         OGTSzfOxWSPB/1DnoaSu8zUoJPN+n+jKjSg3kvlyuWble2R0V+usmef6WyImrEmZCV0T
         I7OK9oBunf24BIsmP9kKd3nOWHDj3HV/L6CtvCf0fGSlav+Jm8ivYgCTRofUGd6sOIWn
         2g6wRhQtWUYOjoBB3W+DG1+pZ8nExGoEVuFEgFK2zQD+7FqGAVadXr+NDeW3Ue2bdJxn
         n1Lg==
X-Gm-Message-State: AOJu0YyOiUpfkMSA9CI9EBC3HXNrvbX7gxYZGMo+EwvqSG1Hn3jm3Xch
	j5A1cLm1XSYMZh1LnALzc0tLT74yjDCVN4kyYj1DUm1edk8aleajmQZfhzZJFYPb+1IQduP38f8
	5JjVZUs7kFWI27UEhg4CcafHIX8zu6vhQcQ+n0g==
X-Gm-Gg: ASbGncsw6vPchEHvDXmhjA/NXZg6b47kAV8GX1UPl7zOXF6W0cogCGWsn32XnZYjiFc
	XmfL4ulvdeVXEm7ko55qvQ0kIQDXsM7xFhfsH/1Yp6MVYM+0L6mLA50xwoxgxMsO4/7Dhpl7pOa
	V9WJNAE3BLDPN4ok2EbhP25SsYZEDl7YfCRNV4/IhecUBG
X-Google-Smtp-Source: AGHT+IHd1CtZlFuSxAsXnx5Takqv6QZTe2+lhVirdtaDn0cFg77DyP9oBpxqfUMLz0N3QxnnHSEZ6bt+VSdCWoGtElk=
X-Received: by 2002:a05:6512:6d0:b0:549:8b24:9894 with SMTP id
 2adb3069b0e04-550d5fbd6f8mr2818776e87.15.1747319765098; Thu, 15 May 2025
 07:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-8-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-8-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 16:35:53 +0200
X-Gm-Features: AX0GCFvO84s9iCLGUVDHGCypS2YVBJg4ZgjowZGClKY4pjGPNQYODIsSapI_tGs
Message-ID: <CAJqdLrq_MG0z+BMCCxX4EGkSyzz-nOuRc+Z0E+wTHH+98KEs8Q@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add PIDFD_INFO_COREDUMP infrastructure so we can use it in tests.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/pidfd.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 55bcf81a2b9a..887c74007086 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -131,6 +131,26 @@
>  #define PIDFD_INFO_EXIT                        (1UL << 3) /* Always returned if available, even if not requested */
>  #endif
>
> +#ifndef PIDFD_INFO_COREDUMP
> +#define PIDFD_INFO_COREDUMP    (1UL << 4)
> +#endif
> +
> +#ifndef PIDFD_COREDUMPED
> +#define PIDFD_COREDUMPED       (1U << 0) /* Did crash and... */
> +#endif
> +
> +#ifndef PIDFD_COREDUMP_SKIP
> +#define PIDFD_COREDUMP_SKIP    (1U << 1) /* coredumping generation was skipped. */
> +#endif
> +
> +#ifndef PIDFD_COREDUMP_USER
> +#define PIDFD_COREDUMP_USER    (1U << 2) /* coredump was done as the user. */
> +#endif
> +
> +#ifndef PIDFD_COREDUMP_ROOT
> +#define PIDFD_COREDUMP_ROOT    (1U << 3) /* coredump was done as root. */
> +#endif
> +
>  #ifndef PIDFD_THREAD
>  #define PIDFD_THREAD O_EXCL
>  #endif
> @@ -150,6 +170,9 @@ struct pidfd_info {
>         __u32 fsuid;
>         __u32 fsgid;
>         __s32 exit_code;
> +       __u32 coredump_mask;
> +       __u32 __spare1;
> +       __u64 coredump_cookie;
>  };
>
>  /*
>
> --
> 2.47.2
>

