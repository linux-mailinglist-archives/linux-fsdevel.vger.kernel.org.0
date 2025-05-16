Return-Path: <linux-fsdevel+bounces-49270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35658AB9EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C636317718D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4519D084;
	Fri, 16 May 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylGodoks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2D189B80
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406308; cv=none; b=Vh7LxnfI44gwCabkYkAnbl4N20J1vk017y9Wf5Add5+V147v8JQbJd7iZE1hkDGgXLMbQKcyEu+mem0t341VkGFL7v9CkPPAoLlL/WegU/DmLwbhaw/V8HgXAgNgsWmYgWjc+57jpZ5he319V0lwUqukAnkrZ40j/xX35PGKVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406308; c=relaxed/simple;
	bh=x4z2xCYwo9fPX793BRjCTj4nqlE0ZVIMCsmio1DpU7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PazezM634BPwWf2oP5ORekuGAOBDGsNTRV5lV48Tw+n5xvcxxE203rZwQusrHJJ6zpXgg/EJYMjRHrJmUNXi0wlWi+EKY99I0yO/F+JfgwBeJN8/Z/O9VRvcFfP3L73r+EycYQxeyXjeELA6ylFuOMlLkCrbbQA7iw72vHq3WI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylGodoks; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so9866a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747406305; x=1748011105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sUYusB+kyJ76xlLEHH5qRi/bk9NwvxZ5fkLN1rm8tM=;
        b=ylGodoks6gEtouvpWiK2FouRrMpwv2Eh1sJF33X1TF2ipa209I7hRwmNWjpOXHpEPo
         07w2HZyHsUgkM9T7xqmbPEwZpj/qdWAPQvxYqKuwTiTaUY4AR3LFNgbbiC/KYqQg3Q/a
         3+LPt3qRDwMWan6jgP+oLaCspe2RCg3JULoj4ezt1niCXv7xYEywUqtO1ONlsOj8qvRb
         zb0R+Mk921gYpg+E2LZkK9P9VjI/V6Vk6CA9CrDzP60gY8Iu39XFnqQuyaKj2QwJHsWR
         QYQYXhdFlr2+gshcB9eHxm6mliW/f4Ik35K8CHx45fEdoq9USw0tbNtG7GrGww7QKvPj
         7Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406305; x=1748011105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sUYusB+kyJ76xlLEHH5qRi/bk9NwvxZ5fkLN1rm8tM=;
        b=pIn8XOZ27xbASrEqsSKt4JbN+A9idC0/bLA313nmEkUwBwOn+e60WtwfZF5kXMM10J
         V/entkYzvXzU3nq47yW8cxlI2FxHUJAaa87G0fCWpEv+PdISDsTP2fedDzx4YP37uBBd
         PIMU0ofMafnbXUfB9gIfzEXLFr7OemFziEvBupYMQdtpBUkjGa3NJunj7hoDWxvQi0OD
         mGU+Fs30ReAB7l4ktjKHT2GwmGPdqkCXI9JwJeKAMPEt80ZqYHxfNguZ9/QyYl2dWd8/
         XLHWAletMzOacG0kCuiMYliDTBTADp8p9fmfte7zcVkRwDLPqlrp2kCSTwuwP0JHSdXY
         pdmA==
X-Gm-Message-State: AOJu0YxUWU24fqUGQ66Q3ruvRoUl1VTM4V4eBaH/6nWeyuxAuRjpnWyy
	UM5eLBofMX0psrDt6x+hVhLgR0aWzRQDNF3rig+B+uaQ5xBY9tiMI6Et6PKZ4KHVWl/Q0zDFlIa
	6kX4+5vHuczAr07Un+S3nA5ncWQo8+uoO1Ov9unaVwvWlmikGSeHVAHul
X-Gm-Gg: ASbGnctm1z/YZpaxgzLTsaDQisGLGKso0uS+H1NSM45dsaFc9nKd3cYgAGjPRDjXNpS
	NiN1R12pFblwlPU0EuE489Vh3c3lJcAEyMKg6j9TZXAFLelJcIuCWmGfLJ1dvtNQnyvpAJ8oRVq
	q+mmGnybQpzFrtBb0DEFW74uv8MtRHMrZoGBB+SW7WmgSfOOWBLI0WTHNfq0IkN0Ik5pn6ZhU=
X-Google-Smtp-Source: AGHT+IHjVPydHL7cpnwkAmy+wB0lfXFTh8aEtdxrJqk903N82gHmcHf1UJhj/sj7jHSEWrx43rmp+OotJ5wNqgsIi3c=
X-Received: by 2002:a50:c049:0:b0:5fd:28:c3f6 with SMTP id 4fb4d7f45d1cf-5ffc9dbe5b8mr231155a12.4.1747406305152;
 Fri, 16 May 2025 07:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org> <20250516-work-coredump-socket-v8-5-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-5-664f3caf2516@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:37:49 +0200
X-Gm-Features: AX0GCFsuzCC3CmbLLxfWpRPaI0gyUSqgeVs70kejvwFPyqgeFolUzQNjXbEK5Yo
Message-ID: <CAG48ez2ewzKuVoUQp=nyMiVS9euPts3fKaexwXMGhVefQXqoig@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
> mask flag. This adds the @coredump_mask field to struct pidfd_info.
>
> When a task coredumps the kernel will provide the following information
> to userspace in @coredump_mask:
>
> * PIDFD_COREDUMPED is raised if the task did actually coredump.
> * PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
>   undumpable).
> * PIDFD_COREDUMP_USER is raised if this is a regular coredump and
>   doesn't need special care by the coredump server.
> * PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
>   treated as sensitive and the coredump server should restrict to the
>   generated coredump to sufficiently privileged users.
>
> The kernel guarantees that by the time the connection is made the all
> PIDFD_INFO_COREDUMP info is available.
>
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

Thanks for clarifying the comments!

