Return-Path: <linux-fsdevel+bounces-23712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F170D931ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 21:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794E11F21B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665F12DDA2;
	Mon, 15 Jul 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BZpg8Bln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4FEFBE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071258; cv=none; b=STrOO9Y9If7HDtqpmsiYm5as8hxGsW6aWkrmDgppnPxQGhLUimQc7MGlC4DEPc8Bu9BmoXhFM04lF/xmMz07rIUJutFD8vpv5l/K/X5ETHNzmfwbE/hwm3UX+szo0P56VxKLUPzRhMNV6suEprNW4zq2gRycBcsC2D/QyRogq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071258; c=relaxed/simple;
	bh=5T+mAL2CEJGy9l4QE+/1oYzq1KiIG3eYZWzE0hbHous=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF27kXTlkS0DbV6sROYIwOlbNSHLLNCFwnbd+SuKZVc70c5whRXc/iF/HqOEXAvX3hEDFjpQN12iUE8Ap+M7F5fco/LBzF2EGAB5GLRZT5LSyZuQ4jlEFye3nNnygDgUVDopzyADKPqFl8wSveZsXcpX0zBDcfRbo5Yr4001JIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BZpg8Bln; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77baa87743so524056066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721071255; x=1721676055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSj+N1deCV/lRMl+PDJPmtWfHIJ1IZbqZ6+B38RC/M=;
        b=BZpg8Blnnf7c0j2Qwst8sJaRYM/npDGFMuwAdl/XRuu8YI1BLGm5re8jS6GKjAEGqY
         eBpwoGPAGiFLWYk2MICY00jh35fg7sxT7PttND9UnF2pXq3wAIocNi49Vgcf7NM+/Dwi
         zeUdefFgsZDLqt7azHNzBhA/akrgMDa766uVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071255; x=1721676055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZSj+N1deCV/lRMl+PDJPmtWfHIJ1IZbqZ6+B38RC/M=;
        b=SBmxD9+RxSYJbZcfDav+TLYWHuQ1xTve1bOmsgk3XpQjrtVEbh2UVenWf7IlkJ0Mbl
         yMnkPfXBout0WGuwo2XYUqHbJ/Zj14T/9UDX1vXxgyCN57eP5W9ETUpTWlle3IEsc9Qs
         yyKRrzR7592ACULs9cO7OpeRUgs5D+TtobwqxE0jur4VU4e1VDZ1JUTVXq0BHJagCmnH
         rzyUqgJEeh0wrRtyW3DFh8T/JDYmuP5cxCxzwiUlqTDXUv621RYpkgt+kC0h6bw/yTPe
         5Dq3VUxu9ceCETP6Lf3NShtPzDe23digcR0y0vt49OJv4nK63OfCg7AcIFO73o7esfiT
         hVLA==
X-Gm-Message-State: AOJu0Yy7DKm86Xk2hcoDzFuVyGHCQ7FdRp8R6GnR8lNgjHZp98FKiFKL
	/i52loD0FnzfchhgfxYimkGHaRnnIpbT3KLms5GycJR2GhyuOq9bio2J3FUf/Zc/Brs+iw82/kd
	s9de61g==
X-Google-Smtp-Source: AGHT+IFG04o8ukiBTF8LiXPCLaSly5F0xXrGvXC9aB1aWrkeqS8Sr6A9edZvo0sOX6PsDGnpZU7Njw==
X-Received: by 2002:a17:906:1292:b0:a72:a206:ddc2 with SMTP id a640c23a62f3a-a79e6a5a00dmr50688266b.36.1721071254838;
        Mon, 15 Jul 2024 12:20:54 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ffffbsm238426166b.173.2024.07.15.12.20.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 12:20:54 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so4937644a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 12:20:54 -0700 (PDT)
X-Received: by 2002:a05:6402:2786:b0:58b:2d93:ad83 with SMTP id
 4fb4d7f45d1cf-59e978120a7mr595277a12.21.1721071253731; Mon, 15 Jul 2024
 12:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
In-Reply-To: <20240712-vfs-procfs-ce7e6c7cf26b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 12:20:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com>
Message-ID: <CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com>
Subject: Re: [GIT PULL for v6.11] vfs procfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 06:59, Christian Brauner <brauner@kernel.org> wrote:
>
> The level of fine-grained management isn't my favorite as it requires
> distributions to have some level of knowledge around the implications of
> FOLL_FORCE and /proc/<pid>/mem access in general.

Ugh.

I pulled this, and looked at it, and then I decided I can't live with
something this ugly.

First off, there is ABSOLUTELY no reason for any of this to be using
static keys, which makes an already ugly patch even uglier. None of
this is magically so performance-critical that we'd need static keys
for this kind of thing

Secondly, this is absolutely the wrong kind of nairy rat's nest of
strange conditionals made worse by pointlessly adding kernel command
line options for it.

Now, the FOLL_FORCE is unquestionably problematic. But this horror
isn't making it better - it's just obfuscating a bad situation and
making it worse.

By all means just add one single kernel config option to say "no
FOLL_FORCE in /proc/pid/mem". Or require it to *actually* be traced,
or something like that.

But not this horror.

             Linus

