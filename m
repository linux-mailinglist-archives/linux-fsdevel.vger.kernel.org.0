Return-Path: <linux-fsdevel+bounces-28705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8496D234
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40ED6B21B94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A3194AE2;
	Thu,  5 Sep 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKMOspPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3138193424;
	Thu,  5 Sep 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525208; cv=none; b=dncTLDieGKKJ6QbYwMHggy7B5rfXlbyUK8Ycp+0r5/I0UfL6lFED+51MXTBvQn91HC8TJCSiCX+SPa0/9OsRV677rwd+OIwh3EVwIdBpIc1hKhR83NaH8HXXvgCt7ht6nvyIA0N2ug0zfRQKbrQd/Bww62QwyZsHNQlaeTQFqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525208; c=relaxed/simple;
	bh=XZnPEdwYX5299M5M5CvLohjv7UGr7OVeODRERuSitr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJhUn8xkx8Lz8GZ7U4nrtR2COulqpM2jN9v5iLQbEXHSqkcBW51sqlcs17j+qcMViU3CuOJbSHOi/LrXtkfGZZ6jqXvEyS+MhkyVuq+v0PJQu+FPA+/XAyNux9Wj59mA5kT6FGShAd5q6f5TrQtojCWsVknMbQUnPWsLhEffyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKMOspPr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86984e035aso84727766b.2;
        Thu, 05 Sep 2024 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725525205; x=1726130005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6VoVXvMgjJFAnKoFBYcoiUaf50g7AR944M8kCA7EnY=;
        b=RKMOspPrH3TywRmNaIgB2Ns1wFOHLQsjxGRxmMfIDeId/VM+wJdhMk33MmzmbrlMiW
         FkN3owU8yKuxyvoBsQw/2sh1i730LLI3btRr1QjwkivnIEJ44oM9Mr8pTKR6qdSmiKQg
         iath7yK9xkUTAt4OY1k4Adks5vxK4e5L8dQ6pIJ7ong4Qv4EvL5+YjNgmJNmy+xKXqZw
         MDuHKkAOjUqaPFXTmNdvLTilcICa/LIh70xOE61SfurgFpt+1b9NmP6zWT2+7JQvQ6G8
         ODSanpUEtQcYppvNj/1bDVCVHQ2jxkac/8A6wU7IzbDOZ1GYjqixXlvVqB9Vew0cqoVx
         x9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725525205; x=1726130005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6VoVXvMgjJFAnKoFBYcoiUaf50g7AR944M8kCA7EnY=;
        b=QhHZhMrXf9RUSbiVvIIqUCVDAnaweZ4HPK1cPZWDX3iZNbsLjVFX4QI2EH488vl8xm
         CqDLVUncDMuXjq4taixOyQ34Peau1lWO/1kY8/JSlxhb5FX6//Ni2qiAVhi47b+0Dymz
         vCcRh+uNgcaGLZYwn6mSKtKOz8gcuo0pGPYwQowSH7QVvRPnLcJlt5Lmb7ZJlFZcYMQw
         SCt0On5fVRlLi4x61PZgj2oR8GRX9Ili7KAJOzLqUvViQ+FFwBy9r+fRAVAfIXvAGt0K
         W8yn+/hG/oynqslc8qD4wotRAhNU17wFdu00GFAWWkSHVGo+pkt28cOxn0zg+8SWiVSe
         lFoA==
X-Forwarded-Encrypted: i=1; AJvYcCUZV8l/fDd1wNFtRtXimecNS31XYZ/fqWoOxA5/KoVo87ign+twiUCHyaMVP8jrVp+iVu5x3mvvN38CMUSJog==@vger.kernel.org, AJvYcCVbhSFtnQ+XxcUvatsbyha0xeSeEIm5A6BqNkIS+XkzcHiXeQEfSgAtMKbm3WoAXAjIRs4bNTjPOq2JM3uRaw==@vger.kernel.org, AJvYcCW4Inss/fb/BlvoBcAk2YSAsJh1pREaBjReay689Bns6CtHTqnS8ifmDRdTlWkq+QFoLgzfmA7MJsLM@vger.kernel.org, AJvYcCWHLpkTSoR5cx1J5EI18vw/rpkZjjZbqhmm91eAYiTJhdnT/NrH3zYmUZYI/HGNJlf4otu9JEjBFACRY6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3WD+Kz28GFNImAQWEDqFg/JnF9jOiVpKM2E9aIAGv/5vOfwe3
	RWbtyVkElYKDhr5ciPplJh5jAHoV1Nx44F+yxob8crr8aoM8C5ldPqadb4DQwLccjTlCQBLX/BL
	Q6Lj1AFZABlKKzI8/hkSJEaeFYQs=
X-Google-Smtp-Source: AGHT+IGcHHmcIfL3pt3Z+CSw87wwzuOptm9dc3Y5/ExCPVuX7rDOZZpaYVk+knjoWAY+OGISPhiN58eLFv90/DszDTY=
X-Received: by 2002:a17:907:12cd:b0:a8a:3f78:7b7b with SMTP id
 a640c23a62f3a-a8a3f79d5a5mr252075066b.14.1725525204534; Thu, 05 Sep 2024
 01:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:33:07 +0200
Message-ID: <CAOQ4uxikusW_q=zdqDKCHz8kGoTyUg1htWhPR1OFAFGHdj-vcQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] fanotify: add pre-content hooks
To: Josef Bacik <josef@toxicpanda.com>, jack@suse.cz
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxi=
cpanda.com/
> v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxi=
cpanda.com/
> v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxi=
cpanda.com/
> v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxi=
cpanda.com/
>
> v4->v5:
> - Cleaned up the various "I'll fix it on commit" notes that Jan made sinc=
e I had
>   to respin the series anyway.
> - Renamed the filemap pagefault helper for fsnotify per Christians sugges=
tion.
> - Added a FS_ALLOW_HSM flag per Jan's comments, based on Amir's rough ske=
tch.
> - Added a patch to disable btrfs defrag on pre-content watched files.
> - Added a patch to turn on FS_ALLOW_HSM for all the file systems that I t=
ested.

My only nits are about different ordering of the FS_ALLOW_HSM patches
I guess as the merge window is closing in, Jan could do these trivial
reorders on commit, based on his preference (?).

> - Added two fstests (which will be posted separately) to validate everyth=
ing,
>   re-validated the series with btrfs, xfs, ext4, and bcachefs to make sur=
e I
>   didn't break anything.

Very cool!

Thanks again for the "productization" of my patches :)
Amir.

