Return-Path: <linux-fsdevel+bounces-29432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8065979A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 06:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF5283184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76F2744E;
	Mon, 16 Sep 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EG4+m3Ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EA2CA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726460463; cv=none; b=Lwpw9PgOTMjA7RP3snqR/j5c9lAWFsDRTKItdDm3K3Y88ENG9aKn2sf1tCPhtFbbXRCCApZoXDb1LKDwYNWkz72SjHsVY06fBbPgVajkFqsaaUgkKzKEieugtFdMer4LNCKe83u4nuZNAJJ4ejMFfUVMHnqopVZSzOcd0kymK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726460463; c=relaxed/simple;
	bh=OTJ/oKsnoisoc9GbqLHkeCIc2BFxmDrQOsJxcfR3nk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbRvNNDme8xYmZ0TP/5cf1CESWtVJT7hPGMnxz2z8nVwXVZRfRMw67IOKosnVxYxqfmwhnNcmrL2MSbVLjyiVfMVZww1EErZXMdIBgwIhTDPcjDjlAnIVA9QdS2MbOz59CNs43KzcwAMaoCWn6QtAOIn59e0kLKIUVFyLpd6CkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EG4+m3Ou; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d56155f51so526899766b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 21:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726460459; x=1727065259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwnw+7buV/Co6cDy6nKRIoLyua67GCD7ZNv0sYBhUOM=;
        b=EG4+m3OuB97C8n50jxnQ/2K09kcBih9ERGeMIO459vRyvMHHgivgjB1jpf4pzTuYYB
         0GmMbrCTJTRnJZIjYdwFg7NyVJJZK2Dyz6OvfCSgxQPmDW0hwEqpNMHQHAl+sJKArZnw
         OUONTkRMht9HS7J13XqI4c4fw+oJgulRV7ZZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726460459; x=1727065259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwnw+7buV/Co6cDy6nKRIoLyua67GCD7ZNv0sYBhUOM=;
        b=OBDFl4Eky2VpQdxn8TAz4498IujUbF1QNE7E97lvwjH8zIRvxHZJfM2vV9eYXDp3s2
         COzYJFu7MnyBbuaZSbVkRrlpAoEAWOHAjuFG2ocY8XiZCVLSVfEbmiKjZJDV+O1vrgks
         dK1F1+Fla4S6AQRtg4UvJO5yBZUqYZYac8mlNGXf+IYL0wZNMwVa1p2yhz9txqmwU+bW
         L4x1820xtKOmbfKNARIWmTmbaLrfHrJLv7/6jTkDH1Nxl9KhdbZ/3SaAuuLpxcuzsEBQ
         L/et6V7XATnZeG63P74Iud8gArNmje9FDFaFE2igfqbpSDWew+IcwbIx3z2Rw2M6EdBC
         QF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAa4lBGyVHz7plwHbfOuJXYgjVTkzNLs7pDL/MybNj+JZHRX7soCvliSGa/TjL2X6nTzQENP67wklypxRG@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEJZkCH6svIvSUa7N0Zud9ftpBl5WIPTVR0TTBH35E7BgOxzD
	uMUGXqNB2a8ma+f+9z+sATvGrl0YWhp1e/zefYm8e56n1aFG9gJkpZKQeyB0hqFMwi7eXlupAjc
	eO7rQtA==
X-Google-Smtp-Source: AGHT+IGBLGBfbBYmFlpDcMoATVajAKwgw9yx/soYqlJOqMX2/EYZThod/v5orDYTEtp8Y0MC0qK8cA==
X-Received: by 2002:a17:907:7fa1:b0:a86:7dbf:9205 with SMTP id a640c23a62f3a-a9029617a53mr1325748966b.51.1726460459247;
        Sun, 15 Sep 2024 21:20:59 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3833sm259268466b.128.2024.09.15.21.20.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 21:20:58 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso5059985a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 21:20:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYjAY4DPN+/Qa36wzKpDr/hDsTWXpGGLuY8Fp2c1CipwIWn7kL2Q+3N0o0WdcRnJJE2I0S5TtStTUzV4wy@vger.kernel.org
X-Received: by 2002:a05:6402:2107:b0:5c4:367e:c874 with SMTP id
 4fb4d7f45d1cf-5c4367ec9dfmr3443219a12.11.1726460457889; Sun, 15 Sep 2024
 21:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com> <Zud1EhTnoWIRFPa/@dread.disaster.area>
In-Reply-To: <Zud1EhTnoWIRFPa/@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 06:20:40 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
Message-ID: <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, clm@meta.com, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 02:00, Dave Chinner <david@fromorbit.com> wrote:
>
> I don't think this is a data corruption/loss problem - it certainly
> hasn't ever appeared that way to me.  The "data loss" appeared to be
> in incomplete postgres dump files after the system was rebooted and
> this is exactly what would happen when you randomly crash the
> system.

Ok, that sounds better, indeed.

Of course, "hang due to internal xarray corruption" isn't _much_
better, but still..

> All the hangs seem to be caused by folio lookup getting stuck
> on a rogue xarray entry in truncate or readahead. If we find an
> invalid entry or a folio from a different mapping or with a
> unexpected index, we skip it and try again.

We *could* perhaps change the "retry the optimistic lookup forever" to
be a "retry and take lock after optimistic failure". At least in the
common paths.

That's what we do with some dcache locking, because the "retry on
race" caused some potential latency issues under ridiculous loads.

And if we retry with the lock, at that point we can actually notice
corruption, because at that point we can say "we have the lock, and we
see a bad folio with the wrong mapping pointer, and now it's not some
possible race condition due to RCU".

That, in turn, might then result in better bug reports. Which would at
least be forward progress rather than "we have this bug".

Let me think about it. Unless somebody else gets to it before I do
(hint hint to anybody who is comfy with that filemap_read() path etc).

                 Linus

