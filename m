Return-Path: <linux-fsdevel+bounces-58370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E296B2D825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEDF189E007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED92DE6E8;
	Wed, 20 Aug 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J7vuicUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3602D878C
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681418; cv=none; b=qtG9BT3NoNh37EqIDv/dvF+8e8Xg7k8DJKtsfYjoeXRM1lmZOLgm4QLd7QaWyCWZhwEFMPJSNP/LtFoKX558Em0y8SNcygjcKqCSxx6qByg64hSGR0noyjOqBfTaVzRAtSbVDbrRB2AOMCWwbWTI1CRcPndqLAEy+Z30WvvKdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681418; c=relaxed/simple;
	bh=q219WXvDP4oLUQwVnDjQ7gTlRvF7SU22s0Lhi5W2tHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/h4opV5jdyPBFfHTvt8ulasqV871EDeiGpMBV8PiqRuYkAd8yIs86BytEqNh9UBrwvlJYNsT4qkHDXwH1zy2Hjih4I7Y8YBR6QzmgVEatR78GtAueZQwR8KscSXfECtvsRrVmfuCeEa8lEcrxvdgSnxYIBuGdG0J7PkJzcGi3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J7vuicUV; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109919a09so76667701cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755681414; x=1756286214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1iwAnRJAv/JiKKllZb4QS5if4zRUIKZpKjeFppjkizU=;
        b=J7vuicUVWX3ZJSbMOLy0egsZIV8xoGQMhY1+dGbW99P0T9xoOr6Drn30kORTDHp8v0
         T7bAp3ETtVM90OF6PQQ7qVSp9RAbg4kM2c7u0Ml053A1p3r3RrpFx0hMuMzBEuD/kaGi
         OcbbofWvflx/ubT9sQhRAYvF/jWP9nQUmEh74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681414; x=1756286214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iwAnRJAv/JiKKllZb4QS5if4zRUIKZpKjeFppjkizU=;
        b=cYpQ3H/R+1E34bz34QdZXeTnZcr8dkz4q+WudtPk2upYnUpqR+uyICVfA8+E/c4/pS
         zM0oHZ7pPir5UJtw8+VKaQYHFL+d8yiyCFXmo9ajJNbYY1GLetXjtHAKSiNSdxu16UM+
         I2u91AJ9675MWObnIc6D9s9iFksk6vvXeJ6xx2u+5kwCxOl4e8wkLfcPpdRtE42cOQe/
         Uh8jo5K3h4OmWLNhifnWRor+UGGWg3yUXzn87tppRT5YbsFM0uId5ATglb6unHFeNEz/
         M+ryIponNzg+h579rotyEAFLpLYH2TX9e7cfPB238RB7m6UZ/DjJ4VtRJrK5vH5Zxj9P
         1tjQ==
X-Gm-Message-State: AOJu0YzmhEdvYpgi6P4gItcBOsnI3bsXRzEBzNNFFk1e77XpZ/+itwWE
	lFoX7YQZv9wEyKdZ7Bx5g+lVEitVzsxSHyPlio2gwFKf6dkiyY4unetPMPRYykRJC0ZTG4ccd26
	NOkigsqK5MkJM2x4s+rmc/GCxeVWpFZGluJzvVyfFUQ==
X-Gm-Gg: ASbGnctHNPeUmT1EunaT0qdf4W+v+Uet6aBsu0JTKgoEzAm7azbXuRQ9M8nSaWuSh+U
	zm0cNAPH16/FiGvrljQpIeLV1eEIyIUSXTihvVkOJdshhuP62NBuAzHjSsM0Yx20YWR+sXQIEjT
	PBubf8DOVo6ELNrR9xZRolhRLE2xydoYspNZn4qq5p/HKu/6QlNdXcXV2xZIhPMtEqZWN90wYiD
	k4S2AXmCg==
X-Google-Smtp-Source: AGHT+IG7UcYEC4Fslzez1Kqr2HyflYWIrIhU9+VVsctAev2UbYNh4w83dEwFocKPP7kWQMpItWRuCAHYiNxNbdDNpog=
X-Received: by 2002:a05:622a:40cf:b0:4b0:7327:1bf5 with SMTP id
 d75a77b69052e-4b291a5b0eamr22424791cf.6.1755681413461; Wed, 20 Aug 2025
 02:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs> <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs>
In-Reply-To: <20250819225127.GI7981@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 11:16:42 +0200
X-Gm-Features: Ac12FXx-ju9_cOUmSgRVGygC_balX5AA2EyOZ-yWOFAuoCfqvh_w5HhsA7OYzZs
Message-ID: <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 00:51, Darrick J. Wong <djwong@kernel.org> wrote:

> Something like this, maybe?
>
> #define FUSE_UNCACHED_STATX_MASK        (STATX_DIOALIGN | \
>                                          STATX_SUBVOL | \
>                                          STATX_WRITE_ATOMIC)
>
> and then in fuse_update_get_attr,
>
>         if (!request_mask)
>                 sync = false;
>         else if (request_mask & FUSE_UNCACHED_STATX_MASK) {
>                 if (flags & AT_STATX_DONT_SYNC) {
>                         request_mask &= ~FUSE_UNCACHED_STATX_MASK;
>                         sync = false;
>                 } else {
>                         sync = true;
>                 }
>         } else if (flags & AT_STATX_FORCE_SYNC)
>                 sync = true;
>         else if (flags & AT_STATX_DONT_SYNC)
>                 sync = false;
>         else if (request_mask & inval_mask & ~cache_mask)
>                 sync = true;
>         else
>                 sync = time_before64(fi->i_time, get_jiffies_64());

Yes.

> Way back in 2017, dhowells implied that it synchronises the attributes
> with the backing store in the same way that network filesystems do[1].
> But the question is, does fuse count as a network fs?
>
> I guess it does.  But the discussion from 2016 also provided "this is
> very filesystem specific" so I guess we can do whatever we want??  XFS
> and ext4 ignore that value.  The statx(2) manpage repeats that "whatever
> stat does" language, but the stat(2) and stat(3) manpages don't say a
> darned thing.

Actually we can't ignore it, since it's the default (i.e. if neither
FORCE_SYNC nor DONT_SYNC is in effect, then that implies
SYNC_AS_STAT).

I guess the semantics you codified above make sense.  In words:

"If neither forcing nor forbidding sync, then statx shall always
attempt to return attributes that are defined on that filesystem, but
may return stale values."

As an optimization of the above, the filesystem clearing the
request_mask for these uncached attributes means that that attribute
is not supported by the filesystem and that *can* be cheaply cached
(e.g. clearing fi->inval_mask).

Thanks,
Miklos

