Return-Path: <linux-fsdevel+bounces-74245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6AD3890E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4721302D385
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E52EB5A1;
	Fri, 16 Jan 2026 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeNhOaN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCF27815D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600958; cv=none; b=HRUmjkNSMxVucdng8nxYm6gS2XjoxxX6jLekyt2/qhSUUnOiaqtM9iqpWDGVCiGZL5xxEcWyn+fjMXm2ab3Z4RCQzjpzRDxZpMYaJjZvqYh5nTyssKfZlhzusuBmRco4bII3jxraa8c0mPWNX9Ymt/0SkxOxdBZiQ7FL5drhRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600958; c=relaxed/simple;
	bh=aydEKRtWWphu0Yz+ZYb4aM5YVFNKPYJX4xEQ92WfiQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay2pUAPMVgcShZ0Ly+QVgyLoGvqmbQWbpqDEfYfcsQRJVbCG9ZTX5BWKIfORBRoR6Q7jJYD1xflaurCRgG2ZstAN0BEhOWuo5Its0292HT9fmyYusKmHuAtIRT8zcCmClGr2ct/Ut27ym/geBhRrNs8kWuVhDxqmrgth1b2tauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeNhOaN7; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-888310b91c5so31976466d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768600956; x=1769205756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kioqGv/O65jucFzmSr0D7VCUrzqpQCB5qF8Dqr7pb54=;
        b=DeNhOaN7fqvxS22GGTIwGgmw6iSlL0ozgKwkPwQVxM+oVLFXrBkQCPxvD1Ahk2/z8z
         GUKiJwYaIxh4Nc114K+xzxWT/f6rGdV/urCk57NuCycx5/itmhSvH+MYO0MV8XffcwbS
         69uP6ef1lxehYzgYqpLDlybYTwu0rZz5hMmRYNKxEMNJJUiy5nibhIuuhxyNZHPkH6j/
         j/0roK5tE01b2kYGsNfQsNUn6Lw50IsEg4EDsd4CVvtk2n7WgyaQf3CJx9bbZlg/6mgw
         YLMP4IQbzw4ZmB+d6M2pzoM91ZhOuYNS19/T0N1ScxiJ+HHXfVeZz37AfOmctX9O1ri6
         MvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768600956; x=1769205756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kioqGv/O65jucFzmSr0D7VCUrzqpQCB5qF8Dqr7pb54=;
        b=p0F+nVG3n4DDoSB/YhQNvLcxNx5xA30rfN9ahwyG51OgNvK7bGZf0qypZ6bbgJtWkX
         7eqQ9duba8CEc5oK56FO6aKciR8IqOUGoodXVkMcZ0s7diYLc5bh7cSTsv6cTvcb5Q0f
         qSUK2PqkVI12b3ajUu4m5JG9X5d4hgV3FZXtXTTgBu3ASgASqIkBhrRgrXHQd30OQ1Zt
         MgLiRsh3tonM+57unvZTudjprmIvHx7d6EwmAz+gsjH76rGtGhKpUifseLcU3Ks7M6jj
         Mw2h4EfNqr6PCUDXagJHhBdwjErjcyZzANwjTyhH6sUqGVImsVKQ54i4BNH7G00zl5pA
         HA6g==
X-Forwarded-Encrypted: i=1; AJvYcCXl3iNJUrwh0BqfPmmRoP58RRQ2pMnevvMxoVykM+1PMaTbcTnX25fAs9FwDxmS5+B5MVkxAyswQkTMdme8@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcPV15FBZN5+nvZ/0V45lpzuRXG6MrThWsvUQnKyTZAXxw03B
	J9lbBCNbMudbM7TPHdV+fj885vbUqSc85PdpmnjvGZ81lKx1M9+hvahuwhavbmYIrvly8ktmJPm
	1XOOwngKeVxhRkHMaAYz3rmYfmv9q+4Y=
X-Gm-Gg: AY/fxX6kPN94C4oCH94mekmu9C82VbyfaOLJct+Fz8i71FRSiZu/328dZ8BWBEdeEsm
	+NEK3BCGfVyITv80mkZQNu+jrMX5N/z+HlCZGZyaMi9DuAODCn5v66o7AlHG2deBuiPQ/NWLBPj
	qHhUTjt8fca1Yxht3akM1actG/WBLJnDDrIpH+7ODWv5N3IN/LmdyARpUs+Mkicn2pM8lonaSVz
	znMlAmpS7yyZ6lJdt4c5pJsI+Z6WYI5ku0nDZeSHqT/QWzUUyCatEJKUNTLMK9q0qzJPg==
X-Received: by 2002:a05:6214:76d:b0:88a:4c50:3be0 with SMTP id
 6a1803df08f44-89389f83460mr116258776d6.6.1768600951054; Fri, 16 Jan 2026
 14:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com> <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com> <aWqxgAfDHD5mZBO1@casper.infradead.org>
In-Reply-To: <aWqxgAfDHD5mZBO1@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 16 Jan 2026 14:02:20 -0800
X-Gm-Features: AZwV_QjD0yw66vmP4kKNl7YuEBZT81h9sKTUGPOWB_dqW1tlS7wTwREAeUYDZbM
Message-ID: <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 1:45=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jan 16, 2026 at 10:36:25AM -0800, Joanne Koong wrote:
> > On Thu, Jan 15, 2026 at 6:52=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > > +                     if (!ifs) {
> > > > +                             ctx->cur_folio =3D NULL;
> > > > +                             if (unlikely(plen !=3D folio_len))
> > > > +                                 return -EIO;
> > >
> > > This should be indented with a tab, not four spaces.  Can it even
> > > happen?  If we didn't attach an ifs, can we do a short read?
> >
> > The short read can happen if the filesystem sets the iomap length to a
> > size that's less than the folio size. plen is determined by
> > iomap_length() (which returns the minimum of the iter->len and the
> > iomap length value the filesystem set).
>
> Understood, but if plen is less than folio_size(), don't we allocate
> an ifs?  So !ifs && plen < folio_size() shouldn't be possible?  Or have
> I misunderstood this part?

Maybe I'm misunderstanding this, but I'm pretty sure the ifs is only
allocated if the inode's block size is less than the folio size, and
is not based on plen. The logic I'm looking at is the code inside
ifs_alloc().

Thanks,
Joanne

