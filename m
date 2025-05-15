Return-Path: <linux-fsdevel+bounces-49194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929EAB910D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 22:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E9316E71B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418A29B8D4;
	Thu, 15 May 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiK4c5VK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EB29B797
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342632; cv=none; b=ekZYRpbE68QhlP7YqbQUmOxAQ8ywudar1VkXkXR8CWXsKHkPOIxC1+5gYTwXV+u2C3NH8O/nhILCfzCrvj/cvTnV2dvdlwTCd2lwb091zzhIwOUFiEvST0xAaa86gbJAThKIBaRpys9FApCFKPSzzpdF3Hr8TtMrnbNdNARcE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342632; c=relaxed/simple;
	bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn75uhtEezcgzGrVPsIp3TUBnTSwG9UrcHiEe5LCF3JXZy+SLJFRJYG7DQOHFK2Q7Yl+l3x/XbxzIX4Ebs3JAhm0KRihTOmScJ+mot3B3HW3Jgpfj0mrjp4RdXfxpizHEUh8sPHqrMAOgJEhMVjXuwNcdIrqXaV1y1vtVyqIk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiK4c5VK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so1345a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342629; x=1747947429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
        b=NiK4c5VKp6uMSJjFMco2TAD5PtvZRm+/Nbty7oVQE3OaZnmKVU3RWdW2kJpwdm8WC1
         9w3+WoYcman57A0RL3v1OVsw2ok20PXL4KRfwkKPZ/DBIqDWy335+k02rAGSMrjKctKZ
         kIPgCvZ3G6k5tUmICjohmIP7Tqge+2ljZ4o6RWu5N7kW8TSzeumG31IpV+p7XfW+pjve
         tNqTL2N5jYN4W/2iw1ODL89i8TcXuy+J52rVziqY0RxKH46PaFD2vk6BytslHkn7eUuz
         WLvCrhCe6ppUBB17JifhmtoB2h3P99gvhohrMn5FM1oktQvi412X2dzVdFTWJaOheR3s
         XPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342629; x=1747947429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
        b=k9rNtogNtqpxjwx3WOJL2p2ysCstHJqfZDo3rBf6YKqO2WXkJzma+/4aqzGgESRJek
         gI5SnPYwM9TV6/8g5fyKZth0NQCsIAaIB/QUamcNYkAM3tYFN895qtQKA2LS9697gG/F
         KFaYVia8GdLePZ2pG/B35k3bS07hpF43seiEs/7fOaqX9CMpXIP6+JSmw5mMh5LRXGPQ
         o32r2ukm1c2vfJOsJUrBijGEqZwhdiaCSAzx0RJoecYQngqp76w9ZWMz9pd+au2cyzMv
         mj32CvnrluWFzk1doWEN/SDOx4oTC7nN/pGRv+USYf3MeE7RWPPyhNEAzt4QlZp4u9zq
         jZ5A==
X-Gm-Message-State: AOJu0YwyXsM+o2TI3MhWmKFTySEhvlj/giDySTmXTJ5LDbAHCSYeMubZ
	d20qbQldyH8H/KylwQNmQ8xo/FfY75TvNnQeIGfIG0h0fDKH8BH+VhwobY8iKoAfb7CzJw7Syo6
	vYa+L3E3bmL0fRbiOrrzsdP4gSbqFLf2/CqCwh/lipOqx2tZEPsn8gpMU
X-Gm-Gg: ASbGncuzCkdLpf32mYNMMvInqljiyjv3fbVGsRXGl8mBG+Bmx+oPGLv5uavhicX75NQ
	2/EnI9jQ5/l7wNOUITlWp5q+rz1PQ0NpH9nChD1Lk2JFdO/cIAscoyWMSUYvzPEshrK77U/QHsM
	jvAxG2A+2OD6PCN5N5jU9Uckfz56qceOQLDKMFvbVRWPuCq6Yb+k5QTz1qcTSn
X-Google-Smtp-Source: AGHT+IHZOBTJlThJhcv/ZxHz/H+8QZlugn3sleQN3wcAGTU8hgAWjH2Njf0TmrGz0ZHIoDeXYKzWzlKfCbbNua8Uh/A=
X-Received: by 2002:a50:cd19:0:b0:5fc:a9f0:3d15 with SMTP id
 4fb4d7f45d1cf-5ffce28bb43mr138873a12.1.1747342629100; Thu, 15 May 2025
 13:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:56:33 +0200
X-Gm-Features: AX0GCFvCU69IQ16RRV7879LgqrtFsOSgJDh6k5Q76ICOqMSjVLU262TZzPZwqzY
Message-ID: <CAG48ez0dqyzT3k4-HC3UjhCncgnPk28c1Av-iV8c9hB5tcu2YA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] coredump: show supported coredump modes
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
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

