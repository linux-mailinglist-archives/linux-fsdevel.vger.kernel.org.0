Return-Path: <linux-fsdevel+bounces-66906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBE5C3032E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4C174F8746
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884293126CD;
	Tue,  4 Nov 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="bV4sjAlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6B21883E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247551; cv=none; b=AXtjq76ex9xGllIcWG+d6wwJv2Uo203sE+HFkwE+Ev9p3IsbI2jgwJvaT0MKu91/QdKW1L5qqTZqe5EOF5O3A35TSjYI69JFc8jF8RY62mgVuYlZH2EQy06qYFTrE9ZcQsMEKSosVgItEsO7ecIAh65Uh4bTRnEPH0AfgCdAekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247551; c=relaxed/simple;
	bh=o2ZzE9o6XdB8UMA5K+0nNLIJydPTIlCljJKrkC6Lwxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5RWa4qtQPnUuOfu3luOCo1HEA9dlpT8VMftJrs33Fn6tDrMOb/OPGqlIGr5ytBQuqsnlTVL6QiELr8F+fwNQD2TQA6XDIXc8hAnnY4vQvyKlep8gxW998db4whSVfOi+wngSfMbF7sNxcJ60/o952YitsH/BHjkpB0hY/LQesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=bV4sjAlO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592ee9a16adso7190067e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247548; x=1762852348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs7U5bpbiQ1mNNfItM2FfIlqMSB3YqM8ruxgZoN9Fso=;
        b=bV4sjAlOpUV+GrdJohmgTKExpVORVmrDjkO/PCsnvqVp4CWvzQ9kLZaRqOfFAyYZfC
         RYHHARKyrBZ2BDsv3dMdXU5ggVveOoDIXz9UI6D6uyw+3u6Wq+X92KQ/sFyAIGGGXt/i
         TJXJjz8uPGmERjqhjPRbiB461YUHUro6jspTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247548; x=1762852348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fs7U5bpbiQ1mNNfItM2FfIlqMSB3YqM8ruxgZoN9Fso=;
        b=bhetzhKD+CAwMMhCOw8JYeGfBJksrWMBgRjezboh+s37drz5ke8TsCdFnre9Fg3PZf
         nN7DR2FUb54V8aQZ2hbrlJQEeAxJQbSF541FpErWBDlDHRfRrlU1marzHSEGuEguOSiy
         vX/lYgPFItl61hEOrCMS3i8QVXpdFEMPFDr++7e8Ed3LzG7aKHo5qSPpHX56jwOsHkKv
         xpAzQDDipkq8wcE1BjGGBC33faQJaEca1Ed3uLC4817hsYmvmyJJPwt/EZ0SLzbFQ4kn
         +hivsqp5mJ3Rd5+29V2eyLToFb2yHgx/JwFht+1W8fa6SCb5JiJXgB2Ggs9AmHAeRLc7
         e7lQ==
X-Gm-Message-State: AOJu0Yx6ENiYsABBNlxZLzr3iUBHeWrogn8cKzaEM6X9+VWvXXRdstPY
	PxYVPY3zHCIZnH8sW07wGfHGgVtYThW4ZAMloTRTu4Md9HAf9EOYsM9covcKb6mxulsZ/QN6hmv
	nRnzZV5jokbJMCxuB76TLu6y2y/UHCIFiGaR+v0VjfQ==
X-Gm-Gg: ASbGnctUHp2PjM3NESVYuJtATgUr5Hu8ID4hU6WrHXg2WCP6+SyoelBZddMqkUal1ew
	/3p9KLqcRnLyH5aO70ZAyVPv/9yqZGPT6W+AG/dn3wa4viqakGCr2S4MKJ5kecjZDnzWHHub6Js
	luXXFiOqCN9osoj+Ac1FH1vU5JjxkBhuMca/mMjVToYtLrnJhxeZMeq8BS6IUjiPtFDoVp1IKdW
	LrdIk3tZMx1f/pvpCmxJTjfujSMIe8AAlCfBPPhilFKfp3HiR8pvpkDU5Qc
X-Google-Smtp-Source: AGHT+IFcRPnbXV81VbRg+b0pKL3fjLwG3r84Jxl9s6fmHyDhp2MgXhX5jyPThzIbVyI26Bwuo8r4Rksy8II5R71gfhg=
X-Received: by 2002:a05:6512:2256:b0:594:2f25:d48f with SMTP id
 2adb3069b0e04-5942f25da87mr1828563e87.6.1762247547246; Tue, 04 Nov 2025
 01:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-14-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-14-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:12:16 +0100
X-Gm-Features: AWmQ_blneMo9_if6WBzLQjXedv-DfHARDPtiOzJNxkYWsXHmtGpv8StzmJlpQWs
Message-ID: <CAJqdLrqiHUfKk2FkCUQZXs63_6g32tEV2e_iPtJoNioQFu6xVA@mail.gmail.com>
Subject: Re: [PATCH 14/22] selftests/coredump: fix userspace client detection
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
> We need to request PIDFD_INFO_COREDUMP in the first place.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_socket_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index d5ad0e696ab3..658f3966064f 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -188,7 +188,9 @@ TEST_F(coredump, socket_detect_userspace_client)
>         int pidfd, ret, status;
>         pid_t pid, pid_coredump_server;
>         struct stat st;
> -       struct pidfd_info info = {};
> +       struct pidfd_info info = {
> +               .mask = PIDFD_INFO_COREDUMP,
> +       };
>         int ipc_sockets[2];
>         char c;
>
>
> --
> 2.47.3
>

