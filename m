Return-Path: <linux-fsdevel+bounces-12053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082CC85AC23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10761F22EBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDB50A98;
	Mon, 19 Feb 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="clB7stdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4450A6D
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371528; cv=none; b=m8AJyCeVZiXdF00KKf9+guCz1CVgitF0FYXDIMf9pDKPOKiv3vPeaoc+Ml1ny6fbQJ668YF6VKo1+2BQU6zNTZ5zP7Tnu3tprXjJecUTic/H2/GPtR4nHbJgxzboRxoHE8xdm3c0YMaviejiiPF7WaNmGwYlDc0OdJC1Tyceuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371528; c=relaxed/simple;
	bh=jCFlgF8j6Bu0dVbKyh9IVM6Nk7kQp9VIx098lOAfJn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbuKu+49L5/6j+/5ZGAFXnhkZVdB1GYVXfO/j+TvLMRLSsKsRS9gtxkLYjskg+wMDXDsECkH6F2NL6gWxLtY5xRgBbrS4FJh1FOtrSrtXkMrvEWRbfETHBMJAvlVhGYVSTJYRIdNDTiCXPsFoyWETKq3o6cykOSnE6SAfk1rJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=clB7stdV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso608390366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 11:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708371522; x=1708976322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7QqAiKW/REifSDEOyZbsbJV6hqLykfLJEnMJzbEaKs=;
        b=clB7stdVDsB06BCctNbExyW8NWPNijRZhq7N4O85eoU//WLNsMYzigr9AfjB0w++Pr
         Tjjoo1M76vqL0CWot45qW8mSz2hRKVV9H6FGPacw/jC+rECLKJDxpYJ8K7TD7x4/Ridd
         DpmzQszUr/7zc+h7s7fghEzZx3PXFuBckscQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708371522; x=1708976322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7QqAiKW/REifSDEOyZbsbJV6hqLykfLJEnMJzbEaKs=;
        b=UNoq4DMZ4gMPOqxieEWjrS40FrGw3oHYcEG7fOBgsStfqsgxIFZ+R/lDNUHzUXLNuf
         PoKhs/QWQ5F99T/LajpcjuTIr5meDDnwCYbym12UrJLrbVuyLWYx0bqd9LUEsc/lbSM6
         SHW93zru8nrH7SzXx7LWzo9fUPwkBlMvlo6U8ZO8BxTmuJ6T1e4UuCVCbE12z7QrnoDm
         67EDnPXqM7iCz3AZFXkbMj4Ra3LVu3Gt37tbw9oSaGRU+IQHf4fJgSbTCWqI02onqK7R
         seU6j6/SeRb5CyutQ1IoHWQncY5IyNfXB4dp8rTxhDdDHpq0v+GdLnY01clVlAT4to/R
         A7AA==
X-Forwarded-Encrypted: i=1; AJvYcCVHSy4xH7fZIm+tpXYIJTGduQ7VcfOVtwAtA4yFYB+3Xpn8dnOmLuHXLYzgatH+4+X4aPIOcg1qbVg8J+VlqfFr2pdlNkHXR97S5tiywg==
X-Gm-Message-State: AOJu0Yx1Ls2lYUkQxRP4no4pSrgA1d61XonQKJpmPi1aTG71YZKsMVqB
	1MYxOCPct1Ue6rwn5D601OWiwNJ+gih4jc4IUO/dXhuaFM4GeH6VifIVC7IgMvOY2Ni9QB70iR1
	jYI1d/jxi6TvD4prCTHPdWrnu1bNawsy3MPHdcNi+5EjxS43U8Ho=
X-Google-Smtp-Source: AGHT+IGCB5+5y5E4Lxf1Hr/Vril4gp0jtd5XT8xihtXP2r9npZXADtn1ZCIEpfCkYomqDWdKuprYtlgnaM4aQ1OComE=
X-Received: by 2002:a17:906:5f8b:b0:a3c:f4d6:657e with SMTP id
 a11-20020a1709065f8b00b00a3cf4d6657emr8701031eju.69.1708371522610; Mon, 19
 Feb 2024 11:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
In-Reply-To: <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Feb 2024 20:38:31 +0100
Message-ID: <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:

> This is what I see from the kernel:
>
> lookup(nodeid=3, name=.);
> lookup(nodeid=3, name=..);
> lookup(nodeid=1, name=dir2);
> lookup(nodeid=1, name=..);
> forget(nodeid=3);
> forget(nodeid=1);

This is really weird.  It's a kernel bug, no arguments, because kernel
should never send a forget against the root inode.   But that
lookup(nodeid=1, name=..); already looks bogus.

Will try to untangle this by code review, but instructions to
reproduce could be a big help.

Thanks,
Miklos

