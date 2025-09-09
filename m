Return-Path: <linux-fsdevel+bounces-60682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDCB500FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3F1886ED5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F2352075;
	Tue,  9 Sep 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvcehZ0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DE2BB17;
	Tue,  9 Sep 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431481; cv=none; b=MgTWwr5mAdN9L78hung4beu4GmK0P/QvE0v0XGMs9e+/t3bmpOEKcjOOaE3VlYBtOyuBNKNLVtNYL9A9P515fnHAN67AgChtCBuz8oxwBl1gLyPyZEVFq3w3zWf8Cjukb+Hl+VWigyUXDcxKB69APErhWAnYjoSY2usInKKqToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431481; c=relaxed/simple;
	bh=3R0m6L3Xc0jpTLVgVCR9emnQCAji/4frJjenqqSAQLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ItOpzB1UdDfOjePDlJdaALf9K8SdMDtCNVydvfFCctvrj/LtaExoy2XiMDVLj0UKTMQAIGz7D7cnCU2py/P/gKXRFcHgoy7MGU3p1UZ2JHwJlQ6grnhcJbVMpZbb0RtEh1/LSOhpLBqpjELdcGG3eV0h41F4lD8DGHJ3a9HSw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvcehZ0z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b61161c32eso24845491cf.3;
        Tue, 09 Sep 2025 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757431479; x=1758036279; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDbmDBECNsOMyPFBVxB/4/c6RAXu7g94A+5MaF46ZQw=;
        b=CvcehZ0zhYLfn1KqL6gzPBpXgFNx3aOpbCFQ/5d61ERAwyGioTgFmv38hUGXQ0ssEe
         oZ87K6lmeNJYp6BDj01LHF1EQk9c8aAwcY2TdRvKga66arhvpNWXbxHJhlaKbCvCC+5g
         DdKgwk9XSTVEf+MjWv2UqH8kh0PtpmR4ZREVrgKk3JQhAUPkGEK0ezyIzebtJsBc34NI
         4+G8CR77oFi0mcteGq6nW8g5n6nLAN3HNA0r+zQPMxahQihml/8D1kVmKzPiVxHjzpOK
         ED0GscbwdCJRkSDhethxK+KINrypoTL/QPoV7r0UsUFqlcq2YlnIcCNeLZwtBSnfy3yv
         VAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431479; x=1758036279;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDbmDBECNsOMyPFBVxB/4/c6RAXu7g94A+5MaF46ZQw=;
        b=X9pA2y3PpjRFVtWvdxlLTFWzq1akiLkzXNHE/JUgbxylGpnE2ddgzhqMt/bz0qejMc
         SaGG3HaxnoHhEawjEii/khhsIPifioCV44MNRGA/zZtbULSisrQILHYjSElrKYAYLNRu
         CxXzBYpdek8lvgJTgwyLcGXh8fvvK6bRmiVQiNVTTo4IzQIjyF7vTphCdUvlBB3GW2UB
         s/dMuuv/nSnGGN4//t16XlqNwxHs4BNHDO0REYsCadDdbpBl8fFyh1+uZKqnW7/HINVe
         Df/A/r1TLXrmmBH6OXDWAk7qrSaaBpT6nTfqvs/vBWY4YhYxiBo+CJKrebdpME2IuyEu
         1+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUMgEK8TPQi8ryMQtFlH2r+DUc91iZS+xjtF+JsS0ec+TKPmlxgKHmWAEoZ8LSB+UEHGaGtw0Rwwjh45jvd7Q==@vger.kernel.org, AJvYcCVf30DcDJzvnbHoPHR8ahS88A7Hai3X0LyH0rxfd34yRuv8mlvTYvYcdqEZxkHCLRQPSaBnVOD3wIgd@vger.kernel.org, AJvYcCWnWqVMFXEFX2lIC+EBrO/AcPLbhXJfFPcRIjbFkasAXMvRyn+eVd6Hba/WOLQ24XawbbDdm/4r+iPOxQ==@vger.kernel.org, AJvYcCXnrN2C0sb9fWdWwG7RMA48/HIfx6pEd6dRevH2/JvjPwm+9XZ8FJ7ulFmrhmAMMRYWOgpsSmXYtQcP@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPOnSY/g0s8YWpD9UtSGDNnLTW+M+dnd9k/YWY+RT85aoo+ct
	xJc0xCrOY+/G7UJRs9qdQQ/vZizzBhYyQZaQohjddKFsFin3SLgkU+SK/HTEtq1PjCQGgThyDvk
	m2Nhi9H0Vxw5QtjAEOguglZnkAQnbvdZbddgag2s=
