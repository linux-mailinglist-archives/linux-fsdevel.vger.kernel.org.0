Return-Path: <linux-fsdevel+bounces-59594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2992B3AE65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F296C1BA03DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351272BE653;
	Thu, 28 Aug 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CiALKVpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387867082D
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423280; cv=none; b=JPLROmV0wAMqbt9yT8OvcQx6Il6PjLFE3Fp2lVYIUn7ETK43ta8M1oydWg4IMQvctyBMfwryF/4Q1+XKOaV72WosCFrxPuULUdYKZgLSGYQhnToBscoTY8s6EHcyCpcMaPbIr+uG0jXwWy+oXbpLrIIMXaHzFyoEKfLUTd/lp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423280; c=relaxed/simple;
	bh=kzxeqn0y/Jw55qoEJpIv+iq5jusIg1XxHAfxU041/yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg+kw2IplgIjHxMTLhHvsh24zES2Ict/kbg0NVjX7ZlbRILnzAwuD5CUqeyFl33p2Kl+plx79q2mOioqLP0hZEmwx0MRg8S12FvF995xx6xytuOpoU5jH8IssS47CQZ/vZ2aSs74GuVAaBzyW3E3YwgwDk4+41pdOg5KAztriOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CiALKVpL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afeec747e60so167010566b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756423275; x=1757028075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy0jph9IJTMOMVo/vS266b4fuGUiTdnREeuDBZ+DxqE=;
        b=CiALKVpLU7NcqDMRinLZMLSlYCm1IkGOy6eSjd8Mqze5wZqtcEEYaWpupCzDMlVVxN
         4mC721f5T4PLuDTqcgY8dN31sGCgu0aglrKsdsTOjokA+RGY0YyfvUzW2M+Hzek1m45V
         2LhnfUnszQEWDL9oC6k7l7mpk7GKrlixK6djw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756423275; x=1757028075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fy0jph9IJTMOMVo/vS266b4fuGUiTdnREeuDBZ+DxqE=;
        b=gVKJOKzNa86nNJaqPJZZPFGrLtGRjU+1pYFANVAj3CRrOelCjt+6xRej7cZ5ExSM4r
         dP1YF1PfgPUmgXeyzAc6PdZasvamyy38waAhqoppvFy7+Jto+mySwARumXkb7oymRTvF
         RRgO6C8HQSIdfL/Bwy7Jo4IzoJV8TMmQQjskqyVsvZJLeQZjImfaTQAY5cTeAE2U5+AF
         mQvJcFEPDT5t0pjZQEif/wSJzVYRqTcR4dynLqrwt3YuIryMcQp7wIKqL9Lz72SOKPWD
         epZK2UUCXVT8RDce7680kpHPqgn1MRihEjfKE9jpNNiON/G6Bj1yHfrKxbPIshP8D+O4
         mv4w==
X-Gm-Message-State: AOJu0YzdU1D3CpE4CFztQwHgNttti6rcgxqaFsiWpwDLjPyL4mUJE+ac
	B2hB5e396mQFNjI1rI8x9Z/RomKvDcilut2uQ5XyYW40QUTQGYQbeXTKerjMm/MerAL8pk8LzsU
	aQKorCqMtEQ==
X-Gm-Gg: ASbGncuHi8sY3O5ikhmMAugqcJtd2DUnDzZ488z2mgOkTdFIqn3dPVomqBoCO+tIo8m
	TVru3mhbHOPMy/CYcLV7zi5Bo7B7TDkU7M19fhbk+Cw26s8D/yl8xHVXZhZIfAeacH1dYmjsIZx
	ZaRWcfHAP3gBL1gj1i614EvQFqEm5aAf2IZqnmEOaHM+CWJKXJC89zFDJd608nW5h5J8k3nNnlq
	id2VuK+Vq8cc49OoLmWM2LxVqzlkMDaFTgJgO5P6iErN/r9YF0l8Yj/jak8+dJ1Pc7enWuzWtyG
	i3KQTS1K0h4GcQMibAXfqH4HGSlaaeZRpSdvR2WqPUqDCyNF+eQNlb/foB49Ewj1T0fUYVrennG
	CBZHcTpJy7rrW9mKeAanP6Gnba+S8O/+Bdx+DxJ6LPWBAdhnhLScMB7t+XAGD+LsggmSuJpBAEc
	I1mMUlPTcCFcbkZSJKKw==
X-Google-Smtp-Source: AGHT+IHD0wgIFwo8rYWmPR3IkaVgWXUS+wZAkv19jo6zqsxXbQhGvlQiN+cba5f18gNH8n5ZY+C7gA==
X-Received: by 2002:a17:907:7f8b:b0:afe:b92b:28e9 with SMTP id a640c23a62f3a-afeb92b2c77mr927461566b.49.1756423275188;
        Thu, 28 Aug 2025 16:21:15 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca08b41sm61556866b.25.2025.08.28.16.21.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 16:21:14 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78f5df4so260304366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 16:21:14 -0700 (PDT)
X-Received: by 2002:a17:907:6ea6:b0:afe:eb44:f90e with SMTP id
 a640c23a62f3a-afeeb44fec4mr394548066b.39.1756423273897; Thu, 28 Aug 2025
 16:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828230706.GA3340273@ZenIV> <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-33-viro@zeniv.linux.org.uk>
In-Reply-To: <20250828230806.3582485-33-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 16:20:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2=v4cV6=jaxjA6ymaadxiWRRNdfzPa==EY6RQxWni3w@mail.gmail.com>
X-Gm-Features: Ac12FXwEoX6QtLRB37-QHgpFM2FioE93LTzPF8A65DjFcSOA2G2Oyq8QDVL5Tc4
Message-ID: <CAHk-=wi2=v4cV6=jaxjA6ymaadxiWRRNdfzPa==EY6RQxWni3w@mail.gmail.com>
Subject: Re: [PATCH v2 33/63] don't bother passing new_path->dentry to can_move_mount_beneath()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 16:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (beneath) {
> -               err = can_move_mount_beneath(old, new_path, mp.mp);
> +               err = can_move_mount_beneath(old, real_mount(new_path->mnt), mp.mp);
>                 if (err)
>                         return err;
>         }

Going through the patches, this is one that I think made things
uglier... Most of them make me go "nice simplification".

(I'll have a separate comment on 61/63)

I certainly agree with the intent of the patch, but that
can_move_mount_beneath() call line is now rather hard to read. It
looked simpler before.

Maybe you could just split it into two lines, and write it as

        if (beneath) {
                struct mount *new_mnt = real_mount(new_path->mnt);
                err = can_move_mount_beneath(old, new_mnt, mp.mp);
                if (err)
                        return err;
        }

which makes slightly less happen in that one line (and it fits in 80
columns too - not a requirement, but still "good taste")

Long lines are better than randomly splitting lines unreadably into
multiple lines, but short lines that are logically split are still
preferred, I would say..

            Linus

