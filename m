Return-Path: <linux-fsdevel+bounces-60304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B66B448C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8146A00EA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A02C21CB;
	Thu,  4 Sep 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyqIhBBz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8F2C3272;
	Thu,  4 Sep 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022262; cv=none; b=XeumRAfiG+vSOXIjIK//DPmlO+qs4JyhP9zrfgXYwVe+u7APMyCvYErYHS+uOHOKyH6LARA7AQT4YPB93HaRvRFeiwxyWLaV48gdYsL8Igknzluo4BXjbn9ShLZ+RKozlnCW/HgJhjd34cIHIIwnkSbtOsxMQ6YotUj+vjh51YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022262; c=relaxed/simple;
	bh=VtBZqDnqzRyEXInZIX0W9OMjUr1uNLiNsrfUI3TbKZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Erwiqr3XufWZ75mhsb4JvyTfBIsBQprrvk3oVJ9rzpmm9Jjem10uk1c/hnDj8dseJCahR39Dy1sLDhmk0jOms+voMt9dFvtyABXdBiRYSGbGYzkuT62tDl5pu7gBSDD3HGnPyaLDE8BTWHF52G2d6TKTMtYN0RUaCMvRYglLlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyqIhBBz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b34066b52eso16873181cf.0;
        Thu, 04 Sep 2025 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757022260; x=1757627060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Aq+FCth5X33OctbBduq8oWXb7JMDm1ZB0ToBXGmXqo=;
        b=TyqIhBBzHqehrNDnEElpq1K54fKJ70hEhFDWsdceE7kdwi9TCs6SjkBOytSjP/hy3R
         +/TLdCFMMILiwKlcNa6pu7/OqyrZnTahXKBsBfN/HgB2jvnBXIgk2/CSwqtsMv32ulku
         X4C7TqKsbEsRQJl9d+KQfRQGSwGGXHYJi1mCIvM83LHGJP54XPV3yjRvsqQmmqNDmo5X
         TVLYigVGaS2H73k9HQyfUbw4xpXtqXxCYCnkyUBsoi6szyzMUzj8ypq0RTG+dK78OhMN
         LSWBGp+LFTApoBbbZd7VYfq3HWWxSWKr6ef4Aaie4FWDmjW+DjKVZ/68KleNUouYbHbX
         0+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757022260; x=1757627060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Aq+FCth5X33OctbBduq8oWXb7JMDm1ZB0ToBXGmXqo=;
        b=JFq7c3TdvUNpdfF61l6Yy+D6TdhBO2oA/BVZfeNGPKoN0qyFmVMB9vL4jFVivTMLz7
         vzI4CAzJZZ9YN4JpHcxd8FJkeyVk3LjHeRoyLY32R3CjhUP2EHJ7DjSM28LSwBgtTXMY
         GNHFdeIlvoKPCXokQUhfABRUsukZqqBQNhiCIM/y3s8/YP9cgMi8bNvkrMPa4XHogOYb
         MyWKDZxfBqikYB8y1oUuv2+0RzHOxpHZ5ZUi1XEZcBz0cc98QRt/wsKN88RYtj0jl+AX
         uekzDxqBtM85KmZaro6wH01wwvWTfjEqTif+/AW98EkiCHVMZpL4HGTtotE3tpnYN7KA
         xrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYsg+1Mt+eWYZ7IZMkdMkOjEZicwohDsWmVuKS7fvniU2Rfl0li07cJ6pFMOI2ew7l34COokll02A=@vger.kernel.org, AJvYcCVXfSS5Dt+EWpZTLeqh2QJOwcW5r0W4tdZYq3pGczgF2hUXFanjwE17zPuEZuRgrfc87ErDJOum/cmX@vger.kernel.org, AJvYcCWVcpHdh72nGVhxKoK0tM5fp7qisohxRfIoWprM/RE25FI2JbM2J56LjChmWGGDpHG5zqVq3nXZFQFR4aNkBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxawRIsiOle9QiUHw2KRUt02dVU8V/s7VXIJzozvaFnF1u8ZJjr
	z6hxKemc1riIj5jW1pWlT5ADDcMfwNjmtExURywIYg0/uMucZHb8Q1jZgOegiclA9A7oanTZK9t
	y9NveT5xcOqdtrii0vZbsncDsp+Ex5Hd4EPMC
