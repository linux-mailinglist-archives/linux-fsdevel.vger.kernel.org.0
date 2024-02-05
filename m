Return-Path: <linux-fsdevel+bounces-10244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CC84943B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AB91C22678
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 07:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D610A36;
	Mon,  5 Feb 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD4uWAwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4F10A0F;
	Mon,  5 Feb 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117210; cv=none; b=rgmFsOk+Bet6liylhjXQu83CRMiDkbBSFCnm6Yd5sYG24VGSCbKonVXOEpYdYhAnNJic5T0iSY2wQkVh7PIYZU4hB9AVHl9ZFmeLWtPRByBfq9r2cG8D+Fb22qrQtGCjB1NB257wZ560ybkMr34D+IBFTkZ3tK7pBXkAQA7PocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117210; c=relaxed/simple;
	bh=KwZ6ZUL4GH9pcE1E3bsij3i2NlW5OXE/LgsbIWtrDMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJT96xHPDkMF3w9FuIISEmRGph8eDoszPN+zgOpqievMjCpIn9ZlncxltZKOHbJUOYWqgzRN2kDgSjEAFvXY7Ca79X5stW/G77+Y++0QBN1VUgJaGudDbKdGs70ugZkLaSB2z7rf4YQg9lKm+gG+vFHpGHd04vt4JazlZIBWVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD4uWAwq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eac018059so4777601e87.0;
        Sun, 04 Feb 2024 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707117206; x=1707722006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHJRD9nhC42iXy6/AgmiQizAEmZmEWrGd0gXlD0+r9o=;
        b=OD4uWAwqerKJRZ8h/Ev/9UGtO/lMLqw3iUL2gmJd47zy81dniRam/U1MI7dhKZ1Fzp
         4RAMVCfsYd5Uf5jVl4r6m+svDV27vEHfIHnr305quzNyxafcAhVqlO/Pja3chWVs+S89
         0TAIGwoQkvAc1cs+teCW25/6/OoN+eXdGwxsufTWC3uOWrKwrMdy61sMKzGVSE78xGbh
         pQH5Lv4VXoC6R2V6lyHZIq3OZPDmKZcQABtULR4PbG+H+ptBsmvawCYyvZ8HDOk4/8Rz
         +gvbFsWEX3tmmi6K7nmTUHhNwLGuROU3MI5N6VDtIAXnDzBgEK6aDbU+cqTD4PKFeNs2
         N3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707117206; x=1707722006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHJRD9nhC42iXy6/AgmiQizAEmZmEWrGd0gXlD0+r9o=;
        b=LCCF5fdCfEG7t/0KXOI5pcAI28FYuFF5JUX4dZaFKvuWrFg+A7JDhnqY0gMTQ69Vhw
         yPpKAk6a5GwuDGAGMRNe9X5k3Iw7QQgAhvCyq+OJqGdH5OOOYAMz77AUium75CRGQeQ3
         3Cop0NQ7HSzFB7JpyMqXEgZyam/X+6+TP+irMV7KplozBx1LoC9GsV545Agfeo90dmoY
         zK/CDUSrXy4h5uz4OFzVNCbJ6PFNREM/Yy9+ZncMjNe/QMLYkYw4DwdOwCBJ2rvbygly
         Hhe4kenWfzGgxv3rio95T0/omINWLyuo2jOtrs8qOx0J3AVLWWaFLR5Lxd/Itj8qjKPi
         xW1g==
X-Gm-Message-State: AOJu0Yyj4bUVvRVIbIjeruLOTaaez9cIwiGRfE5To6AKCcTkZAkLhGd4
	/NiYFO9osPISAG0EO6mP0q49XYgxr18RQdZf8BocvLEK5aqK/uVaqMTheKc0UALFdJyyuJM7tLB
	PUp8b7v+w5k1tcDfK1tAINY9Dg7g=
X-Google-Smtp-Source: AGHT+IGXTqQCTutqGkW5n9adof2HS0J2aMGibZMF4hMkYwX1+YX9XmtIA03f/5XHngC3HYqNapIcvRWB1D55d3PuX7o=
X-Received: by 2002:ac2:5de2:0:b0:511:5423:848d with SMTP id
 z2-20020ac25de2000000b005115423848dmr319963lfq.60.1707117206548; Sun, 04 Feb
 2024 23:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205055705.7078-1-zhaoyang.huang@unisoc.com> <ZcCJbtX3xwBRCqYJ@casper.infradead.org>
In-Reply-To: <ZcCJbtX3xwBRCqYJ@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 5 Feb 2024 15:13:15 +0800
Message-ID: <CAGWkznF2EeLFyKqDP1EMgKz333TyS-pA8+9-KdDLTuZyD1C==w@mail.gmail.com>
Subject: Re: [PATCHv7 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	Yu Zhao <yuzhao@google.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:08=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Feb 05, 2024 at 01:57:05PM +0800, zhaoyang.huang wrote:
> > +/*
> > + * bio_set_active_ioprio() is helper function for fs to adjust the bio=
's ioprio via
> > + * calculating the content's activity which measured from MGLRU.
> > + * The file system should call this function before submit_bio for the=
 buffered
> > + * read/write/sync.
> > + */
> > +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> > +void bio_set_active_ioprio(struct bio *bio)
> > +{
> > +     struct bio_vec bv;
> > +     struct bvec_iter iter;
> > +     struct page *page;
> > +     int class, level, hint;
> > +     int activity =3D 0;
> > +     int cnt =3D 0;
> > +
> > +     class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> > +     level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> > +     hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> > +     /*apply legacy ioprio policy on RT task*/
> > +     if (task_is_realtime(current)) {
> > +             bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(IOPRIO_CLASS_RT=
, level, hint);
> > +             return;
> > +     }
> > +     bio_for_each_bvec(bv, bio, iter) {
> > +             page =3D bv.bv_page;
>
> I gave you the prototype:
>
> : No, stop this.  What the filesystem needs to do is not
> : s/bio_add_folio/act_bio_add_folio/.  There needs to be an API to set th=
e
> : bio prio; something like:
> :
> :         bio_set_active_prio(bio, folio);
>
> Do not iterate over the bio.  Use the folio provided to set the prio.
ok. I should miss the above information. I will update them in the next ver=
sion
>
> Or is there some reason this doesn't work?

