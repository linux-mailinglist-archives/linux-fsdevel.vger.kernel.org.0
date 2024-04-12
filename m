Return-Path: <linux-fsdevel+bounces-16779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E258A27BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F070C1F22D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15161481D5;
	Fri, 12 Apr 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTMDirt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34D41232
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905956; cv=none; b=pq9+dJCT6QMcFQMiwqzMd+iZhSPvJ6gmS4Dn7/Or7fNVRK9gCyqJtXMh6wRQ9XeytMiAYo1WGp/KgM4y9ztN57sZty7M9badRtK0lQIKESiesCoeD9801r9QK2z/P7DVq902/XE20g/o6VvM6J+K5Q2sGKBKVIBdjkWtUjJquYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905956; c=relaxed/simple;
	bh=d0AZF/o43P/elyr6qp9MLVT6fVge63QswRLOHDHVjhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puZ7d8vVxe5d+ZDaMQEfsdnNr+7DtP/XtiKa9D0mzYYw5zO1iJ0Aw4aPHjKonvlvT/1XYqAXHrxJGfit87ih2snKv95QnK2MaHEXm7En1W93mXSBuc2iorvCg49ksWik7ZaxDeOCrHMba7eZs7gvOszJqZoiy2B4JaeWlGAe9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTMDirt+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6962a97752eso4858976d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712905954; x=1713510754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0AZF/o43P/elyr6qp9MLVT6fVge63QswRLOHDHVjhE=;
        b=PTMDirt+z72PDonOfE9e5eMz3zF14SPhzxb7yoB1nChy5vJj9q2lxlTIajZQeD7yR5
         hYuk50PLwrupGuXrobmu6RE27v7IqyRtt8TLyZndNNyttP1Hm/HdI0X9m/vSnishMUuN
         c/YuCrWM/FcsV7UZfU4bY+SmTqffZRzhkvnTxuT9mE/FYL2mRNX0xknh3YkiCb6DGM63
         xuEQbkGLnw1VXnkpgGBkmewD2QRUTTLWhCeotucj0xzWMIplpEITcfbjEoNXvkVofWzY
         AJPw5mpKLxTKX9K8GZy4UDxyI3N6SOlJM3EkFEEaFzttiEgJOXkybZm0tMgB4KR+H0Yt
         4Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712905954; x=1713510754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0AZF/o43P/elyr6qp9MLVT6fVge63QswRLOHDHVjhE=;
        b=mxt5MCvKnlllZwvG5DoSllalI/MTWTq1o6dXPMB5uU28JRzffndaI0/eXZW72xolrm
         zoke10xxjHIL3k2TQBeh9WhqbRD3gr4cZ7TZ+W+wsMQs8dagDF5yyWk4Wp3zn59ru6Ti
         hhkyejKizrC4/xqbQrP+1r9+2103ylXVvrKooeqk/mavtUHP3B4V6KvCLR1R3nNLUaIl
         bqzmTqxOyBmwjQ3DshOYs+BOt/kRIZV/+LvJPL7FzA3ikllelV1fcwK5AVBCWUI8YGv6
         UeqRD5MaGSnjqXoO7DOS1wPrdWUI+nfZBA0NzKMQInx+tc/Hkh4wdnnnSKA9IQicwl6O
         RuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyeOCra9RG1G5O40mvWexsjaqRjGWZMzCfaTOjO5PVUfcV70M6c3BrIqlMQVom7kreO31OXYBFvPkwvfG2KO0OHgLYifVC/ueZY6n9fg==
X-Gm-Message-State: AOJu0Yw7b6/lzI6zRgDgakKBpwtIzr1rEHZKNXgBf66jKxSbgGnEHYOR
	e6KjFRHPBN5x/EgGzIFtJczzlkQobeamIPV4sYGzDom9GUwlx5bOFuYkcffUO0UdjGi+VO1a6VL
	Jkx4NI9qhuRhj4eDYkC/V572arK0=
X-Google-Smtp-Source: AGHT+IGh82wuOwHlsaX02SwUerWhcEp4l8YZwXifyKSXpRAqSoJfx7Yji2NxQyTnSELXr0rLHTnDX4t21KLhGW+XG7k=
X-Received: by 2002:ad4:56ed:0:b0:69b:3467:248a with SMTP id
 cr13-20020ad456ed000000b0069b3467248amr1869393qvb.43.1712905953850; Fri, 12
 Apr 2024 00:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67785da6-b8fb-44ae-be05-97a4e4dd14a2@spawn.link>
 <CAOQ4uxjOYcNxNf2S0yFxBgV9zPMhOQOxY72v5ToCxCPJ2S0e+g@mail.gmail.com>
 <03958bec-d387-494a-bd6a-fcd3b7842c6d@spawn.link> <CAOQ4uxjNF4Kdae5uos4Ch9qBvmAC2kSH58+wVr=F865XhVZsNQ@mail.gmail.com>
 <a54405ff-d552-420c-88e9-941007c7f0cb@spawn.link> <CAOQ4uxhnSDshQmjn-39Q9TbMJLZiWiYXf+8YLVqB7nPW1L5fBw@mail.gmail.com>
 <G2XhehibMSoDHBWhAJVS3UfIT1-OlMgYkwAgTu5v2ys1BIUCznJ1B475OEKLBFf6M9gnlpXqFIkrsWRmofllLba2b7cRogWLODZQ5Ma748w=@spawn.link>
In-Reply-To: <G2XhehibMSoDHBWhAJVS3UfIT1-OlMgYkwAgTu5v2ys1BIUCznJ1B475OEKLBFf6M9gnlpXqFIkrsWRmofllLba2b7cRogWLODZQ5Ma748w=@spawn.link>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Apr 2024 10:12:22 +0300
Message-ID: <CAOQ4uxiR7BHP4+PNx0EBo8Pg4S9po7sDP50ZMVq1aN3zpk=z0Q@mail.gmail.com>
Subject: Re: passthrough question
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

I allowed myself to reply to this snip on-list because my answer is
relevant to the
wider audience.

On Fri, Apr 12, 2024 at 8:45=E2=80=AFAM Antonio SJ Musumeci <trapexit@spawn=
.link> wrote:
>
> On Wednesday, April 10th, 2024 at 9:28 AM, Amir Goldstein <amir73il@gmail=
.com> wrote:
>
>
> Not sure if that allows you to implement passthrough with mergerfs,
> but this is what the kernel implements.
>
>
> Now that I've looked at things more closely I've realized that the passth=
rough requirements are in conflict with some design assumptions I made in m=
ergerfs. Not that I can't hack around them but certainly isn't as clean as =
I'd like. Going to need to put critical sections around open and release to=
 ensure no concurrent opens of the same node.
>
> While considering different ways to take advantage of passthrough it dawn=
ed on me that it would have been nice if there was a fh value that was atta=
ched to a node on first lookup and could be freed after last forget.

That is roughly the plan for the next phase for getattr() passthrough:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxgVmG6QGVHEO1u-F3XC_1_sCkP=3Dek=
fEZtgeSpsrTkX21w@mail.gmail.com/

Not fh value per-se but a backing id, allocated and attached to fuse inode
on LOOKUP reply, which sticks with this inode until evict/forget.
OPEN replies on this sort of inode would have to either explicitly state
FOPEN_PASSTHROUGH or we can allow the kernel to imply passthrough
mode open in this case. Not sure.

Sweet Tea said that he will be working on this new API, so now he has
another prospective user to test and to validate the design choices.

Thanks,
Amir.

