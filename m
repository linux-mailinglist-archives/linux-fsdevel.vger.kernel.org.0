Return-Path: <linux-fsdevel+bounces-27816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB0964472
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B24D1F260A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA98A197A99;
	Thu, 29 Aug 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VlloGS0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DCC1922F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934620; cv=none; b=EvLiFmokr6Wh3Xsnls0z/1ClKI491c92JIYHBzYBfqq1ekGN8oLK4G13NnT4cp0fTiXXyevMUcnpvcZPxu2uIZ+IsAPmIaho85sRm0M+wZyy6/3Y63oVHPYXOGdn1X+jDumBcA1U5V9BEuF7jS8YGHPcb4HQ7R3Kkut7JZHdNWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934620; c=relaxed/simple;
	bh=c6r5N+p5e0daxU7CXz5nIWMWNCoTF84WTktAT8Y9Z+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AN9hYBDSBCN9m2UvgxVn/oCRWUFqLphWeY7JLyo8priYV4sfAeyJFuEDGCIPPP6VFeChO1u8z8iopwMG/TZZKeOamzT59KXS+2bBY5LP+QyzswGTEJwA0JCZQyBmY2JhC1UCozKNft9N/e4tsZ/hq0o6dtKStM42BJUdg+x/kVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VlloGS0t; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533521cd1c3so696393e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724934617; x=1725539417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsC+gfoM6MaBZP3mn7x0NTnh7K+ZhhCt3TESRyjjWWk=;
        b=VlloGS0tSgTB5rdX++T11Wm1X/JDaU256NgGpX+xiz6c0wfbzSr+uUTffIW6xQQ7U8
         berEjIumkjm2dpzf4k71BqfM9NaHUAekrYlwv6LKaUt9tCEHGiLmlK1tcsaOa3QMu0gD
         GdxKAK4qq53lixR15lvkJrEQNGCDHKKn9LVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934617; x=1725539417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsC+gfoM6MaBZP3mn7x0NTnh7K+ZhhCt3TESRyjjWWk=;
        b=OMWCCWCEQGLQNlMWkOXBsSTt8jmRviQDqFNPkKlDaRzi68bPzam37xlYULLNHvHiYk
         jdTrbRPOy1ZY7CUqHKk5wIjcVYMe1+gd/NxZuVmUZowMkzSEI1lGpuFCP1vJviQGEsHU
         V76pW7ar0yht7twWCoXWCS+SZq/ZrHRl8t1QObpdUqs1JRV1m/olzpRaHpcqunGytck3
         rXUvTWO32LeA0UEMk1SNuY91+nqbh+DRqSi5S4ghSGVNLTvEYTybNMBfz6kYxR8gTs//
         46o6YCTA2ESb3DGWMaVs7wt+fMuiWw4J09xNIX7FiRPktzc1tUShblN7pPRw3L4dnmSL
         wI2g==
X-Forwarded-Encrypted: i=1; AJvYcCVds26WGzaaFeOjIS9dDm84X7Lb0+ssM6TzJMGEoQXdjrGQRcdxiL0o078yhCnz3OldDSzCVrQhNyxiayZz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0hJXVzSQeaGQOFOodptLnKwIQKwB6/sFkTYjj9AlWyxDq8gF
	w0DxK4zHRk3dga9FJb0XTHzo1wc+KaPU2IFtUMjLB4BabJR/jS34AIO2svgBSVv6hRz52cfBBrH
	WoZpOQnxghmEimTr8H/XYINYOW1vsEh2PhYRlO6/tUV29ALPTr3A=
X-Google-Smtp-Source: AGHT+IH8clhYKqNN3t6yM6mWOT5Z3clueVHYpFdRhAMDFrCA17blK2kPxMHWFSZTS/0A41zYP3doO8wp8aARXzRVg3E=
X-Received: by 2002:a05:6512:3f19:b0:533:4656:d4d6 with SMTP id
 2adb3069b0e04-5353e5432c4mr2407794e87.5.1724934616618; Thu, 29 Aug 2024
 05:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com> <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
In-Reply-To: <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 14:29:59 +0200
Message-ID: <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, mszeredi@redhat.com, 
	stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 14:08, Christian Brauner <brauner@kernel.org> wrote:

> Fwiw, that's what the patchset is doing. It's only supported if the
> server sets "default_permissions".

My specific issue is with FUSE_EXT_OWNER_UID_GID, which I think is
unnecessary.  Just fill the header with the mapped uid/gid values,
which most servers already use for creating the file with the correct
st_uid/st_gid and not for checking permission.  When the mapped values
are unavailable, set the uid/gid in the header -1.  Should be better
than sending nonsense values to userspace, no?

Thanks,
Miklos

