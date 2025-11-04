Return-Path: <linux-fsdevel+bounces-66912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD2C304D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2434C3BD611
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4F31BC96;
	Tue,  4 Nov 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="eR1ANCPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C73126C0
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247948; cv=none; b=pujCfef8mwjg5mtZRs4MY+ZWNrehnJbyJWc23vUQK3PWxWgJ66Lb3Osx9pbPJwcYn68o206hLNVfc6uTxZRvTJC2sKDPQJK8yW86t386bKS1zdQJ5ffRI/EyEh8UB7jI8Q6TdNVJKQhISFOPNAYMZa3eMSRUhGl6oZzlITKVtGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247948; c=relaxed/simple;
	bh=8MVDF2v6cdOMf1fph2abfBaROvhyMs9iAM0ppr36IuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDv01+VfjQaAozjM91i7sGROtqIWWoLS1CSdSVnqF8HmJHWmHlOhtyfhzjCMTr5dt8N7ItE66wzALxlP7RittfHOHuO53D9I4ukNbgP9ub41bf1AjHcRhNZkUsw4ec4IF8Xd8hhTZDtiAqxKP0afIVfPsBQRjtfkIHp+tpv1UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=eR1ANCPr; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e1a326253so5666401d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247943; x=1762852743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5VFySrBEAMpveHFWgT5NUnlLf8dSP565kmCB53IEaw=;
        b=eR1ANCPrb6j4BnIA075Y/NtIVoeVNeeQ3zk7NuSnPD1aW8qs9emSItNn2eer862Ukk
         crnLedXUEvw82Fk9pdmAsLqCP6cxrkS+cie/clc9AtBTFuohHwVWLGYmnYVDW1tQHlPY
         YMg42Bggkzsw8m4/I1hASO+z+jKIgWXGnBmwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247943; x=1762852743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5VFySrBEAMpveHFWgT5NUnlLf8dSP565kmCB53IEaw=;
        b=CnbcoMFgll8+KvhVta3Dkx0bVJZFCgiIvwtVSHOY991c9c2VELiOJKrfM+NjQ/jNQg
         5J5vbMRYZJ/hDstFZAgiKhHfMNRNHohJ7GZ5ib/qqcNSQWimhdRttXuviZhtwQDXhEFg
         RiTTAJRmFabbMXL3zh1S+hM9bGoZA1TGeD2xZ8BynB6ibSyC6+nfFR5Va34IHAQ/UvS7
         WGSqLzlS3JbDuojs60ItWZbHuRlRsgfo2nFJO5qLpj5R2SCU5ixfBAvyBQPBMuDv5xYc
         IiE9c9wrzEXYrMEAOaphAzuVgwcN0YlNtK01RZABJvTK3HCzEvyMtDo1b0JzrFBW0Gsp
         UF2Q==
X-Gm-Message-State: AOJu0Yx2RyTlL85psaMtwowcDNmvZI8mQ/81qqNM1z3emrKeBh+GH7b8
	upP0TVG3RSbTeDM2NXWoZIWKzTxC4V675X6vWkGM6z04zjMR8/fm4bQwdL1Nye2k02QiD9O9sPS
	/JmeP/f/1eMRlu8osFRUXcMJIHuNX0GfvXN98h66Cww==
X-Gm-Gg: ASbGnctjyV6cCMQ6DYm0oRfQLpOVM1x4hzM8d1COZHRyUEBHk/wiZYbgNRarGsAXrVU
	g7mZJHOfTwyMrn04cgqOLKMhkEP/+61hND6lF+u1/F3WKf/NieDFqNIan2wuU8wXtln4pe3GP7x
	UR5SA7NH9/elRKDd+a8xj7CuP93Ja9I0lOJsEMeXyhISver7TSpWGZVY5NqxgRcatdCtMtuIVEN
	AN/4auYeTc3oirniLas5KTd2sJrKWAKy9+1YjbyDleb2lOvez19fZ12E1ir
X-Google-Smtp-Source: AGHT+IGn4VZVw+tcmss6TD4Vgnt4J1TmiIfLYtDDcgV4IqPE9sZ8XgL6bdVMqqgDyZuGWmAIdjwYI7Z9CYllIPOIBXI=
X-Received: by 2002:a05:690e:1545:20b0:63f:9ff9:1496 with SMTP id
 956f58d0204a3-63f9ff91cecmr8000926d50.2.1762247943232; Tue, 04 Nov 2025
 01:19:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-20-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-20-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:18:49 +0100
X-Gm-Features: AWmQ_bmydQdto5gTwH08XU_AZoMobzl05q9FCm3EuLXXxWp4mdjJLyYhEbPKliA
Message-ID: <CAJqdLrr1_+gorLJKmZuDLoydo4R3BdTcqHb+vJT1CdLOqbocKA@mail.gmail.com>
Subject: Re: [PATCH 20/22] selftests/coredump: ignore ENOSPC errors
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:47 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> If we crash multiple processes at the same time we may run out of space.
> Just ignore those errors. They're not actually all that relevant for the
> test.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_socket_protocol_test.c | 4 ++++
>  tools/testing/selftests/coredump/coredump_socket_test.c          | 5 +++--
>  tools/testing/selftests/coredump/coredump_test_helpers.c         | 2 ++
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> index 566545e96d7f..d19b6717c53e 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
> @@ -184,6 +184,8 @@ TEST_F(coredump, socket_request_kernel)
>
>                         bytes_write = write(fd_core_file, buffer, bytes_read);
>                         if (bytes_read != bytes_write) {
> +                               if (bytes_write < 0 && errno == ENOSPC)
> +                                       continue;
>                                 fprintf(stderr, "socket_request_kernel: write to core file failed (read=%zd, write=%zd): %m\n",
>                                         bytes_read, bytes_write);
>                                 goto out;
> @@ -1366,6 +1368,8 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
>
>                                 bytes_write = write(fd_core_file, buffer, bytes_read);
>                                 if (bytes_read != bytes_write) {
> +                                       if (bytes_write < 0 && errno == ENOSPC)
> +                                               continue;
>                                         fprintf(stderr, "write failed for fd %d: %m\n", fd_core_file);
>                                         goto out;
>                                 }
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 0a37d0456672..da558a0e37aa 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -158,8 +158,9 @@ TEST_F(coredump, socket)
>
>                         bytes_write = write(fd_core_file, buffer, bytes_read);
>                         if (bytes_read != bytes_write) {
> -                               fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n",
> -                                       bytes_read, bytes_write);
> +                               if (bytes_write < 0 && errno == ENOSPC)
> +                                       continue;
> +                               fprintf(stderr, "socket test: write to core file failed (read=%zd, write=%zd): %m\n", bytes_read, bytes_write);
>                                 goto out;
>                         }
>                 }
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
> index 65deb3cfbe1b..a6f6d5f2ae07 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -357,6 +357,8 @@ void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_fil
>                                         goto done;
>                                 ssize_t bytes_write = write(fd_core_file, buffer, bytes_read);
>                                 if (bytes_write != bytes_read) {
> +                                       if (bytes_write < 0 && errno == ENOSPC)
> +                                               continue;
>                                         fprintf(stderr, "Worker: write() failed (read=%zd, write=%zd): %m\n",
>                                                 bytes_read, bytes_write);
>                                         goto out;
>
> --
> 2.47.3
>

