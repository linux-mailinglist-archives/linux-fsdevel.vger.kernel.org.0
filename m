Return-Path: <linux-fsdevel+bounces-67618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB2C44889
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CEE3AA122
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38C26CE39;
	Sun,  9 Nov 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob6C8J68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01626CE05
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725170; cv=none; b=khVY8b2GZb9R9Hiv+jMUdAm7cgocH8ki61J+0gtWd53tXhEcaXvhh3aDa3spSYXYXZjJNDAADDjS1vAo+xwctTwa8HSTZPpbUBBRpeyOPflPVPOlmjSSSrWwjAY0hZbU94kHJtiCYc2cfO5YNWMvR3hG5yT8CkojoE6KVLh3GmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725170; c=relaxed/simple;
	bh=KSSGO7Agzs+7TYQ7KKqeAnwYaZ28KPMxXbYzy0PaAEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shVfSb0w3P8er/QnTtRLBNOIJOVbdVtvKWnNHTq1dvCFc4M2tFqhIsXtU6qq3CXO5SaAsxN6fZZxfR4kKWVDiU6NMOLlabRe17/S2kizcazp9+YbD6cVc93jKhvIvStUGv7ahRwVKSaJITx24J0HXpF6nbv7f+XFmdPudERa3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob6C8J68; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7272012d30so428100466b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762725165; x=1763329965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVwXJXq3xWo7DohhoxXnTI8foqK4xMVIwL9L7OpKE7Y=;
        b=Ob6C8J68SNMi/2OZe8EwvYd25JSvqSB+LCZoiIFFsUR4M2y4YXkyEGfGl+ivoYjzRf
         CMM6br0Xn0Hi7m728FeV+cLK0/OuwSp7mKqLWix5KKfryH2MgfX0ahulqujg2inrF3WH
         9GQRjipsCKjjnOk+fIggsJZqYZ2d7CJ8IfJj+rYvlPqq7uE+JX93TOcGp8CyLQe+8t1O
         xE/AIK1LuVj0rexDvh48Z86TByqgRMYFL4FAvAVnDWoGSbaeMgJp5OHptSjK2NZJc5qy
         MQNrFOElc73Fkn+/WwkQif5TFqtlpzw61LiiQpK/2ciWCmdJBYcnPMwuUigGeFuclXRh
         K4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762725165; x=1763329965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVwXJXq3xWo7DohhoxXnTI8foqK4xMVIwL9L7OpKE7Y=;
        b=uR5Y3JdRDwA9is494LuNtzpvGLv2L//dTrqmFyXklJOIQSldQS4sZrZlYkrjlf2C2x
         TdeHLKFTPwAcGE9V+NtFVGgMPjKwLm1aBXaGxaCT8N15ACa3tYeVT5N+I7cmXAKDIyPE
         CdNg5eRkYFwhL+HxtwFKRmLcrMV2/4mYfRSUgZeKBvdVtMvpP7/eJOIhSUmehh7EehTa
         cPMM5aVBSNMJY5/yzb5A0y/R8iyRPm3a/31ycF8DqHBExj3FzXygNmbrh26szXcvA3C3
         Kk7wuG7o4ANnI1HEKLphHEPOrYjha86s+IBXLI0UXPABSWTGNjjh/lUEGF/kwg9OE5fv
         8mqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqt6jbzOf8FH6OwcsZOyL6KxqJnb6+AqqyR0iqjtpzDqhHlNtx5aAcDgtWuNiZmfO3cYKsYaS+AJsTdLZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUbSwkbivtFiIPviP3rJP3kvooSKyzzQWNemMMYztdH32SaHH
	oEpBQZGPNEzny7g/pFR1SVbYXUpo5NkWEmxddppEETTtsxHyubZmEPVWP/jT2C2scZr4ICvkGkg
	30h/tQOi8+DxtSqpgjsiuCdJotwDLOk4=
X-Gm-Gg: ASbGncuzn3lGhhBKWoCcgsu+o8GGjQfIT7VZdgw6IJbmQTrgvyI62LsOfn+CygBq2yw
	RHd7iiPujv4q9FGXhBbjoChD6gPCml31Mm5Z/2lOXUoXZENkSXHWfB3ja6EoK5Pi6zdooGjGPs5
	pznhnwbZXcTm6gRdvdwD5horyOxyqZHWP6ELfmYjFs/vuEreFipdvNtbRKyLcTGO/pfDQ75ZoU5
	4yl5qOalGfxRoV6J6S5MkPzgVj2nAr1qCBr+ZLZLJVNo47uF+mlCdNn+5JkCbzLKjJK1zlI1sQq
	nYjdU4NNI7Ai/22qsRY9wdnxdw==
X-Google-Smtp-Source: AGHT+IGm2zklAUKqRRTqPY7KSD4Xj1sW03y/dnI40dOTMnRkZJwmNoipuG5q4hPL908aTtcn44Mm7+NVMASEDBRVfMU=
X-Received: by 2002:a17:906:730e:b0:b71:1420:334a with SMTP id
 a640c23a62f3a-b72e028a620mr608665966b.13.1762725165049; Sun, 09 Nov 2025
 13:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109192940.1334775-1-mjguzik@gmail.com> <CAHC9VhRCvoXrUESCjbxz5Bcxjq8GXLj4GvSoXq+sukdP1cuXNg@mail.gmail.com>
In-Reply-To: <CAHC9VhRCvoXrUESCjbxz5Bcxjq8GXLj4GvSoXq+sukdP1cuXNg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 22:52:32 +0100
X-Gm-Features: AWmQ_bk0b4hawYzyDXb9sgQUMhe7v79BweJw0OhxRSsIbcnHE0pse_GzfiY6jM8
Message-ID: <CAGudoHHhLPTktY7tORrJFagxC8xgwM5UzWgrPHsnkGwihBfQmQ@mail.gmail.com>
Subject: Re: [PATCH] security: provide an inlined static branch for security_inode_permission()
To: Paul Moore <paul@paul-moore.com>
Cc: casey@schaufler-ca.com, keescook@chromium.org, song@kernel.org, 
	andrii@kernel.org, kpsingh@kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 10:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Nov 9, 2025 at 2:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >
> > The routine is executing for every path component during name resolutio=
n in
> > vfs and shows up on the profile to the tune of 2% of CPU time in my
> > tests.
> >
> > The only LSMs which install hoooks there are selinux and smack, meaning
> > most installs don't have it and this ends up being a call to do nothing=
.
>
> Unless you have a reputable survey or analysis to back up claims like
> this, please refrain from making comments like these in commit
> messages.  I can't speak to Smack's adoption numbers, but last I
> looked in 2023, and considering only Android since numbers were easy
> to source, SELinux was deployed in enforcing mode on over 3 billion
> systems.  Of course I don't have numbers handy for *all* Linux
> systems, and there are some numbers that simply are never going to be
> public, but given the +3 billion Android systems alone, I think there
> is a very real likelihood that there are more systems running SELinux
> than those that are not.
>

Fair, I was mostly thinking stuff like Ubuntu. Phone stuff is not on my rad=
ar.

> > While perhaps a more generic mechanism covering all hoooks would be
> > preferred, I implemented a bare minimum version which gets out of the
> > way for my needs.
>
> I'd much rather see a generalized solution than hacks for a small
> number of hooks.
>

I'll ponder about this.

> --
> paul-moore.com

