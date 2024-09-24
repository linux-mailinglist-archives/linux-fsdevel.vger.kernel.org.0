Return-Path: <linux-fsdevel+bounces-29983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4619849B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5483D1C21012
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ACA1ABEB0;
	Tue, 24 Sep 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MqMn7pud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9441ABEA5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195659; cv=none; b=bcJ9IYH152vAakmd8xI1DRgAvVPpRcDuV4PgFz9hOChMOvEJX9hgqbZdcg+KTzRm9yWx3OLph6RtHjJr/TTcp1luxZCluvdxwyIpyUQYrZRCbmnJw0Rc1ardNQdEuh+sfVCSDr82D0n76v1kDqza9OkBr8RRg9bopWgP6yaE2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195659; c=relaxed/simple;
	bh=nmK9Uuj1ByPl48wGybQrcJO9RxUQXrVfzgOXeoWVdow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xz/Io2rsBlhrng10Gbd+hVBPbesQaH8aCjuCKXpFn2SP18rwQPKw77MtYJ2whMLb6vDOBYKALtCVbcNX6bLv5PF8EmSLTPlY3fT08EhcxbjV0GKNKmgCK4sTuLHlkp7RZZK2U8vsorPVirjPKMwA0NQTrc//30/U5OjLeLZzc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MqMn7pud; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so75834431fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727195655; x=1727800455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2BsWm6obMCZPV1aGLLtpJZVt21+qXQFY669dpMECc4A=;
        b=MqMn7pud5kY0RobdWySiIshE7sv6CHg/1iZOIxR5sOhCtmSKtSwVr63B/vViYS60L3
         OQEshF31FvNrR2eHg/XcxtRgrNMnPSGOY0YRFzFBT1oM9RpmbmtvZ6iOjdfNaQtRfA3L
         DrRM7c8Yo8LXwZxCnsmIdMFixMHqeZ12zCg6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727195655; x=1727800455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BsWm6obMCZPV1aGLLtpJZVt21+qXQFY669dpMECc4A=;
        b=hT5Fk9xgdfD3h7bAiOT6e01q6C1N/DF/6Q+vW9RyVcyMOTGtP2TXESqT7uVPxVaKk7
         igW2BzhTtlnDUzMyh+bavU5kmuU1Kbu+HvDzvf2iW9THsthVCLv2Uvibgk7uzLul2OaD
         sxc6PFE1b0QSC0+ZBy9mjxu/RjqlfyzMzK0PSjoNWo9Q3cqnRhx6IaTnCntGKTWS699I
         UZDh+AlhjrY/V4E04DUo0TnkYXbbHMYzq+RT4exBOnumxdC0LpBSk0J1C1zqYc6lof3N
         qfHm8hfE6z4hfhmUn7bakk4+SRInrZ7KiCG1mRlCN7m8pidRYmQrBXe3LenSARYUJ37d
         TGUA==
X-Forwarded-Encrypted: i=1; AJvYcCW2vMJZMFFsXzrU9UvkMhJIrDXX1BqsuIphoJn+iv/HJKDrq6JN92y85YUPZ3r4U9yhli6TOoSgtIBMhJyD@vger.kernel.org
X-Gm-Message-State: AOJu0YxogQaXQYy0R804Hm7msoK/Dnklm76UBVAvZQdET2YCy/g9FZME
	/o4GBfcxXQxHx/QcUcv8UGaJY1coS48+zL5fzuwIaqPHoWamPM2Jt1hcr+V5cfw6Hh38enjzJ1c
	1O1NKPg==
X-Google-Smtp-Source: AGHT+IGSjr1Z3OhxNz9dfLLKABYd02SZ571PQhImUccBq/yfu26m6bEeYX/aMPNvCF+2MKljsYf6lw==
X-Received: by 2002:a05:651c:1509:b0:2ef:2555:e52d with SMTP id 38308e7fff4ca-2f7cb37f0a1mr102256571fa.45.1727195654708;
        Tue, 24 Sep 2024 09:34:14 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d288e0dfsm2768781fa.77.2024.09.24.09.34.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:34:13 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so75833491fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:34:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSEZp+597H+Pdb5llzAuVKVycRNjrjCIp0hydXNz8WTLd0qhpMD3L0585gl81hi1MbDiSfQjpF63fUxmkN@vger.kernel.org
X-Received: by 2002:a05:6512:3995:b0:536:5509:8862 with SMTP id
 2adb3069b0e04-536ac2f7f92mr10434069e87.36.1727195651396; Tue, 24 Sep 2024
 09:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110348.tbwihs42dxxltabc@quack3> <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3> <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
 <20240924092757.lev6mwrmhpcoyjtu@quack3>
In-Reply-To: <20240924092757.lev6mwrmhpcoyjtu@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 09:33:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
Message-ID: <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 02:28, Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-09-24 12:36:14, Linus Torvalds wrote:
> >
> > Do we really want to call that horrific fsnotify path for the case
> > where we already have the page cached? This is a fairly critical
> > fastpath, and not giving out page cache pages means that now you are
> > literally violating mmap coherency.
> >
> > If the aim is to fill in caches on first access, then if we already
> > have a page cache page, it's by definition not first access any more!
>
> Well, that's what actually should be happening. do_read_fault() will do
> should_fault_around(vmf) -> yes -> do_fault_around() and
> filemap_map_pages() will insert all pages in the page cache into the page
> table page before we even get to filemap_fault() calling our fsnotify
> hooks.

That's the fault-around code, yes, and it will populate most pages on
many filesystems, but it's still optional.

Not all filesystems have a 'map_pages' function at all (from a quick
grep at least ceph, erofs, ext2, ocfs2 - although I didn't actually
validate that my quick grep was right).

Look here - the part I disliked the most was literally commit
4f0ec01f45cd ("fsnotify: generate pre-content permission event on page
fault") which at the very top of 'filemap_fault()' adds

    /*
     * If we have pre-content watchers then we need to generate events on
     * page fault so that we can populate any data before the fault.
     */
    ret = __filemap_fsnotify_fault(vmf, &fpin);
    ...

right *above* the code that then does

    /*
     * Do we have something in the page cache already?
     */
    folio = filemap_get_folio(mapping, index);

and this is all still in the fast-path for any filesystem that doesn't
do map_pages.

Do we care deeply about such filesystems? Perhaps not - but this all
still smells to me.

When the code that is supposed to ignore caches exists right *above*
the code that has a big comment about "is it already in the page
cache", it makes me unhappy.

                      Linus

