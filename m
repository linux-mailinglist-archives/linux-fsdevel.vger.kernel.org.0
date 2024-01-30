Return-Path: <linux-fsdevel+bounces-9503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E207A841DFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675A41F2C73F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63D57893;
	Tue, 30 Jan 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPdwzMVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A04381B4;
	Tue, 30 Jan 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603892; cv=none; b=ARTl5NUhMZbCw7lxYQG43GVbXi0GIRsi/lSYuXTDZS0xjCe57jr0zwQb5E7VCV1f5CSpwJPP913zAneQWDMfqLdsUpz4T1dUOece/ScTkfU9dmEqxO8+xvmi6AkruR444dAiR83ZEyQxKmg2g/K3UPxtTGmNAzq50C9qeQP+e/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603892; c=relaxed/simple;
	bh=OH4l3l+PiVerAo7bJ29F5CDHx+9RNN4LLhE2EUaq0/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8TecrDxI8zrbV0FQjzYQahKVH6jSUB7layyxRcrHBKO+XJeF3bI+xQKsv+jnDL6syVmcbcF3uSRa4tu+RS4jb1FyB3poLld71Ba99qOwAYiZedCEj5qbTe7Z9Bu5Z3aocgGOHzJJfjPxhJpMKnoizCuPe7vxGJxQeVwcF3bA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPdwzMVf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d057003864so8108501fa.3;
        Tue, 30 Jan 2024 00:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706603889; x=1707208689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDU/2MwbFRllUTNWUINgIIfQ9WlIfROwCcs26QMTgo4=;
        b=DPdwzMVfR+GilX4dx8lFm1KucgtHzrmOS7RT01lxWODOAf9x0Y0sbHQph3vXDvBY1s
         9EKWL6OIrx54nNdKyPgU+hYluaSQskYet4APeSA6MJ1tgeuDt43SNeovhvjx/SfgdKKx
         L+qspfg2w6pVs+0qW4gf5LPq8brnwbuPgxRSej6Z2wLdWySjuPDALXDifhuH+55G85Ar
         szbTjC/Ed+HzlwuwYfbQMVLhzxdn/XhuPtQNxYlf1CO0wlbU7rpCxjJXJUVSYGz3ZFPj
         tK0pFFJoPJrs6wpRun+D3PMTSvVKP/hA4hL3qisphgEf3OnpQmFKSP/s3H4E+pa3gJfX
         MMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603889; x=1707208689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDU/2MwbFRllUTNWUINgIIfQ9WlIfROwCcs26QMTgo4=;
        b=cBHwsvPfM+F/Ku+kvakQb+AwQ+Rndekfyt8MNKEyY97WuQll8nR1TQDsV3DLK9KTG0
         uHVJiY3S4neJay5SWrCZIDe4mWTikkwd7BsGPxdLCfUAjKEqSCgKx/QWw3TOPPVDtjVz
         gWXVj/0u6goAr2xhcBdrl0OQYe8m9ZPOpcJPG0UyrKKphbfElfK9kmkE+Iwcjn3M9vwh
         NA4EP9zSnLWp1L4rPLk5aLA5mlyQGfezVbchUmRfoEbfMgWA4y34PXMa++MQjpPImgdB
         Cmo/G5TQyUWhF00fu7upDDEr/znA9KRuw+gfrw+DZPHzNjbAWpm8rEyguMj3x9VsBsmv
         vmeA==
X-Gm-Message-State: AOJu0YzRYZSwJpXA3zyS1PYmCYP/1WPQfDUX/uNiQqnBhTAUDVikps67
	WmzA2Wq3doMvqDL619M1IFSpcIW8TgNabhlAeB4YF+cJwFinXpQvKZ5u8Py8Pn2QnLJqmame3UZ
	19lnK4mnT1uuzdWmtxu0PKCBXjNQ=
X-Google-Smtp-Source: AGHT+IHu0HanyunsHlgYEqJQJkb6JsQMDMYRKggdaYtUb1d24h//flk1b8/XUBsfJ1tJjUmeHUbxDJxWMCKp612sy4o=
X-Received: by 2002:a2e:a278:0:b0:2d0:4c36:8cbf with SMTP id
 k24-20020a2ea278000000b002d04c368cbfmr2772545ljm.16.1706603888667; Tue, 30
 Jan 2024 00:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126120800.3410349-1-zhaoyang.huang@unisoc.com> <ZbPAjGJr7hrOvNOo@casper.infradead.org>
In-Reply-To: <ZbPAjGJr7hrOvNOo@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 30 Jan 2024 16:37:46 +0800
Message-ID: <CAGWkznGSFi9thfuauMtRy6o9YxQV_CiWtFzuxkrTPtvpJrnsiw@mail.gmail.com>
Subject: Re: [PATCHv4 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:24=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Jan 26, 2024 at 08:08:00PM +0800, zhaoyang.huang wrote:
> > +#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
> > +#define bio_add_page(bio, page, len, offset) \
> > +     ({                                      \
> > +             int class, level, hint, activity;       \
> > +             int ret =3D 0;                            \
> > +             ret =3D bio_add_page(bio, page, len, offset);            =
 \
> > +             if (ret > 0) {                                          \
> > +                     class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);     =
 \
> > +                     level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);     =
 \
> > +                     hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);       =
 \
> > +                     activity =3D IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio)=
;                \
> > +                     activity +=3D (bio->bi_vcnt + 1 <=3D IOPRIO_NR_AC=
TIVITY &&          \
> > +                             PageWorkingset(&folio->page)) ? 1 : 0;   =
               \
>
> I know you didn't even compile this version.
sorry for forgetting to enable corresponding fs, it will be corrected
in the next patchset. The correct version is compiled and verified by
including act_ioprio.h in the below files in the same android
environment as the previous version.

modified:   fs/erofs/zdata.c
modified:   fs/ext4/page-io.c
modified:   fs/ext4/readpage.c
modified:   fs/f2fs/data.c
modified:   fs/mpage.c

>
> More importantly, conceptually it doesn't work.  All kinds of pages
> get added to bios, and not all of them are file/anon pages.  That
> PageWorkingset bit might well be reused for other purposes.  Only
> the caller knows if this is file/anon memory.  You can't do this here.
>
I noticed the none-file bio's you mentioned such as the one in
xfs_rw_bdev() and fscrypt_zeroout_range(). That's also the reason I
don't define the macro in common fs's header file. It should be up to
fs to decide which bio_add_xxx should be replaced by the activity
based one while keeping others as legacy versions.

