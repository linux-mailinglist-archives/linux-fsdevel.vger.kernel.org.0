Return-Path: <linux-fsdevel+bounces-26816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC7695BC9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879991F238C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0841CDFBE;
	Thu, 22 Aug 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ1Ci2lu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69826AC1;
	Thu, 22 Aug 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346068; cv=none; b=lqitahIgXo196+IVaswo5Y8HtJTpY4v+5KkKvO/F6XFYVSgdSN2S7qT5GnU2/qbI/HF0RDMb6mbOna0YXMs0+BqPVW2HhVkb1NCoGdQYb0z+S3xS3r3+e0nu0BdpaLk56DBZ/YFW7owYDebyFqjR0pZ+qHLahy5d4nstuXitI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346068; c=relaxed/simple;
	bh=WQ8zCuBhOHR9wajWVBcM08hu3l43u/iVVkRgQ5fkTcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlwmDrRhGZZgG/t4P66eh959S4A1LTvlsXfyJPWjAjK5M9iXf5Vm+rJfWarpUzKTKsJnQNwVfHwXnRcdEK+G41uz9+/sogFtpAE0fbGCRJj+beX3Jinv4jM/wNRsvbonQywpImL/TH4+AChK4+3k55dsrs0HvkIkCNjdFWHNUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ1Ci2lu; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fe9cf83c7so5987061cf.0;
        Thu, 22 Aug 2024 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724346065; x=1724950865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuwl4rzkAcyRVZqp56l8KyXW3qwZYMG4uOgDY/0J1+4=;
        b=aQ1Ci2lurGg1FSHN6/FiJmm5QOSgiL2wJ2jsjxovA+xDtdFVoiTEWpa0ZS8KaccuJi
         psOX83yoXfoT2C7ZgxuEHHwArOX694VAfxpPiD2O97QGaf+c9LaPyLyrhD5aWCfS3eCg
         MRNp6TI7YFOYvprA2z0cAfE7VMmxwxnfa6gEHHUdm7x8GWeHnPhcgrPg++sD2upAWKn5
         yYiB5yPfjl0Miyor6kOURTocaSFi/+QDzK64z/HYfNQYK9mCca30botSMw5mKdC4ZNwU
         if0euvHSuX9lPN0TCWB31ZxoOFlA28l4yDKopzGmb2HCHDGykhcrhmtEp77U2XAKp11U
         PuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346065; x=1724950865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuwl4rzkAcyRVZqp56l8KyXW3qwZYMG4uOgDY/0J1+4=;
        b=maarPIC4RPl59GsbONKcYLtjcvRqK1rreJL/205VwXpG/42J23MylBJZN/rTnFJzku
         g63UiWpwwpyOImLKDdM4GaKzBxymaIOSkXy1T8VeXZ+D0qe57ZkpAK/cZaFAVUy2tFFk
         W0hMrKl/CtNbR1SaB0BTqSUI5y8yIESsP8biQulXPs2TmxJOz8jToslBp0ZiOz2MAckE
         JV0/Y0ggUKRNrmUcv8JpOR6rnm6SCBKwn7xuXPYzKH0OCH+koMUqutIf8zP2V7GTRi08
         MmPs8kRCOUaaMrTbzsG2Ncy0tNDCDD4KsS9B7f2nX6nbq0cbjEqsEkn4wIJvYYXmPwQv
         EFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHBtXVzE0I+acReGyTzg1raWEw5XBTAAr09IHcJWllcfb2bRpWf+eCZ0G0KILauEf61uKxhjCAhHHaT25B@vger.kernel.org, AJvYcCXp09WlYaUH/msHskUxC+EveSGkqsV2u5JeuHGKJ6Dw+5APhQm76OKsrJEX9xeeUIQ811ug75rd2wIASy5q@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQNFcVI/lo89/5i6pHLloP24nC/f004EUZDjNHRkhYH/op1xW
	W1qqeZzjSBqRBO5rg738PCHKQDa9s+q4U+b9/n70JVEFQ0Ev2xOoKnMEMYkHK1BoNt/wZf5mh54
	76kECJu67DvE9wamx0B/jHzcU4Rg=
X-Google-Smtp-Source: AGHT+IHUeiRGLKAv+AloQUOB3Dht/6V5uELOuqjosFjmD4sPq3W1dSn1FBnAJBuZA0EHHirrfld/27lV5HUwqUvKI20=
X-Received: by 2002:a05:622a:518f:b0:453:17e0:5516 with SMTP id
 d75a77b69052e-454ff7cbcd2mr32573891cf.36.1724346065050; Thu, 22 Aug 2024
 10:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com> <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
In-Reply-To: <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Aug 2024 10:00:54 -0700
Message-ID: <CAJnrk1aa=fv3H7pjmerrHD1fVkrD2inPhXf8DNdfeQpfSbUzdA@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:02=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> =
wrote:
>
> > Back to the background for the copy, so it copies pages to avoid
> > blocking on memory reclaim. With that allocation it in fact increases
> > memory pressure even more. Isn't the right solution to mark those pages
> > as not reclaimable and to avoid blocking on it? Which is what the tmp
> > pages do, just not in beautiful way.
>
> Copying to the tmp page is the same as marking the pages as
> non-reclaimable and non-syncable.
>
> Conceptually it would be nice to only copy when there's something
> actually waiting for writeback on the page.
>
> Note: normally the WRITE request would be copied to userspace along
> with the contents of the pages very soon after starting writeback.
> After this the contents of the page no longer matter, and we can just
> clear writeback without doing the copy.
>
> But if the request gets stuck in the input queue before being copied
> to userspace, then deadlock can still happen if the server blocks on
> direct reclaim and won't continue with processing the queue.   And
> sync(2) will also block in that case.

Why doesn't it suffice to just check if the page is being reclaimed
and do the tmp page allocation only if it's under reclaim?

>
> So we'd somehow need to handle stuck WRITE requests.   I don't see an
> easy way to do this "on demand", when something actually starts
> waiting on PG_writeback.  Alternatively the page copy could be done
> after a timeout, which is ugly, but much easier to implement.
>
> Also splice from the fuse dev would need to copy those pages, but that
> shouldn't be a problem, since it's just moving the copy from one place
> to another.
>
> Thanks,
> Miklos

