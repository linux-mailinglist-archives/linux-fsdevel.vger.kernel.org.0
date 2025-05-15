Return-Path: <linux-fsdevel+bounces-49191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E3AAB9101
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8024A225C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8240229B8F3;
	Thu, 15 May 2025 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nKKaXMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289829B781
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342420; cv=none; b=pJPU7JMJvGQfYNHR/oTXHpHJMNleTf64xF4PsUj8pXNVQ+lo4G52+eh3YCn0ElU/OOFjETotBs0WZ572ZWutFQe3KSryIab3Pd7dQnkJl6n3EAI3sRpFto5GZtodME3UTZuGTuQEU7AZAHi3J1lcUNmLWcHKKxVCR+QyP2oRMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342420; c=relaxed/simple;
	bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abLDhHADtXp6HREI6kKgYBeBUyeZVxq3GyW+6O1/rXoJyBo0JmMy+n6En/RZaZv747iZ1GOsn/owazRLkKgaQCIJ2qMjeIbiL/hn/BFC7Vm/w58T3u3ky0wUI/Q8ENNzlk8chilX2QZBiZQ5gnlQXCAKi0SWdTWUZ45O+C8YIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nKKaXMq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3542a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342417; x=1747947217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
        b=2nKKaXMqiU+Y6HP+xLOkg9rKEusnHOmOeXkq5h/Lhxw2Q5GjKRUQzRj0ZWR+ijlJZi
         puAiKjv1EPimoohXSmZNbBrrwhMe8MUBiZB8yMz7p1tbx7cu0H6lSylVQldX2FmrKOeL
         R+9adWGLo8XvTiMS2VuZevsKr+JFhFDC5bWMsCu2tiL8l+ITcqOWfvoMyDO3VmhE57lg
         9Fb9xr/GIKkVsBl3ivleppN8dMfE+18jhgv9Obr+yCyjBTHUB2QTmso1wprAeKhn+0TW
         YpcMF5PSUrq+OkYDsycdVPNbhSu8VacQOHAEG0Axm7VsikxPJ/q9GYm5cc1n3Mo741a/
         nmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342417; x=1747947217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
        b=DgHjy95k0gluNe3kJnQ6ciPIRIvZbZISlOHAVhBAeUeppNtAcZqbhjr20zC2U4x6pB
         dYozzK5y1uW3ltOvlnNRK01kPB1L9IfFwkHmx2YKiIevYDWCdzVCsJNmC1PSn6+RbVxl
         1SZZ1H79v3XC+8j8VL00LgbyCB4FVBnsCuK8SUetskV3ckl6JtAOL2ANPCd1bN8dwhQ5
         0y4iEuyQl20vmpZpOHZDYVAeZMZTfQgRuODdqgayVMYKZoTT3kBDNvsVA2LTQqN8ZInc
         8Jdgrr0sPYRhmFXf1wvD8vFPdQMmkxXuroaz3R9GI2jBwBLD/smddMmlxQTx0gi20dlm
         6avA==
X-Gm-Message-State: AOJu0YyKJzHrJ/75YkmsJw3krjdDHnX4eXhLLFMfLxBV+3zCUu3vW27y
	akgelNG/PtLxyxIVYNJ1sDszXcZF4h9Nb9YzzMzDKfVOTY62qjrh7iPb9sNL4R/tQ5In/owJ5lj
	KCD0qNDCPfhsUPj8RII/UmzaPqusboN2Fh31+O/39
X-Gm-Gg: ASbGncuu343etHwP/mYUZbphpzE7cEpnasoHsA4HkrkREGkApWGIivFDAsfNOVhxOi9
	SY8CvEkzr+pUh/aXS32dnQoY+CNb4Ko1oXHcKC6h/UL2VOjZEGaLBbpx7wQFBTJeaCZHRKM0E/z
	XFYJIjqZMkxe/rFAHJHDq1q7VGxDTf0OxTezU2VtkS8P2ERkwNfBqCIImhRPYo
X-Google-Smtp-Source: AGHT+IHZ9jFIvkL3s/WhGIrI4IThR5QXdM3cICdVMwLZGSJ4WKA5W38ar/Q+P8ZFLrgmTwdP5BUbeE+U40I1JEI8RSQ=
X-Received: by 2002:aa7:c392:0:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-601233a4fc5mr3186a12.2.1747342415935; Thu, 15 May 2025 13:53:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:53:00 +0200
X-Gm-Features: AX0GCFv4nrwtDZxOQKAFnOch8tVFv6sz1vCJIdy3HEL5SN0W7L19J7ev9XtxuAM
Message-ID: <CAG48ez00GnBZZDjpYBmccgztaW+0206_X8__UiFxtBQhm7rvhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] coredump: reflow dump helpers a little
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> They look rather messy right now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

