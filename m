Return-Path: <linux-fsdevel+bounces-47929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D9AA7491
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D232189A6BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFE256C64;
	Fri,  2 May 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YaG2OyDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A62561D5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195088; cv=none; b=E5HLWv25PYrRFMue5SkDVsCUMKi9sjdqJy699IuwK40aydzeNjaqzELWh/TiVKTk8Uw8lsvA6GX8O2UJGGDcnqGUilp7/Sbj0lhBt4UiD6qwle3ISSy9KWKkfqfyQpHdfjmFh83wkneYHN/Obt8ae219Sz6JFLroaIn8yoTBT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195088; c=relaxed/simple;
	bh=Vt2jUIItSucYOFtSbIcXHATgjkrt7oAf8nrQ6pmlrbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKxiGXnQyeQXLEYe0UDdi9wCG4weIjBbz1UQ8O3HxID8Y6iM+YJOzRhC5s6W21Um2pRRNn0pqHUxV3aWxhKVkFfDpFgi6z7MTfJBQreFYXdWcbwon76hdDCOFLJ7DKT7dCo/nsSOfgN110SwnRpoi46F+HPnbJWHWB+ZJYvU1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YaG2OyDd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso7829a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746195085; x=1746799885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt2jUIItSucYOFtSbIcXHATgjkrt7oAf8nrQ6pmlrbo=;
        b=YaG2OyDdfxp6rWAfJEcX0jTBAp1bikRAEsb3RZ0sVY1Ci1V2Wssrwo01mcXZJQC6WU
         54g+QpeGj9ixHjP+K6GwtpMMFjA37mHJgEs/VhGrIO8v2DfLTnxnucVgZxd9EXz2DyCZ
         4aDbpLFVt6+opDL94J3CWeoXmHbWNYSOJ8lKhV0QPTCkp+v7vVUs11B+/vRqooR1IQl2
         PXHvLWRRElKm2AdKtUCg+P8gF/4x3gLwpKX5q77oSKh4QlC5gEGvnnlm+pjV5lMET0te
         b00baFbNlCj/haUM82JciErz1tJH3MeOH7qc1W27MnoBk8flsKSv+9un59puG8+t14J+
         CI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746195085; x=1746799885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt2jUIItSucYOFtSbIcXHATgjkrt7oAf8nrQ6pmlrbo=;
        b=aO6aq62Fadlqx2hwMkXHRCjY/sSvoVeAbDTJ2+GHmvVXC8s+JNd+Hyz95GxHLbddik
         6/KrafM7LaS0ee61acEU4v8wCMptLDsK13qBlt5+mmLks7oUdYORsRqGbD2SuTta2alw
         KiqoYn6H+hm46hUiecD/iStfqA+W7uMK7nEbaypSHCZEQJ+vqL0blgMxJcO0a01mHkFx
         8se2xttXE51pNjrkgIgfb3r8UEZyp3qsFzu4GJWnW215Fjvvbqo3EPyIzAo7vdLxQkdh
         dT3FllhUa9ccyEo2koyAEAXz27XMdS1ux/HrJOzHTirsBkwLlKNBIThNKQxSFKV0gmxE
         1W9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXeh/JktlM3FnfbIdB/dVsIB40a2DaAkbMQIe1+p7klqBkOHUto1kiLPHZgV+13KL3EIqu+NdRA9PpnjZv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lm2XlqYC6Pzb9QUBwfee7mlN4niCtGW0ahvD6ABinzlyBvoJ
	flIg8meGAhXvtsK5eA3p60ieRO1H/kaqy+GoAn5NmTs94JtLMz1REBN8OpK+gcT3uD4udccQaeo
	0IT/OTNfWW/JXzOn/B/ujdnwmLeQrzGXee/Fn
X-Gm-Gg: ASbGncsQo2RTc/cSefpjyVhS8Q8EKY58CJ68SN7KLOAtpgvbcpwQq2m0qj9S29F7+oz
	iMHHIawP5XT6ilLMJDtlo+Gf3MMQpvvHpVWEZdi8QuDaFKMpgJ99kBJdy2OaPxyKKJXT0ntTxAe
	lcFnXonhRXuIFKRwfesMMg6Ap6AZjztSG5i31Fm1r4fweE7TTzVw==
X-Google-Smtp-Source: AGHT+IEq4zZYwSq4JbP1XWIN3z7LZZH/ze1XMZW0I7CaF9AqWXRX3zQiHPa0jJanCkxNdcG6ojLB9VYf79HdE5YqMJ0=
X-Received: by 2002:a50:c018:0:b0:5f7:f888:4cb5 with SMTP id
 4fb4d7f45d1cf-5f918c08662mr174781a12.1.1746195084602; Fri, 02 May 2025
 07:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org> <20250502-work-coredump-socket-v2-5-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-5-43259042ffc7@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 16:10:48 +0200
X-Gm-Features: ATxdqUENxkugyPW7ElgtsxNZpy_Nh_FmjQSxMwJIlzlcl6CVeGfFkE7y7zUJP5s
Message-ID: <CAG48ez1x09k3neRXqZYtPwgcxN+8a9=HZCtUkok54bRwAk6BSA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:43=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Let userspace know that the task coredumped and whether it was dumped as
> root or as regular user. The latter is needed so that access permissions
> to the executable are correctly handled.
>
> I don't think this requires any additional privileges checks. The
> missing exposure of the dumpability attribute of a given task is an
> issue we should fix given that we already expose whether a task is
> coredumping or not.

Yeah, it certainly isn't more sensitive than things like the exit code and =
UIDs.

