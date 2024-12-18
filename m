Return-Path: <linux-fsdevel+bounces-37747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663639F6CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DF51886F74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0491F8925;
	Wed, 18 Dec 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg1U+V7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E21369B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544411; cv=none; b=t4RGg3d6L1FNpGvPcwnn1npIx/u42NB+pEcRAYtQoFDEWJ8fZqRF+H+dlrtRUTUdaHaL8QKXBTKOLyYYqs+Ku3DcN5O/MP7raWJ9kHbS0wf+P0p9haJVNVfxnnpJQQ2V+gEtldDO13I9Wiqu4dcaKCE5IDec3Lzka84hNRIqTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544411; c=relaxed/simple;
	bh=MGraplZ2UBeer4dXTzffBgNP7dLrDRxSBQjw+PzL+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks2LukuFu6Xj8hBpHoqdBJStIDa13z+5AZmtRO/XDAuCiHtk/GDuiGMIjmSWhDIov210QEKqTCj96J/m8eHb20rkNmLPg8FT+LbqbeU1CMVbsA7BM1DgrS0vqO9UloetXe2o+/1lqKUGz7U9E5g1eGXvadF1hN1jInfG3ofKRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg1U+V7h; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a6781bc8so40913041cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734544409; x=1735149209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGraplZ2UBeer4dXTzffBgNP7dLrDRxSBQjw+PzL+8g=;
        b=Hg1U+V7h3u7nFX4XCmfDOcN8msTnjV8pmNfCXVyrToHtAq/OH4r/33YVAeEI5050PF
         R+up7htTflesrO5sDgj+Jz2bvSpxLMa2Y++C4ylSoM2MAD6l/ElsddRQ6fFaE3Zj92ZN
         5XW7H04CgUc4ykMBDLE6bO0FxWfoMI1xc0hBozbxwkAKOTqFi5OJY2W5gpccs2Xju20U
         opqIPPCuB4V/eGdwoaqFAy51P2UolEuLBaB/aBGpDrn3RWltSHZmnZN0dnOzAM7cdnzc
         MUbir/HcsAmijFsjHeQId/b54tHZyy1vuD0+LJCuofIvaeg/GDPLG0xiCxr7YUD8cVik
         QmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544409; x=1735149209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGraplZ2UBeer4dXTzffBgNP7dLrDRxSBQjw+PzL+8g=;
        b=IBDSiJjEudrArBrKJtDi5jJ+2xmhrJPFAC7cUdLYlDkFMeREnGCiIeHQkqlKLMYVzZ
         TBYzqwuf69PqD/rzGy2hE3+1uoabG9S9RmLvQmBjsil9wHMA11C731VbwrRRMwtLtxNn
         qUeA+GQdvo4pQzAlSWoxr3uvYl7UXVxUm5Mo9VQFXGolmeYRGsVFKFGaoaiazl0iGv7Z
         I/EaM6DaV8R2twU1RAIfHt6GX9Dqvhzu/AOtRJ+B/Oux9ssXXvcGqeAHOyjJrCya3TcX
         EPx02ykNS01GdJCpingff65pQ6qlRAjXTtAWo2URTQUZgiftzLjCBaZHOhN9VOIBM538
         olgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd70PI6mEV3H+LbfKREWPatOZPmsAbsUtsgTu8ljBtYQ6mv4pRSyCNJYgH8BfHcOk3pv5E39wmahqsYAxY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpt46r1enAtSbcS7LiXwlFdtMnkEsxkwZJ7k/Xkgvp/mcFqQQh
	fmfz+l0qYUHuvgGhbVGD5Zj3ECT2vIjALpDt96GhBYwhn5Gx27438K8Wi1TjLIUTD/rOWAS0Q21
	u20b8oBd91trgJwZKT/apgG8df5Q=
X-Gm-Gg: ASbGncuD9rZbnApQHgTelugtvMMIg0LoEhyW0EJ6YtVkvKnXwAumLcjLAi8Nrx69Oj7
	bFc7qYhY6SluVTHGlpLTW2CjUPz9w8DzRjr+qMiM=
X-Google-Smtp-Source: AGHT+IEApLPrAxzKwzG/jYALDVI4GICUhWwGw1WGW8x2kzQHxMX7npKY5EItCSkg71Ibeb+KzuFVDfXFfZMj1XWk2fk=
X-Received: by 2002:ac8:5842:0:b0:467:64ef:9da6 with SMTP id
 d75a77b69052e-46a3a719e79mr6592631cf.10.1734544408923; Wed, 18 Dec 2024
 09:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <CAJfpegtSif7e=OrREJeVb_azg6+tRpuOPRQNMvQ9jLuXaTtxHw@mail.gmail.com>
 <qbbwxtqrlxhdkesrruwgfnu3qyzi6b6jhahxhbvn56kpiw5i4v@dhvdhlslbhcc>
 <CAJnrk1ZHk6BnAWFBhw_rdq1UudgNjBf9r9Eg+VORxuPp48JOPw@mail.gmail.com> <p6ripet3dm6jsmskpy5zgbn66vywug6cwkbdhbbkc6lr2wo72a@5xctmai4jtmh>
In-Reply-To: <p6ripet3dm6jsmskpy5zgbn66vywug6cwkbdhbbkc6lr2wo72a@5xctmai4jtmh>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Dec 2024 09:53:18 -0800
Message-ID: <CAJnrk1bXDkwExR=ztnidX4DAvVD5wZZemEVNt9bg=tkwWAg6fw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] fuse: remove temp page copies in writeback
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 9:44=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Dec 18, 2024 at 09:37:37AM -0800, Joanne Koong wrote:
> [...]
> >
> > Hi Andrew,
> >
> > Could you let us know your preference or if there's anything else you
> > need from us to proceed?
> >
>
> Andrew has already picked the series into mm-tree (mm-unstable).
>

Great, thanks.

