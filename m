Return-Path: <linux-fsdevel+bounces-59399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27722B38662
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF759842F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207E21F03D7;
	Wed, 27 Aug 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NVGw430n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F97212567
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307918; cv=none; b=dI1FIMg+Uhtl7LG90Tyo9UAPDRjO6RccJ7nsqUuG1dpEoo6cnOhZzrBJ220lVoEq3A8bgwztarZZ7K2tHl3nnhMPSkG47bqoMn45VYNvQ7o6OE11oZdbC5ust6i/pr4T+bFmYOoSDlPSvrsMxVogdRmBddRbHWJprKKmMxJTaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307918; c=relaxed/simple;
	bh=2LYGRgzEruwj2br5fK1I0Y4qo+QllOVPrAwaccHSDY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeiKb1Qk8D93fd1h1K3Vl30HR3/+4Bf9nQa//Pt5ZcV+nrpGcb86XtDCj0hYsgvg6QgNUjPzjdVSlpn0ASFzEOtfLeOWAjJj385VJX540QCLxamazyf27xGmKx8czCk8FCwI2pXgE9eaIwwrvScrUXU3cpDS93psnDhLwQo/qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NVGw430n; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b2b859ab0dso42877611cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756307915; x=1756912715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt5xHMtkVvuzpXoWisN8eCboq+fuhc6bO0I1q9wXi50=;
        b=NVGw430n44r0v4I61Ps3dwSbE+1rXfNQT3IxitmLm006AHHz93GSvE6uazbE6Oq4Ir
         wougAueuaFcBaJCAn86ht/zI14hvy4QoCBVC1W2cC3qNRahSAjeQooC5J+DW7WwDTd8l
         JmYIGhDtOWPiIW0gZCw469w3gUKzor7rqi+Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307915; x=1756912715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rt5xHMtkVvuzpXoWisN8eCboq+fuhc6bO0I1q9wXi50=;
        b=aebi4bG9LxPCRy/POQhDcuyYURHElEIGpCug2HOJak7lYD/kOQtmpmqlVrWhwWIY0Y
         tFVR3POR/mxZD7RzguOoUXooJ0hGAMfxGLfSLQH+A+3GVFuHf65KT6V6vrc4KQIFTitz
         mt8ON6+EHHKCJyfOZzz7EA0YCU4ghW6iRVtbYlXXbZwO3bn/kgoFGswJVGMP+JAWWaFm
         4fzrOMdgZ1Z9lxWih2Q7oOWvFhhvRfQbFvb8PHJ2ck4TDR0gtSJFoF/JrUFh2nNxrY9E
         9ZSkKdOr8MCfBziWcqVdL5k99o1y3nn5SYFXw78S0zLgQbfQ6Vw7zjz3EqnG66RJHK8k
         RllQ==
X-Forwarded-Encrypted: i=1; AJvYcCVed6XzPt0ElNpM+Fv2DGBTye3oR3V3x9jDxEMz4GFRuy8Fvjl+cCFZ0NHqn2VbtPG1T1yzqZrmmGHkUJDh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaers9RK7ERi247RG5NJo3vR4VmYbOBG1ql7LyPk8c80bG5xbr
	+04is8oF4Fw1UNoPU8XamhDh/B9gm2VVUygsCKptAlAYVzKZVFjh4+7uqwfG7GnKUxrSI4ax1gO
	OwzJlR/5H8Ro6ZVufhyjxaXEKpjqANjFITo51y3OoVA==
X-Gm-Gg: ASbGnctKeppAVcB38MvduECSCvLxSwLBlUtCWDEjX1ZOtiMpShhpU5cxPqvz5SeVVZ+
	QdbKw2uhKu64N83x1n5j908gt4FZsKybNBifC1BZ74LStj2Fxeu+Vi6E8S6MUfkOu/TaWuGvsUE
	tqGTg6reaKFYYbOrNx6GzBeGElbzoeRFAunsFGyB3r1PnJH7n6eTFD34QNWpZVq/L1zucOt9LFH
	cndMjuSqV4IvmyYl+Jo
X-Google-Smtp-Source: AGHT+IEj7CWrQ7nlecxj1i8qN1BD3F4tB2iVYrGFG6zS/Hb1TrcE3vv5KPVF/SDCZ72GjagTv42CK9i6itl7zRo52JA=
X-Received: by 2002:a05:622a:5a96:b0:4b2:fbb2:d382 with SMTP id
 d75a77b69052e-4b2fbb2d8bemr9697661cf.34.1756307914847; Wed, 27 Aug 2025
 08:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
 <20250826193154.GE19809@frogsfrogsfrogs> <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
In-Reply-To: <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Aug 2025 17:18:23 +0200
X-Gm-Features: Ac12FXw9vVGl3DZdLrR4PKq6vHPU1w7nqcZm0RVQq_fZzO0Wg2w0Da0aFxdA0-s
Message-ID: <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, synarete@gmail.com, 
	Bernd Schubert <bernd@bsbernd.com>, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 00:07, Joanne Koong <joannelkoong@gmail.com> wrote:

> Isn't the sync() in fuse right now gated by fc->sync_fs (which is only
> set to true for virtiofsd)? I don't see where FUSE_SETATTR or
> FUSE_FSYNC get sent in the sync() path to untrusted servers.

Hmm, it's through sync_inodes_one_sb() that fuse_write_inode() could
get called, which then would trigger a FUSE_SETATTR.

Does anyone know how useful sync() is in practice?   I guess most
applications have switched to syncfs() which is more specific.

In any case, I don't remember a complaint about sync(2) ignoring fuse
filesystems.

Thanks,
Miklos

