Return-Path: <linux-fsdevel+bounces-57537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B663AB22E73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1971A25D99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050172FA0FD;
	Tue, 12 Aug 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+4g/Efi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A7126C17
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017944; cv=none; b=pRFLs06FEo9n9VIyyR7syR42qnVcc7kO54eYona5bwgJBdZmBRx3s7m2rYKAJOEOTLi5SPgsNY3RDKKmBQfPcZnaWjGQopVc9i3mtCFMZORVcEfiLa5t8QdWFjt5ru3hBXDNSun27Hi42AUJZ9YYn4bKd9u3/F5lBhLlRChfCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017944; c=relaxed/simple;
	bh=SibeW2U2WnGKJjoCvqQ+x3RIR1dngSmzKWci1qJZzoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aad7mGYtxm5VKgoEmPKk2sfYuh+DfnPpY8XzpQLMlBRM27zPIrXHsfoK0VNoVY1o29tcHjfkekgi5TEbUMWi1/z9ztxF+50lMifRsmQZJgUw/9YZgMDSBf8GJs30gSI30y5cIwYqOKnbHC5lju5PX91ifR10ovCieROBFOs/iSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+4g/Efi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0e607a957so9739691cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017942; x=1755622742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr3CW9p1Y0qv8q9NqMTReU5nix/ZVNNX2NqzNHGcVFI=;
        b=J+4g/Efi+VMHZTbBIosrEaYClhcj81g8L6xFbhw26E9nbbYG5ItiFzJoxfi+zxw0uu
         aLuT8QOiB0tSIOY3MU1ky7UeC5rbvnhpvjs7ENO3jIi2NnS1jSQ3mT4c9Vx1YUCQziIT
         sDAFpRVcEDA8FR9W/+XZLj+L7dY32JQHLOOiI7awYBrFCsvGHhNz2CjHtY4Y/1t17Izy
         /PMuA9+vX50T6ygxkOhMKQ8VGktckK+Npd5Il+UWWBRZjVf7cPvpQQy2UnCeWNaGwLGb
         +YkJnoXvpWPd9w+gmVCzg2Zv5DEXMLS8p4owUyjn1W12+CiVC+vSakbFruOqhGGVYuNj
         JVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017942; x=1755622742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr3CW9p1Y0qv8q9NqMTReU5nix/ZVNNX2NqzNHGcVFI=;
        b=PjLW9a+7wYh2uTWOBdY/9iaqP7gC8YVbyyFpupUoSnSYXI2//3nEhYk0sFYfez3qoC
         WUmX/nnIbqvFARJCAH5wi57g3ad6S8S4WbD54EGylT7vlNL52CC2ceC165xYuk53kxvK
         wGV1178RwL+s2/nC6tgq/Bl3jp0tdGI6/5WzpHFKE+NwqhI7NJLW31YmJnlaaegO/3om
         IKcBRfIQA0gmrGm/k1sW9km+ucgmabhaYiQCat1wCIfu+XI1jhUDMWtyfiyCZHTDxUV9
         b9asVz5d8d4OUbXQGa4tv+N9AYkKHxcaweo1c9LXdmI2hbtUQ5HW6EUkuZqWFSAOmUGh
         9s0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4zynBkrgjxW74GvsmxNyGhAczgwoVVtVWmt49wcctz1ydr9evI+FuF/rnIZlkEOF9fSz6RBhvAaV/usb@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOIpIxsVfrFBVbS06lf+z5G6YIxui99EJz4bDH1J8fYBIX/an
	4PVkL1V4d2i7IkY716ysBUk9Zil0MZeP2EXtHHEtpCNsdiR2NmzrjXyVVby2jEMM2cpzAqBfmBR
	p9ltIXguXZWDMt9r6p+Sxgjwf18MgTwHIcA==
X-Gm-Gg: ASbGncuu5vYqQY+FDoBUc+bTS3b8kOQNHMuQQyg1r3UZcm2gxa9LCWVUdLokxBFn/s3
	eB7Gl1rkJFyHO0ga5ROmGU5JuM5fmQRU45A3LaAW5B+XR6QotCaYr1ASbCzqICaQXbGEeQDfJeh
	cjApwjx2RjLhVgD5rNz9He8vPh9J8SwDYtTEstQYmyIuuKvTNkxT4/LjbGE55LE2zaHzoDyYw7E
	kwDc3+J
X-Google-Smtp-Source: AGHT+IE8N+QKwcexhYzZ07kzSL2xwAaHXqOAZ1PxIhRpLz7xXUaFfrx9zhlv4DFaDz+CKj/fiIkecu2usOp+gVAKu5o=
X-Received: by 2002:a05:622a:2611:b0:4a9:a90a:7232 with SMTP id
 d75a77b69052e-4b0fa7e8fc5mr5086411cf.13.1755017941801; Tue, 12 Aug 2025
 09:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807175015.515192-1-joannelkoong@gmail.com> <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>
In-Reply-To: <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 09:58:50 -0700
X-Gm-Features: Ac12FXxRXeExg9vPytAmiKHGLesinfhVCHHmC9gL4hbvRVUDfW784yndOztuwU0
Message-ID: <CAJnrk1Z9hPV2-Bv5hw3XJHOg_4Df5p4ZHJ6MHYH1ScwND_xVsg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 1:27=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 7 Aug 2025 at 19:51, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > With fuse now using iomap for writeback handling, inode blkbits changes
> > are problematic because iomap relies on inode->i_blkbits for its
> > internal bitmap logic. Currently we change inode->i_blkbits in fuse to
> > match the attr->blksize value passed in by the server.
> >
> > This commit keeps inode->i_blkbits constant in fuse. Any attr->blksize
> > values passed in by the server will not update inode->i_blkbits. The
> > client-side behavior for stat is unaffected, stat will still reflect th=
e
> > blocksize passed in by the server.
>
> Not quite.  You also need to save ilog2(attr->blksize) in
> fi->orig_i_blkbits and restore it after calling generic_fillattr() in
> fuse_update_get_attr() just like it's done for i_mode and i_ino.
>

Oh I see, thanks. I'll resubmit this. And will do the same logic for
the fuseblk i_blkbits patch I submitted yesterday.

Thanks,
Joanne

> Thanks,
> Miklos

