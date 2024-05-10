Return-Path: <linux-fsdevel+bounces-19254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BB48C20ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FB61C21939
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9716131A;
	Fri, 10 May 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c+3UR2vf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B167160880
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333370; cv=none; b=VgOQ5saXrtEfxly6JCUA5szu3ipbJ7BgWZOHHvvVM3JZ5JeBsZ36V5htks0NJjPS3PNcW/mcUZ+ze2ZV6/3eJQgUC+aqq8WfMy2ZT1BN2Vflo1kqH9dGArPx4r4I5/p1pE8oumesykWBpw5hmphU8MCyz8qMsWiq8wLnhwqtZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333370; c=relaxed/simple;
	bh=kc4GbU1nJuP5rf8sWY3kjEhTD6HDa5dyZKuLq3c/7BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHK/okIBArfjCHM5Gj7pfOq/GiMItjJmx0TW3n9NdlcQnq/XqnrcYbp02lWfedekOXsKkPHzYLcNwNE2RudtV8PYusUix4XkPtcdpwzgaQxVLTDZEuPQPRiqeAQccc5LY8aERz7zPdZSidMkiQy0n5ZkPBQQChNFqH5KwdGDK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=c+3UR2vf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34dc129accaso1282558f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715333367; x=1715938167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kc4GbU1nJuP5rf8sWY3kjEhTD6HDa5dyZKuLq3c/7BE=;
        b=c+3UR2vf0YUIPpGxf2eLtPJIV18uEULczA4rs85CBZvnIXxhZrJVDPXXT03Vw3vIJo
         pheLxRN9nS6jcCUSSWszMs8TFHjl2RyLS0kcbzUuHAO0OUjfwIMQVAYf9Tzav9fVgYhN
         /kbCbnOEQ+pKWkue3rvMTKBV6lAKWX/a6yZvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715333367; x=1715938167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kc4GbU1nJuP5rf8sWY3kjEhTD6HDa5dyZKuLq3c/7BE=;
        b=Pz63nIXVYIAwiOs+2twKydfyrzObVC3q6txZHy+SsYSKKA0cOUWF8WlqF5/5pAuPW0
         2noradgOtWriFYyPkWz64b0tdqp87qrFSMNlAU49uSnwMkrhcxISu2dvG9At7kzAmBEg
         rjCgByOKc1W7OOG37eEqg2QJFmo5dFZmwAx983T964PZF7wTqpArltVN4vksM9gH82Td
         NmxuYUnaCsJlti2ipq+RVswrSAkmMfkmWUGsZ/jjgy4G25ZiTx3A16dESetP57g3/jDO
         A6adBOclRJ55JGX1AOpc66szcA4YZTk74BeNhunoXcJPQzBVA37no45x2Z2mLYHdtz5u
         jYWA==
X-Forwarded-Encrypted: i=1; AJvYcCWb9jMeU6lDGH19wNsahSwu9qY14x/DfsjbzaBjFxS+3CaJ/BJqYPNr3g4AUG6QNUrMpf1Y65ECOGN22zygqXdBWT01fzphLdaUvMDPvg==
X-Gm-Message-State: AOJu0YxAFW4ZU/o8PjHtWKLLpabnJj2wP5GoE9t08N9PbYOX6QI9gYpO
	lKb81NEwkt05KI7ATIk6fsN9EBBB95sbqpvX68dNh3laQDQ812XVd4FMb4x56DxWntYsNqTde9I
	LO7416xhXPi78+WvrqcGFDv5IECluJ2p1cOfjyinoYc/OqYKe
X-Google-Smtp-Source: AGHT+IHoNg2wt+6Y3ymJG8oVFpFmmomjuz4lHKnzzbQ6LgbHb/LqMAAY75w6GRVowCoL8xUng0HBItGtzaV8OwenIdU=
X-Received: by 2002:a17:907:1707:b0:a59:c577:c5cb with SMTP id
 a640c23a62f3a-a5a2d55a749mr146034566b.10.1715332890702; Fri, 10 May 2024
 02:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509125716.1268016-1-leitao@debian.org>
In-Reply-To: <20240509125716.1268016-1-leitao@debian.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 11:21:19 +0200
Message-ID: <CAJfpeguh9upC5uqcb3uetoMm1W7difC86+-BxZZPjkXa-bNqLg@mail.gmail.com>
Subject: Re: [PATCH] fuse: annotate potential data-race in num_background
To: Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 14:57, Breno Leitao <leitao@debian.org> wrote:

> Annotated the reader with READ_ONCE() and the writer with WRITE_ONCE()
> to avoid such complaint from KCSAN.

I'm not sure the write side part is really needed, since the lock is
properly protecting against concurrent readers/writers within the
locked region.

Does KCSAN still complain if you just add the READ_ONCE() to fuse_readahead()?

Thanks,
Miklos

