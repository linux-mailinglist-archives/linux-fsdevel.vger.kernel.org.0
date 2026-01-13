Return-Path: <linux-fsdevel+bounces-73507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A337AD1B08B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A609B307A56C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1889736215D;
	Tue, 13 Jan 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD9JtAPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4534DCEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332277; cv=none; b=oBOJ2Eru/pJzDvMz38vQIqiApO1vcCaVBEdUeMJ4zi2F1o2PbudBrtktAzVG4m1999Rm7n0Abvc3tBsFspnP7X184XWrvDWB2O3r7FR7dECZz7av2kWiAN+K/Aoq4/MpITm6yXdSEBfd65y/8+De4s56Rmv6+TPs47WKEbn6rvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332277; c=relaxed/simple;
	bh=w4v+BwX2tgJ0XT3Ynx3Ta5J3Yw7ZRDmO9U5J2is2t7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrlBNguVXjmOTuGPZE1UJSIkpL8wlRvoCs8P78Ae0pOkgeHINAwa8mYeYSjeCyucnN/cE6Bf91TXg/b9EljLQFo0NkZ0kfr+jd/B9rmvwcvkIBf0qN1amnn1uV8Uz40bJM+tfV6syllg4uphvQaFzzC3JxllTcXm1eQL94MsTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD9JtAPt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb5810d39so4169474f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768332274; x=1768937074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OiWidXDlc9SIxtf//Pc3bF1d2VDX0rCMR5B+TBktRE=;
        b=UD9JtAPtaIQm/J+3ZFhViueHB/WkjJU+YJsPKl6LHs7ja5erVP0en3pohY/ZVgQG/k
         eyWzj0M4HS4eiNhM7VLUgP+2uB+UdmJaGTJZzKSS/rxnnrwP80tkeEpktGGkDx7VH2Jk
         iNO4yCQ5Yn3aBqqmR6e4LoCdrCNoXgBS1PKZ8X20iSHKJyrq1Bb7ZNmWggVgKmsIEt2+
         bYIt4VtzOToFtAhDMx4YKc1Ibrl0mbkb5i8V72wn2dFBuGw6zDBgthUb341aDs//Xq9y
         BbaZHBo7dwLkWVwapSpVkkn58M7L+bRf4hstNjG9jR2K+7KQ0/e4tNj9t7C4uCCoApde
         1rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332274; x=1768937074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OiWidXDlc9SIxtf//Pc3bF1d2VDX0rCMR5B+TBktRE=;
        b=NcyOBBBs+mPBmnspSzLKyK7KfSx2pWm0pIZvNWDiP2Nro3elu0/Nv8Kqi59zZpPb7Q
         hM6+HcCj8v36TH08ZVMILGPJBCOA4ik06dMupJKSjlbXAkC+QoMSneb++WJe95+x6zGN
         U/IhXGsG0TmEiPPs8Ac11kCET670zE8yf9nNVsE/kIILJIHvuWvkxSj772ceyJDVjpGP
         RcSSAPx6boQbSQPPnidlVnXhIMVN/DVW398KntGQXHjzhO7YaZfyQjzpvlrvwQs/76yt
         huTgSUwFBkSayTE/U/6x+bLMZokqUsLjfdrxRvluFoLzVwHvsh7SACgsqg8IiSmXzi4E
         3XZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjKXvslGB1A6QJojdLo2BTeeS5Lu+akuNqr3B/meav/busE40KkpYIdfPAWTzdcyVCYDc3D1WNqlyBVaUs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XByRitn1kVD1KEFsMD7tR72rlev/g16bxdz/XOyUtnZv8FnU
	cDRs71PxP9XzgEm25A/XJQ4pRArDLrocGNdZZsRormkfKc8HCX5aLvPf
X-Gm-Gg: AY/fxX53inu8Hm2ZCAGdKO4sn3ny2Hb4Sc6DLpr3Y6dp4V/MVeq0idgChPxG9MLJTu0
	NUTtxTg6ME3NX6lr63UBJAdAWG3XgNtJ9fe2Kz6tO05F6RwO4T/G28OGlzZU6TH55Mw0QCqDnGP
	Tv5RqoeDh1Tl6QzpynjBg6T3sAsz18R094uTqnrK0COgCT9PCDVwBUwzqcL1CPCrWbtjSJAOcMr
	qR2gNsP5ga4p/z0XyEh85JoynHW2tAu41HHYx1R/OiFzoopRMYxrMAL/wTkO56pj7Xfgrj7XOwB
	n3jRtaHzYQNI0TcX4C5jz3dSbOZ+HVlWrHxUi5vVnT3jOkl01ntj+0UJEhfjkRylyH4vjhsBJtG
	+e2M+jmpzWGubybZNDK4bCtPVCoAlh2SD3rSrBc4s2HuugrR1SKu11tj2nYLI2UP7MA9bB38hER
	Co5t3ibkW9VuUYxQ8Q20YL+3vTnkCVnrX4ny1+uROP0AJiV0oyz7kPX/ZzE+0EWHY=
X-Received: by 2002:a05:6000:1a85:b0:431:67d:5390 with SMTP id ffacd0b85a97d-4342c554c46mr10986f8f.54.1768332274380;
        Tue, 13 Jan 2026 11:24:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm45481323f8f.21.2026.01.13.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:24:33 -0800 (PST)
Date: Tue, 13 Jan 2026 19:24:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <20260113192432.25a799f4@pumpkin>
In-Reply-To: <20260113183346.18ef7c74@pumpkin>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-31-david.laight.linux@gmail.com>
	<62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
	<20260113183346.18ef7c74@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 18:33:46 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Tue, 13 Jan 2026 16:56:56 +0000
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > > and so cannot discard significant bits.    
> > 
> > This breaks an arm imx_v6_v7_defconfig build:  
> 
> I hadn't tested 32bit when I sent the patch.
> It was noticed ages ago and I thought there was a patch (to fuse/file.c) that
> changed the code to avoid the 64bit signed maths on 32bit.

I've just sent in a patch to fix it, compile tested for 32bit x86.

	David

> > 
> > In file included from <command-line>:
> > In function 'fuse_wr_pages',
> >     inlined from 'fuse_perform_write' at /home/broonie/git/bisect/fs/fuse/file.c:1347:27:
> > /home/broonie/git/bisect/include/linux/compiler_types.h:630:45: error: call to '__compiletime_assert_434' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
...                       ^~~~~~~~~~~~~
> > /home/broonie/git/bisect/fs/fuse/file.c:1326:16: note: in expansion of macro 'min'
> >  1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
> >       |                ^~~  
> 


