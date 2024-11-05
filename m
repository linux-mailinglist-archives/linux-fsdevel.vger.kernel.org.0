Return-Path: <linux-fsdevel+bounces-33660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9629BCBED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 12:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A8D1C22A83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B831D4350;
	Tue,  5 Nov 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LX1wFNqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CB1D4141
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806496; cv=none; b=I/1qAPHZdPPpkovQ3Sl3jb9tNb3qliae9eXfM2N7y2/+BOBTY68J9EezLPvo32HKXguXDgFJ7OIJLeErlLceTL1CXohDcHFXE/kqyRR6cfNIwPnSgijxBip5BlDgu5ig7C+xf4j2YtetSkq5+VVGF1P749DN8Zrc9O//DR/h4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806496; c=relaxed/simple;
	bh=5hOqNCQn601FkDuP2nCWB1ATvSZ1VINosMu3McQuJAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1piVZoDCZPcQTv4wcAcjJDtsnFTPkNOGTikhwIbCQdNCgMV54cohXSwAolwDdOTEyQyKTVQV9ERXEH6zq4KtjGMp7v2wiv19rJUUZ+dx/fhQ+/ytpV/3DpMPpaceYp6eIEHjMO6VS2j7qi6PT4A7zi1PNeFfq+uC6l/laD27fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LX1wFNqQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460b16d4534so31310231cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2024 03:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730806494; x=1731411294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psWw/Rad+KTcv4OScEPwUco7plFjBWP/BEIctwXEWNo=;
        b=LX1wFNqQemfMpNMlAn6G21W5VZAdXrvLm0ULGDsSrUEE0IRNkqLY45uEuqGL3IgxIg
         r5SNJtuICuX6rMGYdKKlvl7WUxedaLAQN0urdsqGrD6Xxo3CtSNWi+W+itnos534tO31
         5FrTQJ1RXkW8mZB42sHkTTDjSd+OKba4GL7/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806494; x=1731411294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psWw/Rad+KTcv4OScEPwUco7plFjBWP/BEIctwXEWNo=;
        b=Rdt6otPXMWfX9lB7OiOIjc/Hk608bTILWc29NxMinL/SUu+jVFRcrWn9atr8PUG4/n
         Ot9Rk0EfrQx/mNzk44IivDB6f4Tg6uedwqPnTFWIF27K2k7kPNxWZxdGApZJ+/fL3BO7
         qdkFe216tCOaL6Wah98kjcrIVKhglGTTDr4LXuwXgFhuf/Qn1h61e6eUl3EszVcdQNfI
         5ZxeEBh0+4oLx50sdDIPql1ww3JR5j4yDpjT4pa9Zy6PCUggsRux/p2L5i5XBmzrQVQw
         pZkK8R9E90kWrQNee1a+ZLOk+MekuP4MH4Hu/R4srowJuoGAweQYDHUlzrJpoRQ8qyk7
         Z7SA==
X-Forwarded-Encrypted: i=1; AJvYcCV/TFp5JPFUL7RDNScSt3F5PWZ8nFqhoRzbwJKLEHnycSmxYqKDluw6XeSf/YZSI0QTCQr+4meBLFm9pJmr@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7tzaVNPmnXEKaKj3avihA8OWszOSy5oxXP7lTkRbTrCpPD/T
	4osOG4dvgKB9oFTTHQqsoSvIXCN8Mwe7N2elVQ0EgKfs3MFXsuwG482U22+JaGUIbbUAkqVP3Z2
	B34r06Z3SzgZb5iPGKMack4xLaMDpPdGGE2yayg==
X-Google-Smtp-Source: AGHT+IH7/d1rmM7VWLPRdbK3Mx/FHurc8/ZPHObnO2Y9DUt0VsVdAZFPZ5dxnw5XFLU0s99im+MGu2kVCQSjcLwlGLE=
X-Received: by 2002:ac8:7f54:0:b0:461:1474:2057 with SMTP id
 d75a77b69052e-4613c19b6f4mr546758841cf.53.1730806493688; Tue, 05 Nov 2024
 03:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025150154.879541-1-mszeredi@redhat.com> <CAOQ4uxhA-o_=4jE2DyNSAW8OWt3vOP1uaaua+t3W5aA-nV+34Q@mail.gmail.com>
 <20241026065619.GD1350452@ZenIV>
In-Reply-To: <20241026065619.GD1350452@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Nov 2024 12:34:42 +0100
Message-ID: <CAJfpegt3qfhP85f+L+Qz03JAfOcSP4fzfz-x_8dvwoP9CgLdnw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: replace dget/dput with d_drop in ovl_cleanup()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Oct 2024 at 08:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Oct 26, 2024 at 08:30:54AM +0200, Amir Goldstein wrote:
> > On Fri, Oct 25, 2024 at 5:02=E2=80=AFPM Miklos Szeredi <mszeredi@redhat=
.com> wrote:
> > >
> > > The reason for the dget/dput pair was to force the upperdentry to be
> > > dropped from the cache instead of turning it negative and keeping it
> > > cached.
> > >
> > > Simpler and cleaner way to achieve the same effect is to just drop th=
e
> > > dentry after unlink/rmdir if it was turned negative.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >
> > Looks sane.
> > Applied to overlayfs-next for testing.
>
> I thought it was about preventing an overlayfs objects with negative ->__=
upperdentry;

Yeah, I overlooked that aspect.   Amir, please drop this patch.

> why would a negative dentry in upper layer be a problem otherwise?

Double caching, see this commit:

commit 1434a65ea625c51317ccdf06dabf4bd27d20fa10
Author: Chengguang Xu <cgxu519@mykernel.net>
Date:   Tue May 26 09:35:57 2020 +0800

    ovl: drop negative dentry in upper layer

    Negative dentries of upper layer are useless after construction of
    overlayfs' own dentry and may keep in the memory long time even after
    unmount of overlayfs instance. This patch tries to drop unnecessary
    negative dentry of upper layer to effectively reclaim memory.

The reason lower dentries are different is that lower layers could be
(and often are) shared, while the upper layer is always private.

Thanks,
Miklos

