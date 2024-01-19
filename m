Return-Path: <linux-fsdevel+bounces-8345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8492832FFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC2D285E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866A57302;
	Fri, 19 Jan 2024 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KWiHxkn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFEB1DFCB
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697353; cv=none; b=HGXhrmcvVyI1HzSMKB4T4KTxUhTUAD/vNoevD9cA20qBtwSm0SzopZxusVnaAaJjgN/0QHxsR3RFcA3SM2gHMTPRVax4dYkKT6XEp18csoUOPH1rUPtru5ix6eXfPJsZUYWhGo1fkMS4/jIcJ0C6id56MJHuZP5PVqCyw9m1kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697353; c=relaxed/simple;
	bh=3jb6pFXBSFVel6dAZ3yCWtN/P1QVqxFXuuMbdaVxdrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfM7MsN8Xc78o06Obra8sdk0v95clnJKvxAJOts94AlOfhztWkrfdLUCMmGBdG5blLEt2Ppf5CdCG1O5pUgNOFVK+Ymctm1XVKMNgqOaVIsifHpQfqQaBSqlS4AsK3feu3ggtJcRnyeAGiUo+5QO/f8s/pZhJWuCke2A9uetXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KWiHxkn5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso1465660e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 12:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705697349; x=1706302149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwBOP0/0KVAJ64wSBYfkOvyxv07cQW8DEklEE4ytW+o=;
        b=KWiHxkn5ZEhh4iW3mHjc8iPD9fd5H/nvCuRdMdCXb4c82xmD57SArOnO/z60JJ/Qxb
         siKdVvOmOMJs5hKjHOA/miCYJswVim9AvDYCkgNM/fswfRRuAQHK3W4uBs1KhcRHLyg/
         XMpdig2mA3+0+7YIT75RrUmq488m4C8mDQJkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705697349; x=1706302149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwBOP0/0KVAJ64wSBYfkOvyxv07cQW8DEklEE4ytW+o=;
        b=ModLVcW2VSFJ8d5xcfjDLOaCS4j9GGJhBRI6mcnGq0J7NzX96XAz6ALki2a2utcBu0
         rYsOeY6zCBC6hCBlqu44DGtQh4xvHFpiHI99rHLKlG1QHlEVbcwieGSfhpqmkJHScUeO
         Qaq6sUzM+dCYZ8xv/RdaCw/wypUfrdRCn98J+e/dpger9FWlzvei13WrZN7OAUbaA0Yj
         IHMB9U2W8wi0R23weXIjZn88eeJ2tpvbSD2Ngy6qoj1889CDCMTx15obt3MRGta7Z6zu
         eYazImDwZZlgFKiKxfJxN9aXRKLAblvpdneFYqYRY3QIGkI9r0WSNsYubwOmXYnOm3VV
         hJmQ==
X-Gm-Message-State: AOJu0YzoOp8JtTvQ350qLzhNhLVSUHYkQRlR+dkI70RL1IflaTRLWb74
	L5Peu8Kp+XB2xOfNHIQKLEzqXyP4ieI/1PftQ+4awfv91EGxlNSp9dtGSiQ7CdNBISxiAsyod4Y
	ZbV4EXQ==
X-Google-Smtp-Source: AGHT+IFs3GMdw5rxjG2KLD7MEhclgYLeaLxQo5v8fve/nWXEReboKg7PG8r2lSu4Lrx9a39Gk9k1qA==
X-Received: by 2002:ac2:5e9d:0:b0:50e:6784:8614 with SMTP id b29-20020ac25e9d000000b0050e67848614mr73108lfq.101.1705697349301;
        Fri, 19 Jan 2024 12:49:09 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t20-20020a199114000000b0050eb7941041sm1113081lfd.297.2024.01.19.12.49.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 12:49:08 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd46e7ae8fso15731071fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 12:49:08 -0800 (PST)
X-Received: by 2002:a2e:a585:0:b0:2cd:e286:7514 with SMTP id
 m5-20020a2ea585000000b002cde2867514mr86343ljp.141.1705697348071; Fri, 19 Jan
 2024 12:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119202544.19434-1-krisman@suse.de> <20240119202544.19434-2-krisman@suse.de>
In-Reply-To: <20240119202544.19434-2-krisman@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jan 2024 12:48:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
Message-ID: <CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dcache: Expose dentry_string_cmp outside of dcache
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, viro@zeniv.linux.org.uk, tytso@mit.edu, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 12:25, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> In preparation to call these from libfs, expose dentry_string_cmp in the
> header file.

Let's not make these header files bigger and more complex.

Particularly not for generic_ci_d_compare() to inline it, which makes
no sense: generic_ci_d_compare() is so heavy with a big stack frame
anyway, that the inlining of this would seem to be just in the noise.

And when I look closer, it turns out that __d_lookup_rcu_op_compare()
that does this all also does the proper sequence number magic to make
the name pointer and the length consistent.

So I don't think we need the careful name compare after all, because
the caller has fixed the consistency issue.

I do also wonder if we should just move the "identical always compares
equal" case into __d_lookup_rcu_op_compare(), and not have
->d_compare() have to worry about it at all?

                     Linus

