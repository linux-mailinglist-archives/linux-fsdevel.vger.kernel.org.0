Return-Path: <linux-fsdevel+bounces-48074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9DAA93F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52363AB06C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF72561B3;
	Mon,  5 May 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aICp9tk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00B14AD0D;
	Mon,  5 May 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450385; cv=none; b=c3OBsZKjkvRjGiVPqkemIOtxYcERSPbL7vpfPEW1ZmrNTT6LTjYjD1exKQKk104go2n6TTFJe1ekosD5Lmia7/YRhJ41ISpU6lagrTHmZbFC32sSDypxwpt+c8OGVx6k/2AJkBcJPk/o3GndpZUwgGF0PJqd9oTRcQYqJks7vHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450385; c=relaxed/simple;
	bh=uCI4GGDvp7qQsh+t3zTcdBpJfTY7Ac9JlLHagg5/GCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0tX9nvgXAezT/ggO1Cs4JhlFGRzyxYuemowsYWGhjDuv7/0anXonScBnGiyGNUkTMAS267Sa+Npw2qehCGvcyLE1vKTeZP8YylSL7fCnAyS5XB/9CZESz51NWEoszwFTYaHist4m1YB/QBkqrSR5y8X6CyhN59A4C6AqaWftb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aICp9tk0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7387d4a334so3517134276.2;
        Mon, 05 May 2025 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746450379; x=1747055179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCI4GGDvp7qQsh+t3zTcdBpJfTY7Ac9JlLHagg5/GCo=;
        b=aICp9tk0d1+WU74sNDmIinIhvPaYy8xyDFydglMwF3/2dzoXCTeeOL94GwGmpCsbl+
         qCCYmbGjGJiN/Ek7WjCL8n9bpg2YC7AZtttHT0F5VdDlBuyfUao2As4DxIyw/eWKKZuR
         kPlNIjBX8myaMb3zN/pGyMsPJU93KFkv9klSxJIfAdQToV+ZJojxak/pheyJm/ltLz3O
         WaDQG/dYlIl/2tp+HeRpUelhDIMIu3wTRIP3aEeiPMzKdDjvKoA+3vlQQdPQP3MSe0qr
         zuh+EYc9eV3wOGeg6Uk0WTXMn+TwP6jpQZKA1p5K31/cSNxsYHaghJijNVJ6bsyX4tH0
         xLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450379; x=1747055179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCI4GGDvp7qQsh+t3zTcdBpJfTY7Ac9JlLHagg5/GCo=;
        b=NSQAVzCNsdvb+BLz1hPYRsmOxeqa8KT4hDQ7qwDwVOG5AJTjJki51QpkT50Yr8XoUw
         ndeLXTndmRMJgmtZp28c2ZzZXrByAXVODJHLIpAfO5zq3kEDN8m01NAaPSl4qqQDH5wK
         oVhwD5xxMUwGRLLDTncOn6zHp8JZxgZnLQgKJTbU8cEQOHFDn9v/p68uc/yZrr9A1EfE
         A3f8NGfWBCTlZeN/kpLmMk58IGtsidOFNKJxCBpAxms1dMYmoy+kIVqzkwI+27pm+4DQ
         JeRHDu6EQhTGgtjIQX2fZgReCBDeDI8zWDlcU1Mh5G6hRBLqQEu9V5cb8HmhYYCN93ay
         D+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBxYt2vEzUf/rHa2ly5ja+E9z3W79eO35AMiQwugYZxjEs15dXFM13KmPDfWi3wjE4Ka4UmwkA@vger.kernel.org, AJvYcCXUrd/GntMqnIHRc70o9uvikrMifAA2i4Gz3BxcQ40R17Rgn0QeDLSGujE+UGTFFnE+FDhP9WVmg9+q8d1e@vger.kernel.org, AJvYcCXm+fhImIweqyHdJ+m9XiiFO9jwSsIxarpq0v0VTxoDoi8iZZ0xX9s34hzR67zQPOlE5SjId6BHK76kiTNC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3k/AETVS2y4uNwWXI/r02GfmIbaUA0cz/J/gR2JHvOL4XSrIn
	Ilog2VM/BII7HtOaEsAfmBxi+aYLJSxkXicEAXxDoDhFa+Kl2q0aKPQJ3ZJPnrp3w2D8tHt8WOv
	dOZr2EFeGGyZBVOx4pzziZ6RRPpI=
X-Gm-Gg: ASbGncvoVuq/GnFJw3RjJa5FMoXQrSsax8Sadaod0ln60xvVZ+wFAxbyeZJh3a0SUPR
	ok0F5sBo5mRaQhgO2UBNfJMhT4rpaCcDe6iiM9KQUFh/m7T00nqfhtZ8ep2SgIFAaK7pT1FgHYR
	IIX0yIypjwQJhklDQuoFwhUNXSg7bQATv6V1fhlM1VxM4LeeDnkleN+Gt3HdGcTykY30E=
X-Google-Smtp-Source: AGHT+IFbNjmLRKkZVDdlScvLB7kaE7KsEheUT2D1/I+3bycBJgPVlWfdPba5YFcglsJum201HxNV13wp1i7C9+ziARI=
X-Received: by 2002:a05:6902:70f:b0:e73:1ff1:ca2f with SMTP id
 3f1490d57ef6-e757d364af4mr8076314276.32.1746450379233; Mon, 05 May 2025
 06:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
 <20250505-work-coredump-socket-v3-4-e1832f0e1eae@kernel.org> <CAG48ez2PNFmaMCg9u7febjDgYytxi5eB-261sZBHrfBcTgavfA@mail.gmail.com>
In-Reply-To: <CAG48ez2PNFmaMCg9u7febjDgYytxi5eB-261sZBHrfBcTgavfA@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 5 May 2025 14:06:08 +0100
X-Gm-Features: ATxdqUH5O4VB2y3nNPNvDUJ6q-Z-WjTzq8yNdVfCw-lWfWKhCjD9hQegpSizKdg
Message-ID: <CAMw=ZnSnpXO5Y7Jn1YarJ5Q6QdjDZieRgAR41e=jvDKjOHGyVA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] coredump: add coredump socket
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 at 13:55, Jann Horn <jannh@google.com> wrote:
>
> On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> > The new coredump socket will allow userspace to not have to rely on
> > usermode helpers for processing coredumps and provides a safer way to
> > handle them instead of relying on super privileged coredumping helpers.
> >
> > This will also be significantly more lightweight since no fork()+exec()
> > for the usermodehelper is required for each crashing process. The
> > coredump server in userspace can just keep a worker pool.
>
> I mean, if coredumping is a performance bottleneck, something is
> probably seriously wrong with the system... I don't think we need to
> optimize for execution speed in this area.

It can be a bottleneck because it blocks restarting processes until it
completes, which directly impacts SLAs if the crashed process is
relevant for those purposes, and it often is, we have several use
cases where that's the case. The usermode helper costs hundreds of ms
in latency, so any optimization in that area is very welcome and worth
mentioning IMHO.

