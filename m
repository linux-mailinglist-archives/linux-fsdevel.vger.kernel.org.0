Return-Path: <linux-fsdevel+bounces-29113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6838D9757C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C4428D201
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639561ABEA7;
	Wed, 11 Sep 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQW/lblr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294E1A38CF
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070380; cv=none; b=H4NkGLtmQJCT0RXTEe1FUiZvJarukS1qLQtEKlxLH0sz3rlP6ZQPQjWKuPpSzGqbVtdlpEiOyW8jeN6hdziufPGc15lCwOjin0toYxDk9tFnydF3W2CrXNG1ZF/2RZu0CUba/mZb4mQVAbLxC8CSu7Tb4Q9pd3tgh3ywc7GnptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070380; c=relaxed/simple;
	bh=p9K2tAwux1CTkP/3UQ0vbRqkTl6P2K48GLQp9Os4ZbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkjLc45mZ9D6GZ0hEoM5k3FuCCgnqg4SUFyjgX3cNTFD4hKA+fXNNgsGDQlKJCQG2S88jSbqF7qD5pIZxet6kXTvyV7PcwS2Fy99CI74yclq2AaPfTu0a02SgMFxQNMYkzzpHETi3UmDet3ekGLk4nLTzUaxumjJ8/9AP3XEq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQW/lblr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d87176316eso829524a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070379; x=1726675179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9K2tAwux1CTkP/3UQ0vbRqkTl6P2K48GLQp9Os4ZbE=;
        b=GQW/lblrKRhCQHgH3yOGkjgNF3wJVuaIqGJXI47LhPi1ZYJ4wd8zTvG50wXGnBeLfn
         i2UMcUxPdHjyrwbhLWEbwpq4gLc64TytOiB6bz6mzFFn628be8fqYH2ZD51kW84nJYLr
         kfO2MjOzSN6VGgr8h4NO85sD4fvosv7ozat8HPw9QjcPXqGf5wP4LwComujJc6snD6Ai
         6iVQshVrAavglCMUoU9X/Lg4VJfInMZH2XoEppHafUTNQ5erBJXv1ADZrMQUKh3fRB0h
         8WqQwOAMXNuCDuVmnhpyk9Y06dUbSWDfInr7I/QHeJH8tC333unuK+CTQNuURx/7EzM4
         Id6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070379; x=1726675179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9K2tAwux1CTkP/3UQ0vbRqkTl6P2K48GLQp9Os4ZbE=;
        b=X4fXomx7JndrE07isCuKlCtSRGwwJf+98IHLdrj7fFwVkjNOVlpMPL679ptaUJC50x
         Mtq995hn1u0GBZzkib4Sye58stvFZGNuPyruyg4dPMGXOwr56J/hyTlHqLi6lj8gHZ0/
         eIOJz33F7+k5xbSwjO4LfHcOE4NtN3QKDR0Qdu9hxG70sjCP0BFhe+Fs5zGAJnsAxkbZ
         Y1789x7ZRHkBE+Wmr8owGM0HTGM3mqQHBvfyUtMW44liL7taIdej1GRnvVjAkii4qm15
         a3Gv8IveGBifu1w4MlgkCEtSqkSiMm4ZM/kmbyCfTSVkauicZ9CxKttJcFQ+NnyuSm0S
         1Q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4nFCTNgVGDX/A0NvK0Cz/tc4zc9Ge9W5F+8XwcG/0LCT+NnmeZHp940bUmO5BfJc/iieM1rIQys8A3PiZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjY2Np/eHIF5fTyri9uiG6rqO5P+JMgUv2MBlQyHaDgxT1J1j
	zUwcs4DSJXD0Rp6AZVt0/zmAuaQw8udhfCFVe0w5veUB3YvT6FrNNhj3QxjWL86OtvL+uxiIZrT
	//G8N3RpqkoLurmGgT6TB/Gq9olUNzQ==
X-Google-Smtp-Source: AGHT+IGJJxtmH5ya95+oKHlDKpUnXwPT3/+XPQqA0jf4qkXaQPkUU8TCcWUvL7rGdwOre+E4eQXyuv+SAsoxNtyXTXU=
X-Received: by 2002:a17:90a:c705:b0:2d8:b043:9414 with SMTP id
 98e67ed59e1d1-2db671fc520mr11080156a91.18.1726070378539; Wed, 11 Sep 2024
 08:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm> <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
 <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm> <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
 <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm> <CAOw_e7aDMOF7orJ5eaPzNyOH8EmzJCB42GojfZmcSnhg_z2sng@mail.gmail.com>
 <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
In-Reply-To: <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 11 Sep 2024 17:59:27 +0200
Message-ID: <CAOw_e7Y49DRmVxEOPcAubtdzXzu6J-Z2wdkumxDs7OMHLRipbw@mail.gmail.com>
Subject: Re: Interrupt on readdirplus?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 3:06=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> I mean SIG_IGN, either at fuse server startup or at set in opendir and
> unset in closedir, the latter is rather ugly for multi threaded fuse serv=
er.

This would work for my tests, where the FUSE server is the same
process as the one opening the directory, but if that is not the case,
the SIG_IGN would have to be set not on the server, but on the process
accessing the filesystem, right?

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

