Return-Path: <linux-fsdevel+bounces-63908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A369BD17B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8209E34670C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5E2C11ED;
	Mon, 13 Oct 2025 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWCG7q2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEC215F4A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334181; cv=none; b=mBjpLrKM5DmV28wNwBk3UkAxS30xH1Vj5ovGk44/ZlDgW9/w5a/xVedAAkE5n8ZgeHn6QcMfUdxBuBjQDFoEfK34p7WRROMyV2a6+aCBMc/iIuzpBI/KBmlUx5KGT9g9KeQfQ5pMVFkGjVo+NcMiaitFHRSJc3828m1+ZRuqYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334181; c=relaxed/simple;
	bh=LkiHDxUpll20Mzzyjyp6GAradkAWV81/VhYmzsLwOLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZevzshsMu8vLuWNNNmXwIYtUhjQkCXA52GLByIQnYDLHyDABQ3Y8X9ShjxwykkwWfyhl6bdF+sFsO/B90yfAUIby8WIRgTAOaLPIEWvEKalF+FKoiT8QMwHl3zcCysPuu1eUPxmzGSBzRmXo5gg1rP/4JKkLSie218S+0ZqeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWCG7q2p; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so1272763e0c.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334179; x=1760938979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFw8GX7he7wIYguaN9JzvQNXMrk3Z90u5aRFTT7c2yU=;
        b=IWCG7q2p7ncp3CeE2O5Slzpe2mNztlvZhmi9ntpDYMpxLGBvuzLRHSH+ncBuJYaKD+
         jzc6ucI6ohY6D/Iica3jWOpZd+lh0UGTNdAzv30lo68Fos9U3jAC+xcC2jHVIp/qaQH4
         EKmTWoWaxx1XGMIAKWpSuyQBq+FQggTp+T2YRLmhhPAC1WDFsCEaklEKKoc3gnGZXfyM
         VxHlzrORf8boipLV1lThncDGuIYq55L9vVWVlvLFid8Y81xCaMzjT7xFu169zTPqSlYy
         ot8bM/NL0/yxTgbiqrefFX17lVANYxojBoKcYczeWjOU2o26WB8fcrBiEP6ApN2kkmmZ
         L4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334179; x=1760938979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFw8GX7he7wIYguaN9JzvQNXMrk3Z90u5aRFTT7c2yU=;
        b=pyswBZQDG1Vgn6om1WRjaB3ZS/TYWqbTnYk/wlp+iH89T1rfWZ3A3AjKs5LSY4Eca+
         5ZdJH3NPljv5QBV/qmZvnyl5wngpAv54ZQ69HffByocXB1IbpUZ75ZeQLeevmwshi1hw
         vJGU1F8rkB4XrjOL6Z6sEm4ZLkI76WGHpRv8auz9S8DKAzSQRmzslnvRse6ADCmW/RTE
         FmUdskb8IUKMRv61bS8ZIYVr0QzheeCiN3vOqgcpZYIBZSZc3n/bUid3iRxZyhkdy0lL
         SZ0iKQUG/l/uys2uAexDoqmPp1subg2NEwJdcF5RxWyCr94jUwvnGysdD6n7CU7d1GrC
         /Emg==
X-Forwarded-Encrypted: i=1; AJvYcCWFeiHY4iyucqISksPujmEHKuUgLqx/48QhrW8u9+CJGXlO5A36GQjb0VJd0oCrG0p9coI9q6dhcw+/fkcZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yznt27bVecy65pj8WEN/pXp4FJ3bW7rW4/8wPXL28bFvnOmZtsz
	cG4bhimoFzbMdwQT6U53fipBVOzIaKjx0GHQ+YObCLoEJ28Li939ntB3PN6qyIBbB2YcbTW7VfS
	P/ovT0UdqoQx6LD0OTiaG8JHmHF2dR34=
X-Gm-Gg: ASbGncuhlA2kafjQp3LzkOKJTTCKFj5/KHoHhmta+KnDMfVGEQa3SFg91h8/lwMmJa4
	tV801dDA6ucW5vWFNLfTnRmDHeVEAIztB5zNHxR5KQocSdsl+bqEJwS/COexkvCmP3415MKxeuX
	Yu5oM9/nA+Jlt7gXrHqO4QgXHILh6oi4hxiORUXNTj3NN3zgt9klZH+fSJVCdCqJ3Tnjr0Tx1fv
	+1h28jWhuth0O2+maQZCnbzy4SroIGCd0Lg6w==
X-Google-Smtp-Source: AGHT+IE2pzpIXFUlQnxpSAUJmDsWbuHYPNEdEfC1GOsG6qkn6Ggw30mR6TSMqPTmSaIF0L9e6DD5b5ldfGpQurArkk4=
X-Received: by 2002:a05:6122:91b:b0:545:ef3e:2f94 with SMTP id
 71dfb90a1353d-554b8aa8d4fmr6241006e0c.1.1760334178612; Sun, 12 Oct 2025
 22:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011013312.20698-1-changfengnan@bytedance.com> <aOxxBS8075_gMXgy@infradead.org>
In-Reply-To: <aOxxBS8075_gMXgy@infradead.org>
From: fengnan chang <fengnanchang@gmail.com>
Date: Mon, 13 Oct 2025 13:42:47 +0800
X-Gm-Features: AS18NWBq65kKS67xgSwyGWf422mFA-TjXvUExYQYDBZ5JznD-_4en1JwPHXcFWo
Message-ID: <CALWNXx8pDOvDdNvw+v0rEyi33W8TL+OZW1YiFbF6Gns3PeWOLA@mail.gmail.com>
Subject: Re: [PATCH] block: enable per-cpu bio cache by default
To: Christoph Hellwig <hch@infradead.org>
Cc: Fengnan Chang <changfengnan@bytedance.com>, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, asml.silence@gmail.com, willy@infradead.org, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:25=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Sat, Oct 11, 2025 at 09:33:12AM +0800, Fengnan Chang wrote:
> > +     opf |=3D REQ_ALLOC_CACHE;
> > +     if (bs->cache && nr_vecs <=3D BIO_INLINE_VECS) {
> > +             bio =3D bio_alloc_percpu_cache(bdev, nr_vecs, opf,
> > +                                          gfp_mask, bs);
> > +             if (bio)
> > +                     return bio;
> > +             /*
> > +              * No cached bio available, bio returned below marked wit=
h
> > +              * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
> > +              */
> > +     } else
>
> > +             opf &=3D ~REQ_ALLOC_CACHE;
>
> Just set the req flag in the branch instead of unconditionally setting
> it and then clearing it.

clearing this flag is necessary, because bio_alloc_clone will call this in
boot stage, maybe the bs->cache of the new bio is not initialized yet.

>
> > +     /*
> > +      * Even REQ_ALLOC_CACHE is enabled by default, we still need this=
 to
> > +      * mark bio is allocated by bio_alloc_bioset.
> > +      */
> >       if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <=3D BIO_INLINE_V=
ECS)) {
>
> I can't really parse the comment, can you explain what you mean?

This is to tell others that REQ_ALLOC_CACHE can't be deleted here, and
that this flag
serves other purposes here.

>
>

