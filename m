Return-Path: <linux-fsdevel+bounces-29883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE897EFCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E435B2166C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1C19F138;
	Mon, 23 Sep 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AvhCgZrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1481474BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111960; cv=none; b=Jpqv78BgFpyONeqDiILFl3ISrVd1rZuUrXxcKfCr7SLO8fLT+RWaqqPliuqj5o1qjX3d3dClvFKoj/nPFbhMwNbv+YKHq+7ZhYYXriuf2u5yVYZ1ye8ZyRV4cYHm9W2zK9D6s21uj6Pszg8b13aED7CaBk1frn4yihjd75xWyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111960; c=relaxed/simple;
	bh=8CzslkZb0sUznqump5kOXrXFXRvqNxrUKdCua2E89hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEA4on9UCWghZxaQuF9TNvM+a1HqvFTIgB+BEFA/AyK4gwJIJuhNlOgPKpqFpIVE5o3sOb3WtQnuP1DCaC7CZrUyKtIlAoZ92pHRy1Fzmrn83PBWXtfhHtyRiKtwmURaeFlZG3p8lrLTbXd2mWDXcZ1sXIAVaJjbI3v0ngLdqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AvhCgZrL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f66423686bso39931011fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727111957; x=1727716757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/88YtmKHLqGAFWhvYULFA4aDXhjl5wiNzxfGpypDRso=;
        b=AvhCgZrLG4SH4JiWI1UbkyMSomGZD3O6qcsBpzfiB7FFwJaEUwGQSl2QrpHCu5MJT2
         zG4q8HQfK4KbIPOvA7/MV3ht8j2gDIH3ywJuPu8ciVn/R148cImVEeM7DSc93GEXQA2V
         xBkF1ml0Lu9tbzVV/4WZcg6rudPEAkUa+PuJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111957; x=1727716757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/88YtmKHLqGAFWhvYULFA4aDXhjl5wiNzxfGpypDRso=;
        b=EywRx0pwhRfFFJt+a+5stxE9oyYv8ClXwzsD8F+jwsO6R8XcRs12eqcAjlB1iQh9JH
         Uv0SFf441y/aPmrpQywwLAbkroOhmzLLkYM4LCCdtW9/rKjZKRdFRRIaYNAYs1olrv3F
         46yzbnbw2Se0sQHbWTwNWjTpaE8XY13leBi/CeZ+rU6nQ0YavB9JeS6wcd3wMcbIpEtV
         y6cO9dPg1IsFKsesjfJ8Gy2zRYgye6TItAgEU8QjscUFpz77FYpT9fNarqgZRee5lH6k
         y8GlZb+bSp4TT6B8o+/aIDVXe0b4Ubf61w4jotwTS1UigMDAhJtp8PTApllW1yQZwFeK
         IztA==
X-Forwarded-Encrypted: i=1; AJvYcCUXeDGqIXP9QHtHqqVMyAST/sAIz3Uo1/ZMcP6egh/ORfuwDUmZJNwkMNVbQvIPUPyvJnLk7A+dx6pylcxv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pOcCBgzhSlJwexOjA3w86s8acqXvp/5ojXQsQ4zwWxdf6nxq
	uFwm2bZfiM/QlZuxoqVVKb9J4bH3jbRLEAbmuOyNlnYzTIgW7EBZ7mB+sLUpHm+rJHoYan/Azob
	WJhc=
X-Google-Smtp-Source: AGHT+IEpwPXw5SN6MVx/1fXFxHED+4sMW5J7DF1p2cWIBnYzFa5iygx33GbqIE5eYU/lAo5jy5nvrw==
X-Received: by 2002:a2e:bea7:0:b0:2f7:7031:dc31 with SMTP id 38308e7fff4ca-2f7cc382c22mr62548511fa.27.1727111956584;
        Mon, 23 Sep 2024 10:19:16 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb60aecsm11117171a12.55.2024.09.23.10.19.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:19:14 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a90349aa7e5so689042966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 10:19:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPyRjtBK13IB9FMaIDS/rY7pFWaVY6L4OgtHht60fivT/VfW+mAycI2kDDIVzuSPn6uPWMTJrunnqrhHOk@vger.kernel.org
X-Received: by 2002:a17:907:25c1:b0:a8f:f799:e7c9 with SMTP id
 a640c23a62f3a-a90d566c9bdmr1174018266b.2.1727111953883; Mon, 23 Sep 2024
 10:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
In-Reply-To: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 10:18:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
Message-ID: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 12:28, Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> We're now using an rhashtable instead of the system inode hash table;
> this is another significant performance improvement on multithreaded
> metadata workloads, eliminating more lock contention.

So I've pulled this, but I reacted to this issue - what is the load
where the inode hash table is actually causing issues?

Because honestly, the reason we're using that "one single lock" for
the inode hash table is that nobody has ever bothered.

In particular, it *should* be reasonably straightforward (lots of
small details, but not fundamentally hard) to just make the inode hash
table be a "bl" hash - with the locking done per-bucket, not using one
global lock.

But nobody has ever seemed to care before. Because the inode hash just
isn't all that heavily used, since normal loads don't look up inodes
directly (they look up dentries, and you find the inodes off those -
and the *dentry* hash scales well thanks to both RCU and doing the
bucket lock thing).

So the fact that bcachefs cares makes me go "Why?"

Normal filesystems *never* call ilookup() and friends.  Why does
bcachefs do it so much that you decided that you need to use a whole
other hashtable?

                   Linus

