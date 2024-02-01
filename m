Return-Path: <linux-fsdevel+bounces-9800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520E845008
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 05:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9557EB214B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738BD3B7A8;
	Thu,  1 Feb 2024 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inOwgJO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5033B197;
	Thu,  1 Feb 2024 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706760338; cv=none; b=e06EUisOP7FSUe2EC83LRebdEXXkFeWt+cGu3xqquKI1vsjzbo4L5JhZAGON4BozyLP02YHt53PBxUzEcta1cgiqVr5U4osKXWXAf8KF4MAVvTBZHiXiXzkW388kzgH5hAV1CaXcYArAS0MzI+seULLnP5jAiXPk4hm/9FjMRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706760338; c=relaxed/simple;
	bh=JEgdm4dXi+L1DQzTB3h/avDvAmCbRi6xV/Fe7blQnM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0DvMm4PrvLlYQd6PIe99gL030idgASLz1ioljN4kyxsvvrolbG0PB4FDu8ChzCRwkGnzSREL2VZwaMJ4pza+cRpSAdHn7ebkJN6VSnuHUD9+Qqr8P+1ssRcvvGBea/0FrHF4t5CduDmyD1OPC8i8G1c1cQDOyd48mYhs07l5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inOwgJO1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5113000a426so123360e87.2;
        Wed, 31 Jan 2024 20:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706760335; x=1707365135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVtZzGrAZ7Rvq/x504vQLLiqx/E0QPJtNjyDBer37qU=;
        b=inOwgJO1klhdL9TwB5BnVudeeJjDIIzKOdrSnBjwTANvTzLvHWNsIrMnkGJZAWdQf4
         O7gnXG6qxAzD6iZcITQNn06BLPSjsXnWvbI74OiZNM2XjZG2IBSH6nKmXimGn9Xue4/O
         TpWsbFujOC57j71E26ccBR2+Y6UyKVj9n616zPfxeW2LKVieYUgJ7TRzDRE3byrJHHpb
         /w2DlHWs3jfZcTEHGtCwo7cyb30Q0A8w5UeX2+4OTFfkm2IPC2aOJYY207PTO7+9tDq+
         HSgCQo0o6xgNUcCf+5g6SNi7K2mpCcAx9aal+GQ7ev8GPQVcodwxgI7jQ6oLmT84PhGE
         9goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706760335; x=1707365135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVtZzGrAZ7Rvq/x504vQLLiqx/E0QPJtNjyDBer37qU=;
        b=d10cw77yq9F+JzI5MDBdmR8H4+YfVgYUNl6E9bu65ze+iaPUnSWBYZEOi/3eJN7IEM
         ZzFKmmCAaK9P8SSIgyQkzVxiG/9y1XavPq/TqE5h9Aku7FHhAhBSAK5BZtaEMTtccuAg
         vbuvaLAfx3MQEfiUfEeeOrjs4oejf4S7B4wylPBXxhv1OGRsVCOIhFGa8KgYxTQyA5Rr
         VmGMF44I2ru+LWNbmJUP1PsGWia2R3jI/8WjGzPc4eP5QvNyss/HQ1xE+Ws9669+UCXI
         yiZyPsUtrRRHKpDV0yGbxa5DErNvCk2iNzp5TQaE1rAbdacbIE15B9T2CGUgUjbWrVlZ
         fO5Q==
X-Gm-Message-State: AOJu0YyGPC1gX4rbwssuj7Us7yyy0HGuTLeu4f7eyhIkFzboKJCV20Ax
	I/4mB9qpxGm4Qle6m4PF9ohaaN1wf9CVaQuSIjOo3DAwIHbK75aqusYOmblhGsQwD6VoqytpdWb
	xVWrdKZ65adK7FtuqldpiVbjaPRc=
X-Google-Smtp-Source: AGHT+IHpnc3L5drGX+KAL4BK4m0LBZFIPEWSaWzqj8aEDtJJKuyCfdXo2Mh+7dQM3JkU4FRcmq161BRCmppHxt3f2KY=
X-Received: by 2002:ac2:4550:0:b0:50e:d1f9:ebe0 with SMTP id
 j16-20020ac24550000000b0050ed1f9ebe0mr1110331lfm.2.1706760334966; Wed, 31 Jan
 2024 20:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131105912.3849767-1-zhaoyang.huang@unisoc.com>
 <ZbpJqYvkoGM7fvbC@casper.infradead.org> <CAGWkznGLt-T1S7_BM8-2eLhxVYktYYLmdfMbRKRK88Ami-mEdg@mail.gmail.com>
In-Reply-To: <CAGWkznGLt-T1S7_BM8-2eLhxVYktYYLmdfMbRKRK88Ami-mEdg@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 1 Feb 2024 12:05:23 +0800
Message-ID: <CAGWkznEv=A1AOe=xGWvNnaUq2eAfrHy2TQFyScNyu9rqQ+Q6xA@mail.gmail.com>
Subject: Re: [PATCHv6 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:39=E2=80=AFAM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> On Wed, Jan 31, 2024 at 9:23=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Wed, Jan 31, 2024 at 06:59:12PM +0800, zhaoyang.huang wrote:
> > > change of v6: replace the macro of bio_add_xxx by submit_bio which
> > >               iterating the bio_vec before launching bio to block lay=
er
> >
> > Still wrong.
> I did some research on bio operations in the system and state my
> understanding here. I would like to have you review it and give me
> more details of the fault. thanks
>
> 1. REQ_OP_ZONE_xxx
> a. These operations are from driver/block layer/fs where we can keep
> driver/block layer using the legacy submit_bio by not including
> act_prio.h.
> b. most of fs's REQ_OP_ZONE_xxx will be handled by blkdev_zone_mgmt
> which is the same as 'a'
> c. __submit_zone_reset_cmd within f2fs use no page for REQ_OP_ZONE_RESET
>
> 2. other REQ_OP_<none>_READ/WRITE except REQ_OP_ZONE_xxx
> These operations all comes from driver and block layer as same as 1.a
>
> 3. direct_io
> keep fs/direct-io.c and fs/iomap/direct-io.c using legacy submit_bio
>
> 4. metadata, dentry
> Are these data also file pages?
>
> 5. normal REQ_OP_READ/WRITE/SYNC
> fs choose to use act based submit_bio by including act_ioprio.h in
> corresponding c file

OR could I restrict the change by judging bio_op as below

+ if (bio_op(bio) =3D=3D REQ_OP_READ || bio_op(bio) =3D=3D REQ_OP_WRITE)
+ {
       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
       bio_for_each_bvec(bv, bio, iter) {
               page =3D bv.bv_page;
               activity +=3D PageWorkingset(page) ? 1 : 0;
               cnt++;
       }
       if (activity >=3D cnt / 2)
               class =3D IOPRIO_CLASS_RT;
       else if (activity >=3D cnt / 4)
               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()),
IOPRIO_CLASS_BE);
       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(class, level, hint);
+ }
       submit_bio(bio);