X-Gm-Gg: ASbGnctLGvRve1EgG6oW0aV6Fthb0ksQWghJO8P6dkmu8WjvV7EGuoavycfNXjNx/Bj
	+0pO2ECOm07Kc7+fvb5KIJtFLnf2HvYbzQ8dwnhGYo3WftXKpyeBkYU5dWH9NxCfcfQD3RtMrjp
	yiyqKL8pyB/TSLAt+J32pOl5IKRsV0uJtF4hGS8dSa/qwep7YQxaT4EGaNQfBHVG3tDbnoRb2JR
	A+G6n22yACcV7v/A2Mv9YQ=
X-Google-Smtp-Source: AGHT+IE6h/blzNtkiS7tRQSAW4vjy70N2RtjiCed7Thx/n7bpwfptLXKBBHGKN92aIlVAliSIdhlvRW+askAAL9wkJo=
X-Received: by 2002:ac8:5dd1:0:b0:4b5:f421:14dd with SMTP id
 d75a77b69052e-4b5f836b29cmr131506101cf.7.1757431478686; Tue, 09 Sep 2025
 08:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com> <aL9xb5Jw8tvIRMcQ@debian>
In-Reply-To: <aL9xb5Jw8tvIRMcQ@debian>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Sep 2025 11:24:25 -0400
X-Gm-Features: Ac12FXyx8pmrJDFeGMYZs3RCR1CTlhpwdwdT0peJF0IyLF-S26qPwC0nNO2DnTs
Message-ID: <CAJnrk1YPpNs811dwWo+ts1xwFi-57OgWvSO4_8WLL_3fJgzrFw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
To: Joanne Koong <joannelkoong@gmail.com>, djwong@kernel.org, hch@infradead.org, 
	brauner@kernel.org, miklos@szeredi.hu, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:14=E2=80=AFPM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Joanne,
>
> On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> > Add caller-provided callbacks for read and readahead so that it can be
> > used generically, especially by filesystems that are not block-based.
> >
> > In particular, this:
> > * Modifies the read and readahead interface to take in a
> >   struct iomap_read_folio_ctx that is publicly defined as:
> >
> >   struct iomap_read_folio_ctx {
> >       const struct iomap_read_ops *ops;
> >       struct folio *cur_folio;
> >       struct readahead_control *rac;
> >       void *private;
> >   };
> >
> >   where struct iomap_read_ops is defined as:
> >
> >   struct iomap_read_ops {
> >       int (*read_folio_range)(const struct iomap_iter *iter,
> >                              struct iomap_read_folio_ctx *ctx,
> >                              loff_t pos, size_t len);
> >       int (*read_submit)(struct iomap_read_folio_ctx *ctx);
> >   };
> >
>
> No, I don't think `struct iomap_read_folio_ctx` has another
> `.private` makes any sense, because:
>
>  - `struct iomap_iter *iter` already has `.private` and I think
>    it's mainly used for per-request usage; and your new
>    `.read_folio_range` already passes
>     `const struct iomap_iter *iter` which has `.private`
>    I don't think some read-specific `.private` is useful in any
>    case, also below.
>
>  - `struct iomap_read_folio_ctx` cannot be accessed by previous
>    .iomap_{begin,end} helpers, which means `struct iomap_read_ops`
>    is only useful for FUSE read iter/submit logic.
>
> Also after my change, the prototype will be:
>
> int iomap_read_folio(const struct iomap_ops *ops,
>                      struct iomap_read_folio_ctx *ctx, void *private2);
> void iomap_readahead(const struct iomap_ops *ops,
>                      struct iomap_read_folio_ctx *ctx, void *private2);
>
> Is it pretty weird due to `.iomap_{begin,end}` in principle can
> only use `struct iomap_iter *` but have no way to access
> ` struct iomap_read_folio_ctx` to get more enough content for
> read requests.

Hi Gao,

imo I don't think it makes sense to, if I'm understanding what you're
proposing correctly, have one shared data pointer between iomap
read/readahead and the iomap_{begin,end} helpers because

a) I don't think it's guaranteed that the data needed by
read/readahead and iomap_{begin,end} is the same.  I guess we could
combine the data each needs altogether into one struct, but it seems
simpler and cleaner to me to just have the two be separate.

b) I'm not sure about the erofs use case, but at least for what I'm
seeing for fuse and the block-based filesystems currently using iomap,
the data needed by iomap read/readahead (eg bios, the fuse
fuse_fill_read_data) is irrelevant for iomap_{begin/end} and it seems
unclean to expose that extraneous info. (btw I don't think it's true
that iomap_iter is mainly used for per-request usage - for readahead
for example, iomap_{begin,end} is called before and after we service
the entire readahead, not called per request, whereas
.read_folio_range() is called per request).

c) imo iomap_{begin,end} is meant to be a more generic interface and I
don't think it makes sense to tie read-specific data to it. For
example, some filesystems (eg gfs2) use the same iomap_ops across
different file operations (eg buffered writes, direct io, reads, bmap,
etc).


Thanks,
Joanne

>
> Thanks,
> Gao Xiang