X-Gm-Gg: ASbGnctn6MZ44bCPylpn/kXYNO2H3Gvbnm7KMvn11OFBdykXdZoN8Y+jBOsPvaCzNND
	GNuBqsQXAlOhJcbPeysMKXs9BKxj3TpH75C4sBkpRgsdk2THgfzdGiTWCgtsyfUP6CXAIRuuU8E
	aHU6uuJq1XVFUAdL7xKtaoSFtD5EPP+9GhSxzrp1WOzLGmD1ZyIdOpJuusIZKp33uXVOXOXyaWj
	vrW7zg/
X-Google-Smtp-Source: AGHT+IESOH+/gV89VbLDBJSmKKqP2tlJG71ot1JexhlyiP2R8bMDQXsq+or5DmkINHJPn5sMZROFmKQyKcSC7ZXnzdI=
X-Received: by 2002:a05:622a:40e:b0:4b5:d932:15d2 with SMTP id
 d75a77b69052e-4b5d9323589mr46900421cf.23.1757022260119; Thu, 04 Sep 2025
 14:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-2-joannelkoong@gmail.com> <20250903201659.GK1587915@frogsfrogsfrogs>
 <aLkrB7CcPsaEkaA-@infradead.org>
In-Reply-To: <aLkrB7CcPsaEkaA-@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 14:44:09 -0700
X-Gm-Features: Ac12FXyJXe7KuCGyUuJZoluxWmDaiI4V6ycAPDLKi4m3rXlYV_s9UdlVjip7VmA
Message-ID: <CAJnrk1a0f4L0etiR6D3ToMtKy6y7Vc+=ok1=3wtug2XvY2FUKg@mail.gmail.com>
Subject: Re: [PATCH v1 01/16] iomap: move async bio read logic into helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:00=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Sep 03, 2025 at 01:16:59PM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 29, 2025 at 04:56:12PM -0700, Joanne Koong wrote:
> > > Move the iomap_readpage_iter() async bio read logic into a separate
> > > helper function. This is needed to make iomap read/readahead more
> > > generically usable, especially for filesystems that do not require
> > > CONFIG_BLOCK.
> > >
> > > Rename iomap_read_folio_range() to iomap_read_folio_range_sync() to
> > > diferentiate between the synchronous and asynchronous bio folio read
> > > calls.
> >
> > Hrmm.  Readahead is asynchronous, whereas reading in data as part of an
> > unaligned write to a file must be synchronous.  How about naming it
> > iomap_readahead_folio_range() ?
> >
> > Oh wait, iomap_read_folio also calls iomap_readpage_iter, which uses th=
e
> > readahead paths to fill out a folio, but then waits for the folio lock
> > to drop, which effectively makes it ... a synchronous user of
> > asynchronous code.
> >
> > Bleh, naming is hard.  Though the code splitting seems fine...
>
> Maybe we can look at it from a different angle - the code split out
> isn't really about async vs sync, but about actually using a bio
> to read data from a block device.  Which is also kinda important
> for what Joanne is trying to do.  So I'd encode that in the name,
> e.g. iomap_read_folio_range_bio to mimici the naming used for
> iomap_dio_bio_iter in the direct I/O code.
>
I think the issue is that the iomap_read_folio_range() function used
for buffered writes also uses a bio, so there still needs to be some
way to differentiate between the two. Maybe making the async one the
default "iomap_read_folio_range" and then the synchronous one
"iomap_read_folio_range_sync"?

