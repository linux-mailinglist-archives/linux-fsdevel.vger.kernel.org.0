Return-Path: <linux-fsdevel+bounces-53741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5BAF65B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450261BC48C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAF24EAAA;
	Wed,  2 Jul 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y47i09IZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21592DE710;
	Wed,  2 Jul 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497045; cv=none; b=enzGUcKIh4fvWAOFYGPDrKskITCI3h69DIg069/cUxFlR/5CgV6eC2czusdQPS1N0xG3HPUFG0dTIUoB9TnDh6Yq2irfkxUrAa7jWGd3gp0J1Ov/V+ylb3YEZU3uLonPoPh91AzTy5zyhZHUT9zZfeTgszZv0jl7uHk6Zoovj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497045; c=relaxed/simple;
	bh=8EW0hGGxBNPaepJB/kat+o+7PivqzOmIdnFN/RapTEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfP4E/p12yiZmKk2+exAAsF8bHjID6xv/NDe9qcxesZWmqaJ72sFnmmVi9F8GS6iApVLuXavt2rabACqVEVGoplPdepk3hRe1SK48WFsx+FvXp3+5FnKxLtaUjKl/fHYbYNPN/d9oYH7QfrcZjAWEdoXYj9/DpnFfuWKS8ItytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y47i09IZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a5840ec53dso89973261cf.0;
        Wed, 02 Jul 2025 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497043; x=1752101843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+sj4DzOPih53SQUVn5/WouvC+G14JrQj6it97lI9Kg=;
        b=Y47i09IZk5Et4ftvV1FxOZmTsZ4EWF/yIKUxArsHWI8s9/7v3cPW2VHOxJIUZNZydx
         HybZ9We+llzhu6swD1Wk6yf6WDOEVdPUMjKSdvTI7UTHkb5N4QPSqDCZFR5TDDIVrcob
         IF6N6da3AsvPLkSJpTNsCSznssP2bMKAS9FOAXPnh2P4HSsdD6helG1QFPXWbNBzTSs4
         /XTjZYec4Ip3phcorCNliRRSSKyZubVJTQc/NzvU8GhzrsLMzexaJYAT9caD1NGzzQx7
         wKA8+oivWFUKAY4wj/Q8E2hS8QVleUxoJ91ptjblZeQaQu3n3+wp2aWQYNMAk63XWz9H
         TPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497043; x=1752101843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+sj4DzOPih53SQUVn5/WouvC+G14JrQj6it97lI9Kg=;
        b=da9yHRZ16laDkJkaxmizfbcVNlKIs0Uog6HbrLYMXrOa8iq5H+FLmOlWq2Q99RdHaK
         ZPA6JerCgP7j5I09fYJL/fmWFs90zKLNmxL07i8UBXMOKI5N//Sj9PTYhIPH0rZM6H5g
         tKG7cDGIUhALFpSS48cs43wwwAdL8DX0xM3JpLxUW4tmIDQWQDiQi6cIjghOGiit2FIq
         AS3MkNVO7GynAvqKZh5eqjs3TFdmxZQi9KVc+hf8FkplQuNxvu2607XTkyox6mFuL/yC
         H6YomETs+F1LZYOAw7I/0J5cVhDNv6M8Izu3+/r5YSyihfAOWUs/5562efQAMsuJxuq2
         ZPIw==
X-Forwarded-Encrypted: i=1; AJvYcCU+XLmNaCzygWE0qQ3mpN+OP6YFD2m/dgZJ1YuDVNjhZMKn/MSa1UPTPpvuVAaDGA1EvBD2A7Y5QM7v@vger.kernel.org, AJvYcCUr3nPNIPEcNAZ+tO9tBmR3MX9WI6NqJaG3L+LUAU7S1fxJUS92gI1FMQXwRQbGjBCvMx13AFZO69kSVg==@vger.kernel.org, AJvYcCXuVWmhuvWHED6uDRXwiP4HY7Mt36HfavKqa3sWv7ITrWRw21t2qSDl2QbHdKzG5SVDtTMzmDrDNWRI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtk5rNqDDAFC+QCrKsrESUv6MDF9H3yLtvVhpMnayhMylW+vDv
	aM01pxSFQysowEkB2hA+JdB5bJ6bhLKGzwQTT10MIpU3mptopJuUCdw3INU0FTtrU0Oze/aJp7A
	bpVfJV2O+7Ei8iObCTHSoyw904dLr3+k=
