Return-Path: <linux-fsdevel+bounces-72213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9634DCE8389
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 22:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7AB3010CEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B92853F8;
	Mon, 29 Dec 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4jpFlzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8048125B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767043897; cv=none; b=ooTz7jJgiloKVdUeI2lS6x7BAZNTLrJRLLU5Vjmj6X1tNyiXsdUbhQpXElAcmBAdV5UNGDspyqMc4u3WZWIHDln1ZX/7Hkeq03HLqvpjOX2AiU2W77OogjAactYdxXa3/qyh06r6BIz62SLXji826fehtG4ynIXBkqekfUHA5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767043897; c=relaxed/simple;
	bh=2doAA4Fk0P1J7gufz0cYA3e0Uog/QgQKoRTnXLg5fJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igv3aJ9Wb6yXmI/JXwDCRxv1XFVST3Chrqw2OuCc29pZDbF3Cj3xxpUzM7qLv0dwL+gWXewpAQ1RP4RFW2Qf645Q+fXwaa0uemAdstqCbK+WcpnK5LrRdotlzdE7oevTj/h66otsJaoPUCMejW7DApPNFhAbPpsKKbgfHTmPVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4jpFlzq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee19b1fe5dso107239641cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767043895; x=1767648695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2doAA4Fk0P1J7gufz0cYA3e0Uog/QgQKoRTnXLg5fJI=;
        b=C4jpFlzq7FyfNXmfL8N0+BXQJM6Hm9cm8te5L4YLT9U0ucswSJeUYKC2dMJ0dizxkJ
         EEpAfoEP+QaWjDcGi15JAdSIl4323kdnuP8WGFPj6qYBpwcEtgAGu+VWWlMX6Jbe79O1
         cJu42pyJF7r3MIZeqRE02BXzodp7wAKBQ0l1Yru51iYB7OQiMGFGA9PAHUQ/ruPjbcEn
         JtDlois8SJi45wDZinMCSRAbdU25WfATYxzNoBm6wKjVMzxQL89rKLmmk8xG+KlAOL3d
         1htNwHa91zoXr1621KTvZNyRDXuQ8X/U3fdDH7hiyoQYQE7ceprg3viih0icMCayNfuf
         AiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767043895; x=1767648695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2doAA4Fk0P1J7gufz0cYA3e0Uog/QgQKoRTnXLg5fJI=;
        b=lzGnfK3APG2nXo//J8AOAJevAZMwDvjgvk5T21EA0y+1buLu4VqZcXrvpNT3PFzeow
         ZZPCVKvTXMEh34hzVTaHKIMu7ev2Yp7AXVQ0TFoyFMWo3FgunvC04h2XtpgbA9ZijOp6
         FkFajf8W5BJoY/0XCFciMy7OoZ2pHudVlZR2eA7CobFpos0q34e0FRfg/VywfdhdqxlF
         jcX8feuMIEgR9faLYqmLEwcAf3yPemHau9ZVKaP5hMq+MFuiJpDTjqJMx0j1MOb0sSRp
         1pk5TGbALIP91RjyCQb6dmSpcs4BbLmzRR05dR1zxZQbiXtOv++diO0VkLPRbDgHkDh9
         9Cmw==
X-Forwarded-Encrypted: i=1; AJvYcCXlcLKNBVnPwGHWwC/+TgfJSkudXc0cSLUnt6Aj6p8EEzynMk1LQn4P/gMwESqYMmcXamKPg6C9li68Y9+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjz8UZziMw1I/sxbORO0fxsKW7+UlP8+Qb8Msk4h7MTzmJvHzZ
	fZat0Plj7YaEy9L8VdgYWXGcW59jt36E6hD12TVeGbij1d/0s2jbCqh0SpPZ+gq16zgqehFpvJj
	ggecHFIVWLMu169NbDtbS98kdMtTyrLI=
X-Gm-Gg: AY/fxX7+fGmUDbJ44/UXae57CVOjpoeZrl+BEu9KFaKHVJ2T2W9eo+ikhTiEhh3EtPH
	7M1lZSuBaBhJyTWsZGzBzTU8ib3PEcZuok7CLTXe5wEsx6JLvtL5oQqP1aIoW8hW4aDfXMoPFWM
	eCPfnm8r4V78F1pYg4yc8zSXwq14stkJ2N3+E18N89oc/sqdj504DsSD1/w5G5P+Gp+DdhN1WxY
	j60+8FD/T/d1Xygl5dApcU4t2NIEG5qToSOJoO8sJ9lwk+w8/6HJd3s5L/Ajxfq/cc/kdSj7gBe
	WlQk
X-Google-Smtp-Source: AGHT+IEW6jCTZX+LNzZ1wuZKqmsS+B6NgyKwbQpmwlQuybgwz8ITHGyQFS44a4Nm36kvw8ngyNueou3teounR4sB2Hw=
X-Received: by 2002:ac8:758f:0:b0:4f4:de66:5901 with SMTP id
 d75a77b69052e-4f4de665a8emr252776341cf.5.1767043894904; Mon, 29 Dec 2025
 13:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225055021.42491-1-kuangkai@kylinos.cn> <9f54caaa-1936-4a37-8046-0335e469935d@bsbernd.com>
In-Reply-To: <9f54caaa-1936-4a37-8046-0335e469935d@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 29 Dec 2025 13:31:24 -0800
X-Gm-Features: AQt7F2ofnTGHxTQ2UOtNFLmTU-KIMEH1sPmO6h8T4nB8eK__3vSK-sV1h-M14Aw
Message-ID: <CAJnrk1b28v4RWvVN5LWwMiqTtqC=wWPQhSQJ-dkYQyaFvjbVPQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: show the io_uring mount option
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Kuang Kai <kuangkai@kylinos.cn>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kk47yx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 25, 2025 at 1:34=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 12/25/25 06:50, Kuang Kai wrote:
> > From: kuangkai <kuangkai@kylinos.cn>
> >
> > mount with io_uring options will not work if the kernel parameter of /s=
ys/module/fuse/parameters/enable_uring has not been set,
> > displaying this option can help confirm whether the fuse over io_uring =
function is enabled.
>
> The problem is that is io_uring is not a mount option, showing it as
> such would not be right. Maybe showing all FUSE_INIT parameters should
> be added in /sys?

Or maybe showing all FUSE_INIT parameters through libfuse to something
like /var/run/$UID/libfuse instead of doing it through /sys/fs/ and
the kernel? I think other connection state could be added there too,
eg the name or pid corresponding to the server.

Thanks,
Joanne

>
> Thanks,
> Bernd
>

