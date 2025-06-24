Return-Path: <linux-fsdevel+bounces-52832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4AAE736C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA0C1BC3857
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55826B0B6;
	Tue, 24 Jun 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OvPSwlip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58126AAA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808678; cv=none; b=n1e8bbfB2nEdobBHci4aGzbRMUQBWIvPQPinjkcl0iQqjeqFOZ0kQXiT6mafmRM+76DIMAYvglRvdxXAxQI5x0cGqLxmJe718/x/cMSar8x6Q5ukBKiTVz6b2h+AMffQFYUkHKgaQ7BTRve5UnCpIbs8w4B7+JwppOm5dgVltrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808678; c=relaxed/simple;
	bh=phaDN7eV8f6TzylrwNnPTs5X3yC1ERVNmiyd0BZDIls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGLDbH3Wf0FQ+fRvHxDdC71SR1miYY+iNyNVXShi4J2hvjGQQ3AeXYXzPYgg1L9WtyAjWJ/3VeIvgXP6GZtRAt83CcC1mxa/Iyj+qYD8Qat2r5Z0N0NYnq02u3qSTZBa7+iLyZd54IEdCYqVli70pKyXaY0hnXFnJl49CJqff1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OvPSwlip; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8276224c65so1023177276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750808674; x=1751413474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypGqRXT9B6uz9VhXeJhe2F5sbavYCtgIItdaOAEXkS4=;
        b=OvPSwlip4Kazt/S9ri2j5VeDhKda3I8b1Q9PV6y68MNtHjhVuPC5elfuYB9bigs5tO
         w+nA6MHplF++ChPYTyd5lhDGickosH0q7WTpJdbfAH36b4jWbY1PaO/47pnIhnj3nvXt
         WK8upkmDTdi41+Lxu4KGwmDsn8oVgXum2GQJ1+EQHlk2Kn++fV9YmmpED0OdnRGA9buF
         JRurl5/iI5DdCi6xxf7+WFBbOGojJP9yxyeLEf8H8Njt0hi1es4pbsPNZx/tVZvFHV1R
         EjIGqPCIIO/ijxKP6QgRpKDlZdcqL9Nu0fmVuIqcgbCBpTcTyvyYmwwjB8Q2b96ZRxsg
         rfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750808674; x=1751413474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypGqRXT9B6uz9VhXeJhe2F5sbavYCtgIItdaOAEXkS4=;
        b=vQqZCK5cHnplt2UNifIesqiZ5D0v41Vd2KhCaOChXt1ZFqJDXLPV3VVsjC8sS8PAgj
         TZX8Jo3rNO6ahnnLpCHDXIdhtxAxn/oH3ccKOGkWQqAHvHMY656w3V+pUHZ/SIYW2zqK
         5jV48sCIB2jC1KDaw9yu/Z91fXwHkFHcmHV5/CyG/jklwwQRx01/drlxvYUWbwM0QA3O
         n1EWyidKJ3F6l7kWqvlZ4esGhgoH8pO4fPdLTMw9vSjTBiRcRL7G8se4wZ6vOcdUToQM
         XFJlc828G1F4UqnVSKVNzYs6vmm50R/bnrf7i1Fy/90snqnV92ClfP9Bx+SVPKcKClf0
         WFlA==
X-Gm-Message-State: AOJu0YzUUP3pILilgkuMvpj77KmsPZdOi5t5CLu+eZ8qj7wKiwRh02OY
	ND/5b8IAcH3AQi5W9xcFvkGjZhASevB35SUiRN5Nnj4At4fUqV68WiMvaclaAVv+8E2pvB/Fo/B
	pn3BdhUSRr4I/6rUnZTXr7J+l03FRTZljagpJE2hX
X-Gm-Gg: ASbGncvbzMVS/mIL87KWsXwoMwNhxntokG1qy6ao+/CJ1Dev/rE+AXUeQKqAiaKO/ry
	MnlZde2BtFo3D8c6u+QVJ0QiB79LMMClnpEEAoqjcV05EPTwfQS5GthlcIGYXjT2Sn/OOmnNDhB
	EMG9Jff2iINN0h8FY64rQp5wc7m9U7G9e6bl826u2tQ2A=
X-Google-Smtp-Source: AGHT+IHYYzpIRcCARvY/5Tfe83HpMMGfatz5XhMVHQG4Ncv8Gwm83fUH9i11USV7knuqyOID1THO3kDuJPt0AFVqMkg=
X-Received: by 2002:a05:690c:7011:b0:70c:a854:8384 with SMTP id
 00721157ae682-71406cb4bc7mr15901777b3.11.1750808674451; Tue, 24 Jun 2025
 16:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV> <20250615020154.GE1880847@ZenIV>
In-Reply-To: <20250615020154.GE1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 19:44:23 -0400
X-Gm-Features: Ac12FXwcVhx-YeOi1FT2F4B7uxfo2lfTBSXihnFcoA7yu_J3MLk0q4urxj_iGGE
Message-ID: <CAHC9VhR6BAOqHuBf+DdWQC-D+Lfd2C9WLTEpFjy1XQkqH1syig@mail.gmail.com>
Subject: Re: [PATCH] selinuxfs_fill_super(): don't bother with
 selinuxfs_info_free() on failures
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 10:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
>
> Failures in there will be followed by sel_kill_sb(), which will call
> selinuxfs_info_free() anyway.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks Al.  I went ahead and merged this into the selinux/dev branch
to help avoid any merge issues, but if you've changed your mind and
feel strongly about taking it via your tree let me know.

--=20
paul-moore.com

