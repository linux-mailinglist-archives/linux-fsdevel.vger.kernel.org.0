Return-Path: <linux-fsdevel+bounces-26553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8995A5C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202081C22365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E416FF41;
	Wed, 21 Aug 2024 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEgXiMa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72B28DCB
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271752; cv=none; b=TtXtr93BOgQk6J7CJBDz/GRCkE5UqS3IoatJSy2BjMw2jKKbWwGV7DJcvL8XfdMkiUOJZNzjxfLykRX1VYQXyofDY0Sr/mhj13ZR5ksqBXbO6Nqz4PyuCP1/NDLDKN9R772xtXlRwDNAUve8LA1ECW7FfDKxAtSr1zFbgOen+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271752; c=relaxed/simple;
	bh=tXnVCUtfD3pdyXKOPA9ZrBRP+RfhQs+o+WmyXOe8qH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDsumNrFh9l8s1UQXa539s++pep1o6vjlkYCBlpG5E1KmhOXiMr8SefvJ95fXLW78NN6hcXwRs+kWXonaWxS+o57bF9g91e5nxJZ8JYXFav3+89AeCPyfhOBDbTyTAHTkCnZGSONBP0jXj8DhIefscbz1tyJsiKy1p7sRycnF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEgXiMa6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44feaa08040so752551cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724271749; x=1724876549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6F94HxVRYFkRVTa6eZ28JCGZzeYOMLrnrckQsOyjsU=;
        b=WEgXiMa6pyewl6svkb4U17OzAgCJsXsiVDlZqjVLCkUqQlmENrjJrLqaNLZSQ9OZ7Q
         NcynuolAXUwfV6issFgV+O1zOxnY3URwguQlOlPa8gB6JznDcj3PmDHiaVAg+IbncCrc
         AYzouClEsPt0JZmUDalND75/DDfQ8h+3cWd7FpQKmJD3upQiy3XbUDjrgKjYExc6hSV2
         NvKuStcOTmLeEZo9C4356La1Tsec9xxJz+41yCENiLg90H34s+nn4qzaTzkPCbgaYoRj
         QMadvntC655JZI3bXjbasRcaakgHUBsLiBOfWN6L/YqAuEL8iVRO+v2lC6IZJglSC9g3
         Z6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724271749; x=1724876549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6F94HxVRYFkRVTa6eZ28JCGZzeYOMLrnrckQsOyjsU=;
        b=iCyVNrPQORRYiNjy7tttYg54D/oXlJgeBV5Mlea9X4q5J0TXVY9anwC9gdJWUyMhFb
         dB3l/Li/LFAZw7ARGZNqzsvOs6PEMx4PwCDRMJQ0Xp3OHFMahJO8nWU603S5BJz4dKJX
         HNap5M7msc5tnokjbFhPPCJEUcGTS9fNckqRaLAKoiiQfJV71UxVqO9Sk3zfHFeVADuU
         7Hnn5rTBWcgL2esd5HH+aGPheQ8thL/7XwvhVpZKm9Za0zR4VkqFDHZPDTUBH2IVJmgC
         MBxC8ZI+PkLScHE3ed1ibkOXtQErB8nJqa9Whysc1f1d8lUt1sh0f0ThWt0xOE74asnX
         3Y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVZgTAGm87RvM1XyW4k+MvrST2LvXFn40ubKZ64yPpverTRx6aeFD2hVpNZKyE0SUmR5uLUhV7K701rmnF@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYOuAVT9qWQ4xcKCOPncPUd4bWRboO5fpaERK9ECjdRKEo71l
	3/neHXis2qvaA6r799y5BB+42ga1AobdBOc/njBmGVtw3ERrJ4kIPuhZYjp+GazGAYrjUnwLvW1
	6EJuco6OJ6FMSCKNT+5GK6JqUQhc=
X-Google-Smtp-Source: AGHT+IGsuU9N7vz0ZfmOB2t53aML4ZAvIF9nqgHppcw7zSbyYF+THzbkdU8Y6J8UWA4Hi3sFr8vNFeovIltU3bXoXFQ=
X-Received: by 2002:a05:622a:5b97:b0:447:eb43:5d0c with SMTP id
 d75a77b69052e-454f268e15cmr38219701cf.59.1724271749287; Wed, 21 Aug 2024
 13:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182417.504672-1-joannelkoong@gmail.com>
 <20240819182417.504672-2-joannelkoong@gmail.com> <CAJfpegswvvE5oid-hPXsSXQpFezq3NLVdJWTr_eb4shFLJ2j4A@mail.gmail.com>
 <6d1c802e-1635-414a-b0d7-ad5306bfaf8f@fastmail.fm>
In-Reply-To: <6d1c802e-1635-414a-b0d7-ad5306bfaf8f@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Aug 2024 13:22:18 -0700
Message-ID: <CAJnrk1YkAggwb94bojbxhsLLcQj3TPM3CdO2v4h9H_y0firrwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback list
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:26=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/21/24 17:56, Miklos Szeredi wrote:
> > On Mon, 19 Aug 2024 at 20:25, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >>
> >> In the case where the aux writeback list is dropped (eg the pages
> >> have been truncated or the connection is broken), the stats for
> >> its pages and backing device info need to be updated as well.
> >
> > Patch looks good.  Thanks.
> >
> > Do you have a reproducer or was this found by code review only?

Hi Miklos!

I unfortunately don't have a repro, this was found by code review. I
started looking at the writeback code after reading through this
thread
https://lore.kernel.org/all/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alib=
aba.com/#t

For v2 of this patchset, I am planning to add a few more refactoring
patches like abstracting out the shared logic between
fuse_writepages_fill() and fuse_writepage_locked(). My plan is to
submit v2 this week.

>
> That's indeed a nice catch from Joanne!.
>
> I would have expected that writing to a file and in parallel truncating
> it would leak WritebackTmp in /proc/meminfo. But I see it going up and
> always to 0 again.

I think we only hit this leaked case when we're writing back to a page
that is already in writeback (which then leads it to being placed on
the auxiliary list). I think in your example, the page isn't already
in writeback?

>
>
> Thanks,
> Bernd

Thanks,
Joanne

