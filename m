Return-Path: <linux-fsdevel+bounces-56719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40645B1AD81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003B13B6569
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15D212D83;
	Tue,  5 Aug 2025 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ldPnqoDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2772E36F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370681; cv=none; b=HSrfLlxdfI+Z6DiQWSseKP31WCYgvnqblDTxRgHS86riURU6q+417B54E/qNKOiKL3vlo7pkwC0udsKZLaijFlm6jytHTtfxLS6tp1coVOUNuD2S5T6TDQ1g9bm3D9TUa4/yYT5NyuQuakY9kOAir/siC3iEJl9iCs2IzJ12JFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370681; c=relaxed/simple;
	bh=mCDty+ZlP6+w8QR2ne3foKy1xa8aHGrKC/hp/usLt+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AifIPAZf66eBMnplg0csl64DVhKSArpHZtooFCNAzJ7+hFQlopxdTgqVyb5qLJF4+FuotBVTz274goy6oQjdBM72JE2fZF8n+nxqdyO3+OVI0CZdtK9xEMe+Ju73Z2QNrjNrire8NAUl3FoeYqs9WbSKrQzHtZv6jo1CQQd7ZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ldPnqoDg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0619a353dso16760861cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 22:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754370677; x=1754975477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AW1Xtmn46b00P8P/isvB1Sm5uTkM5FhZYM9o3WpZEXE=;
        b=ldPnqoDgKYFjmOP5QEM3TkOEZAjL8S8QQefkCkBgxBESW+SS7quVdkOA3OYbu3weLJ
         7vg6vxu4YHC1T7Q7sDgv7cCyukgrnSZQ8e0au6P34UoKZDjtd5FMzZwDGSz6yujhrpL2
         cEUZV0PxQUTGwJoDjcdzZF7lI8MR+D8vq0u7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754370677; x=1754975477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW1Xtmn46b00P8P/isvB1Sm5uTkM5FhZYM9o3WpZEXE=;
        b=DYFsYDStB8AJ++UrpiByQyVqweF+AXOkOK0g+E4BAe4dv16ACvvlsNcQytCvIUPNrd
         4ABP44zPocoNPOVmrOUsxPLrvn5+brntnSE0iv43FnV9jydCxrTGGG2SdLr9/zI8LK7V
         hjy57kfI22VxdXp9OVfJ3aed/vtTNYo0wnhDsTP5mN0SLMLxYskLqhDgcslv8xz5jPpx
         Y6a0MgxtU3ZYT3Bla78CpfFbduNp98kzTypu5AQAB8oxT52Crp7xUB9WNWmI+HmjQ+6V
         kofj2SULPJeGgqTQgHpHRLOWTDoGkngKaiwIb7saDO+kqSWkYVCbWOphi0ZufSkSJRqH
         MrCg==
X-Forwarded-Encrypted: i=1; AJvYcCVjBzE97tvJdaTmWCvEGVg7qkr3fm7QpEprQsm1ldf2HhXg/0f4rlkewhphgRWG9Df6mxnLUkSB1PZo4ZXt@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVhX1Vvm7AdFDfv1Z11DAjWO2aQKPho+7Yi7KmD/fLsz2oPQx
	h3oElbjI8h4qVP4nbVxnHNezUmU3EKSUacFrainKD5QwL9RctWgPmSPi/MBalCvVF8AfiiqJUk8
	KU9aFNbyAar+FZW+RVzVQfkRuTV5D3pImkDDsLogJPITsl0/HIRM4uoI=
X-Gm-Gg: ASbGncuw7dtMGSr1I6MXf+9yJceNAwZnKSyC+ylojaOVGUJ+emq5QFk3mJBeAo17ixy
	I5jL/nvAj4tXaawGevOuavT+kYehMVNaXONAVXl2iWvHkaxW4saAIgBqdOJY0Zs8cKwJYYo3TwU
	vbfa7z/qoEdkbXFsheEwJnsKvyi/sxpIlB61dcnvA63nvrSSmkuHIz0AjtLciIEfkxRYxGgwlVv
	Sw6r+A=
X-Google-Smtp-Source: AGHT+IHQGK84Q/7Of1/rjZsOOf6eSVganroeRmny3JrYilTOOOF6t6SFMiZ9oiLay6NwME0BGdybf+B5Beon+jthJvs=
X-Received: by 2002:ac8:594d:0:b0:4ab:3c02:c449 with SMTP id
 d75a77b69052e-4af109e1677mr197635351cf.17.1754370677111; Mon, 04 Aug 2025
 22:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804210743.1239373-1-joannelkoong@gmail.com> <20250804210743.1239373-2-joannelkoong@gmail.com>
In-Reply-To: <20250804210743.1239373-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Aug 2025 07:11:06 +0200
X-Gm-Features: Ac12FXwS4XP1zNJ1caLPxRxitwyXfW7ZOEzKOirzkoaGYV03VcmnzTTHgso0GyQ
Message-ID: <CAJfpegsH6TEQO_Cbj5Tc7z_dYTfnE42rpi13HrfA0WbRmWs-=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fuse: disallow dynamic inode blksize changes
To: Joanne Koong <joannelkoong@gmail.com>
Cc: djwong@kernel.org, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 23:10, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> With fuse using iomap, which relies on inode->i_blkbits for its internal
> bitmap tracking, disallow fuse servers from dynamically changing the
> inode blocksize.
>
> "attr->blksize = sx->blksize;" is retained in fuse_statx_to_attr() so
> that any attempts by the server to change the blksize through the statx
> reply is surfaced to dmesg.

I expect no big breakage, but I'm quite sure that message will scare
some people for no good reason.  I'd just keep a copy of attr->blksize
in fuse_inode and present that in stx_blksize, while keeping the
internal i_blkbits consistent.

Thoughts?

Thanks,
Miklos