X-Gm-Gg: ASbGncvrEzdPb8KL7crHyAS8Swy5R1btdo+HHJZ43ghJY0umYV32mlWjW1IUzKB+ZIH
	vXVtWxoArXxqMpRo1tYTxjCRIeZjQ/Xd0aAwWspWpB+ttni541cAUYKLox9rEGX5fh2UBebWqAq
	FmDlKbhqZUPF1XarnxQlbD5Xk7ue/Bv1QaMGNQ5TaeSdxXBwI2f2TfbNl9UZo=
X-Google-Smtp-Source: AGHT+IGh+uw6/WknPh/VOBOhELlnb2ckIXgQMw+Dl8Agj8uw+6O+8N23tvom7rsshXm0+/bXl2b6LhX8aRmfe9JENnM=
X-Received: by 2002:a05:622a:1343:b0:494:9455:5731 with SMTP id
 d75a77b69052e-4a9768dc925mr69623251cf.7.1751497042623; Wed, 02 Jul 2025
 15:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-13-joannelkoong@gmail.com> <20250702175509.GF10009@frogsfrogsfrogs>
 <20250702175743.GG10009@frogsfrogsfrogs>
In-Reply-To: <20250702175743.GG10009@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 15:57:10 -0700
X-Gm-Features: Ac12FXz7lG-Jak0UpEVy1wDinr93eTqUtI8IoSMS4xFeGJDW7InC6JSRScIU8tA
Message-ID: <CAJnrk1ZhFropUE-qoXcfa4VB740quF7nkQ3cs+NNbwPTFgpLsw@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] fuse: use iomap for buffered writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu, 
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:57=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jul 02, 2025 at 10:55:09AM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 23, 2025 at 07:21:31PM -0700, Joanne Koong wrote:
> > > Have buffered writes go through iomap. This has two advantages:
> > > * granular large folio synchronous reads
> > > * granular large folio dirty tracking
> > >
> > > If for example there is a 1 MB large folio and a write issued at pos =
1
> > > to pos 1 MB - 2, only the head and tail pages will need to be read in
> > > and marked uptodate instead of the entire folio needing to be read in=
.
> > > Non-relevant trailing pages are also skipped (eg if for a 1 MB large
> > > folio a write is issued at pos 1 to 4099, only the first two pages ar=
e
> > > read in and the ones after that are skipped).
> > >
> > > iomap also has granular dirty tracking. This is useful in that when i=
t
> > > comes to writeback time, only the dirty portions of the large folio w=
ill
> > > be written instead of having to write out the entire folio. For examp=
le
> > > if there is a 1 MB large folio and only 2 bytes in it are dirty, only
> > > the page for those dirty bytes get written out. Please note that
> > > granular writeback is only done once fuse also uses iomap in writebac=
k
> > > (separate commit).
> > >
> > > .release_folio needs to be set to iomap_release_folio so that any
> > > allocated iomap ifs structs get freed.
> >
> > What happens in the !iomap case, which can still happen for
> > !writeback_cache filesystems?  I don't think you can call
> > iomap_release_folio, because iomap doesn't own folio->private in that
> > case.

AFAICS, there's otherwise no private data attached to the folio for
fuse for the non-writeback paths, so I don't think this is an issue.
ifs_free() would be a no-op.

>
> ...and I think the answer to that is that the !writeback_cache case
> passes all file IO directly to the fuse server and never touches the
> page cache at all?

There's two !writeback_cache cases, direct io and writethrough.
For writethrough, the file IO gets passed to the fuse server and it
also gets written to the page cache.

>
> --D
>

