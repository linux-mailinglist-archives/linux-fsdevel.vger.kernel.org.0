Return-Path: <linux-fsdevel+bounces-55966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEBB11157
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A841D00199
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68AF207A27;
	Thu, 24 Jul 2025 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VamdhapZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883054723
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383832; cv=none; b=JUSpvdK6AxqUYjuslF86neDOW4bEVOo7Lf77Xwx/15zFT8uDtLqlmWxwRYgI8W002VDjqNAGaz6Ygeg3EcGAAetAqWZyl6wfC3Dh4GdjNQd4NrQ7AOG94Qq173c084YAU64Aw9XfL/PLOiE1aidgtkF+XPW51WtvNIgdU+rfLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383832; c=relaxed/simple;
	bh=jyU2Riz+wx0DcoKskDIXKh4msBsviSfs6xotnSVuFGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4I10UmthskC4dnaZS9JYx7y3Wrj9OnGkr2klRZ8Cjhm0vEV5BFHgqnAUAZFdqd74JJYKqBe+8DhdPvEnmOJ2c116l+9TKfOf9tVSLzBwQllz4tP7PmYYQR7Oac9gHHtu6epIUi3w/6CaAQEVvil4Gju21NHWX2n41lwgft+fdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VamdhapZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3226307787so1217183a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753383830; x=1753988630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHgVyEJ8iJk5rtNl3+thq2lwZ5FhOrwHASCtSkeEmpI=;
        b=VamdhapZXu1LCN83A+YgTxK2nWWYqge7lW0qjzdd/wHrTb9+Xzeo/aW0qBiNkMBFg9
         ia93yMpQxwIfaJDlfAEAbz8+JSLFOi8QlxEfGSIyfWfdR38Ywr7eHIcPfmMmqG/gtyDK
         f92Gw+yEuKpXyoIn49DF0cjeYhRBXzPiUdzQDq2KIAKa7tWpJGMNvzNK5Fwv0/2CAXtQ
         u46ID5zjEF5ZJNH4vIoor3baNPVccPmsKSV0PLds9HKqsZfpvGq3BvAVEkYLA7t/L1zg
         J9av11/4aAoms9ZTGTXptZbkUMNw/IeHKqxeMyicId8cRpymItaNsfwjZU1k0i6w3NUZ
         ByGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383830; x=1753988630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHgVyEJ8iJk5rtNl3+thq2lwZ5FhOrwHASCtSkeEmpI=;
        b=HdVMlNS9JrARKZgL/D7ubgjfp1ndDRye88BDKwqT8uIwVQHx5gfaQBPhb51NFrMvn4
         WHk1Z34gOIujTwUcZ48qWJKlr1kLX/VU7s6osRyHCPCR6BpMCIzri5nR6/ya2PjiDNGS
         Zvdy1+oYVOQnW7BnM7VQIPlMhDpilp6WhN3nyI7unVEJS5gQxUItUxJQSYK+0s6YewRa
         vmsc0dcSOTvJBJ0dTtEMew/FHEHhXCcFPfdqZ1eip3+kCXbIS/bF6HYEaM8C5bbCQiyZ
         cRGFHkbsdaNwfQJX/Uq6RXrnYg3Mgkq7JsSr1tsldjvCsNjQtn9i012vHz485y+lS+ft
         G7Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXcw05kBA4eObgyOwrnjDvpHWRNP6iIxSCMOI/lk8IcMljhd24x+4s0ERHbzWLCk8xd3fisCAt1N+rXv0Tn@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOiIfgJtt5JtMadPXZIY3PYo2FXNh+/cFGyeVTUrban9+grRK
	B8gTwA3xv33K0cPlFzqSVFa8rZZ28Z9JhzXoZKz/MZw8e8+k7dygqpEY6RW5Ws5bWeZGlVFTIVg
	8x66S7KogHqExJjtOvcslXkqa1sDBE07GAMsvnH684g==
X-Gm-Gg: ASbGnctCwwK5Fi3MbiOu8T2ZS17bVDtj6FEU0ZHSGnJRDVYI9vF1hm470Nd+vzpXJ09
	C7G8VnHprYD/kdHaUW2oAI7JqkSGu8+OHY47pRUZzsaL1DCKHneJ1z+RN1LGCxwKjtR2L3noM0R
	jYUXoqfmNFGuw/a8FVPv46RNaJSP46dRYgX2lD2CXqih1ABbrUYHnwIZ4zNrdBwKA8+YayqrTW1
	qSCFHuvM1o3LC4d0D6h7yv6YRfVIuwj1YzLEfJ8
X-Google-Smtp-Source: AGHT+IG9L9gg7ixVYWlh41rg/m1A1scQEtw9OVWs251mJbV7ftWwOWfHp7oOVtaUKCS6cQwi1SSJCVX8+RyRlApuoaI=
X-Received: by 2002:a17:90b:2b8e:b0:312:959:dc42 with SMTP id
 98e67ed59e1d1-31e507a7eedmr11963396a91.11.1753383829775; Thu, 24 Jul 2025
 12:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723230850.2395561-1-joannelkoong@gmail.com> <20250724162501.GL2672029@frogsfrogsfrogs>
In-Reply-To: <20250724162501.GL2672029@frogsfrogsfrogs>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 Jul 2025 00:33:38 +0530
X-Gm-Features: Ac12FXzLTJkr5OzXRymfujHUQNUYUWGhsUfbagL0Yr1EY2mqTezqtYXma1sSqnE
Message-ID: <CA+G9fYv+NRoMYHv12V349YiqUSxVT6A55W5byDR0oARh+-6vLA@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove page alignment check for writeback len
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 21:55, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Jul 23, 2025 at 04:08:50PM -0700, Joanne Koong wrote:
> > Remove incorrect page alignment check for the writeback len arg in
> > fuse_iomap_writeback_range(). len will always be block-aligned as passed
> > in by iomap. On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT
> > so this is not a problem but for fuseblk filesystems, the block size is
> > set to a default of 512 bytes or a block size passed in at mount time.
> >
> > Please note that non-page-aligned lens are fine for the logic in
> > fuse_iomap_writeback_range(). The check was originally added as a
> > safeguard to detect conspicuously wrong ranges.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I have applied this patch on top of the Linux next tree and performed
testing. The previously reported regressions [1] are no longer observed.
Thank you for providing the fix.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> Seems fine to me,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
> >

[1] report:
https://lore.kernel.org/linux-fsdevel/CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com/

> > ---
> >  fs/fuse/file.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f16426fd2bf5..883dc94a0ce0 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2155,8 +2155,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> >       loff_t offset = offset_in_folio(folio, pos);
> >
> >       WARN_ON_ONCE(!data);
> > -     /* len will always be page aligned */
> > -     WARN_ON_ONCE(len & (PAGE_SIZE - 1));
> >
> >       if (!data->ff) {
> >               data->ff = fuse_write_file_get(fi);
> > --
> > 2.47.3
> >
> >


--
Linaro LKFT
https://lkft.linaro.org

