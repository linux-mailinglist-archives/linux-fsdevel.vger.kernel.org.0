Return-Path: <linux-fsdevel+bounces-16907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2368A4A27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E77B209B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 08:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE894594E;
	Mon, 15 Apr 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YrE7l87z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA04DA06
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168912; cv=none; b=tJACQZBs6Uy+rO/LeTbqp5tAvrOEen464B687soeWJG2Fe98C5mpNAtRM3f3NUY4HUQpqMYcZcFFLTA1gW65L4CI1X7D5l6bjU2TUJLf4G9AIxVKv1rHja/gReea2kTFFXX9iM7QcnzfKc8fZ3E6vu8KH57k099SST5YzY2rXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168912; c=relaxed/simple;
	bh=S1m1e2bI/gQvrAci+OwbqC0fzLGX0+vaBIEuuOTDhuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyy8ITggzYk5j+QHHGkMAc7gFs9Jk3HbJfm3iKOwNxvZfR4UOcfseYIuMkz0c0y33dCjhlKMQWvICV8X7tJSP1R2vifBxVxkES4IGsGKGPQ+Ecim8nt1Z0uWPx9u+/nI+a2xvjTk64rVV5csf+aAwLrpMTMAQ7qoVprGuJhJnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YrE7l87z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a53ed18f34fso30811866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713168909; x=1713773709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/SAQyMuBh2qddjwOjqsIgHDRRpgrnq27KkxONgfckM=;
        b=YrE7l87z1lGgKbGPZYnpqbhia7uCMO8wOnVCelscTGW5/QXVJgeGLF8jbKqpihB5LA
         n75TzzFyMfDUfYNYK3ZWCn/qoaAN2CIuf1g5AWCERxziU/7n1oLLjsHHQ0vTLDvT5tWV
         GNTSxpFGOOyQFWzXlwiyqeMrwOvf92WeY6bWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168909; x=1713773709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/SAQyMuBh2qddjwOjqsIgHDRRpgrnq27KkxONgfckM=;
        b=Un//h8k10xIEaFseJE5mYGr4q9p65COnPFmCkMz2t81hGEsD0x7zUc+/xznAN5dlDF
         6KRLEMyPy8KbFV7MzCZQ9yM/Z6mRMupilNqttB/bRUVhwkFJ8F2ggMrsq3rSBMzy+FyU
         bPbkE28dut0LPe+P2fSMo7w1b5A6mCv6yCNXTCkdTzZWaqKCqwUnqOgYYfS53Eprv5Sj
         9b1y2/rJIDObYZ03sDPzUJ8qR0d8XM2mhqazXOj17t6hsD7RXC61PKRxhamDhw0TGioB
         JM6ENMJ4mIC2Bckz1i/2TEbnDnvry7CbveuVWQtrvC7WXyxLkQvkU5nU8z6q5hdh3ERz
         h/gg==
X-Forwarded-Encrypted: i=1; AJvYcCUyEXTPlG9+pkdfwT3ZUT8KsPzSVkghcGA97sjDYSP34ID+rFX6qOWrSxohjeI/KT3nPB2TAV8sKbDnzlnBQ1uWyT4uMaguECCoMQy9SQ==
X-Gm-Message-State: AOJu0YyocFrfJ9+ayJgRiXdKVtf5chL8P5b6KSGAFnOmCC1T/LZfbO0q
	xc4Ugh2O/CwiIKZk041lS7TmtXy4mKay7mTOALDKefvdtbEWm3oJMG6mSeL/i5TKHaSRDnjNAau
	2duwL9q01KR/Cvdj3E7Edn1eThI+y4chb4bEwDg==
X-Google-Smtp-Source: AGHT+IFoG9lavipRsSKRXr8zt7FeNIbCz4tLKb+wfb2lgCeUjSIBFe2OJqgvzWr4KBj0Sc56LtUAQL5TC9vNbYrzfSU=
X-Received: by 2002:a17:906:e0c7:b0:a52:5df1:84b7 with SMTP id
 gl7-20020a170906e0c700b00a525df184b7mr1918580ejb.10.1713168909003; Mon, 15
 Apr 2024 01:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407155758.575216-1-amir73il@gmail.com> <20240407155758.575216-2-amir73il@gmail.com>
 <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com>
 <CAOQ4uxgFBqfpU=w6qBvHCWXYzrfG6VXtxi_wMaJTtjnDAmZs3Q@mail.gmail.com>
 <CAJfpegtFB8k+_Bq+NB9ykewrNZ-j5vdZJ9WaBZ_P2m-_8sZ5EQ@mail.gmail.com>
 <CAOQ4uxjtDAuMezRXCiVpBPoTXt6d5G0TWJxb=3QVCvp1+VN59w@mail.gmail.com> <CAOQ4uxi4Sm7X6bJ44tpkZBhKm-XHGFW-EuYZHcNKMp59E+ybTg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi4Sm7X6bJ44tpkZBhKm-XHGFW-EuYZHcNKMp59E+ybTg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 10:14:57 +0200
Message-ID: <CAJfpegue9QByOVKy1aehh8oanK4BuDBEvksdtjA0-x7t+X1thA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from
 parallel dio write
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 08:50, Amir Goldstein <amir73il@gmail.com> wrote:

> I see that you removed the unlocked check in the fix staged for-next.
> Please also remove this from commit message:
>
>     Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_open() is
>     called only on first mmap of direct_io file.

Done.

Thanks,
Miklos

