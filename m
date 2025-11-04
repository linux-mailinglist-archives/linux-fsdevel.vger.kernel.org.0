Return-Path: <linux-fsdevel+bounces-66900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBFC3021B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3063A76A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990E313E2C;
	Tue,  4 Nov 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UzIhja6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB62BF000
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246415; cv=none; b=WFIhDrXhe0ySnBh6+SgcBPOhn57KrQUYgh0n4eCoNZ0Pmk9C6inNlHw7ciTuBMVUfbMHY2og/WPyu+BZYmDC4LxlLkeQTrBGigdaJlug9ce+f2N/96Zth5/2j7FlmzHCjxDdmA4PQoHs3BfFfYwixabvRsBS5djqjuunCkdUmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246415; c=relaxed/simple;
	bh=gP6cNYFzRNpWkbN1NTP1C84FkDJ5I5+eZ1iQUALPYx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFt8UxPgVWuEmnCjqTQ/RgVjoH7dPKY1iV5HJSBvMMQ+05ufRVn4xl8hU0kSl3x3VBXxWMWuw0+s/GssTn+hmg0OuwzQwg9R+0AftPXsC4JuTCTtdqyLaYUYtqy0bUZyD2G5jBRN7CeYaivVoqBkfH36jM33S30yL/wZ9rGUJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UzIhja6H; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so6453360e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762246411; x=1762851211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+OXJnO5n+g/tTpX3EMxsbFglDyw91SA+ogZeLugo7k=;
        b=UzIhja6HOuHSqImVtPUZAycEX1KX/G77sQjLI4eEN5act/NrE1RRGvNDF4UMt/Rq6Z
         0QPmDgYbRDMFPjsvLrh3SZy4U/TGo89eWA9a3ibsCiUo4cpitYPRQLlaeID4/16euNa2
         91UxGQ5eWMhlRxnzGVxl1yZr2ZY4QvVXptKTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246411; x=1762851211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+OXJnO5n+g/tTpX3EMxsbFglDyw91SA+ogZeLugo7k=;
        b=flvNNyeOW2PgC0vT9MKXVpQ+EDEYrL9t3ADBHoItW6JJxBrkkzbqs8pIl44hfxQn6/
         8AzzhwUriXoA1PkOnnxIlQh37tHg26pTQ3BdE6llIfvDko/T7jLcLcYOyrRmQHQC2tsJ
         PI83j1v7WOItKPn5BJTT1DC9RpPMBduucnvWQAt5iVrWuwzKPDV5K2BpSm8JLuAmypAD
         jEv4iQriqsCp3DzWOIwS23DVd0izxNf/F1bxO/X2QZ3Qcz0Dkkbh9eCIuC7MIOrcWB7Q
         oDZ2bBx0PNSM6Zl6KWU0zfQSvzZXZKrjgv+ae9i+r/7NPaKw7xU9x4ok11i7X5qwXlOR
         khHg==
X-Gm-Message-State: AOJu0YwL9RVUMMh6BmT33A1yp5H0k9TOb6B8778D5w7mtNcIVi7D1lsm
	Qc56QPu3o4sSXOQ+3ynMgy/PNmbFIqH1AP3Gj2TYM4doWwuMjKp1QdrqsAF4PAtU9Bvv/12600c
	ckysz2YnsXEwMSric4i74LARPgv1qClfC139fpzUU9g==
X-Gm-Gg: ASbGncuLmJW32+GAS935Rb6ijpkgF040fg2TVOO4bHUmASiBu+YzCYnwM5GzYJiiaDz
	VZig95OWLezYXzbhm3vnKwbyo3lv3dX6H9tZZ9xXuwflU3Gfy320Xabkt1uOPsQ6hfxQb6niB9+
	d9DdxO2aSpgspqEQ71XtNnx95xGDZDGRkQcnDJLqsdMU/RfHCROesmFab57uuFL/HIIsqhu26Ar
	zo1s2/wIUZBeX1PT7i1N6ylUbKBxS57B4cnKb7vrcAU3SmdKAo9B7Yyexao
X-Google-Smtp-Source: AGHT+IGJ+z0iFxZhijJNpEMc1N0AB6Pa4n0v8wGhfmcglDnKhowMsADaDG9Ej6mXnqk2khs681gchLMaC1Udhx7ZAbE=
X-Received: by 2002:a05:6512:1391:b0:594:2bd4:c856 with SMTP id
 2adb3069b0e04-594348745fdmr797353e87.6.1762246411410; Tue, 04 Nov 2025
 00:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-11-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-11-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 09:53:19 +0100
X-Gm-Features: AWmQ_bmTYbLrtUI9VB4T3B3ctrVNl3ozG6AI_qT1Lx_inBRtWI5cYeifq7EChzA
Message-ID: <CAJqdLrqjvitPqNYbfZx0-fsA6LCzVV6aatkCt2qAiQiGEXTLNg@mail.gmail.com>
Subject: Re: [PATCH 11/22] selftests/pidfd: add second supported_mask test
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

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Verify that supported_mask is returned even when other fields are
> requested.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/pidfd_info_test.c | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
> index b31a0597fbae..cb5430a2fd75 100644
> --- a/tools/testing/selftests/pidfd/pidfd_info_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
> @@ -731,4 +731,36 @@ TEST(supported_mask_field)
>         close(pidfd);
>  }
>
> +/*
> + * Test: PIDFD_INFO_SUPPORTED_MASK always available
> + *
> + * Verify that supported_mask is returned even when other fields are requested.
> + */
> +TEST(supported_mask_with_other_fields)
> +{
> +       struct pidfd_info info = {
> +               .mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_SUPPORTED_MASK,
> +       };
> +       int pidfd;
> +       pid_t pid;
> +
> +       pid = create_child(&pidfd, 0);
> +       ASSERT_GE(pid, 0);
> +
> +       if (pid == 0)
> +               pause();
> +
> +       ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
> +
> +       /* Both fields should be present */
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_CGROUPID));
> +       ASSERT_TRUE(!!(info.mask & PIDFD_INFO_SUPPORTED_MASK));
> +       ASSERT_NE(info.supported_mask, 0);
> +
> +       /* Clean up */
> +       sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
> +       sys_waitid(P_PIDFD, pidfd, NULL, WEXITED);
> +       close(pidfd);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.3
>

