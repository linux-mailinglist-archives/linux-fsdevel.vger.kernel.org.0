Return-Path: <linux-fsdevel+bounces-30731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51498DF73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0BA28734A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679631D0DD7;
	Wed,  2 Oct 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvN2Cys4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA861D0B97;
	Wed,  2 Oct 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883655; cv=none; b=tSrxWBAiiwl0HW6VhaK5Zgu1MRnfa1N3XCNS+gGkLnAs5Krvzq9CNGl4youYHLx30rnN8zqq5q5GTYmrO7P3QIhXs5y/e1qyPmo/Abx7DAAMXgXp07iq3Qw7xlWGJLJPgjab+SX/FavKn0A+9+a7IiaTiT+owRUQwqjKNbXSPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883655; c=relaxed/simple;
	bh=WIP2KkjUlSVjwcDNw4d3jTWw8EguXiw7+Opg9pqYWpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O25n/v13Jk8vfL5bWUdFXeJN6UIcKft9arNQ9zv8qjqNc4A5btPsitPjOEs+6OTdKoMiAFH5NgQfP0qCPQ89XZxQt7hGvV0Im/JVHHHE4K1YoOEtVA3EF8zHlG5KCU6GzBXVxyATLfFFLIqrEGL+DhnFuFrLcZztQHuwtmkzGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvN2Cys4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso44998701fa.1;
        Wed, 02 Oct 2024 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727883652; x=1728488452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BO7GvoEvRQo4g/wy/IaY0N6iqmmGOHEMQUrshuZ/AU=;
        b=MvN2Cys4KDWHFH9mb4MoczJHGNJyH3MiXa6FWsO6J8qaP1coR6GANjoGNhpxlKCNq8
         UNKP0pwM3ThK28T2Mj8tMTO5Gry+1AFo2xXObLhTHOO+SbM5QX4ycTVkXgIqzlBOIgsU
         KKmhCHTlVwOSzi9HT5aT692ih6cg4ev5mkUEB+LgE7XZ6P7G6IoOnE7Xm7D47wGx8TMh
         12qAOZVN0vYu1DlKynCY+dBesYH8yQdDR0PewTcBDfI9c7QZGCP62V+wbwLwD2jx0j8q
         Ak/j6YuQ/W/1Rek8mACrClloBkHAjiuOsoUCosQhikT2yOJx0ZmiFnSHT3CBdbJE0GwV
         E5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883652; x=1728488452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BO7GvoEvRQo4g/wy/IaY0N6iqmmGOHEMQUrshuZ/AU=;
        b=RVUi8oVqVGLk358Dh30Ty6U7Rbp8TjCDpjKL//oO6xHdHtPRGlqQVvr/f/7ctAXIRr
         9qrSZoh2Gk5qXwj0UFElkjH9irnechKtUrYjvLv3GVIwg1IC5VI+/3lYnPt5IIV86VqV
         f4Shorw+op4pi64gkQxh+O+uNG0yf/SebLSej0HaUOavXDb855dFPW5kCZqO73C38IJK
         17fLUQruWNzerUfLekJKfb+eUx3TZvuNQiwo2vBBas3r+9CQMc7IC8wHp6DG+YmyC8wQ
         uFCmHMgRVRDNXpKNfV6y8ypPdZJF5Ff0jdUPAkErBB3m6xNG9IoN02UDSdNNe41tw86J
         SHwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Ln0kClGeUxxtmvGcj51wtxTpQV2liTa+vtzvEGf11SCLFRde2xSWwmmX0TSylWij3X8qd6Jnq9Ocfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5EItufwtWC1xOnP5YgDzpZZYwcHsnCxYQG2hKA5NLpjEha7b
	+2lg5Zv65xPWgvcTweHK+WaE2KSOT+MiwEt3g25rUXpYowyvjN08OP0hSyR+XtnCJp7Lhuv7K9k
	D78vHK8x3Ez82JoALRQpAM1Apwto=
X-Google-Smtp-Source: AGHT+IFuXTdNAQnGRSwGmrKlUm8cdAE9HZOTGFJNei48st3ZVzmi325nJB/hpn0GE9NQdMu07nTMExp2YkaqeHUXfHQ=
X-Received: by 2002:a05:6512:ea4:b0:536:55ae:7458 with SMTP id
 2adb3069b0e04-539a0795bb2mr2354026e87.40.1727883651912; Wed, 02 Oct 2024
 08:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002150036.1339475-1-willy@infradead.org>
In-Reply-To: <20241002150036.1339475-1-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 3 Oct 2024 00:40:35 +0900
Message-ID: <CAKFNMokwCtK2WjBPRqbO2_Me=x_RRH=htF=Tcz0t9g96--Wx0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] nilfs2: Finish folio conversion
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:00=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> After "nilfs2: Convert nilfs_copy_buffer() to use folios", there are
> only a few remaining users of struct page in all of nilfs2, and they're
> straightforward to remove.  Build tested only.

Thank you for your ongoing work on converting to folio-based.

Page structure references still remain in other files, but I'm
preparing a patch set to convert them to be folio-based, so together
with that, I think we'll be able to remove most of the page references
in nilfs2 in the next cycle.

I'll check out this patch set.

Thanks,
Ryusuke Konishi

>
> Matthew Wilcox (Oracle) (4):
>   nilfs2: Remove nilfs_writepage
>   nilfs2: Convert nilfs_page_count_clean_buffers() to take a folio
>   nilfs2: Convert nilfs_recovery_copy_block() to take a folio
>   nilfs2: Convert metadata aops from writepage to writepages
>
>  fs/nilfs2/dir.c      |  2 +-
>  fs/nilfs2/inode.c    | 35 ++---------------------------------
>  fs/nilfs2/mdt.c      | 19 +++++++++++++++----
>  fs/nilfs2/page.c     |  4 ++--
>  fs/nilfs2/page.h     |  4 ++--
>  fs/nilfs2/recovery.c | 11 ++++-------
>  6 files changed, 26 insertions(+), 49 deletions(-)
>
> --
> 2.43.0
>

