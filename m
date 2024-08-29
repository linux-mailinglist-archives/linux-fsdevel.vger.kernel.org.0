Return-Path: <linux-fsdevel+bounces-27779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F080A963E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A559B22C12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67336171E73;
	Thu, 29 Aug 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Lh/hvZ0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0D18C027
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919896; cv=none; b=iDhLMEyn9kIi0QUxuk4O1QAQUEMFM66/+tO2qr0AFGubcbQ0PJHzLQTO76JxMPjEZImJvfQMvah/Eq4ho82x2DcSEMoSDNv2YWyUr9eTeR7PZuTHGEkOv7y8PL5qjLnKysnyDa7V3o9jMd0MVMSaSJNK43GkT5rTJRRKtbt62L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919896; c=relaxed/simple;
	bh=3w766+HcCKSDYIdv+dG3eTKeIXTUGtDIeXWuYIwhAqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8c1Lz1Eb4bsrcNu6B3kbxn7Ae+UCrt6Udo8roaWDhqdn4PrVsJIk3JbssQfUB1BFn78z+Nn0C44u+ZtOjRMG+4grTV81/qKNJAMzGVwfZLW4lKfpsnM+DhCvjHxeOJkq/esUch95SKjIQTUaI0XnqTlrZAwGSDJSj4rKJqbpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Lh/hvZ0s; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e115ef5740dso414884276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724919894; x=1725524694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3w766+HcCKSDYIdv+dG3eTKeIXTUGtDIeXWuYIwhAqs=;
        b=Lh/hvZ0szLIBCYADRr2XdtMuB6j15PRmZoJ+HZ99O7wrNeOLiao/mAKwxLZrQcyvn2
         cZg6VDBf436s9RS3FvDyI2whxnwCy/w3L+9+Bgyoo2cu+alidER3NXBFaK3q/Pu26B7W
         QwMoZqV16UUiNvdNgBMrrSqZWf6oRa6WmM4qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919894; x=1725524694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w766+HcCKSDYIdv+dG3eTKeIXTUGtDIeXWuYIwhAqs=;
        b=BUrZX8C0EDuQbBurAkZ122RPHj5seIb7eLQlACsXV7Db6iJRdXNfFgTtA0fwxoANEc
         HwmMPu56G6RP65sHFANNZDFBqN6awdk3BgkZxIkqvDlqxYijBm7qN22z2Tk8+QVUnpD3
         1ManA7getdq+WMGQaNHmoPgqPWQqIIGPaS6k/VGwlOyaEc3q491focXdX1q4kRA9+fF+
         c60nSSjXbl3U3DBq/TSmCG5QiGoIPj5DkXVH0z1Td9g5nlWTNXdrNL/mL7ZTSJ8Mynht
         W/CgexscfHBQIvrZOK0BHinnQbvTTYK04FyvmIUh6tZ7jqdeGNCTv07XdClZxsppHJ7I
         vD/A==
X-Forwarded-Encrypted: i=1; AJvYcCXfYRX8jKi57K0M8NVzB4AogyDMsm+reqUuwwrmCMVgHbpBg2da7EEZZ2VJAtbEe7hS/w0nzVJ7pZ3VJmm9@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUpf6TTjuNx0nk4d7Zygc4cJlc+05ffHcEZT1SLBR0iJwwlLb
	tg2xgiZceecIbE2s0o9EKRut3yelaQ1ShhZEVr7tIPSodlX1ObMGwMYdn6vSGcy/b8wnl1uDOvO
	yZpV+61+Yp2CbCpcNSyIGQKx61iEdpWBhsb0HAg==
X-Google-Smtp-Source: AGHT+IG47dSTLUJKOxckDP0cvBvcSU1zeI0pBYa76Pq5u1sId6PvgzMME+2Ls5N3IO9y/mR9iy/0sXuMxEi09poq5Ew=
X-Received: by 2002:a05:6902:2291:b0:e1a:50e7:abe9 with SMTP id
 3f1490d57ef6-e1a5ac8687cmr2277947276.34.1724919894406; Thu, 29 Aug 2024
 01:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com> <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
In-Reply-To: <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 10:24:42 +0200
Message-ID: <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, brauner@kernel.org, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 21:12, Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:

> This was a first Christian's idea when he originally proposed a
> patchset for cephfs [2]. The problem with this
> approach is that we don't have an idmapping provided in all
> inode_operations, we only have it where it is supposed to be.
> To workaround that, Christian suggested applying a mapping only when
> we have mnt_idmap, but if not just leave uid/gid as it is.
> This, of course, leads to inconsistencies between different
> inode_operations, for example ->lookup (idmapping is not applied) and
> ->symlink (idmapping is applied).
> This inconsistency, really, is not a big deal usually, but... what if
> a server does UID/GID-based permission checks? Then it is a problem,
> obviously.

Is it even sensible to do UID/GID-based permission checks in the
server if idmapping is enabled?

If not, then we should just somehow disable that configuration (i.e.
by the server having to opt into idmapping), and then we can just use
the in_h.[ugi]d for creates, no?

Thanks,
Miklos

