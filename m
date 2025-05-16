Return-Path: <linux-fsdevel+bounces-49268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F37AB9EB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973CAA0801A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D319F43A;
	Fri, 16 May 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGuVxTQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ADB19066D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406061; cv=none; b=NJcDbTJlslhdvBFhqcD7C3LWqEyXA2Tppi5vcv+xBwkNVhFjoKdRDg2xuB0XufdkrX3HWeu/eD9MY2mQonE9bKBBSXVt2EKNhyCZxj1m/HdgUxZMOZ5J1vDIkiuj4v1uzhR9yzX1wM68ylgvKHqS9KczPZwTMEgA34oV4F4kODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406061; c=relaxed/simple;
	bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/ps/UIiuD7gKzL0XfLW1MzdTPSMKjhaTY0su/OQ7dkaj4tfbo22Evu2ue5B9cTVmcq9dR9wm+XvwwlnkxdIu17wzYqN6bfYjQJF//Gxk/b/6B33N5rymCZZGe/LCNWhlPXw0gIojOiPIkir8oYrPHDESSrV6rupibLcFrIZHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGuVxTQI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso12462a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747406057; x=1748010857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
        b=vGuVxTQIYGn+f+GPputS3WJ9uQtgpFnyZMc9zU0hVE3w1I4meBQumbC+zkmaj5pMWe
         /dZ/2GJ0+PzCZcZR/PQPexTMpxLls4XG1LTX8Mc3C/i8CG32oIFfgPxVGqdcwchU5zB4
         waLL9ogKl6fzdnTwNoLduMHTbuvTcTxKFViMrSAH36JaH9xcg8H+evngATmCjuUndS1Q
         AyBQSmOBIhMjyk8aWV4d+pWVovMq91xkrfFSjlI6R5pYhyDsP6ynrmFd1CfsBwzd71gm
         kNsReH4HvmeReUdPdQCbQt7EY6p3YBi3CeqZKPedRIR4RMFJfu1wO/izNHE/etK1p/JD
         YnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406057; x=1748010857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
        b=QZsFCvqTkCfDpfYVagmDL+rea4T+PrRjWtFSpM//Tyb+JxGJQ7uM0jzpZS9+OOQCsj
         IIwzGFpgzifq9z22nF4T2tzk22zAiUAi7yDxoenu8Yg/rQr2XXXF4QxgQY0ZLqGVr+HB
         cK6lW3BlQcySRocTAC+OyxX77awT9T5Er18OJfsBZVgyK50Ha/vuISGOJgk24WjWYonQ
         RcWa/2384xCdGEMVVsGrRFxRZdYuM+yRP0yeFwgCs+XkUCtNSUP6VOG1BdDJxwZ9ckVb
         Awlc7S7P9anfdzecgextKIJDtKKBudpL+EEoNtTVV8c6c+VI9D5EE5WCf0EjXxhHHVdZ
         FYpw==
X-Gm-Message-State: AOJu0YwbbyXWOkZzIJ+47gZNZjoazDfCPxJtdQR4NrCI1CEaO33D+U+I
	rWjw0zObIdcNjQZdZM0CX9eeZ/E5myduQLskUbGF3+rGZ7O15OVAQQvqS+A+YQVhS7Jo5Q4ZidA
	uhA9Skn6gdb0oK6gRwHGlhhReHUAw+wEo1vxUn6vT
X-Gm-Gg: ASbGncuajgmsoA9G9daXhbplObJARqb0YoLF9Yjn2bm0rY9Z3T99yF9mX8btIYNPYDG
	36DtzT8oBDkETkiD5qU0UR5gzFMLrDfTBfBmzHXpCHl2gQl/bPhiEIFegxODg/BZOGIiaS3TbEF
	kCBHvec0UZfH9yYu+5rvVzJyc57Vhy3F/4d4mLvXpcVI6mLIpALHMuvVmmrVzS
X-Google-Smtp-Source: AGHT+IGCSHxzW91C4A5f0hB+8GzPDiVXw/aNuBqA0vePJ7mSh5UedOWWbXq+/BmaUddB31Y12bkHvm3bpH51L/eGgVg=
X-Received: by 2002:a50:8e51:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5ffce29ea75mr210811a12.7.1747406056679; Fri, 16 May 2025
 07:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org> <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:33:40 +0200
X-Gm-Features: AX0GCFtQVpgNrEjVFvdmdJYYDaEF3VTJ2Dm_tJFrdzJ22BVKOsDvuggvKcRma0U
Message-ID: <CAG48ez0e+-SdB6AWXFKBy4i2Dy8ducic4aH5=hKQDqpN_G-sRg@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] coredump: add coredump socket
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
> Coredumping currently supports two modes:
[..]
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

