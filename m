Return-Path: <linux-fsdevel+bounces-14766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A287F045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 20:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F42280F5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4856748;
	Mon, 18 Mar 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a6dPOdrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5D5645C
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789280; cv=none; b=b6dQaFkRhGsmiGaQWwESqBZ4V0lIRREHTGbEU7NxSziJf5QFmMZt6fwMOk+oFG7Hte2jwc+tUwybfp705eR8UiE70Vpm33GTeoubJ2QYzvl0fA/Cmty7UuSddFC3lIO6jf8qBbudEULAkZm6jAExJfkOi+Et5yMNZSGP88ct6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789280; c=relaxed/simple;
	bh=ZM7EmXC1nFNCsh6vA7OcOL1R8WaE0YVIRhn6pPNKQus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg7VJSpY+qqapFS2zmexR/BEYanhryEubBEnTziQ3vgy5V75mc8IBZwO2CuQ0wswSaMMGORMorjab3GNHRnHRDPVvwq4v9nvBE8BKAe/C4en2cHQLXO/XiWPL+zBjK+niHuf0AuHWVkhOrNXZg/HA3/Iz+3m2fTBheSJfQnligE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a6dPOdrB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5488793a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710789277; x=1711394077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oN4fiPM3Eza8VdazjMa5IGx7BirNAfpH5hEdexWHLK8=;
        b=a6dPOdrBU72ltrPihTBcfL6mmNhgFitoB/LixqSKYtpL50nSY4FO9QMJkYms/3XPHp
         phSnKkAdkeVkt6/2flF4dk6SktxGrBwQ6+0TJhVqxYM0ifIrCfhwWBje57ttQPtoF+c5
         RAdJh3xv5SYN8i/jIGJuR/QphgWbRmFg9oFxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789277; x=1711394077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN4fiPM3Eza8VdazjMa5IGx7BirNAfpH5hEdexWHLK8=;
        b=bC9sZvszkje+XDXpKzRJ5kEn2VQ9Z8dbHU1TTW6ak9in6CvaLS90wTxbZHkoivvYvW
         NH8ybTWBodF+yE0ggUG9BfjhiBOwVxdx+QHchHtKbsJq8fhZGzWu8k25JoUCA3oJhNBS
         8l51vtGX5Q47NKO+Q+xwoHqKa4WEUrzXplLfvdDWDw6zDGgDz2HRShoovBx9SzSMkrH2
         3hDgAL3HF2epWFKcpwK9YtTRhEEh4mYYq200uQwz5y0+JzM3gZj00R8xo5HjYzo7cFED
         ELi6ppfIaOSttP8Ax5DTedzcuP4vS/XKhMHAzG6Gxw8OKBgcZypKpn0yuiJTgiJJKd3e
         x2uA==
X-Gm-Message-State: AOJu0YzTO2Ul6U31ZroqDWa+SNowLHVjWDPELirnrMrTjLw461gc+eO5
	yJpqnqcQAA5wFIvAwZIqqokjKpsa8X3j55W+NqTIEzhopkum7dvbRlUNb0mNt9Ln18I78o2CtJO
	6S13p9Q==
X-Google-Smtp-Source: AGHT+IFBZHPajAElbs/YWaqepa0navF+QYUaBOqpO4BMV4BjRixNlVlNlOtn03EaMeQhhV4YspzR4A==
X-Received: by 2002:a17:906:4749:b0:a46:2100:da56 with SMTP id j9-20020a170906474900b00a462100da56mr147595ejs.55.1710789276704;
        Mon, 18 Mar 2024 12:14:36 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id gx27-20020a1709068a5b00b00a465fd3977esm5265533ejc.143.2024.03.18.12.14.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 12:14:36 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46aaf6081fso283559266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 12:14:36 -0700 (PDT)
X-Received: by 2002:a17:906:2ed7:b0:a46:bc3a:cc91 with SMTP id
 s23-20020a1709062ed700b00a46bc3acc91mr157204eji.44.1710789275586; Mon, 18 Mar
 2024 12:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
In-Reply-To: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2024 12:14:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
Message-ID: <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 05:20, Christian Brauner <brauner@kernel.org> wrote:
>
> * Take a passive reference on the superblock when opening a block device
>   so the holder is available to concurrent callers from the block layer.

So I've pulled this, but I have to admit that I hate it.

The bdev "holder" logic is an abomination. And "struct blk_holder_ops"
is horrendous.

Afaik, we have exactly two cases of "struct blk_holder_ops" in the
whole kernel, and you edited one of them.

And the other one is in bcachefs, and is a completely empty one with
no actual ops, so I think that one shouldn't exist.

In other words, we have only *one* actual set of "holder ops".  That
makes me suspicious in the first place.

Now, let's then look at that new "holder->put_holder" use. It has
_one_ single user too, which is bd_end_claim(), which is called from
one place, which is bdev_release(). Which in turn is called from
exactly one place, which is blkdev_release(). Which is the release
function for def_blk_fops. Which is called from __fput() on the last
release of the file.

Fine, fine, fine. So let's chase down *who* actually uses that single
"blk_holder_ops". And it turns out that it's used in three places:
fs/super.c, fs/ext4/super.c, and fs/xfs/xfs_super.c.

So in those three cases, it would be absolutely *wrong* if the
'holder' was anything but the super-block (because that's what the new
get/put functions require for any of this to work.

This all smells horribly bad to me. The code looks and acts like it is
some generic interface, but in reality it really isn't. Yes, bcachefs
seems to make up some random holder (it's a one-byte kmalloc that
isn't actually used), and a random holder op structure (it's empty, as
mentioned), but none of this makes any sense at all.

I get the feeling that the "get/put" operations should just be done in
the three places that currently use that 'fs_holder_ops'.

IOW, isn't the 'get()' always basically paired with the mounting? And
the 'put()' would probably be best done iin kill_block_super()?

I don't know. Maybe I missed something really important, but this
smells like a specific case that simply shouldn't have gotten this
kind of "generic infrastructure" solution.

               Linus

