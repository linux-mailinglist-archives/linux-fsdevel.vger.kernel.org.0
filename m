Return-Path: <linux-fsdevel+bounces-43653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F61A5A1F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B6A3A5810
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F472356D1;
	Mon, 10 Mar 2025 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzK9SPmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36759230D0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630518; cv=none; b=D7I78nGo42grIrJBnFB8+MzpoCb7OhTKouzhm70/e2BTytM1G0Is4+7lnejSiGc4jQGgOpmkw17EAgCWVLzh7re7y7acTVuoq6LLwn7TG0IDvUQHRy4cNjSmyTJ6hIN3lYC/7KaCRzfAV7NSnh4C1/p00gSr88KD9Fopjn3Kf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630518; c=relaxed/simple;
	bh=SImQJADbpHTlvNCQBrZUtzCB2b/Tc0ig7xFDdyJ1a/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqwfxfUKJuxm06PTgeswB59HFmOXEmnhWfh6sGKNYQ7vmsRJPIp672+MSzfzL2oqQ/C/VCBZJR2YnUijp7l5XaEAvVdrx64kBFXJ64Cr/yMTFNrbENRmEwBQg1s4XuCcwSqeu37feNEuN/oCeXWCQa+mvhXfgeoYmCso5TdsFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzK9SPmX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741630515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pAe53a+t+jZXRC//+k31Dxd8ZsLFTZkf6JZER3Ffgc=;
	b=HzK9SPmXVSmQZy3qEeLu0TXfRRgLI59Pn/xY699n46KBMZ7TbrF1tWJSrmu23ZY29iBFVE
	kU6rVFWL+rk5LkuUW2hrCsoXvWICfadZVrHOUgLDGSQkBJT5QRoSGAhMOMNJm3jx9s/2E4
	LsZ/r1tBachFmtdpLUP3cFn4xYTmi6w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-MqJ2-umEMCClfFLzHWxfvw-1; Mon, 10 Mar 2025 14:15:12 -0400
X-MC-Unique: MqJ2-umEMCClfFLzHWxfvw-1
X-Mimecast-MFC-AGG-ID: MqJ2-umEMCClfFLzHWxfvw_1741630512
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224192ff68bso69154935ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 11:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630510; x=1742235310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pAe53a+t+jZXRC//+k31Dxd8ZsLFTZkf6JZER3Ffgc=;
        b=J6GrTGjLeo45KTDrPOIRzA7u14fnnyqyCXlDASwz8jNV5k1LePKlia/3hULPx1nl0i
         suS2xwolzCwj2BsN4OPHZOy5a/IiFwk7cQJXILmA1vpx5lM0jhJB7u8CAqBNkvLjc/pt
         yg/IHeuhKsncpcsA407GQtMXYIylyK9NCtBi8fLYmS8diYjJLIiKhlR5ibRXclnayDF6
         HpBfr+tfedz5xIFJL2C5YZFqU9AiHSLjNm98LBTfvuutMLspCdU2ZGeY/crpD4126Imt
         i+IUW5LgSu2+OHFP3Wet0aVkTU8LdNoT0fNtXDe7vcMVp5rwyTKMeyNFsCLwSh5wTvXI
         h0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiQx68KrWc1AvgG3SZpj2eDCmxEqBj7oAblZAcBBdyi9Sr9SI1TO8qvYClrq6+Jyi+GuEJ20EWhpqqBn5L@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYV+J/W9AgZCOE4x3+n3tgX7vFPH8gLpAt+bS5yW2SqyiMKT5
	Bb6x7IZ3xeX4D0Q4L6//ix/1Rjbu2fubNfqMKtyVYZ2Pz+dzKxsCmLMaznFrSWxAJdw9Pj0G9GG
	mbNs1X74YfljqL6/YbCNgbVsxls9gHWHezOFOQV9YR1eenQRLIqm6YVwx0tUuPjmvke0NVF4oNA
	kI4BnwkYwyLoK1/C2cujRLc4scRB6hA/pBBk31EaPzgtMecUlG
X-Gm-Gg: ASbGncv/NhSRkEn3pkTWBk5l47CacFaG5Yxizm/6Jvm9MzLzsK+CPVZ3ICY9dHuMGhF
	9K2aUWcza/A3mwtYma811I+HZd4ZCwzIFntvw/EJ2eC9krJlMHdj/61TzjNtk2pUkLVsEpqw=
