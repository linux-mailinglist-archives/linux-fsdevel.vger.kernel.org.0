Return-Path: <linux-fsdevel+bounces-51033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D0AD20BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EEF7A677A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F7253F31;
	Mon,  9 Jun 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXb7M9Bb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F868253933
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478648; cv=none; b=MXjVH2lkzuh44p2U5x7YsJS2Sqzy7ntwQUxEZ7wrDxO5u0USdx8oOQVpEtfPD2giO6UDHtYuaaKh56JtMUm6nFm9VqGvb9poeSaLmtj7u0ZOFEZSDVY92Rsh2ed2M0k7Mj1RXQE6McuQxmIqaylM+nRzl36sDy9dElerkAIPDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478648; c=relaxed/simple;
	bh=J5qpxaxX0Z9D8jwQcV7Jphj88CgSJy5mE1KDGiZb3LQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g0TDouf/v2dum2DmDqtzWDb90tb35L43txQMij44DUyFh/pL1PrUUjy+S8K8QnPdx/v2kfITRe7fPjxJZ5CvspWojFdmo8ghOGxEt+7qzOi5PBQZ9btnUEtqe7bXh+9TRGI1Qie7og16aN9WExjQiIa71ravywFBbtoELnzUMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXb7M9Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2814C4CEEB;
	Mon,  9 Jun 2025 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749478647;
	bh=J5qpxaxX0Z9D8jwQcV7Jphj88CgSJy5mE1KDGiZb3LQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PXb7M9Bb+7UzP6b7FETUrgtf0dnRYwszqvD722rUQ2Gh96eWuQd5AawY4uoH7cOGG
	 +pEexgTl57+ouepNKxH/+Ec72zObZI9IWDTn2fhfYsc+JFeIWMtipnR66FKPZ1ROeB
	 jXRkaNwrdlqcDPADVr/+YObfo6sqmnGOpNjwSNzCXOV1UoABHVIY6W1KtQqao5MExn
	 JQ2svas4C93P6Z1czyhpoFMAurKiRQYMBiCgVHoHJWfWiDHUZYobVpOEiP13fnN6E/
	 h9JsYcvoawMO5c9qLXk180pRCBqf7uSWi3h2FId4+OXQFpLl6qpitqrb+yOEh4WaYr
	 wZVzuG61dom4w==
Message-ID: <4352cf30f1a599b67b550c0eaac443231cf28c54.camel@kernel.org>
Subject: Re: [PATCH 2/5] selftests/coredump: fix build
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Daan De Meyer <daan.j.demeyer@gmail.com>, Jan
 Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>,  Mike
 Yuan <me@yhndnzj.com>, Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>,  Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 09 Jun 2025 10:17:25 -0400
In-Reply-To: <20250530-work-coredump-socket-protocol-v1-2-20bde1cd4faa@kernel.org>
References: 
	<20250530-work-coredump-socket-protocol-v1-0-20bde1cd4faa@kernel.org>
	 <20250530-work-coredump-socket-protocol-v1-2-20bde1cd4faa@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-30 at 13:10 +0200, Christian Brauner wrote:
> Fix various warnings in the selftest build.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  tools/testing/selftests/coredump/Makefile         |  2 +-
>  tools/testing/selftests/coredump/stackdump_test.c | 17 +++++------------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/se=
lftests/coredump/Makefile
> index ed210037b29d..bc287a85b825 100644
> --- a/tools/testing/selftests/coredump/Makefile
> +++ b/tools/testing/selftests/coredump/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS =3D $(KHDR_INCLUDES)
> +CFLAGS =3D -Wall -O0 $(KHDR_INCLUDES)
> =20
>  TEST_GEN_PROGS :=3D stackdump_test
>  TEST_FILES :=3D stackdump
> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/te=
sting/selftests/coredump/stackdump_test.c
> index 9984413be9f0..aa366e6f13a7 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -24,6 +24,8 @@ static void *do_nothing(void *)
>  {
>  	while (1)
>  		pause();
> +
> +	return NULL;
>  }
> =20
>  static void crashing_child(void)
> @@ -46,9 +48,7 @@ FIXTURE(coredump)
> =20
>  FIXTURE_SETUP(coredump)
>  {
> -	char buf[PATH_MAX];
>  	FILE *file;
> -	char *dir;
>  	int ret;
> =20
>  	self->pid_coredump_server =3D -ESRCH;
> @@ -106,7 +106,6 @@ FIXTURE_TEARDOWN(coredump)
> =20
>  TEST_F_TIMEOUT(coredump, stackdump, 120)
>  {
> -	struct sigaction action =3D {};
>  	unsigned long long stack;
>  	char *test_dir, *line;
>  	size_t line_length;
> @@ -171,11 +170,10 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
> =20
>  TEST_F(coredump, socket)
>  {
> -	int fd, pidfd, ret, status;
> +	int pidfd, ret, status;
>  	FILE *file;
>  	pid_t pid, pid_coredump_server;
>  	struct stat st;
> -	char core_file[PATH_MAX];
>  	struct pidfd_info info =3D {};
>  	int ipc_sockets[2];
>  	char c;
> @@ -356,11 +354,10 @@ TEST_F(coredump, socket)
> =20
>  TEST_F(coredump, socket_detect_userspace_client)
>  {
> -	int fd, pidfd, ret, status;
> +	int pidfd, ret, status;
>  	FILE *file;
>  	pid_t pid, pid_coredump_server;
>  	struct stat st;
> -	char core_file[PATH_MAX];
>  	struct pidfd_info info =3D {};
>  	int ipc_sockets[2];
>  	char c;
> @@ -384,7 +381,7 @@ TEST_F(coredump, socket_detect_userspace_client)
>  	pid_coredump_server =3D fork();
>  	ASSERT_GE(pid_coredump_server, 0);
>  	if (pid_coredump_server =3D=3D 0) {
> -		int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +		int fd_server, fd_coredump, fd_peer_pidfd;
>  		socklen_t fd_peer_pidfd_len;
> =20
>  		close(ipc_sockets[0]);
> @@ -464,7 +461,6 @@ TEST_F(coredump, socket_detect_userspace_client)
>  		close(fd_coredump);
>  		close(fd_server);
>  		close(fd_peer_pidfd);
> -		close(fd_core_file);
>  		_exit(EXIT_SUCCESS);
>  	}
>  	self->pid_coredump_server =3D pid_coredump_server;
> @@ -488,7 +484,6 @@ TEST_F(coredump, socket_detect_userspace_client)
>  		if (ret < 0)
>  			_exit(EXIT_FAILURE);
> =20
> -		(void *)write(fd_socket, &(char){ 0 }, 1);
>  		close(fd_socket);
>  		_exit(EXIT_SUCCESS);
>  	}
> @@ -519,7 +514,6 @@ TEST_F(coredump, socket_enoent)
>  	int pidfd, ret, status;
>  	FILE *file;
>  	pid_t pid;
> -	char core_file[PATH_MAX];
> =20
>  	file =3D fopen("/proc/sys/kernel/core_pattern", "w");
>  	ASSERT_NE(file, NULL);
> @@ -569,7 +563,6 @@ TEST_F(coredump, socket_no_listener)
>  	ASSERT_GE(pid_coredump_server, 0);
>  	if (pid_coredump_server =3D=3D 0) {
>  		int fd_server;
> -		socklen_t fd_peer_pidfd_len;
> =20
>  		close(ipc_sockets[0]);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

