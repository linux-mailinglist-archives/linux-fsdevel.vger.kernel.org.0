Return-Path: <linux-fsdevel+bounces-60297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3853FB446B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7081A4790C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A862750F0;
	Thu,  4 Sep 2025 19:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEs3WsgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F3242910;
	Thu,  4 Sep 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015184; cv=none; b=bZFj4sQmqgBbcFHDEXF/mDnRnEdgfBywtNwrbewKRZHAK3yP6dahVtlZ23ZIgSMb10ItPuilrUpR/OReNi63saVUcuGSTDjDkmEN1Vk2jVXhCOlk9vDlMS5P3KyOW4RW2X5UDJ0Z1MJ4B0qPCK2h5JybU9twWqHJHgcpDkzCSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015184; c=relaxed/simple;
	bh=Wh1L5XpgQJ5vOpxlqyelKTn6PiP3ejdECIGs5xjC8ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olhkTVZ8dMvtvA8MLjftgVCJX+gDEshmpdInLP5p1eQyCz65SD4ydDCjtC6X8VAahLFhBWckxD4GDNxpMRCVuWa0+ePakYPkQ15Rro4skvyA+JydZImuwVImz49ERvkvDoqIJ4y+V0IiFkZgwwgg2XeKjhaQWfdnlBfXKwq5wNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEs3WsgC; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b38d4de61aso18291581cf.0;
        Thu, 04 Sep 2025 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757015182; x=1757619982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYm7syom9MWBpuJ7zcZzkOxlRKn4XoKNaWWjP9biNPY=;
        b=hEs3WsgCOMD8euI+xTt35TFpW0p6KOHhisuD7CeWPY62eb/e8wEWUtK5/mQRHTEASj
         5GLLs5OBdjr12/XmS1e7KZjV5RQNHAbmJLCfKlUnLKrm2Dvc9AW3csGJqSWihYo1zQ++
         nRSkx+kXEeOWMPuD3Dgne2bFbvQAbD93PBSvUrbcGedXQEeXrvB/C1A716Hn7B3XWPtp
         Gg297QA2iM+/p03SVC17QtqXN1EvMMj1eHPzOpbRu1lJK2bYyW78bNY0E8Icq35rScBf
         v0vLrPEyGDey+kw52FDJpaLmgND7C0dbEDh6hOjXsRrQCCIMF1SOhOAoHkJQ033vtzDk
         JNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015182; x=1757619982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYm7syom9MWBpuJ7zcZzkOxlRKn4XoKNaWWjP9biNPY=;
        b=AcT5q1KifhC5AZAnjMyapMjcove6hFk3eS9w1vWOoy8d2oqisyIaLoXYtNzp5KBsLS
         RWudq04OQ7PY7mPQPBHXpJAae//5lP5PY83efBgnSIzt5e0Nov6vo++lzDb+D6VxA5oe
         2VWTF0dNCHcpuGY8rLpd/eEg0bkq3lGyF//ZYlk2hcgbbigE/OTTZDm750E/oELy+0b5
         2m7sCFc2LaZrGgnvSFWAk9Z3ULLc9n4aink7pcoEtKdHEqeIh6vlGgbz/zb9+/deIBpu
         qvbNoTqw+vj0lOM1GQLNDH99XygMFMAa32FLem01jDoyr53wIVVXiTEDgc7hkmY4rDdo
         VUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEVORU8LAqW8zP2/Q6igFUvyiqvkauktI27QzwfmwbKbpirRtp3zp9OJm5w8ABRdut8VWKudwZx8vXXngBZg==@vger.kernel.org, AJvYcCXX0N1RU56qIJ8hKoNgSd4YeayPiSDN1X9sflVblJ5fYyKSoq9/Y6OF6h0kEFNoy/j3e1IYJl2c1m32@vger.kernel.org, AJvYcCXlvKk4kjJbr3rUBy3W/2MgYV2wEepoto0I7vTEP0PKeekM7FncEB0rjgGk2oYDOLhX6Aa2wT3QLOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnY4C6Yj9XM6HE28TP32eibbClQ0+D4T+B88TW4h4CHZqYInwc
	d8Qw5lZuc+aTb1UkpbG3DooHYHA4A27S35FOdu53/XjuEXLJTYtirm5UbOPovtujuXkwe9V8Cjo
	yTKDG8mVd2yiGVgS001Y33iePCsXY1Pg=
