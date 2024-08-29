Return-Path: <linux-fsdevel+bounces-27777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A499A963E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5903B1F257EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2418B467;
	Thu, 29 Aug 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gzD8o33q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1718A94A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919149; cv=none; b=OKuaRZxtY6dkW4RlxRMjd90sUX2LgvcwMB8xLnThFph7Ew5KOG4DfiFbGzzyac828TZgTNwFsVf2YWPGJi6DOPvvJU9bLDHB2NQ0vExhuKRzAfUfSnMaNhNRHZO1vt2Xe+C5N5QdWRHsjjmQ2YCHhJ/KybwZow1ewqUDax9DUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919149; c=relaxed/simple;
	bh=L3dPum1PytTKidi7Re63S7tX42qk9OmN+oPp8nk8jro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/2ZOcyyKES2yJzPRKkF+GlbxHJuEP8WA0np2Ih9k8Q42dccMqEdJZhl6a9KjqKg4nMuU0AtJeE/GnOAIEHLt4NRTU8IVIhgfO7PnsddD1pA/sGWhDN5B2APmejSJDwWYxJ4DCEfq5XVA5UwXxAd8ReGm27GrknmUZImy6JldxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gzD8o33q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so3764481fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 01:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724919146; x=1725523946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3dPum1PytTKidi7Re63S7tX42qk9OmN+oPp8nk8jro=;
        b=gzD8o33qSr+abtjgCLtV0LIZF9cUejr1Sx3SCl2pSPoD0mHSwAXgSoVMrjSZAlpMWH
         LwgOYNl3XcsrnG8kGxC2HuRaYRnRABtKTsMpfynEicnae7PDWZ0SzwrHYIBuAsYB8M7B
         SzYyjsD0Vtj3gtHZE0BfTSEpugfwFAP4Cst1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919146; x=1725523946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3dPum1PytTKidi7Re63S7tX42qk9OmN+oPp8nk8jro=;
        b=Ml+ZFknv3FodmhDmh+RYaxjTwhP20zYfDt20XrHM9ir6hm9KyrcN5A9Quzp85ji5Ng
         Ype94FcK2Dx0G0a95WC47CgaYAR2l39UCI2dAWO24Am50da15aoSZ7GHhQHz868XNNIf
         wCQ2cKQw1CPCMjWeCnT9WuGPkNdBlLAl5qtAcxJwldA7yrq6OEIOdX3JxClCDnBfEwER
         JjWih85D+8pzkT+/Ryy3yta+/ltobzDJnMbxLspWSEEr/jfUzdyd0a7SpCPBcx6nkBB6
         rfJKUyddPR8tIUApqevbmy8JcddQr6Y3hl6nMfbGPsbnUpMTCngzzA6Lvmdq6x8bJSu6
         +sDQ==
X-Gm-Message-State: AOJu0YxTSh/CnYjTAVVgcwG3AUccr1pjzrfc//4Oh4IFBdipu+O6W3yA
	QcjYEatKY3BA0zmWXrIykkpA1Bi93unrGJhM2eF7DpJ5F0uxBnCqfqB5xfDqp00NYiHyWVqUHAm
	Xxvjfa7s8HJ+Nonb269LKReHlDsdFSrlEAedMaw==
X-Google-Smtp-Source: AGHT+IEVrvNm6I1mTUWhwhHNR6RdQlhP5rQjSf7x/pRknmbwKlbIQMroy2g+xvGHAQQJcJHQr5FCGmbJqoRV6Ie8Ahw=
X-Received: by 2002:a05:6512:3f04:b0:533:32b4:ca6f with SMTP id
 2adb3069b0e04-5353e57d01dmr1092434e87.34.1724919145331; Thu, 29 Aug 2024
 01:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710101023.2991031-1-ratna.bolla@quest.com>
In-Reply-To: <20240710101023.2991031-1-ratna.bolla@quest.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 10:12:14 +0200
Message-ID: <CAJfpeguUtDLVgcnJ2T8u-zTwppCW+VyL9Lzs4Dxasx4t6mA_bg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Set iov_len to sizeof(int) for FS_IOC_GETFLAGS and
 FS_IOC_SETFLAGS ioctls
To: Ratna Manoj Bolla <manoj.br@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, ratna.bolla@quest.com, 
	Srinivasa.Rao.P@quest.com, Srinivasarao.Cheruku@quest.com, 
	Narasimham.Yamijala@quest.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 12:10, Ratna Manoj Bolla <manoj.br@gmail.com> wrote:
>
> Hi,
> User programs are passing integer pointers as argument to these ioctls.
> Many filesystems(xfs, ext) honour this to prevent corrupting the other four bytes.
>
> This was discussed in the fsdevel mailing list with subject "Argument type for FS_IOC_GETFLAGS/FS_IOC_SETFLAGS ioctls"
>
> Please see if we can be compatible by breaking correctness.

I don't get it, FS_IOC_[GS]ETFLAGS is handled by the VFS since forever
(v5.13 to be precise).

Thanks,
Miklos

