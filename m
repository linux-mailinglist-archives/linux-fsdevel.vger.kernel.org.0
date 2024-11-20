Return-Path: <linux-fsdevel+bounces-35360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C89D435D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 22:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D9B22518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACD1BBBF8;
	Wed, 20 Nov 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Kdydq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB02F2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136858; cv=none; b=qqLWi+lIv9THooLV1ylnsyD3DoNWqGxOHJp2vJBSrg8DCHYYdDvFXu8COgwBftgwCRBQrFTlYz7vvDL93lcIDNtkmAlyto0+m8tVOQmDNX0B7bsX462cW8dnZM9V6uzke35M0sF2fJfEt61I+fNdcTJzMK/rfiiqIbdDZWrpKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136858; c=relaxed/simple;
	bh=o0kM4WpzxjOE+TTwQiPJgsEKfBMkSUjEw1ErzVj6ukQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFHpfZHc/jZNPJOkBy+Sa8BpytIDsCvHAANyd7/BKpzjsuADE8NsiR0dnQWYubIpKXmbANd9nrxvUimkfxlEMzI3BN1vcDpxiIqWi2qcRkHfXR50Dxzm/RIoItYGy4adgWSgzaQiB6urQM/ivmvDpqCdY0bMD7bERkqPt2sallM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Kdydq1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eeba477fcaso1449557b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732136856; x=1732741656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBMvOP94zwi3fROmHLGUx12WWNWVxwWf9yDwt17V2Bc=;
        b=B5Kdydq1h1qbaynxcvH0Zujla+OvaYMshHwSaPH7sESPZBoi57kjs7t1ieY7n7L8Yt
         4kTQv0DpFFl5wGqBgdCGjvhR16M5wlOlkIttYenE85LMEtFQuSp+UAY5g/KAQilt/YH2
         h8xgamNqZg1ch7Li0cbtwY7OOMZlLfehYGw/rrq41zbFZrsHLzwO53WbRfQ++K7MlhIi
         wejG/fiNZx/JI/K/vO7ut9comAIHQADHzKteID9kN0xzQE4MvMQPA+Ru4daC5TmsM/EP
         BIpmiQeikp88TIS1XLhJCd5J1/59XJKFn3V1pnGeRf9G3ptypRRKgxgeAs1x4QAsYxIC
         /V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732136856; x=1732741656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBMvOP94zwi3fROmHLGUx12WWNWVxwWf9yDwt17V2Bc=;
        b=fz+ysL4o9KQiNWdc9trc0OXolCqNgf15R1KaJeACRhNiwW2/HVEUgxEp3T7B+dYCid
         7hzT2jBxFSH1Qh5QepCNkUW4VBGu83gMoH6ur6Az56Q3zoOUhiKibqClUyZVQY/ymsz4
         OpXDEZS6n+FhAO3x2zP6uyIn9RfEQN9izZQl53tGw61nXGvZnpHw2IpfreEECjv6Cra+
         o6O+jQln6WOFIQCUpRVt4zYs9Z80VS36bitq83PmhKC8EaUPuMyy8lmU/NtyqrVxqmyc
         Mmj/vv7SMzVxvonKiuZ/S4LLnpL4oIut6kfAwIsrSnVIRntn6v7CNs89usSbsQZfW045
         xnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmLs2mjk65j6IxhMYOZJZh8UQEAvC3Dpzv6bvxWimYWiLu7dtFdsJBboEiC8gQDlFf0Wpf6HkikRgTPFzB@vger.kernel.org
X-Gm-Message-State: AOJu0YwDW6CNi6ET1bXGfuOVh7duOp81z8ijoWiNWD1dWxGhkHESg0kA
	xiDZVoPRuH5yvMsDrgPuVc75rTsdYzBeUuExv+jnqM7ac0TV1bnIz3PkBgu4LbCxuf0cS3T4v1C
	K0fTMT3ceId93T6rbudLmzPiqiOE=
X-Google-Smtp-Source: AGHT+IHD9mzTR9i+dHkUlYMfrhSKLKR6mnnoGUt2cVCPV1N+PwUFekfxDW+5GGXbKwAPZyDMiMqdRPtE0XMatA7qmT4=
X-Received: by 2002:a05:690c:9c10:b0:6ee:40f0:dda8 with SMTP id
 00721157ae682-6eebd2e2271mr54827807b3.30.1732136855903; Wed, 20 Nov 2024
 13:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115224459.427610-1-joannelkoong@gmail.com>
 <20241115224459.427610-6-joannelkoong@gmail.com> <89aef56a-6d1b-449d-8fbc-94d305bae78c@linux.alibaba.com>
In-Reply-To: <89aef56a-6d1b-449d-8fbc-94d305bae78c@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 20 Nov 2024 13:07:25 -0800
Message-ID: <CAJnrk1Zn4Ua3E3-CFnyYY4JGD11J6kaV6SExBKPO1KHRbdaLww@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:59=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> On 11/16/24 6:44 AM, Joanne Koong wrote:
>
> > @@ -1838,7 +1748,7 @@ static void fuse_writepage_finish_stat(struct ino=
de *inode, struct folio *folio)
> >       struct backing_dev_info *bdi =3D inode_to_bdi(inode);
> >
> >       dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> > -     node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
> > +     node_stat_sub_folio(folio, NR_WRITEBACK);
>
> Now fuse_writepage_finish_stat() has only one caller and we could make
> it embedded into its only caller.

I'll make this change in v6.

>
>
> >  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > -                                       struct folio *tmp_folio, uint32=
_t folio_index)
> > +                                       uint32_t folio_index)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >
> > -     folio_copy(tmp_folio, folio);
> > -
> > -     ap->folios[folio_index] =3D tmp_folio;
> > +     ap->folios[folio_index] =3D folio;
> >       ap->descs[folio_index].offset =3D 0;
> >       ap->descs[folio_index].length =3D PAGE_SIZE;
> >
> >       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> > -     node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
> > +     node_stat_add_folio(folio, NR_WRITEBACK);
>
> This inc NR_WRITEBACK counter along with the corresponding dec
> NR_WRITEBACK counter in fuse_writepage_finish_stat() seems unnecessary,
> as folio_start_writeback() will increase the NR_WRITEBACK counter, while
> folio_end_writeback() will decrease the NR_WRITEBACK counter.
>

Nice find, I'll make this change in v6.


Thanks,
Joanne
>
> --
> Thanks,
> Jingbo

