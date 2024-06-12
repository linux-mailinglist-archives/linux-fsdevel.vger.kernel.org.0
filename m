Return-Path: <linux-fsdevel+bounces-21507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D57904C23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70471C20F16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140A516C684;
	Wed, 12 Jun 2024 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdMX8FwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2515665D;
	Wed, 12 Jun 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175493; cv=none; b=c7du4lxyhtZMbxFbW8R2A7h1tWNYo1sC0Sut89ytLAJEHgHKWGyU60xHnkld1fV4mYQMuMAcvB3YkO+8oJM37UTifRr2rNK/P/vQckeO5ybiz77OVHUmB+X0Z2tuDZGyME9746LS+ew4lPs68z8XAGQRpbXJ9F5EyYPtfEGC/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175493; c=relaxed/simple;
	bh=p1rkqdX4nFpn8dCZsYXZyvKTd/fDJuHOGVOHqkwMsmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnGWMXrgigUjoNsja+LB7UQHXAvXnq/zdejZs5ClpHtqcwYhm4JOC99tKVNiI5ztikgQx0rJDpx0x8JK9Kf52GuB9BmWVAQUu8EwDYpwnHH0LlJXENAXYzy4DBHAU0tIRRHdx2iLn9CjVY3EveA8jsyBL2EH1eagakUNGD67lls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdMX8FwO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c2ecbc109fso3088007a91.1;
        Tue, 11 Jun 2024 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718175491; x=1718780291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yf54Wa1SE9vp/tJ3cJNQWcthR5DhTfYZVQgtWp1NLZ8=;
        b=TdMX8FwON+kV+LnnozYX0wo8klbSfzyZCrjysLUghnJVr4cSMoXhxA3kEoAeVg5Avy
         eoUJpmqRbm/iLG/HC+1iuQBluLfMBH/aVDjk6i9KOB4zqYNTIX41i/3O+4kGlvk3ypM6
         5HCqSZxmxxwa5W3Wem2kYoDyDWxWkBcYnPD/gV0bCBSznJUmBKjdpDfT8h8Rr0VU1voy
         vBPuvAyM13SSEKtl5WZswCHtiGBKsNjonBb7bIN9FlVxLu/nchBG7ytrltT+mBP7QpBV
         liixU0v0QZasC59xNMrX+W8e0u9HYCwVsLlOB3ev+6cInaOuoM1sSiDd6EANHAvtN/hb
         i1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175491; x=1718780291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf54Wa1SE9vp/tJ3cJNQWcthR5DhTfYZVQgtWp1NLZ8=;
        b=kEJtdEDu8Q0Bk5TL2Wgwah5PX8XL+/raQvNQto2Czr7ywn+et+T255uXqBzsCG+OlG
         AVWrDoCWg/qORmd35uQR4fZqRaSAcCJ2moAnkRaoHf04iY+ckdlUtXWp6CRvd5vv7KJ/
         xi8d5XUp8rfklp96QoI6cl5d/X6Bye08wDNpj/SnPWEgbX/IbBl8nZjrF/1ih7wgASJ/
         R8dPmxRNvZ59pXVuaQC4B48nzqaw0AJdC1fazZEwjS+EUAvpu/b1wf+Sa2dT110iHnHJ
         lB09rNV76WZWV0xwhrZ210C1z4WAtvS1hF+WFxPE0YOtnEA0cqadX89V2BAKkzjaVwlY
         UMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBMtJvAvfnxuCfpLIX3BRZqO3OOekwIqYyUZDZEqfP5rXiiK2636IIkSU9y0dcSmH0/zY+4sw0nMBE1nZXL9ZHgKy79AeURUl7QE/gtWZABsI2ESeYXNJjKfKuk7PrdIBmIO7FnvANkXLj02+xjqvoITZ3MhHsuNk++RZwB4LODQ==
X-Gm-Message-State: AOJu0YxjqFvSyfe6xdoQg9RUEK0r6jma2FQgAisSVUx3QCprPruFtbCY
	BxFJz3UfUrmhut3ezYyUmDrYa/UFUr1Vjqy5+GqXo3F/Kcg8pRnIl3AdkhJI614yGAsPVyfva+w
	FQPCqm+nY8Wx/sKbApTOVtgSnm7ViwEtKC5Q=
X-Google-Smtp-Source: AGHT+IHq6UY650bqkZXEO4Gyq7SUgAT79l/h3ccYb+ytWMAxBcDebAD+GbEVhvRZDVgYp4BMB/TR1C01JO23VwA/DWc=
X-Received: by 2002:a17:90a:8985:b0:2c3:274b:dfb0 with SMTP id
 98e67ed59e1d1-2c4a7629f13mr949448a91.17.1718175491330; Tue, 11 Jun 2024
 23:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611110058.3444968-1-andrii@kernel.org> <20240611115950.35197b36eafe0a804ecaa0de@linux-foundation.org>
In-Reply-To: <20240611115950.35197b36eafe0a804ecaa0de@linux-foundation.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Jun 2024 07:57:59 +0100
Message-ID: <CAEf4BzZKYTnj-=PBSQ_74-o4rzKx2_VO4PRLwyq4szCcZvoGbQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:59=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> (Please cc Alexey on procfs changes)

ack, will do

>
> On Tue, 11 Jun 2024 04:00:48 -0700 Andrii Nakryiko <andrii@kernel.org> wr=
ote:
>
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to al=
low
> > applications to query VMA information more efficiently than reading *al=
l* VMAs
> > nonselectively through text-based interface of /proc/<pid>/maps file.
>
> Looks nice but I'll await further reviewer input.
>

Thanks! I'll work on adding more tests meanwhile.

> >
> > ...
> >
> >  Documentation/filesystems/proc.rst          |   9 +
> >  fs/proc/task_mmu.c                          | 366 +++++++++++--
> >  include/uapi/linux/fs.h                     | 156 +++++-
> >  tools/include/uapi/linux/fs.h               | 550 ++++++++++++++++++++
> >  tools/testing/selftests/bpf/.gitignore      |   1 +
> >  tools/testing/selftests/bpf/Makefile        |   2 +-
> >  tools/testing/selftests/bpf/procfs_query.c  | 386 ++++++++++++++
> >  tools/testing/selftests/bpf/test_progs.c    |   3 +
> >  tools/testing/selftests/bpf/test_progs.h    |   2 +
> >  tools/testing/selftests/bpf/trace_helpers.c | 104 +++-
> >  10 files changed, 1508 insertions(+), 71 deletions(-)
> >  create mode 100644 tools/include/uapi/linux/fs.h
> >  create mode 100644 tools/testing/selftests/bpf/procfs_query.c
>
> Should the selftests be under bpf/?  This is a procfs feature which
> could be used by many things apart from bpf and it really isn't a bpf
> thing at all.  Wouldn't tools/testing/selftests/proc/ be a more
> appropriate place?
>

Yep, agreed. I used BPF selftests as a quick and simple way to
validate it's working end-to-end (because we use /proc/<pid>/maps
across a bunch of pre-existing BPF selftests, so that gave me good
coverage and signal). I'll look into adding more tests under
selftests/proc for the next revision.

As for the procfs_query.c, it's not really a test, rather a custom
testing/benchmarking tool convenient for development, so I think I'll
drop it from the patch set for the next revision (and maybe will put
it up in a separate repo on Github or something).

