Return-Path: <linux-fsdevel+bounces-37745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186B9F6C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B804616914E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C151FA240;
	Wed, 18 Dec 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgHQOleQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC2153BF7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543470; cv=none; b=OsW9NXA1zLJtcLRviaV8Zrdnnkg+KeZk25Ulp9zAe5O5/kV70mrvvl/IteAUqTMWaPG7KWaeTVYMZZELEykClKrEQcbMfv+2mXVG4ASARf158yC7vS0olDS3uwGjqX6FVk/BvgCctJ0tlWvPNVtQoulYUNLK6H3dsl6Ag7QzxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543470; c=relaxed/simple;
	bh=IIBIqZOnfKr6pM2CvA8Zi/c55QXl1NgxkrLv+CpBYRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHER+XvmzPjW4hmJtFB/0JShNVsFXLaZ/dGjh71esp6W8ObheOTfDdHsNQsJ0JtWUsK0hbWXlJQtqNad/ONHGiQwJEPfBbEdvstQDhQrscZ6QDGCk0CE8q2z4dVgfXkBKWkviu7N5ruE6X0peE3wIHvip2UT8AcvlupNqrZMPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgHQOleQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46783d44db0so69795071cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734543468; x=1735148268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fH7ukBubw8q9Mz+EdgjPyJ9msb32DYRVDX0kJLFFcI=;
        b=SgHQOleQ8XDKF+SXyWSJ1K+a2f1VigbTxvF7rF3X2fcMmdjoWqtth0Z4mflKX8PDt4
         Ex145UGOT16AHLicQB/QPiHUA6Y6OSMZ7RcP5aNtRMb/ajhyNL5FOArYk02/SfkxN+ic
         iGpvdYa0C9XZQXHpdydA/L6je5UwhQp+j/sJeKiOY31WyxZgq5n1OD2IxsXfFV1Z/mXl
         UaSXRMKCQv/Lm3ooaziHZ47bl1P2kUoPernMlmN37bVncnhlaOl2Xd0bpW+R6qKIDjc2
         nOD69Vjzrz/6cI9dqgE6fjUMpV6UyXMtJn0H+bHn1emJ1noijV8CZJ/LzWpnq57qZv2X
         Z35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734543468; x=1735148268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fH7ukBubw8q9Mz+EdgjPyJ9msb32DYRVDX0kJLFFcI=;
        b=SMhcHf+eVX1SlmZbGI1d9LnPhj2sfCdpc2lPMx9zVENn/nnz+fwFhMYnT2Opfx0ix1
         FTAzF6aGlRzk+pK1rrCFdtIA/Lqtq0FyVlz8+p1Mk2DLVbQyxEhTEBAA/FHz2uJ5jGdO
         n6klYlRrMIqN8a/5Tuwmy1hBx7IdGdHJNjuNa//OkxZQEXNIthoVY0JNOzmU+Qr9N+6u
         E32+8OyeA69FF39WSQs8s/oUIRQG0Ti8A+Y8R1pmsJnXjIF32YpdB+7oblK0/hgubeuS
         rvSMqCTYrUJ7Hsd739QWvwWyv/DIYlwN9cXHxAINPpJrMhoUkk8qQEzUNR2u6DhAn5JX
         cATw==
X-Forwarded-Encrypted: i=1; AJvYcCX/jNTCvCqw9UKXwxIMCUgS5l0ZAh+SC4TheUtscVcZLvUpg21Cz/sDxuWeAymmWOYMVdX4z0zNuNMLu5A9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxot8/L5QNcFFLwcMWb9v6AtNccp+lNhSDrXmNZCjRBPkr405H8
	U9x8ipNTJGx05U7bdrk3nXD+DZQLplkon9jmLHbMAoWlSay04EgQX/L7coZV+PeS7sOm/Tn64MM
	YAYXieKlTsjb9N+NIWcQ+K2e5ZjY=
X-Gm-Gg: ASbGnctUnd8I9hlnm4Tu6bXkeIWuSy7XfUQOwOwtbzv8WKszRQPtX/Diu5dZnW99kvo
	5H8opBTBUpy4BZmw6G8gRKX1PbcybocKbCkQYnuY=
X-Google-Smtp-Source: AGHT+IEua5mW1kcPCg8I2bjSWXvBp0ap5K4QMStKmb6Gjgo0XnziiDA6snQ0vsHpcLUOFjdpIIvNmhoTsuqGpn8AsYg=
X-Received: by 2002:ac8:57c1:0:b0:467:6e45:218d with SMTP id
 d75a77b69052e-46908dbf364mr63775501cf.3.1734543467618; Wed, 18 Dec 2024
 09:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <CAJfpegtSif7e=OrREJeVb_azg6+tRpuOPRQNMvQ9jLuXaTtxHw@mail.gmail.com> <qbbwxtqrlxhdkesrruwgfnu3qyzi6b6jhahxhbvn56kpiw5i4v@dhvdhlslbhcc>
