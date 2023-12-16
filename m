Return-Path: <linux-fsdevel+bounces-6315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DF815B00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 19:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A7D1C219EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 18:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465731A72;
	Sat, 16 Dec 2023 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9jmdFDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094E3172E;
	Sat, 16 Dec 2023 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db99bad7745so1435840276.0;
        Sat, 16 Dec 2023 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702750627; x=1703355427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvRVmZz0fw4sy81ISwg0UmUCzFZE4mCNoPdzHScTDrI=;
        b=i9jmdFDq3mTzHWblmX+MWiK35gxF0zci04EM4L8xa0yrvNP4n36bb7oC9vQ6EVYtD/
         m32x9SvC/IbYgPChVnogpk8NURIwV7pP5pY64VpfC50sii0w5ol5Q4rKoBHmHVJ+uBmS
         VJa8rg3di5KMchkhfrsJ1+O65TJgt899jT7bgn92j5QSEST3CYRDlG3uhBqiOT9esv8F
         IoQRFvtMYKf+HQQOu/08H1sHjzfB+lMIVrEvj+THEvMwlIWkx37yFhhrcsOcX+OxZt3z
         OkmddB26/t5PvN8hIDmlMtozDIftEyn8ch09SioLduoPrhfDJhIX4j7f3emBc3Mb1oAr
         73OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702750627; x=1703355427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvRVmZz0fw4sy81ISwg0UmUCzFZE4mCNoPdzHScTDrI=;
        b=tQ8m3/KXSgyZ96WxmFlTOHPKuJipYNkZ4VbmQlvQXlKMjRmshH8K70pRgThkm4ChkJ
         w/d2QsSdqMqz/DnXhXvCzC8aAkrkn478vDuAzvYlqz1QxGd8aIpI8hfebU+rMnWEF2q7
         d/ICGw+1/4/IqGo9fbjJphEP9U2CCfWt5epA3tit3/+ubb+cb+K8mYFWlRtUGEOaq1st
         HRzKA5MqM7U6tTpkw4aog16xgTSl4jthhdyuQOkOk6EJ01eODEMCwH7fvKArVJU72V/2
         sLdCAKb2G0moakYObLHMFmRiepF+JMEiIXnfWwSNAEocMGhMGTQy/pY/693rMOOKONqE
         Sugw==
X-Gm-Message-State: AOJu0YwIS81zT16VfbSm8rJvs2v4c2jw3IjJHRZH29HI6S5cTP7YVlYw
	px147zSP69NAWf2RyFpdGRTQTmfFvBYCRH14+qw=
X-Google-Smtp-Source: AGHT+IFn9alYrc6pyynJlC3AzJi9+jW7Hyc4Xh9rzrTv9HUyVpLWeYI0lwWtoeqlkhu4lV+c1wb6aazE7dSYi/iN6fw=
X-Received: by 2002:a25:5f03:0:b0:dbc:1b67:e358 with SMTP id
 t3-20020a255f03000000b00dbc1b67e358mr8995770ybb.95.1702750626697; Sat, 16 Dec
 2023 10:17:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206100253.13100-1-joshi.k@samsung.com> <CGME20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7@epcas5p2.samsung.com>
 <20231206100253.13100-3-joshi.k@samsung.com> <ZXpWOaxCRoF7dFis@kbusch-mbp>
In-Reply-To: <ZXpWOaxCRoF7dFis@kbusch-mbp>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Sat, 16 Dec 2023 23:46:55 +0530
Message-ID: <CAOSviJ2U_yTgvx5SBPvkOg0nZ8wNxRCJyLWZ_zBnN74HcDFA1A@mail.gmail.com>
Subject: Re: [PATCH v18 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org, anuj1072538@gmail.com, gost.dev@samsung.com, 
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>>On Thu, Dec 14, 2023 at 6:41=E2=80=AFAM Keith Busch <kbusch@kernel.org> w=
rote:
>>>
>>> On Wed, Dec 06, 2023 at 03:32:34PM +0530, Kanchan Joshi wrote:
>>> >  static inline bool bio_has_data(struct bio *bio)
>>> >  {
>>> > -     if (bio &&
>>> > -         bio->bi_iter.bi_size &&
>>> > -         bio_op(bio) !=3D REQ_OP_DISCARD &&
>>> > -         bio_op(bio) !=3D REQ_OP_SECURE_ERASE &&
>>> > -         bio_op(bio) !=3D REQ_OP_WRITE_ZEROES)
>>> > +     if (bio && (bio_op(bio) =3D=3D REQ_OP_READ || bio_op(bio) =3D=
=3D REQ_OP_WRITE))
>>> >               return true;
>>>
>>> There are other ops besides READ and WRITE that have data, but this is
>>> might be fine by the fact that other ops with data currently don't call
>>> this function.
>>>
>>> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> > index 7c2316c91cbd..bd821eaa7a02 100644
>>> > --- a/include/linux/blk_types.h
>>> > +++ b/include/linux/blk_types.h
>>> > @@ -393,6 +393,10 @@ enum req_op {
>>> >       /* reset all the zone present on the device */
>>> >       REQ_OP_ZONE_RESET_ALL   =3D (__force blk_opf_t)17,
>>> >
>>> > +     /* copy offload dst and src operation */
>>> > +     REQ_OP_COPY_SRC         =3D (__force blk_opf_t)19,
>>>
>>> Should this be an even numbered OP? The odd ones are for data
>>> WRITEs.

Our request opcode needs to be write based(even) so that while forming nvme=
-tcp
packets we send this as part of the nvme capsule.

But now I think this design can be simplified as you suggested, if we align
COPY_SRC to even and COPY_DST to odd. This requires us to change the design=
 by
sending dst bio first hence forming a write based request, followed by
src bio's.
Will send a follow up series next week fixing this.

Thank you,
Nitesh Shetty

