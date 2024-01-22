Return-Path: <linux-fsdevel+bounces-8414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882D83620D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 12:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4CD1F28190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641844392;
	Mon, 22 Jan 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkrZTEWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4944383;
	Mon, 22 Jan 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923058; cv=none; b=m+DKwlEPI87nAvOa5DWviZWzgQ0b2YG59qNVINuwxfNQZQkFFf/jsqRnNQNIWvIORgKTAEAoIBWRB4nBrAhoRrlYrcXpeVIpc542d3QpxhEfFycKA5K2YVsV5DJAMvYmE9hTcdH+ej2mTuq2v86XN7UhoPYMtSinf7NGk8Z8XZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923058; c=relaxed/simple;
	bh=zcVAxKfwOUmbMO3DAhPWLyj3eObc61sh4i9Uz8AGnCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7OV9GHJ0vBQxfjV2rTmoc97LMZ3iZpbP66UZZWDvoUm7C7HFrIYOMP/68wzedB87/97DmDym3hpUreymRLCBjlR8zhAfYLpcwdYbwbacTtQe8PEJUuqS5o5Dwut2RevcN9wF0rRc3p6IuwvEv+Lh9CdIWr/HVaugjAuBTnTmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkrZTEWO; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b71e8790efso691872e0c.3;
        Mon, 22 Jan 2024 03:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705923055; x=1706527855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zcVAxKfwOUmbMO3DAhPWLyj3eObc61sh4i9Uz8AGnCM=;
        b=PkrZTEWOnblMw5bi0A+MYH5inyYywPwFRuPpGqy1YUNYZHFN0V1X/GWkDoNzv62XTo
         42q7/QHU/d+QJ/mBjBJ1GDjLY9p9DLmzUaq/LELTBnNeuZE7HutxGLHdt40Y7Zs28GF1
         enOTDP11hFD5UcElmNaahh5DwQO+LSME/mKAU5sPQvpxld94IrMT+bOaFJG2w/fCEn1O
         pQMkhVL1EgLvXRWXpshMHc1FmKvTmwgAOSJU9TnBuwIeGz+brbP18gbEB8LjN/q/GrSD
         DlQwifTAlegu//liolPYNHXD1sn5wO2SwOmMKVkqA6WECbH7y1FA6kfyTdlni259+82r
         ktPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923055; x=1706527855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcVAxKfwOUmbMO3DAhPWLyj3eObc61sh4i9Uz8AGnCM=;
        b=Pk8BDPM0Vc9BwBuuUyZiDxH0Z9SqGqpzzZ4mXGdmNQZUa64LaMeCtYPSB/1ELuswQ0
         ql+SUAcJ8IB4gK6wBoTQehdzCA/a/b3/kY2fxIdp3x5h7GuvbCJGt6xaY7bgiNWU2B/e
         yYQUF8/19cEv2Makdb6oSggUvVE2OZnITLGHpWDHsPMosmmyB6PLMovhwaEFrAuhQ/32
         aubyARuxTN0JCGZwPeI5sHEnfLYqyHuKXo2xilSkWVqQ/E7Y4di2REemwm2ZVWLLUy/U
         RZO/QTFDnD2AYMcBt+3+iLUlOuhc8Qm7wsr8BSTJ4QJwn6dWvkZ90wdY7hIkLyFcVl5U
         9o7w==
X-Gm-Message-State: AOJu0YxhGR1QZmiFieD15a7MXwyFbpDIMKYKaw+AoNOxSc0/xHMGl1UW
	rmnib3WBXLOZMKEULoCCNykI/aYNARxYhp4DFwNfV3NVpdcpho83WKfgt1LOYHAMnuuMtyyKgZC
	9g4kDslV4EXMprDDRmB9Y9wFR5LDbw1l4Es04wQ==
X-Google-Smtp-Source: AGHT+IEi3nxGy7jjlcg0ZIYvmFU3xW6Uvz+kXbQpX+9XFZdTuB4+WUJm+uu8jld+pvbIEAETbV7tgQhf+5E/8LwkTNY=
X-Received: by 2002:a05:6122:1789:b0:4b7:1685:9f99 with SMTP id
 o9-20020a056122178900b004b716859f99mr1353510vkf.12.1705923055546; Mon, 22 Jan
 2024 03:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
 <CAOQ4uxj_EWqa716+9xxu0zEd-ziEFpoGsv2OggUrb8_eGGkDDw@mail.gmail.com> <0473f5389dd1ada08c73479612a4e054c8023d94.camel@redhat.com>
In-Reply-To: <0473f5389dd1ada08c73479612a4e054c8023d94.camel@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jan 2024 13:30:43 +0200
Message-ID: <CAOQ4uxiYQp_1ftooE0z6MR4iqjf392QpaaptgRwT4ogaefo8aw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Alexander Larsson <alexl@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Alex,
> >
> > As you can see, I posted v3 with an alternative approach that would
> > not
> > require marking all possible lower layer roots.
> >
> > However, I cannot help wondering if it wouldn't be better practice,
> > when
> > composing layers, to always be explicit, per-directory about whether
> > the
> > composed directory is a "base" or a "diff" layer.
> >
> > Isn't this information always known at composing time?
>
> Currently, composefs images are not layered as such. They normally only
> have one or more lowerdata layers, and then the actual image as a
> single lowerdir, and on top of that an optional upper if you want some
> kind of writability.
>
> But, when composing the composefs the content of the image is opaque to
> us. We're just given a directory with some files in it for the image.
> It might contain some other lowerdirs, but the details are not know to
> us at compose time.
>

Got it, though I may need you to explain this again to me next time ;)

If we were to change the tools that pack/extract overlayfs images to
mark directories more explicitly, we would need to change other tools,
not composefs.

composefs has no knowledge of the fact that it is packing an overlayfs
image, until it is asked to pack a whiteout or a file/dir that happens to
have an overlay.* xattr, but lower layers do not typically have to contain
files/dir with overlay.* xattrs.

> However, I think it may make sense to be able to mark non-lowest-layer
> directories with either n or y.

There is nothing stopping you from setting opaque=y on lowest layer dirs
or setting opaque=n on merge dirs when packing composefs.
Old kernels will not be bothered by these marks.

However, I forgot about the consideration of xattr lookup performance that
was the drive for erofs xattr bloom filter support.

I guess erofs will pack much smaller without those explicit annotations and
getxattr(opaque) will have better performance for no xattr case then with
opaque=n.

Thanks,
Amir.

