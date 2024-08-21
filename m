Return-Path: <linux-fsdevel+bounces-26530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA59495A4EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC94B21FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E017D1B3B0E;
	Wed, 21 Aug 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qLRGHFnk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5E4085D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266491; cv=none; b=H324d6PrX2y+x9oNZTCKFxPjLDcYSnRzz8LeFjPswXPSxs4Gf+IyC5EYmQcZfxZ7Ai2S9rAeIRWNgUTFOl8hd5OWJE47kLHS8ujb8xOneKLwUCk6XA0zaejgjnUH9FLRMZaY7RnAscjY6fLEL1MSnk9p3meyxFHL+JOjE+ny9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266491; c=relaxed/simple;
	bh=Rp3LthfeXTw2X9NI3W93UFVVc/6ajFD7za4PyO0WvOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTq7+iJ8JXRcJPw+sVwAw7olgWtyi3rYVaOc4UfMpszgJiYX/L7fz+RZYwk3e8U01bfNWEquVUOaCLNWWIbEpdJ8cJS5/mxveYinK2KB19G8ckblnAa4yRktVAKUlqjlOUEiFSgBLy8FcaDq5f1az2ZT8q2lYbNGHkTm9kur9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qLRGHFnk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so901858866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724266487; x=1724871287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq5uEisDzDBxXv7GJ+h2l/Ide8mDV7YKempIxz5GAKE=;
        b=qLRGHFnkPTpiHIgSaghgKHFNNQ0HNhjzquw9kX950faWrnl9XQNMI+ZAcMZo+fmrfN
         PhfMhs73PHeELd4zCvaIlh5X4HMGaD3jXmsueXhdHN9enJxKMibzKDThBKmFvCracwNu
         1/DqlDW0ZSN5hME71TWyKeLUEffwJguuqQLBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724266487; x=1724871287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vq5uEisDzDBxXv7GJ+h2l/Ide8mDV7YKempIxz5GAKE=;
        b=QUSkRzQ3rcOD3qB0+7QokaKekQ/2OjU9spKzQ4PPOfOrvYJRCucwz302h2Yh+Es6Uw
         iPzBJrUznpzXGg7DSUi4rzvN//SHHtfVsZEPPR5wP6yMHSHz02jcvaXKuFM32dzKxCHT
         s+UoAkX11xIeOu7+pHQPnGNhFcIroKmAbvr0JbNOuqc+9PBRJ/F9tjrvKyqmYC+6TcXq
         IyioeokJLpINl4SugThj4mzGnYjvu5ft3hb+gsoVvOWcyge9ckXewOnPkdu16PExVtm2
         vB6JNeNgbiMo0qqRFtC+ZxzbGhY8ly6nHPIUBLh+Mu58VndAl11Khu82mfmC6euUl+Xr
         1K5A==
X-Forwarded-Encrypted: i=1; AJvYcCWTqg7RxRYLYrSlvLUoRQL3hULAlrsLA1V2S731reBpxSnOdQFbolSiXB7ply301HGdRqjnhe2CetZsRHmJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsn+x/wP0AIAmX0H+R5pqG+ESWw3z16wsHMBYhu/gEtS1Z7qNi
	DJb3ozWb8lbPvtxK8wgTalxaUBnkaKfD/aPFrBb/YtcOBxvBg2mKr2Cm1hydN2j1RBYGof4lqoc
	wtZpBWdVbjTrOvNft8GYYqj3GzgJ1bbsBNhVywS8X00mLxDJrQCU=
X-Google-Smtp-Source: AGHT+IFfTFLmhihNNhMJ21LKNYH4P+xxxoLM6VuwY50khscoeqoEeq86WVuJZZIfbQPk7KMNE7TXz6tUG1MyuUry7U8=
X-Received: by 2002:a17:907:96a3:b0:a86:73cb:99ef with SMTP id
 a640c23a62f3a-a8673cb9b4fmr277313966b.39.1724266486950; Wed, 21 Aug 2024
 11:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com> <20240821181130.GG1998418@perftesting>
In-Reply-To: <20240821181130.GG1998418@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 20:54:34 +0200
Message-ID: <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Josef Bacik <josef@toxicpanda.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 20:11, Josef Bacik <josef@toxicpanda.com> wrote:

> "A well written server" is the key part here ;).  In our case we had a "well
> written server" that ended up having a deadlock and we had to run around with a
> drgn script to find those hung mounts and kill them manually.  The usecase here
> is specifically for bugs in the FUSE server to allow us to cleanup automatically
> with EIO's rather than a drgn script to figure out if the mount is hung.

So you 'd like to automatically abort the connection to an
unresponsive server?  I'm okay with that.

What I'm worried about is the unintended side effects of timed out
request without the server's knowledge (i.e. VFS locks released, then
new request takes VFS lock).   If the connection to the server is
aborted, then that's not an issue.

It's also much simpler to just time out any response from the server
(either read or write on /dev/fuse) than having to do per-request
timeouts.

> It also gives us the opportunity to do the things that Bernd points out,
> specifically remove the double buffering downside as we can trust that
> eventually writeback will either succeed or timeout.  Thanks,

Well see this explanation for how this might deadlock on a memory
allocation by the server:

 https://lore.kernel.org/all/CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com/

Having a timeout would fix the deadlock, but it doesn't seem to me a
proper solution.

Thanks,
Miklos

