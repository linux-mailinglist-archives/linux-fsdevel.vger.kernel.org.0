Return-Path: <linux-fsdevel+bounces-38995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E5A0AD54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 03:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2137C7A3BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 02:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1C413B7B3;
	Mon, 13 Jan 2025 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAX1z9zz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083B43AB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736734424; cv=none; b=cDmXOtP4D9RWbcn57oHqSdYc/zWdu7XVocMN5f/iHGl8CgdSFfd8i26hKOhAooQPTSjBZpJGOsZi0JxguVEZ1uJb+95ZAEcj7SihqZbaDBx3TU+r+/RCHG0am2rhqqIbQGrixXRnOF/cSn4t5mqI9XUiSstuDUlIkM428JgpCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736734424; c=relaxed/simple;
	bh=HqU7byBjxlY92J51O+sZvTLZx+11VTKdY3Nid+oYKsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWnqDxqs7GjYcuxsPuOxbGvmBHszvD4PA7OhWUY9ztgugoKGHd/db+SQxRFfWAfwvq7dNpdGBETRHNSZWypGs25ZowVfO5VGSraH1lvfT5svAxZNzRMFFOKnfSOGL7KCUf3xuKNg4F70CkYOummmmkNmzYRkH6RsefYt8MteHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAX1z9zz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54024ecc33dso4013777e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 18:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736734421; x=1737339221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDcDUBKGkmZsI2MI/ECjzfhFHia4nRUYNYyVMxKgrLw=;
        b=GAX1z9zzo8+SIjpe+PMGY28doTCbZQX+BnOkyf0DLNJfvNcv14bANr+piVUG4oAyN0
         UY0ZvkBz8k7YFTaUhMgL3zL7R5YrX/CS2lgBvF3Q3ChbkV0LUAd6zMv/OHrt0AMbWITZ
         5cYEMkJuzXuJh/p/M1vrQicMniT90D9WkAm2rgj0K8UduB9yn4s5s6f526lprwPeo3Ha
         ms3+LS9bMJ6kNGpI9zEZMYDuCKYWYQid9rRCwtIOuRZfzafVqOEoLB4kn+94I7M468+3
         mu/0kZEMMEtgM1LhgSPD8QEt4HFZWYOUPlUDfifF5TtlmzwqlBx55hkDGm7OEi+b7b/B
         /YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736734421; x=1737339221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDcDUBKGkmZsI2MI/ECjzfhFHia4nRUYNYyVMxKgrLw=;
        b=AVLwfZgCC2XHsMrF3xjkXfypjixAQ94QYapD44vxEwTUR7PefjI941MXdEcW/nnUgf
         DRnAiBIjvcGwZ1oj6/a1JUedCFaDYmyg7qh8uhAzNyup9MBR++hn3opmIaQUs4ZcaTK4
         VQvFVKz++wAqF8Xm1dZIksGQMz29/FnCc9udF7wXBPpO3fssPu4FIltv67Fyz3HU9VRH
         PFDV9/g15GHxvyl26hX+8CKItMMpnBxoPbykTC0Bb99GOlFrUtvkGhk4FUkyG/M0Upo6
         b+P1n6wWF78Et38ibjDN7rVdsmKPRhLUnAQ+psTwGUVspND9iUKPgYRNXRyGUVlt3IoJ
         ifVw==
X-Gm-Message-State: AOJu0YxIiNTjErA2nU6ZgX1JqzbATXQj0y/aDxnIhAnmqsJOFWyevM1u
	YfDgbpKG3GX6SHukLKHZr1rOQ3ktpbUclGPVpqQpLjnOMSdFG4BBDq7kc04rx5iuo5cX/2qFMSw
	fWBeWsI3w2+Bfb/UmuuD4egnuCkLHnoj0
X-Gm-Gg: ASbGncv/n/DE7vQ+Du6piRxqIEV43H6TQk1Dl/dkPMAA7dzxkMf5OJ3A2I2s+G/FgCX
	UpT32SM7MfuDa4Sv9isTIuOHo9fkvMhpCR0C9FRo=
X-Google-Smtp-Source: AGHT+IEPOIPxslz/CTEJ9iaTriKVnNtEAXhafJGV8ituMIvOCKjA8/dxS4HYjEiRrKvJZxHO9Sqyo9D/oIsFJEumykA=
X-Received: by 2002:a05:6512:2205:b0:540:2542:cba6 with SMTP id
 2adb3069b0e04-54284527758mr5478945e87.21.1736734420818; Sun, 12 Jan 2025
 18:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NahYr5vyu74oPTp_+W2X8mOzP9GYZ8QkMtgk4xTKLwzzHA@mail.gmail.com>
 <CAJfpegtGG38y+WC6TAe808fXWtYNtyeOuQq3pcie2y8AK7-==w@mail.gmail.com>
In-Reply-To: <CAJfpegtGG38y+WC6TAe808fXWtYNtyeOuQq3pcie2y8AK7-==w@mail.gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 13 Jan 2025 10:13:29 +0800
X-Gm-Features: AbW1kvaMfbpqr1MNiQq-XkFsYzyFmw8Frusxqx884INe3gYx_5aSVbftqChuIzw
Message-ID: <CAHB1NajCho-2iaiay2tY2_y8N23qMGtTR0NzBkpET3SupWvLog@mail.gmail.com>
Subject: Re: Inquiry regarding FUSE filesystem behavior with mount bind in docker
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 9:56=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 10 Jan 2025 at 10:32, Julian Sun <sunjunchao2870@gmail.com> wrote=
:
> >
> > Dear Respected Maintainers,
> >
> > I hope this email finds you well.
> >
> > Recently, one of our customers encountered the following issue:
> > A directory from a FUSE filesystem(a local union fs) on the host
> > machine was shared inside a Docker container using mount bind. After
> > updating the FUSE filesystem (by killing the existing FUSE process,
> > replacing the binary, and starting a new FUSE process), any operation
> > on the shared directory inside the Docker container failed with the
> > error 'Transport endpoint is not connected'.
>
> Restarting a fuse server is possible by storing the "/dev/fuse" fd and
> passing it to the new instance.  This obviously needs support from the
> server.  See some related discussions here:
>
>   https://lore.kernel.org/all/20240524064030.4944-1-jefflexu@linux.alibab=
a.com/

Thanks! It's exactly what I wanted, very helpful.
>
> I'm not interested in a solution that bypasses the server completely.
>
> Thanks,
> Miklos


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