X-Received: by 2002:a17:903:2f86:b0:220:c63b:d93c with SMTP id d9443c01a7336-225931ad50bmr10249255ad.44.1741630510328;
        Mon, 10 Mar 2025 11:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv1DkG5rlbNPTvM2luEYDXZzmIPhJvZg4f0mJY+AucA7HhO7+60DKAkDW/BhCblf16viK2KTiWJh3F2wdWK44=
X-Received: by 2002:a17:903:2f86:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-225931ad50bmr10248985ad.44.1741630510020; Mon, 10 Mar 2025
 11:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <20250210133448.3796209-8-willy@infradead.org>
 <CAHc6FU5GrXSfxiRyrx_ShR7hJkCMaQD=k-mhTJ37CzbUMR68dQ@mail.gmail.com>
 <Z84Ay7gj2JQMUuRE@casper.infradead.org> <CAHc6FU5TcVWAOH+Yu1Q0v2j363NXnm8cd2cA0_ug14MmdTtzqw@mail.gmail.com>
 <Z85gf3GfqNX3enPs@casper.infradead.org>
In-Reply-To: <Z85gf3GfqNX3enPs@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 10 Mar 2025 19:14:58 +0100
X-Gm-Features: AQ5f1JrB4RR5v156ID73ehkXOUBD7KfJ3QN8J_3DiPrwyJTjF8tKd9ZlAHWzC7w
Message-ID: <CAHc6FU6JuOB0HZ84qqYuseH-CEEmw5o9bMNLzVWVs80NRmpT0g@mail.gmail.com>
Subject: Re: [PATCH 7/8] gfs2: Convert gfs2_end_log_write_bh() to work on a folio
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 4:46=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Sun, Mar 09, 2025 at 10:53:29PM +0100, Andreas Gruenbacher wrote:
> > On Sun, Mar 9, 2025 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > > On Sun, Mar 09, 2025 at 06:33:34PM +0100, Andreas Gruenbacher wrote:
> > > > On Mon, Feb 10, 2025 at 2:35=E2=80=AFPM Matthew Wilcox (Oracle)
> > > > <willy@infradead.org> wrote:
> > > > > gfs2_end_log_write() has to handle bios which consist of both pag=
es
> > > > > which belong to folios and pages which were allocated from a memp=
ool and
> > > > > do not belong to a folio.  It would be cleaner to have separate e=
ndio
> > > > > handlers which handle each type, but it's not clear to me whether=
 that's
> > > > > even possible.
> > > > >
> > > > > This patch is slightly forward-looking in that page_folio() canno=
t
> > > > > currently return NULL, but it will return NULL in the future for =
pages
> > > > > which do not belong to a folio.
> > > > >
> > > > > This was the last user of page_has_buffers(), so remove it.
> > > >
> > > > Right now in for-next, ocfs2 is still using page_has_buffers(), so =
I'm
> > > > going to skip this part.
> > >
> > > How odd.  I see it removed in 1b426db11ba8 ecee61651d8f 0fad0a824e5c
> > > 414ae0a44033 and all of those commits are in 6.14-rc1.
> > >
> > > $ git show v6.14-rc1:fs/ocfs2/aops.c |grep page_has
> > > (no output)
> >
> > Hmm, you're right, it's only that automatic test that's based on an
> > older kernel. Sorry for the confusion.
>
> Looks like your for-next doesn't include v6.14-rc1.
>
> gfs2            104b4d597ff21b923b1e963c5793efcadeae047e
>
> is the entry in SHA1s for next-20250307.  And:
>
> $ git log v6.14-rc1 ^104b4d597ff21b923b1e963c5793efcadeae047e
> shows quite a lot of commits (9847 of them).  So I think you didn't pull
> from Linus before branching for the v6.15 merge window.

Right, this is the point at which gfs2-for-6.14 was merged into mainline.

>  Not sure how
> you manage your trees and how you'd like to improve this situation
> (do you rebase?  Do you want to bring in a merge commit of some -rc
> version?  If so, which one?)

I have rebased onto v6.14-rc1 now, so things should be fine.

Thanks,
Andreas


