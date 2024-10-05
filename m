Return-Path: <linux-fsdevel+bounces-31088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FC991B3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF31C21095
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E728166F3A;
	Sat,  5 Oct 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gXhs+uWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599D5223
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728167718; cv=none; b=cEWAP7AtSSUbbIqN+BFiUePdM2w1qFh5OsrRPdRc8NWOSuJDCArvd9cgbL5j2HLUFKDGnJqaolQxJQSa5fizg7g7jXyJHcXt5Ohu1Kuw2ZWAVRCdjODPOcSewDQ+rgbFGUaUD8bf1TqNehn5JpMabu24UyojboiK3PHlXwUuA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728167718; c=relaxed/simple;
	bh=b+AWARzu8Thd5FUOfHILFpuGGWUetHMUNgu/HGN6+q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJz+vxh5iRDs90yMf1ZO4rhLbdZ3M+MWxmZ+zZ0gm5PmUuI0BRM5iYW9VSf5gnWmnKuByObV6pCfZYdpvtARhWvdS2cIPUNWVDtGnZ5K4dizBx8rGtrlqqjXgAafG+RdXLzMH3zhywYxU9rakmC0uNEChjUNJtGblshYjQrpLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gXhs+uWO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a994277b38bso49229466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728167714; x=1728772514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HQI/L/s5ZU/jfp6TpSnEQe99W437IW863hAyq7v8534=;
        b=gXhs+uWOEbptDmOIJk5uJ/HJes7td4ZOrm9iC3T3O5PPphk3KMz6HL94b+Tscj+hdW
         i7hysUMP+BBzhPxL0RCVv4siQNGVJBIF5HxJfSkKUNkyxyVlHz0HnvHHjVLTaQfTodko
         juYkpoYcKKnnnm6P7Wg6b1e3KVXdAvAuPegnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728167714; x=1728772514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQI/L/s5ZU/jfp6TpSnEQe99W437IW863hAyq7v8534=;
        b=JkPud+NKWge5AD1OjuJ694lxZNmi6bai/cg5fE2VrvIxg2qkffqQLcM4aynYg/PokM
         2uOQ6sAnYix6V6KGyicZUPYuJOKWcBRR4LQKiliZNIL7ihWtZgJlFJ5G+1EzLRuImaOx
         BCRawjlirGw+XaS8/r8KSd9Dr26agajoOjqFUztK48NHFp5EM8qR9WHPNx38qDv7VfCj
         uAfoqzQ9DHHcnedcx9U7P6fYUGdKmqIvgnRr3trjV0MJLIF6V43JJjJXR+CKcpIVY83w
         1N2vj8Fx1xdWgvrYyU+8OefjeObhMf1O1AxxncHw114Q+etfs/qxzphz2M6tbZ42eLfS
         5Xdg==
X-Forwarded-Encrypted: i=1; AJvYcCUzLV8875V0VjRY5vv3IItJLIJxJ0VfCGC9owTuZQPlzUiC9jgA+DL1c01t6PLcLJentu7Q1HvGwUIqHahK@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJvj/5F7UYh3UYT6D9agbsfJClghKk+Uu2D3GbwxWnxawmT1P
	WgwgSVeP82dDMLYa6CVQ0n2KBbqpEJelZ6DGE5PegQOO7I85EvHivnr5KRnizwCC2xY0rom7Ggn
	DYNCcVw==
X-Google-Smtp-Source: AGHT+IELgL1Ug5449d2LfmWTylcuomdo5P1NQ6gpDDdOK299E9BINH5heeJ9STSoDYIaSdTLFE3sbQ==
X-Received: by 2002:a05:6402:51cc:b0:5c8:8e3f:1697 with SMTP id 4fb4d7f45d1cf-5c8d2e9f87dmr8922670a12.23.1728167714496;
        Sat, 05 Oct 2024 15:35:14 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993897cd3csm140217966b.78.2024.10.05.15.35.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 15:35:13 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c88d7c8dbaso1935027a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:35:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyQdNv2JYR24dSFvIOJQcyhP+6xfeEmBVY1ihuTEcoc1FYXgm5yxrUUUUBuQyqgc6VQzpFKxtamJbouUst@vger.kernel.org
X-Received: by 2002:a05:6402:27c9:b0:5c8:9529:1b59 with SMTP id
 4fb4d7f45d1cf-5c8d2e48716mr7992911a12.20.1728167713376; Sat, 05 Oct 2024
 15:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
In-Reply-To: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 15:34:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
Message-ID: <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 11:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Several more filesystems repaired, thank you to the users who have been
> providing testing. The snapshots + unlinked fixes on top of this are
> posted here:

I'm getting really fed up here Kent.

These have commit times from last night. Which makes me wonder how
much testing they got.

And before you start whining - again - about how you are fixing bugs,
let me remind you about the build failures you had on big-endian
machines because your patches had gotten ZERO testing outside your
tree.

That was just last week, and I'm getting the strong feeling that
absolutely nothing was learnt from the experience.

I have pulled this, but I searched for a couple of the commit messages
on the lists, and found *nothing* (ok, I found your pull request,
which obviously mentioned the first line of the commit messages).

I'm seriously thinking about just stopping pulling from you, because I
simply don't see you improving on your model. If you want to have an
experimental tree, you can damn well have one outside the mainline
kernel. I've told you before, and nothing seems to really make you
understand.

I was hoping and expecting that bcachefs being mainlined would
actually help development.  It has not. You're still basically the
only developer, there's no real sign that that will change, and you
seem to feel like sending me untested stuff that nobody else has ever
seen the day before the next rc release is just fine.

You're a smart person. I feel like I've given you enough hints. Why
don't you sit back and think about it, and let's make it clear: you
have exactly two choices here:

 (a) play better with others

 (b) take your toy and go home

Those are the choices.

                Linus

