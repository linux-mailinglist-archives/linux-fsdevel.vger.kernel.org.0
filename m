Return-Path: <linux-fsdevel+bounces-62417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40EB924DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14337188B271
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813F311C2E;
	Mon, 22 Sep 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFejKAtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6593112DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559804; cv=none; b=QE227dLa9uqLFDFl9ufIMddo/ecIKRtA52cUqs/+a4jvsweaB9ucHMyxMI4qjz9d1BrQ91ZVNt4rTQDMvtYwX4dqJDN7T0pGzVGN87+/duZLeg+Jf1xpBr9OGYQQDyilbEDEXWZYROELL6Gr0eqBQVypJGXrNzPVAmuiuEUz62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559804; c=relaxed/simple;
	bh=m9/XGEHINrVzPTUGiEZBd4c6Fi+tGqA4JccCjRyRcuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSRN2I9D61NJGzW3Z50Z4S+u9B6ShiLlWaQTvpibXGAesXG/n3b3nJwqE1xjoFItnMnOEjxpBTi8gXtBd9crIso0Wqlcth8Wm5eoLO14o1yhna/ZPxygPXpHoPFyvrR7hRNakZ1KJKORP3GL84j9pPQnihjKL7GzPFpUSwFY6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFejKAtP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b7a8c428c3so36400741cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758559802; x=1759164602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA+alynuVVEEPnntcyqcLLSauhQLoM8gOAgbz++kC00=;
        b=RFejKAtP74up0mb6zIBo/ztzZ+Sf2255tgJnRZKBv6pqR/bH128weEJfGas/TXV/TZ
         9VEqSf+YbClXEI6WiXooTNJbGCXE6u69aSZ6fFDB+NJAHH/iXXUw81QlAs3nMCxgifOb
         m2I+HzjucroSBR1eF8GxhI/vfpwitPSi2XX759NDy0WTS0UecXOTEx/OZ0q6HIZQstz8
         zafcoOd3ah8UHBlSpvZZRSjZfvieU52eCiHotHgOlF2AIq6WSb9HkuxeOrfSuoXsvYwi
         h0Giq5fnu5RjVNjrlFAtYL+9Q38eilZ6EABhXmAHZ5g0BncUcXhVA0RRigGZ5A7WmMhK
         r21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559802; x=1759164602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA+alynuVVEEPnntcyqcLLSauhQLoM8gOAgbz++kC00=;
        b=TTTxmaAeDFNGvHnL63Ygu1Z+1NwGIAH88b2PnzCK1C1bM6l0qmhkDIPzBPTiQ+NQpJ
         s0tlm4Z/D7BhgDDu2unL0orZkTf55VLF/gwxT2ZOojXt0fSSxxnFo5LEug5QNtSbEi/D
         xD3uK6lPnSz/CkiLE/ldcJBzRpcqqrhZ2B39RG4egvkkAosVHzFQnwufBLRg9B4y6ihC
         KHcgNh5OcZkSuX9SQthEpmXBleVgyItlSbkjLS4fCUMbh7XyXSdTkiL2UI5J+1uR3qlG
         G5YYLdYJkK5VZPHgfAfL6UPVotv5nNX34NXLd9v+Lm2DVHEmW9xzzTee6h4NJ5yyLkE3
         f3gg==
X-Forwarded-Encrypted: i=1; AJvYcCW9UNsc32+0iiP4ATFGI7rLE8jSPJLPAWWNIKp36TaxZk02NOMP9QdW5PFvwD8I40/4wvMtiFT+B0JxwW9S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+HerGDkVBO0KE56mm5HijCXoJR86gymNTDtWab3wKX0m0MvT
	R8Di3txm45BBGafAFiHfeXY4wCAeYT1nkU7aSq4zi2jOJgjSDUBQ5iFptxRiF9RARa2pBSDtFjB
	OGU+z6xGhQBu+F7LWrvk9BYRmjTNO/5M=
X-Gm-Gg: ASbGnct9T78VG5iY/1PgN1NcblcPwpvkmsZEYidb1Gu9D0fId0TkeI5PRjPj4P9adiX
	ixyKwzJBg3vcirhYLYJ0iDUWI1R+hYIuixS9iJLFojV0HfjlUUVUAg5bDkbpIsknjZULhjJg0iR
	m/BGUdEoJ887GMPa7kI1IQ1c92qCY/jvB4iuovu5zrhB3mkrndYvfup5ZJVIIRl+r4OAsqrb8It
	RX0kbNq6fb98R0b2tZ6ckqmipjP34iqz89GsGSD
X-Google-Smtp-Source: AGHT+IE2GJniwx2CuhW63kr8BKynTNE4Xt9Ay1AkqcPL9FzvjlWdOzfghumDj+pZeJOeKep2YblFDfteGq4gqyUOwfY=
X-Received: by 2002:a05:622a:653:b0:4b7:a62c:3747 with SMTP id
 d75a77b69052e-4c07151d134mr177156361cf.46.1758559801973; Mon, 22 Sep 2025
 09:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-6-joannelkoong@gmail.com> <aLktHFhtV_4seMDN@infradead.org>
 <aLoA6nkQKGqG04pW@casper.infradead.org>
In-Reply-To: <aLoA6nkQKGqG04pW@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 22 Sep 2025 09:49:50 -0700
X-Gm-Features: AS18NWCYGl8IVCOH-hPpOfmVBaFG3jn-gUPUQCOuCGVD2SlbTPYRIsrQjTCDT5g
Message-ID: <CAJnrk1ZxQt0RmYnoi3bcDCLn1=Zgk9uJEcFNMH59ZXV7T6c2Fg@mail.gmail.com>
Subject: Re: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to caller
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:13=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Wed, Sep 03, 2025 at 11:09:32PM -0700, Christoph Hellwig wrote:
> > On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> > > Propagate any error encountered in iomap_read_folio() back up to its
> > > caller (otherwise a default -EIO will be passed up by
> > > filemap_read_folio() to callers). This is standard behavior for how
> > > other filesystems handle their ->read_folio() errors as well.
> >
> > Is it?  As far as I remember we, or willy in particular has been
> > trying to kill this error return - it isn't very hepful when the
> > actually interesting real errors only happen on async completion
> > anyway.
>
> I killed the error return from ->readahead (formerly readpages).
> By definition, nobody is interested in the error of readahead
> since nobody asked for the data in those pages.
>
> I designed an error reporting mechanism a while back that allowed the
> errno to propagate from completion context to whoever was waiting
> on the folio(s) that were part of a read request.  I can dig that
> patchset up again if there's interest.

Could you describe a bit how your design works?

Thanks,
Joanne
>

