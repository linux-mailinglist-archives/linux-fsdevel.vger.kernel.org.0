Return-Path: <linux-fsdevel+bounces-30868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716B98EF17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC51C22629
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B15170853;
	Thu,  3 Oct 2024 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjcTko1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFE145B24;
	Thu,  3 Oct 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958047; cv=none; b=q6xwhIlM+HCZUsdp8bIQ07s4/2UQuut9bDI9FZhUTqef9CE7KiJs+S6kSIBLNTu/EjRWWl5GX6CHpmIAL6P8qXAR4wVNFmsAXtwBUPq8sebYMfhuq8ukQ3Mw8oRoUBYuUg0veHibtuftDEKF7bS93IgWvBXSNtGKjPNFXm3sq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958047; c=relaxed/simple;
	bh=EjjGeWOTxqh8kNyDOAtatpqOHWsE2KBHIRl2Cj4rDKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT4CITu+yw/6AFloThRkItLpTiaVqTHbH33dIU0/BurZMNiXWnDtroimxgmC8Idgaiu1/Qqe9kCYLXmsoKbszhmRpFgtxhUbIyEp/0I2PuSUoY9FWQ9Uqg62+0be01KVEdSdZjTkyIJnB6870GUGcTVd4Rfeh4/tuqu6Luyh5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjcTko1y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398996acbeso1040308e87.1;
        Thu, 03 Oct 2024 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727958044; x=1728562844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6syHiaG5x1+UMsC6ZVAUhcpO9y9MsfbtvNnR05E9os=;
        b=HjcTko1yYRBZRI3FwObz31/Z9psSUwT4LgNYY8/7dAcIOaa0C1ZrFVzJcRI9YdZY54
         kDN/bflUy67rjk0mEAN2EpImcc5zokdc0j/k2HIx1p0cgvEfFbC7JAhx55hzN9HHnw3a
         Pqqjs/umMqw2Ahz10jiQNi3wpcrjp1SlwvBAv0xd4qy5pW+8/V6gcllsyYGCCKijAMcL
         p72l7fKrbLj9SbfexsBTD40yjJUfDZ0VrTC/9gyIqFtkeBmYP3bmFbO3klQmKiAqZH6a
         J8OmKB+uYI6MfJWLM3UQO3Ix8TvBkRNgt6zxCRuw3X3cZvbO0jmRSxUOwFKap85PiI0p
         dK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727958044; x=1728562844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6syHiaG5x1+UMsC6ZVAUhcpO9y9MsfbtvNnR05E9os=;
        b=N8qRZKffud0B4TSGpTnocrFCuLnuybgayetD77FZV3/utKFGWQu22MBGQUkX1hXEq6
         /xdnGl6M4TL0rATj0dPkZ2WLVfNgwDo5BtKmCN00BdbvQvSXVjBhnI0pVZx+W27XXWoQ
         uSQTVeXMu2vtQmZsamfhm07DFWiwZHG7KW8POL6ycPo0rjhQmfs6BNPJeQ73pq/1/m5p
         JSezIJMEBL6J6nXD1634EelqrO9LeRMPAK18LgsL9/ChbLDIqIcLW8TU0ZqF7W3TbIS8
         JQgqoM1guTd8X1QwZA2SEWAQd55tYFObNpZfg7oWZ5z10CUutM6g5aByuT/r31BXkI0S
         yW1w==
X-Forwarded-Encrypted: i=1; AJvYcCXI98OK5I/1KjM0/sJUZdTn9+1uiUVF7XU+xAG2Yoto7MWKfezbYuQT3JIHw6n/uZyBq4C8nn8MSb466w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYQXGVPr3rEPOa76d/VfWDyUJ2AZ4Sx2KIREkOAuEJe9PqvMi
	QsE1CbTKZTbC3FHoKFbHekAVGnJ8t65QOWBlnZc5UrJEO6LxTkEjljzFKl5M1K++aQiDocHdrnl
	0Q3OhIBauhdhUMIfrt/Wmtjml3BM=
X-Google-Smtp-Source: AGHT+IHy4YyMW2KDNJdyaNBZYRhAEO8FSXEAc+n16sMGK61IqWRvUq0tucQlWmCJ8jiKmfp0kd8V0T2fljoeMCh978E=
X-Received: by 2002:a05:6512:2804:b0:539:972a:2360 with SMTP id
 2adb3069b0e04-539a07a361emr3915111e87.55.1727958043951; Thu, 03 Oct 2024
 05:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002150036.1339475-1-willy@infradead.org> <CAKFNMokwCtK2WjBPRqbO2_Me=x_RRH=htF=Tcz0t9g96--Wx0A@mail.gmail.com>
In-Reply-To: <CAKFNMokwCtK2WjBPRqbO2_Me=x_RRH=htF=Tcz0t9g96--Wx0A@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 3 Oct 2024 21:20:27 +0900
Message-ID: <CAKFNMomrF8k=Z4omLTVx2f_mhUjRxo8h-s=wXmoU6uoMYZ7v+Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] nilfs2: Finish folio conversion
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:40=E2=80=AFAM Ryusuke Konishi wrote:
>
> On Thu, Oct 3, 2024 at 12:00=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> >
> > After "nilfs2: Convert nilfs_copy_buffer() to use folios", there are
> > only a few remaining users of struct page in all of nilfs2, and they're
> > straightforward to remove.  Build tested only.
>
> Thank you for your ongoing work on converting to folio-based.
>
> Page structure references still remain in other files, but I'm
> preparing a patch set to convert them to be folio-based, so together
> with that, I think we'll be able to remove most of the page references
> in nilfs2 in the next cycle.
>
> I'll check out this patch set.
>
> Thanks,
> Ryusuke Konishi

I've added comments to each patch based on my review and testing.

The biggest comment is about the kernel panic caused by patches 1/4
and 4/4.  As I wrote in my reply to each of them, this can be fixed by
replacing "buffer_migrate_folio" with "buffer_migrate_folio_norefs".

If you are busy and don't mind, I can fix the points I commented on.
If so, please let me know.
Or if you send me the v2 patchset, I'll check it again and add it to
the patches I'll send upstream for the next cycle.

Thanks,
Ryusuke Konishi