X-Gm-Gg: ASbGnctMzo70g8C7Pe1j7fLikl0k/XBVAWhkEIJfPFHhTN6ZkFz5TC7DRwRE0G40W3u
	b/3ozmhq+MXzt5pPksVHoEp0wYg5UwqtssGlH4FMJ6DItPErZCD3rWQSgl/3To5LL5IV/5COTHq
	+UEDd/DgJS5aAPWfdoVQDDt+pKBS3Zq++EW4NPH3jJ55VaIFLNi8vShPuiG/ZUAH9eDAsCBEXYl
	WXiUa4e
X-Google-Smtp-Source: AGHT+IGFt3R6bT2vPfGlFjKRKndtT851pS99zx9hnN5QeiNFVSBi5KMA74rY17+dIQCUUFKEx8djF0S4sBoW0HDzc6U=
X-Received: by 2002:a05:622a:4008:b0:4b3:444d:d831 with SMTP id
 d75a77b69052e-4b3444ddad2mr159303211cf.77.1757015182203; Thu, 04 Sep 2025
 12:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com> <20250829235627.4053234-16-joannelkoong@gmail.com>
In-Reply-To: <20250829235627.4053234-16-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 12:46:11 -0700
X-Gm-Features: Ac12FXy13SRY4M405gjeOtKvNGp10QZZ6VbMtSyH5Rp4FAF1DkWbCGO8hD8JzNg
Message-ID: <CAJnrk1Z4Oeh_en+pYH9fmq_erNyxm=_a+YgusYY1Uf9uuxP7pA@mail.gmail.com>
Subject: Re: [PATCH v1 15/16] fuse: use iomap for readahead
To: brauner@kernel.org, miklos@szeredi.hu
Cc: hch@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:58=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bdfb13cdee4b..1659603f4cb6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> +
> +static int fuse_handle_readahead(struct folio *folio,
> +                                struct fuse_fill_read_data *data, loff_t=
 pos,
> +                                size_t len)
> +{
> +       struct fuse_io_args *ia =3D data->ia;
> +       size_t off =3D offset_in_folio(folio, pos);
> +       struct fuse_conn *fc =3D data->fc;
> +       struct fuse_args_pages *ap;
> +
> +       if (ia && fuse_folios_need_send(fc, pos, len, &ia->ap, data->nr_b=
ytes,
> +                                       false)) {
> +               fuse_send_readpages(ia, data->file, data->nr_bytes,
> +                                   fc->async_read);
> +               data->nr_bytes =3D 0;
> +               ia =3D NULL;
> +       }
> +       if (!ia) {
> +               struct readahead_control *rac =3D data->rac;
> +               unsigned nr_pages =3D min(fc->max_pages, readahead_count(=
rac));

This should also be constrained by "fc->max_read / PAGE_SIZE". Will
fix this up for v2.

> +
> +               if (fc->num_background >=3D fc->congestion_threshold &&
> +                   rac->ra->async_size >=3D readahead_count(rac))
> +                       /*
> +                        * Congested and only async pages left, so skip t=
he
> +                        * rest.
> +                        */
> +                       return -EAGAIN;
> +
> +               data->ia =3D fuse_io_alloc(NULL, nr_pages);
> +               if (!data->ia)
> +                       return -ENOMEM;
> +               ia =3D data->ia;
> +       }
> +       folio_get(folio);
> +       ap =3D &ia->ap;
> +       ap->folios[ap->num_folios] =3D folio;
> +       ap->descs[ap->num_folios].offset =3D off;
> +       ap->descs[ap->num_folios].length =3D len;
> +       data->nr_bytes +=3D len;
> +       ap->num_folios++;
> +
> +       return 0;
> +}
> +

