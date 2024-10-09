Return-Path: <linux-fsdevel+bounces-31490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6119976ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF961C23890
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F41DFDAB;
	Wed,  9 Oct 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKYY8/06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1B40849;
	Wed,  9 Oct 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507120; cv=none; b=uE2SFt9s4r8g0XLA1J3H2zUg+9RC69jXsnhhTq2iH2FkI3FrBtSbkdLCt7QcMzy3Qj+08t307FiTOmQY5mWBW4ZMepsWawedCE/jqJbMz5d3+G7LA97/R6jSHDjMkjbBT0kharXCvI2nuBHDTyVA0yf2qmj8nCTByepVF7bDzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507120; c=relaxed/simple;
	bh=7eEYmkwZOXgG3cVEV4IS3EQLMD0iGOzTcNtfPWmdV6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxJrkp8VC00FqZWMxjAFrnKhBVoX0kmYh/w1VxN9/p0jPwMOctW/f3MGW/h8vuh+FMadKt5INQXFuKg8O0SiZnj2bsM7f/QWjMz6jX1muUgizvUBjjj/b1t2gtQrSqcM45DcFUw8ggf6Pc9qzIqGOS7TwaiOOyOz5Q0V9hCbhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKYY8/06; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fac787f39fso2062581fa.2;
        Wed, 09 Oct 2024 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728507117; x=1729111917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eEYmkwZOXgG3cVEV4IS3EQLMD0iGOzTcNtfPWmdV6o=;
        b=QKYY8/06XTXHjnrr//gXN6wtN/858To7OyP7z8aIVexry7msl/7xJOIytoXwSa0jxX
         Y3QXwY21p/i7TPR0HH2EsV32ocNmRf7F4mIgmvBIIKjJJxFeo+q7VYHueLKz0zpeM2LN
         BaJgDSC28d4aHhZTQBxmLv42WfMzl+zBwdH8qUCpd/Y9yqWxRad+NylGgGpYZoYfeOpe
         mPbWitsWp+LjSdYJQobdOaUdwFJKMNXVY+zYLlEZXwH801/2nm58RU9Gt6fkBMSkosOQ
         RTZIkNjLaooB23zKAzABwBNZsT68lMk+rK9AwxegQKjdCzEtbg7iIM+mvFdQTe229VXG
         M9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507117; x=1729111917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eEYmkwZOXgG3cVEV4IS3EQLMD0iGOzTcNtfPWmdV6o=;
        b=nS8RsUim1oIzCWoALe7TnJNtqkyc7axs/zrwR96lWk7vJ1IOLZuhHkSN/Uy1a9eHGC
         2w14GgxRg5+SyVRUFuH/fzIEntgK5+RVEutI3mxRlNoDGgUCRguKjqHIxT/a1+2MaUSO
         0kK7nG7d8++jo6mraG5l6nFpXI79UjdwrRWwQOerH3HwZ4N1540N3D4mVevhPLn2ztYU
         4bc2p+40ZA2hG5fXbtj3oTSLXBPYPOsghtAI5fxGs3jX63hVXCQ0WzWc0x/adm9AhXtE
         rr1es5NxAdvMCKuzz4Sn+eL/uMd+matygfeb8YqVbF/qFG2GxKT7JESSrjGF3kRPifcC
         71XA==
X-Forwarded-Encrypted: i=1; AJvYcCUj4OwvBKVlUT29TIj7N7YzAJ/IbTnKM1aR1wDMY3w+5Icwq3ABjfINBIBFQMbjW0gpaNEYolJk3732cCya@vger.kernel.org, AJvYcCWvNUYhexSngkPh+Thu66bWMGo2J+QjsIdXvxgPdMFsGtIsyImxE0yunI4+1TKT+3ddhcIjYg++hKM=@vger.kernel.org, AJvYcCXKPukSsvQvr1UnFNgqYVODlncxo+b3KTdcbtrvEgOT5C6G/eMNQJIecpKb/cNjvHEkMCeRFYXR37Hsm+hPHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe7y465q8n1b16lv4UZDNkDPwWdCVri0wdsuIxoylSU1TfPv0
	q0YyJ+d5kVll+ifm0JUSP9Y2vWSRoceG7+VdWTQb++wri9LN8K1yv0HLnuVFQrWAKlR7j18TpNz
	FuP3x14xvAZEpGzC+wBuFDpaQfsg=
X-Google-Smtp-Source: AGHT+IFPqpXACmSDMOmLZlZLVksWQb1h2WwlpU0ag6spXreUoZYethZyf7RMHEGsspTXj65mCdnvjs7xn/2TiYx9YHo=
X-Received: by 2002:a05:651c:505:b0:2fa:c519:6e66 with SMTP id
 38308e7fff4ca-2fb187d1e4dmr21747781fa.40.1728507116460; Wed, 09 Oct 2024
 13:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009193602.41797-2-tamird@gmail.com> <20241009204433.GF21836@frogsfrogsfrogs>
In-Reply-To: <20241009204433.GF21836@frogsfrogsfrogs>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Oct 2024 16:51:19 -0400
Message-ID: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
Subject: Re: [PATCH] XArray: minor documentation improvements
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:44=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> n00b question: is xa_store(..., NULL) the same as xa_erase?
>
> If it is, then should the documentation mention that xa_store(NULL) is
> the same as xa_erase, and that both of these operations will cause the
> xarray to forget about that range?

They're not quite the same in the presence of `XA_FLAGS_ALLOC`. Per the doc=
s:

> Unlike a normal XArray, storing NULL will mark the entry as being in use =
[...]

See https://docs.kernel.org/core-api/xarray.html#allocating-xarrays.

