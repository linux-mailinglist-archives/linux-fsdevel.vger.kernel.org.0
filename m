Return-Path: <linux-fsdevel+bounces-60221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31812B42D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 01:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AD91C22D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C953002A3;
	Wed,  3 Sep 2025 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iibGvN29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4762BDC1D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941192; cv=none; b=oE3RY2VFX7pKRS2Bxf7pYaRgra1MsbLj10sgVB82xWdOayCg+fGhWBBvph7oDR5whDmzECtsKnzoc2Xj8heyM2j1tnkWwRQQKLTQRMb7vNxfOJPLfCbTq5YKt8AXKmg25LNTuMpHEPmjym86CvDhWPGeyTSQts+SwgWgZkFmg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941192; c=relaxed/simple;
	bh=Nq2WdkKqG7EfTDxOQlFfyszo3tlI67WEzvwkU/ybGrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi4zcuqi6D3xlUUze/C3eMi8IRyxYLkWoqJG5BhZ+WTkCYDAqXgDvnqD5AaW9B6GnTeHj26w0ATjZoRHu0NNomAk9eU0JS085OjmAe3dICAmPYn7I6CW3ZzRnQFYPMBFU3HcRCkhNu5gDUcRs1yM3qcGYQR86GsRf18XzaOPQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iibGvN29; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70ddd2e61d9so4304856d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756941189; x=1757545989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGxTBfrf5rFsONCC9HJBGQ/kdfQbCEnToA5Y48+NVH8=;
        b=iibGvN29u/iexTH/TjNprynJqiFXN1J6Spft5vgMzBOx4x7XEL2LaEFv6M/8bxbVSQ
         NmRdnoLxNFYh/g4KBX61xnnptwvmW/TY4/v9IyQFkMHT+xZ19WKyFDvlEtQcStqyueXl
         SX2shmPCu+r/5eQ8OEPL4kRCcBTpnilCm7KmqVb/8Npjrmth0l/9RKdXe0aXF7u+4Oxm
         DPkP18dy7ytElWEhapXvb+Bq7K9oBtpqZbSnqmOgTrqP3mxRetoTIOi3Jx+AioC1QkyL
         jEHtsKUNdUUH72RbXukG4QbwOFxrFY6o3LSAo4/4KSElI/4TKQhl75tF1K8S6zTNEDrC
         De0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941189; x=1757545989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGxTBfrf5rFsONCC9HJBGQ/kdfQbCEnToA5Y48+NVH8=;
        b=e5jczxOVhzqnMRhEKy3jxZia8MRvwWo3o3s3/v/jIFSLo4YpnfvKA5Cd8TSzvkaKEK
         QNOmPk693RIdd2gNIOVcMF3cMnNyWzEJGP16pf3FRVLBKcfi/Raqk8w1y8wWh9c0WsSD
         whSl+Xo7zHIMtLhXq8hz/vO0Ej21meFrtwVwtntlTJZDqzaNbkxi3KF4BFmZEU1PhBz/
         YMxxiQKD5+BSOBf0PuV+aUsAuWj84pqS4CC/N1MtHQvy0eIEbInISSAUkdoYX9MGnFaj
         L5H8p5dEqXOeW9EWLY3usgpYRP3jm2qq3YOPJYjTuEFZac9qeFt2zLiyrU0FDQkpLMRS
         sQJg==
X-Forwarded-Encrypted: i=1; AJvYcCUH9W/S0QVkT3tygNAko/Hr2ZRO4B9nMMnUR4q2wGEMlvkS8TRVXe7UEfdE4JEW+e3+lcphzWagkDs+jSiY@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLoCcYMxuD3PavTRp3cHYpTlMde9/mko4hruKo6O/X7HJOE5d
	mYiOnT3HhFoCsYr7cOXoSJ5Vn1qIpKEQUTrjKVulnNP52R7C56ZmR/XwTtbaQkhaW33Q4QkHuTx
	a98D3Mq/WwPkoayfMOwpV1ivdyEkJUmg=
X-Gm-Gg: ASbGncuzoi2wBDyPKAT8ecPL3PrSfSyQfD9uez0FBWCdJJ4muXaj9P8dlMoYZB4WQgh
	DVilshetYL5y3gpdnw/jhlziJucPEj/EeZtLZ4TZN1QDOqqLgitQw+YtJanCm4jsvIvzzvVZeot
	j5V6ls3YDiH1U8XHn7s1iPHnnfqth6loMETEUojzGMpsmvGUbnEiqcFoLy9WPfcBw8vzyBOkfOr
	4Zetpjo
X-Google-Smtp-Source: AGHT+IFpau2abrWRbQ6A4uKGUrJfNNMVYMekyYwLs3CQEfWWKl3J8XeYxo0PNci/3ZoHXqJZ1hj9M4S7craopEe6L+s=
X-Received: by 2002:a05:622a:1214:b0:4b3:10f0:15cb with SMTP id
 d75a77b69052e-4b31da3fe45mr211322051cf.38.1756941189320; Wed, 03 Sep 2025
 16:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-2-joannelkoong@gmail.com> <e130c95a-103c-40ba-95d9-2da4303ed2fd@redhat.com>
 <20250903200210.GJ1587915@frogsfrogsfrogs> <701a1718-fddc-4ae1-817d-d9549ad71a09@redhat.com>
In-Reply-To: <701a1718-fddc-4ae1-817d-d9549ad71a09@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Sep 2025 16:12:57 -0700
X-Gm-Features: Ac12FXwgoZxlIzrq8oeC0r9blKti-Fhf4qdYBK9a6mMv6r07wm-GvRIqwEqP5kg
Message-ID: <CAJnrk1bxDbDv_7QTdv9wXKum11t-hk3cU6wQ01NB4bPvV2HWUQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm: pass number of pages to __folio_start_writeback()
To: David Hildenbrand <david@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	willy@infradead.org, jack@suse.cz, hch@infradead.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:05=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.09.25 22:02, Darrick J. Wong wrote:
> > On Wed, Sep 03, 2025 at 01:48:41PM +0200, David Hildenbrand wrote:
> >> On 30.08.25 01:39, Joanne Koong wrote:
> >>> Add an additional arg to __folio_start_writeback() that takes in the
> >>> number of pages to write back.
> >>
> >> Usually we pass something like page+nr_pages so we know the actual ran=
ge. I
> >> assume here this is not required, because we only care about using the
> >> #pages for accounting purposes, right?
> >
> > I think all the "nr_pages" here are actually the number of dirty pages
> > in the folio, right?  Or so I gather since later patches have iomap
> > walking bitmaps to find all the set/clear bits.  Perhaps that parameter
> > ought to be called nr_dirty(_pages)?
>
> That would make perfect sense to me :)

I will rename this to nr_dirty_pages to make this more clear / less confusi=
ng.

Thanks,
Joanne
>
> --
> Cheers
>
> David / dhildenb
>

