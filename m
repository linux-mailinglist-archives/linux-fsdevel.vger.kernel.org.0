Return-Path: <linux-fsdevel+bounces-7927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525382D54C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E475C281556
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F499C8C2;
	Mon, 15 Jan 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QSVn3Jb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22CC2CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a27733ae1dfso969016466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705308523; x=1705913323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBYM6AIScy780I0Nf7J4q+djX9TPxGd6ZoUUlgNFgb4=;
        b=QSVn3Jb4FFMB3H2EPkxXegiltNdAnesPkyYAxbo5OHyj3BdX9ZAa89//Mz0f6B4HZB
         HhbNe3kXOiNvWW5GBuliYF4q5vRZ7wfkR2B3f+TX+YMqBQ+x189shof2qRgGK7i41kBz
         pw/5JCsORhv/Tc5FVj6WAtwXfRPQJAfwIkTM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308523; x=1705913323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBYM6AIScy780I0Nf7J4q+djX9TPxGd6ZoUUlgNFgb4=;
        b=AJ5wP3wvnpI0KNKDHwFyDwUFscsgV7hPM2P7rKZv4A/CgjDjiCDEVKbashrRYK5nty
         J6Vl79aAuYrDavX0AdL7aV8ruOs0vTczFQaOJhRLZeoZnLaLOZHzP/ZAsT9UtFly+NIp
         KN0hIw+frjN9ki6o7/dev6a//353teVeH3x7d+b1J9f7Qh0AvLrzWWx4QOOvewLIkFO7
         gKa9BYRqfs1S3kliptNjkpriWBeTeYiWDSCSH/d5dAlAsLE3Hl665uSSYjM7c7Sl5ZP2
         TuuWLsoL0Wu5sJYviJzoUkCH7gMV1qyES3002N+o6nyVO6jD91oj+tyndwZ+V/5ySl8P
         whkg==
X-Gm-Message-State: AOJu0Yz0NZxDQy9Bs1KIqjkXj4maI4xs6y0kit34+wNUWfKuH+fYwtAu
	SSg6wbtNfmnLK2TvDMDY4fXlMHLhk6OoQE+WrrS43Uc4Oxt5pP2XKAQSRw8K
X-Google-Smtp-Source: AGHT+IFlPbkEF2Z2DTsbrTI6TPDA2bKrs0EuVItDGIbaSOoGG2Q8ywJs80nt0yfAjZLismH9B+PtAS7BQ22LuglaIeE=
X-Received: by 2002:a17:906:bf41:b0:a2d:2121:2a93 with SMTP id
 ps1-20020a170906bf4100b00a2d21212a93mr1051270ejb.70.1705308523018; Mon, 15
 Jan 2024 00:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228123528.705-1-lege.wang@jaguarmicro.com> <SI2PR06MB53852C772180B28FE8AD7182FF9EA@SI2PR06MB5385.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB53852C772180B28FE8AD7182FF9EA@SI2PR06MB5385.apcprd06.prod.outlook.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Jan 2024 09:48:31 +0100
Message-ID: <CAJfpeguVpKAJKJ04mnbGAr-7grnO=JDxGSfBPXZHt0J4WnTc3A@mail.gmail.com>
Subject: Re: [RFC] fuse: use page cache pages for writeback io when virtio_fs
 is in use
To: Lege Wang <lege.wang@jaguarmicro.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, "shawn.shao" <shawn.shao@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Dec 2023 at 14:06, Lege Wang <lege.wang@jaguarmicro.com> wrote:
>
> hi,
>
> This patch just shows the idea, to see if I'm in the right direction =F0=
=9F=98=8A
> And a quick prototype shows the performance improvement.
> If there're no obvious concerns, I'll try to make a formal patch and
> run the fstests
>

I see no issues with introducing simplified writeback for virtiofs.

On the implementation side, I'd rather see a new set of aops to make
the code less tangled.   I also feel that the time has come to split
fs/fuse/file.c up somewhat.  I'll leave it to you whether you want to
do that or not.

Thanks,
Miklos

