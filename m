Return-Path: <linux-fsdevel+bounces-27215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D095F9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97A11F218D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A97199244;
	Mon, 26 Aug 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lrc+uev0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15248198E70
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700278; cv=none; b=iBD6vP3OYm4m38MjdAYG4vYT1aWt8UZyWvZjteKuNfbY/swkYVviOzQv5DYKsrhUjmMEcoYeJr36ptsfre5AAHOae4Hh3wRyqyBaOzlgk/8IzaotodmwiMU7C3I5zMg5seAoQT5gdU0t4x/d7EOQsS704U+eCEXCU8Ll8Zd8o04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700278; c=relaxed/simple;
	bh=iLVCxBE7eTfwj8ncMZ1E4YQjRMItTW30tjdhn2aqe4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp1juft1mc4WIt0W/5/OYoV3e8gzSC5CfKJ6gcxSo7Wy4ayzvTWlYFRtnMhA1IfNIf+HZNNZrWA8cvo1zFPY3+rG6ibK8ptVpI1kNMVUanhLtYp0ecxf2pNl1eOXAempskuZb6jey40By+0gkcKi6pX3cxa8uB74QJMTLNxLprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lrc+uev0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c1ed19b25fso37756657b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724700275; x=1725305075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pdl8rAPODNH1DYUiul4n7cS3RmcHlTUnkI9dMlMOkk8=;
        b=lrc+uev0H6o9HFwuznDWtj44djUGQlDLVncqoDWvy9nWZfoFabdRoQZBqz3QfwmSdt
         MIq6pOTpjaqfvvTEM5/+KrWzXoap9KGUkEYYz4BLTMac+m/UG242yRwmPD0x+ZoaZN3U
         pNY3oeeLu/Er69Jt0Nks0CgGD9x69z86Iai8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700275; x=1725305075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdl8rAPODNH1DYUiul4n7cS3RmcHlTUnkI9dMlMOkk8=;
        b=eXYm3KNxjd/TqiPNZUeSwydiYgoG+Xm34zqvPrP0wWGEV7pzxTR7/npO8RSl2cEoF4
         GCPtuNkRKrtxAdRWeraJKP2C+oZG4ocy+Pwi3VJoe/r5mbYbqs2qrSvfuZhy7aGwMmsR
         I9bGrTIxFbfo3mtexGja8vzUBxjZ+HjFBlDFn/7b/HJfpVWmHTE5M4D90pBv01WxyL8Q
         VSc/lmm4aoKijOnU+oZ1zoxcptA8wJXNRH/GWHydwaQkNHpf8sjjT4XROiA3uGgMHN9+
         ytjdd/hymLs8Z3WBfBcOVqt+wQNUbeVhoqmFyZqk3D8XJYGVexlyXmNATc0wmbYwnLMx
         kDxA==
X-Forwarded-Encrypted: i=1; AJvYcCWmXJQjY4YMgR08tLkGe/eqGM0x65KvD4lpVFjO0aLGsRlzruLNSu1viZIFV5vX+/qElyCU1Erhkhc8yXSG@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHeLckkiUW4G9mmf/Z577ERATcfF7gdqQC0VzvWprtN+Ettle
	O/Jpjg72cIl+II7z3L97hz55Qx/RPVGA85pn3TO6kztxnS9znxwgytXVsrhtrpkASnzzGghFslS
	0vVOUe320Z4/ERAajl9a0snkMffRXO5CmeZVienhtfgErh3nI
X-Google-Smtp-Source: AGHT+IHNK95lz7RoP/iiwKLhCzvfsqOhNa34m6ooBrxcZ4bZDzpwzVUsRqAmYcqldo8byzdXXEPDx3ROFcEFWTWWuL8=
X-Received: by 2002:a05:690c:fcb:b0:65f:d27d:3f6a with SMTP id
 00721157ae682-6c6249dd335mr126663547b3.7.1724700275110; Mon, 26 Aug 2024
 12:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824092553.730338-1-yangyun50@huawei.com> <20240824092553.730338-2-yangyun50@huawei.com>
In-Reply-To: <20240824092553.730338-2-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 21:24:22 +0200
Message-ID: <CAJfpegsFvE-oSaYqNWBAdiXnBYWGAp+Lc8cjL3BWs9bd+O_c2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: move fuse_forget_link allocation inside fuse_queue_forget()
To: yangyun <yangyun50@huawei.com>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 11:26, yangyun <yangyun50@huawei.com> wrote:
>
> The `struct fuse_forget_link` is allocated outside `fuse_queue_forget()`
> before this patch. This requires the allocation in advance. In some
> cases, this struct is not needed but allocated, which contributes to
> memory usage and performance degradation. Besides, this messes up the
> code to some extent. So move the `fuse_forget_link` allocation inside
> fuse_queue_forget with __GFP_NOFAIL.
>
> `fuse_force_forget()` is used by `readdirplus` before this patch for
> the reason that we do not know how many 'fuse_forget_link' structures
> will be allocated in advance when error happens. After this patch, this
> function is not needed any more and can be removed. By this way, all
> FUSE_FORGET requests are sent by using `fuse_queue_forget()` function as
> e.g. virtiofs handles them differently from regular requests.

The patch is nice and clean.  However, I'm a bit worried about the
inode eviction path, which can be triggered from memory reclaim.
Allocating a small structure shouldn't be an issue, yet I feel that
the old way of preallocating it on inode creation should be better.

What do you think?

Thanks,
Miklos