In-Reply-To: <qbbwxtqrlxhdkesrruwgfnu3qyzi6b6jhahxhbvn56kpiw5i4v@dhvdhlslbhcc>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Dec 2024 09:37:37 -0800
Message-ID: <CAJnrk1ZHk6BnAWFBhw_rdq1UudgNjBf9r9Eg+VORxuPp48JOPw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] fuse: remove temp page copies in writeback
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 8:47=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> +Andrew
>
> On Fri, Dec 13, 2024 at 12:52:44PM +0100, Miklos Szeredi wrote:
> > On Sat, 23 Nov 2024 at 00:24, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> > >
> > > The purpose of this patchset is to help make writeback-cache write
> > > performance in FUSE filesystems as fast as possible.
> > >
> > > In the current FUSE writeback design (see commit 3be5a52b30aa
> > > ("fuse: support writable mmap"))), a temp page is allocated for every=
 dirty
> > > page to be written back, the contents of the dirty page are copied ov=
er to the
> > > temp page, and the temp page gets handed to the server to write back.=
 This is
> > > done so that writeback may be immediately cleared on the dirty page, =
and this
> > > in turn is done for two reasons:
> > > a) in order to mitigate the following deadlock scenario that may aris=
e if
> > > reclaim waits on writeback on the dirty page to complete (more detail=
s can be
> > > found in this thread [1]):
> > > * single-threaded FUSE server is in the middle of handling a request
> > >   that needs a memory allocation
> > > * memory allocation triggers direct reclaim
> > > * direct reclaim waits on a folio under writeback
> > > * the FUSE server can't write back the folio since it's stuck in
> > >   direct reclaim
> > > b) in order to unblock internal (eg sync, page compaction) waits on w=
riteback
> > > without needing the server to complete writing back to disk, which ma=
y take
> > > an indeterminate amount of time.
> > >
> > > Allocating and copying dirty pages to temp pages is the biggest perfo=
rmance
> > > bottleneck for FUSE writeback. This patchset aims to get rid of the t=
emp page
> > > altogether (which will also allow us to get rid of the internal FUSE =
rb tree
> > > that is needed to keep track of writeback status on the temp pages).
> > > Benchmarks show approximately a 20% improvement in throughput for 4k
> > > block-size writes and a 45% improvement for 1M block-size writes.
> > >
> > > With removing the temp page, writeback state is now only cleared on t=
he dirty
> > > page after the server has written it back to disk. This may take an
> > > indeterminate amount of time. As well, there is also the possibility =
of
> > > malicious or well-intentioned but buggy servers where writeback may i=
n the
> > > worst case scenario, never complete. This means that any
> > > folio_wait_writeback() on a dirty page belonging to a FUSE filesystem=
 needs to
> > > be carefully audited.
> > >
> > > In particular, these are the cases that need to be accounted for:
> > > * potentially deadlocking in reclaim, as mentioned above
> > > * potentially stalling sync(2)
> > > * potentially stalling page migration / compaction
> > >
> > > This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, wh=
ich
> > > filesystems may set on its inode mappings to indicate that writeback
> > > operations may take an indeterminate amount of time to complete. FUSE=
 will set
> > > this flag on its mappings. This patchset adds checks to the critical =
parts of
> > > reclaim, sync, and page migration logic where writeback may be waited=
 on.
> > >
> > > Please note the following:
> > > * For sync(2), waiting on writeback will be skipped for FUSE, but thi=
s has no
> > >   effect on existing behavior. Dirty FUSE pages are already not guara=
nteed to
> > >   be written to disk by the time sync(2) returns (eg writeback is cle=
ared on
> > >   the dirty page but the server may not have written out the temp pag=
e to disk
> > >   yet). If the caller wishes to ensure the data has actually been syn=
ced to
> > >   disk, they should use fsync(2)/fdatasync(2) instead.
> > > * AS_WRITEBACK_INDETERMINATE does not indicate that the folios should=
 never be
> > >   waited on when in writeback. There are some cases where the wait is
> > >   desirable. For example, for the sync_file_range() syscall, it is fi=
ne to
> > >   wait on the writeback since the caller passes in a fd for the opera=
tion.
> >
> > Looks good, thanks.
> >
> > Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> >
> > I think this should go via the mm tree.
>
> Andrew, can you please pick this series up or Joanne can send an updated
> version with all Acks/Review tag collected? Let us know what you prefer.
>

Hi Andrew,

Could you let us know your preference or if there's anything else you
need from us to proceed?


Thanks,
Joanne

> Thanks,
> Shakeel

