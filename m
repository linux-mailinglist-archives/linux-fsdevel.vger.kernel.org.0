Return-Path: <linux-fsdevel+bounces-27462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFC9619E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3E3285317
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E519D093;
	Tue, 27 Aug 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN32/RG7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FA3C08A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796619; cv=none; b=IYPXbBvj/RCY2oupuqCFZUUNLZNUBJWvZAT6oggVPv2042YR+5BQUsAWLxoQdI/C6eWlozN6yFyZJDW7VJG7aBOnJu5Z0UXn+zlwggUs3Z2RYnpp5uMGqISozB/Gn+HLyCqphwgsOhVwEMLBuTFBPtrV93uMz7OFZo47KILORns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796619; c=relaxed/simple;
	bh=hjYO//v6qSgbw2ExJUrDR8ORYHW/HzSZOyFQadLFp+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+NxI4cLOcWvuhwvxSWDEyUIZE7xkY/aInzpqqBT3rsr9V/3y/2CaX8V75GStgSKwVsBbibJj4SdTjj9aLGG8v4fG+Xm2fWKK4eswRaOfBMxTP5YGhd8X9svg+j9u6UlyK0Jo9RmArCtd+jj3tHTQcbXDfht4R8kDNxiv+ukjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN32/RG7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-451b7e1d157so31626861cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724796617; x=1725401417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRxtnQ6Yr4ujPUF7Dq/0mNUbz6u2Xf0OG+0iE/iL6jg=;
        b=NN32/RG7nscSItrcEIqoIZj2yIDE4ljtZOhAbVT6JETp2j479N1mOeWd3H18aO3smW
         3JuuY2VRMYbgp/S0HHQd7KUrstzJ8aeZ7fxWp2bjjpmVwVcy0966b5K4JHDyshofMPtD
         wqf1ok3nfxZOhpMn9dmsrK4uv1yuXlF9iOeV6gnhdVgrz+2gLW1P8NXOA7J0dRfHMR61
         dW9GV0lijf1K4xtTd7tMpsBSkAizAHzMh0up5hV/fekrMlnBz/wo4XaTtGWMfWzZ4NGn
         H+bUwErM1IHV+hfNmuNpgt43iR8bZYxGhP8YGTYXSzPipzouGLmu8CoDp8qKqMBx98QT
         A2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724796617; x=1725401417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRxtnQ6Yr4ujPUF7Dq/0mNUbz6u2Xf0OG+0iE/iL6jg=;
        b=WPtZWXxSxUwT58jRG0edd3mEKZ13zBQVXuB2+3lQgJm0BYOC9idv56u0Ga1rw5WUhl
         4L3jc3SHB5AaVyYBjVgxGkQ+gasE7Gkyk+lFvaswBifiF/5QrTd5AAl/TdqGrewwgMT/
         BuojIGDl3BXBhy2AqWGE4lnMvVLlwvTZdcuMDl7gty7iAxm208L7f7lM4MgKDGpTmBTk
         hodN4oDHwTdgGlAMQhbb8p3hl1yk2HgdDHYfxo+MBcC3gfya9SvAfo79Wf0tEZp+h2aL
         4ipL1nlAUkdyonw7WL9EQnFStyjx3kVK/Zq+mSG6R2GjAaGnBNQbdL1o59IDrbNUM3Jc
         LlQA==
X-Gm-Message-State: AOJu0YzVd92m3K+1aANkgHsqt0t3aYWSPIzo5X0fUAoZKD0VmpSZ7A1A
	kz+aAp+ViPjERhj6cdSj3+SkIr3hSj18Se2v2f714gG4jUtvfJPmb27WGfULdvbHZ4N1FRtQXSn
	CB7JTIjQxpjkuPKAbv7Yqoxulitk=
X-Google-Smtp-Source: AGHT+IHjRZ7GPE4T71Y3b+zHQsU+77D+bmeeEdw7Jv6m3qmXE0B299/AecHgR5YnM4m1CvtIjA3Q6rIOZGmU7W+qF+s=
X-Received: by 2002:a05:622a:99b:b0:44f:ee81:b2a6 with SMTP id
 d75a77b69052e-4566e6815bbmr2656341cf.39.1724796617095; Tue, 27 Aug 2024
 15:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724791233.git.josef@toxicpanda.com> <5666724f5947145cec4f7b774cf276eeb236eda5.1724791233.git.josef@toxicpanda.com>
In-Reply-To: <5666724f5947145cec4f7b774cf276eeb236eda5.1724791233.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Aug 2024 15:10:06 -0700
Message-ID: <CAJnrk1aexaTAMU6v5C=SXJ91k9i1t1e1Dg0BdpXmomaX2-efYg@mail.gmail.com>
Subject: Re: [PATCH 10/11] fuse: convert fuse_retrieve to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	bschubert@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> We're just looking for pages in a mapping, use a folio and the folio
> lookup function directly instead of using the page helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

LGTM

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7146038b2fe7..bcce75e07678 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1709,15 +1709,15 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
>         index =3D outarg->offset >> PAGE_SHIFT;
>
>         while (num && ap->num_pages < num_pages) {
> -               struct page *page;
> +               struct folio *folio;
>                 unsigned int this_num;
>
> -               page =3D find_get_page(mapping, index);
> -               if (!page)
> +               folio =3D __filemap_get_folio(mapping, index, 0, 0);
> +               if (IS_ERR(folio))
>                         break;
>
>                 this_num =3D min_t(unsigned, num, PAGE_SIZE - offset);
> -               ap->pages[ap->num_pages] =3D page;
> +               ap->pages[ap->num_pages] =3D &folio->page;
>                 ap->descs[ap->num_pages].offset =3D offset;
>                 ap->descs[ap->num_pages].length =3D this_num;
>                 ap->num_pages++;
> --
> 2.43.0
>

