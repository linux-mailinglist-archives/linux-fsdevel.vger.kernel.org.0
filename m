Return-Path: <linux-fsdevel+bounces-61975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0354B812C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCB71C27217
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC82FD1BE;
	Wed, 17 Sep 2025 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NfT7yy9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D82FC881
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130060; cv=none; b=TTMGgBrVBTQsmZChYZLu5GKmjv3uUBHHomAy/dUZExIf3tsvWsWhZdywwzBTsEh4gf+1UiNQSBi1SC4arwBZo40VuxrFl7yJQgkLiwQwBo5OPjXLmgoVp2yc8ORNXQGuk57bzHlPDdzyzrON6SEmxO4tJBiGau70rx5PQDfPhO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130060; c=relaxed/simple;
	bh=yBgNglhUj28Ssiy8gVhtR3DVtZUq7MxzTlcQ+kt7TDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeVf3HeIf5sJm7TlARQiM44h96jUJUljwSuO3/lXbxJ64jGLFY1O9NlI6C+SGtpP2/2qdhxsGeSyBuS493zgjf/zLuu5NP1chqAK+PF0ndSOB1ZBr6Hyz5DxFTD/qJnbRC5/mgdFlf2KWYla8fekonwyCAuHHkoB5BsjGm2XbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NfT7yy9y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b795fa11adso536511cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758130056; x=1758734856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBgNglhUj28Ssiy8gVhtR3DVtZUq7MxzTlcQ+kt7TDE=;
        b=NfT7yy9yDHLhTvGPmk9mIbqvfyGRr5F9ucxVssdTiEUucHoSvWqy5CXj2y/yA4KL8h
         R6dIQFefRPZVO4sL6e4b6jEOetme7oz3b1nyhM/YGwVYezPVUGz1M1m7zoA0bWMpyCgL
         Rtb00Tz4w+jsFkrPh3T0H866jaTVfrA95U2Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130056; x=1758734856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBgNglhUj28Ssiy8gVhtR3DVtZUq7MxzTlcQ+kt7TDE=;
        b=wDbGcXOYvfjj6VhLRfdXrdOTOTdZ8qdTjwxe/yW+z24UumAc3TMFX03A3hM81PJ1YY
         vBmaKOHlxxmSw8a+9GyB569igtI4Tf/XhH+J3r8T5dB/tJplYptqzRVZudJw+9pwumiU
         f4rx/gaHFasxuMHCburITtr1LYGJmWelbHegykPlhCfB2r+N4mCwhmijC388+Cgd+M0p
         Q1PdCK0lKr0eWI2VVnh911im6rM5hNtXNEpCnWqmpkLxYRs2xFr1YlX0Bg3BfFXRF6/G
         RJDXKIc/+jiPmoZ1B71MBqRb4cf3FRLyT+MkUAvAHqp77Eh8GXF4H9/UXBiYJoLRGTDp
         DxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk3LQaBXOQSlI2jsvhnKuhpV9eJbUh2huFLEjm5zA0oSarnuFgy1a4Jz/tvZC85IRN68OfiQTvt4x/CdiW@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDz2B28KOYvin6ZDZ49o/3NHRY6sfC+4XIK8+zERTTZH6i+Dn
	QIoOttIL6Kr/kc9W7mrN57ha5N9sfOoI+6qDpyzs4SCRRK3DZB/CqYy9uVvdvsMc011145JEsFg
	qYi5vkQ9To7uOkz/UTU7EObdqFutL8OfjzCEE+6w0hg==
X-Gm-Gg: ASbGncuY4U3Z4LjYgUHtCTV0O1FUy1564sOxcvxlJcooysNEYhGtykh5kmDF7wW5TwN
	zB1yLHifEfDFnOyMlNkgkNqQAd3Zwfug8+GsUUPVHcf6iatjB37gVhVWqNKrOGd4TS4xyAZozkj
	tbY8H7DxfENSA+FmdxHekXSAvxAp+srbc/ujag3nl84cfZf2WvITIfm8YsFVIKiVAX3DctuJZ8g
	bLZiwierqUipejMfxuVelY0et/BUZ+Bv64LKWxu
X-Google-Smtp-Source: AGHT+IFBkFOk0XNIkJfTtP12NzSLh1/XbpFxeGvj1/V9q4Ba7zUNhwZjk6B+bsdIG3yL0hBBs0xc19mJKt5GE6VamIM=
X-Received: by 2002:a05:622a:18a4:b0:4b7:8028:ff1d with SMTP id
 d75a77b69052e-4ba6cd70b48mr32432871cf.74.1758130055944; Wed, 17 Sep 2025
 10:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153031.371581-1-mszeredi@redhat.com> <20250917153655.GU39973@ZenIV>
 <CAJfpegsZT4X5sZUyNd9An-LxQQAV=T1AEPUYQJUUX4bZzUwJUg@mail.gmail.com> <20250917164148.GV39973@ZenIV>
In-Reply-To: <20250917164148.GV39973@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Sep 2025 19:27:25 +0200
X-Gm-Features: AS18NWCqpvfS17bi0aCbYLaXRQxbYd_3bKWSccrJkXY_9QIc6sOxFHCKnJZBA_M
Message-ID: <CAJfpegvYJD8UUuukNY7oj7-PSu48y6hXn+iV9iHzrO4fdgWXQw@mail.gmail.com>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 18:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 17, 2025 at 05:42:18PM +0200, Miklos Szeredi wrote:
> > > ... and if the call of ->d_revalidate() had been with parent locked, you've
> > > just got a deadlock in that case.
> >
> > Why?
>
> Because the locking order on directories is "ancestors first"; you are trying
> to grab an inode that is also a directory and might be anywhere in the tree
> by that point - that's precisely what you are trying to check, isn't it?

But if parent is locked, it must not have been renamed, hence
parent-child relationship holds.

Thanks,
Miklos

