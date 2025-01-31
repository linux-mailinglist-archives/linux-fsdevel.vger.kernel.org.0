Return-Path: <linux-fsdevel+bounces-40513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9AA24347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2895C168048
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 19:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A781F3D52;
	Fri, 31 Jan 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eE3yYIQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7C1F2C4C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351767; cv=none; b=nxAiiQqhSHk5tdnvAUxIq0RvgSYPeU3qGQEd8/DOSxcaSk6/KPXL+kfEHdXYPjx5odPstAmS6iCm17MT6sFv1fttfQhaakE6PpP+PKInLnx5hQ49cnW+O3CMSweaHVQoeIcx8GdZBEP1EM/zLhjdBFmeneM0wnJW0LMd/ciypAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351767; c=relaxed/simple;
	bh=6mNZ4xvYrztdUt3VAEmyU76MqqlVzCskyl9xs7r1dWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KycPgBnhCwJ3DomRu8tFeBw7juwuLJIGBah196Dbv1134uxgTSa6GOLzjMWBzueW6pyGCa3tcAsIHgmYap4qmHO2QyqLgEtaAst5kfRpDNl/iGzJbgPuQ90919YbqzxSdW5CkuoJcgzMcuDisWjt8yzJqEQ59LSlPbxgOXRaThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eE3yYIQj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab6ed8a3f6aso337117666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738351763; x=1738956563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFNlmVKPYE7jDmEVaBZiuv3Xu6NPqXC5SQ+g/XnBpg=;
        b=eE3yYIQjdl5WbRRCZtZYCSRz/tBJa1WbTuw1Cik2rZrQ0Gk3aOeubc+pAhh/sFD7vB
         ypAymTxqVYm1n9FOxLSjtq3Q3htNZ5lrMPHCPdUhaedVR0ZAT7ENeZXIXRprKy6mRHXl
         JXvKUBuc0nfMOlOFaOCXt0WyPu7DHc0x2iNV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351763; x=1738956563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxFNlmVKPYE7jDmEVaBZiuv3Xu6NPqXC5SQ+g/XnBpg=;
        b=Y0EE0SNRQ7Za9o8okEyssC7lZ6umXhqF4PoaOnAz2eNwvvh1eVQ8BrDuUsxsjC3sWV
         i9FSrLn7mSDFpQONdhCgia4TiNSq7h5J7SkCCz8FZrEdOPvItlOW8+EQwNhEUkRxk5mi
         q/jx1+OQNtO9+B2pCRR0H6cmbwuXAFtiYNYqjgmU3d6Vo+xvLNHgQK/ZuwORsWrIcEjY
         jzpfv9VgUvR7wTp00d+PI1OfI3QJXMfMbA0DjB0xG8v5B0lnEnZS0O+1wBSFYL3SlqFX
         07IXo6mKRgO2l/TZXRcjig2J4W2VG5NHbKLGJfi3LjNB8pKhReuF7yy953SxdhPUNaht
         +C4A==
X-Gm-Message-State: AOJu0YxqzTKencXkOO/M9CfWer8jrGyZj0TDH9CL4bar1/rpUvDSaFss
	3CsW/rV5gWTx8yS5DIheOJ7pBvMRDrBamK30/oatO11MHtepH2pe/wf2D4ooJd4SBxuR11eG4pD
	3vx4=
X-Gm-Gg: ASbGncug1MzOOY95OqyqDQ8QbJ3iONjbresu7Iiw+iGEJQ0ixY+lTHHMcG4y3PAq4Dd
	p7aqI0I+M4YrdSS/vOlOfZKnRXzqdFng63m/UJEf65s+n8ENAa2Cz5n1xmzCVXKvWav+PXs3+NR
	jc/GCdTdhhBctAgLFCzwnwS0wzZyBm2PN9DA8NiFKAaTb6wRwOa7jXb9vsPnVIwoD5Yop3F+e9X
	f8gvDZhjlfX6QrCqPAkx5dQwv/z4FFd7vsclgrvKCe97KJnbeXo2+A6Io8NPbDjBCYOTcl6vbvA
	ZBqHomgWDNsUIM3Kty+HKRcdrjw23++vP4lcF5Yy0q4zUJdufblhiYiSalUeEJEXtw==
X-Google-Smtp-Source: AGHT+IEz3kE7p1A0NnX3F6dKRG4pRiSAlodhhZ6BYw+xpM0wwucnh84sxuaY4QYzjxleEXuaPdEKjQ==
X-Received: by 2002:a17:906:9a93:b0:ab6:d400:354b with SMTP id a640c23a62f3a-ab6d40035c2mr1111904666b.53.1738351763243;
        Fri, 31 Jan 2025 11:29:23 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a81adsm338421966b.36.2025.01.31.11.29.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 11:29:22 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so4943990a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 11:29:22 -0800 (PST)
X-Received: by 2002:a05:6402:2551:b0:5d0:e615:39fe with SMTP id
 4fb4d7f45d1cf-5dc5efc6853mr15165022a12.18.1738351761971; Fri, 31 Jan 2025
 11:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131083201.GX1977892@ZenIV>
In-Reply-To: <20250131083201.GX1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Jan 2025 11:29:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0FbExNA0nHe=VcJy1j=uNY-YvkzQcTCCOEALwPuWzBw@mail.gmail.com>
X-Gm-Features: AWEUYZmoyR7SPaQuBvAWZWXEc_WnFsswAzunTrabZrELh1KDYlXROVtGNDi0GL4
Message-ID: <CAHk-=wg0FbExNA0nHe=VcJy1j=uNY-YvkzQcTCCOEALwPuWzBw@mail.gmail.com>
Subject: Re: [PATCH][RFC] add a string-to-qstr constructor
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 00:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> This commit lifts definition(s) of QSTR() into linux/dcache.h,
> converts it to compound literal (all bcachefs users are fine
> with that) and converts assorted open-coded instances to using
> that.

Looks fine to me. I do wonder if the cast to 'struct qstr' should be
part of QSTR_INIT, so that you can use that the same way when you
already know the length.

We have code like this in fs/overlayfs/namei.c:

        *name = (struct qstr) QSTR_INIT(n, s - n);

in bcachefs has

        return (struct qstr) QSTR_INIT(d.v->d_name, bch2_dirent_name_bytes(d));

So both of them would seem to want to have that cast as part of the
QSTR_INIT() thing.

Or maybe we could just make QSTR() itself more powerful, and do
something like this:

    #define QSTR_INIT(n, l, ...) { { { .len = l } }, .name = n }
    #define QSTR(a, ...) (struct qstr) QSTR_INIT(a , ## __VA_ARGS__, strlen(a))

which allows you to write either "QSTR(str)" or "QSTR(str, len)", and
defaults to using 'strlen()' when no length is given.

Because if we have heper macros, let's make them _helpful_.

Side note: you missed a few places in the core VFS code that could
also use this new cleanup:

        struct qstr this = QSTR_INIT("pts", 3);
        ...
        child = d_hash_and_lookup(parent, &this);

can now be just

        child = d_hash_and_lookup(parent, &QSTR("pts"));

but sadly a few more are static initializers and can't use 'strlen()'.

          Linus

