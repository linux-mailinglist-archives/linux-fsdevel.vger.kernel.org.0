Return-Path: <linux-fsdevel+bounces-70383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCBC9944C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 22:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 004824E2734
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DAE28469A;
	Mon,  1 Dec 2025 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfr97lu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE392773D9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626080; cv=none; b=QDQ/LQjGpfxEnUocPJ8Pgzt1f5P0mM2ePflpUj6d865pQBzkyXnp4jJOfR//Z/Rua+ZMVeiUpL247jDHt6Vf0/b7gqo3BE7YOVEdceo9aNhjjkCbG1AaLPWov68IHUkMVEt7a0+cgPdH+9ZiXlevFvYPTRZqoVOoDczrnaFzDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626080; c=relaxed/simple;
	bh=lD+/GAj+NzAte4zXP30/KXgg3y4cblHJqNHaPOZnL1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4OmgQJleWR0dBZy4XGf8Ts/uA7fZbG5Kuv+FBJHIkQX7HmpYbNrGAz9jtlZcUpPwlbnmoKostsZK+Re7Uehwld6H++7OdExjRqj01SHKU1qLQKsmyWRlmfKkMhusDivBs/3pyZM0RmX+jBquHBvwVwPf2llna4Waq8K/6dWrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfr97lu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415A5C116D0
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764626080;
	bh=lD+/GAj+NzAte4zXP30/KXgg3y4cblHJqNHaPOZnL1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bfr97lu6+wPzM7rEFuD/ApRyvIzRHWd6bg2tFQznbFXDDtX8eNNUT8vS0EfA2yc8L
	 Vhhm8RJsddUC9uICUttfmfxAHdi6I+bzWirpMqH/hnOVwmyiUom5Dde2tBS/SO1Bbq
	 xAKSWWVfKNz/ObKXthDyJyElLTy9R8ZtMv2oV57l6P+Y4IdkYhPjYIhE1XmS7Sw/kF
	 dexfdBCf23Zw8AJBFQ/5UOSHPtXzu+/ElKp9ULVAdh8vz+5GrIxTm0l8HEIS5Mf2ad
	 B9vCBmQLsmK2AphxhXh8LDFeiVpaQS5Xv7NaM0Fyd8pk2Ddw8mO5zUPidmUM3TANC0
	 YL64QFssdot8w==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so1612415a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 13:54:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaLgSlGxVNG10e8ARl2TZmyAL3IACdXWxm10Utf1YT5qTruGCJdThReKM3jYj2b8YAqAyCMDGePOpajC5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95x4/jaB5y/E43kmduVHCxX7yRIlO1KRWTWYGGEsmKpbBo6Bi
	OR1SwZUTQ+cHy1C91W71q/CZURwqXaa8o5t95wRSuuBRXRzLlpiyIQncsZ/bes1pEn87dB/8HLz
	IVcenMu/eDcZsLAI2lVk3Z6etK1K/wbc=
X-Google-Smtp-Source: AGHT+IFHt/ehrIVVTKCT4ILP/D2MYJUY8cYS/xIfvPBm94lR3TDonB/3g7RyvzvhIM9pJ8b4GC7lvr8kQKiCzSsuo/M=
X-Received: by 2002:a05:6402:2787:b0:643:e03:db14 with SMTP id
 4fb4d7f45d1cf-645eb2a8615mr23789231a12.19.1764626078572; Mon, 01 Dec 2025
 13:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org> <aS1WGgLDIdkI4cfj@casper.infradead.org>
 <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com>
 <aS16g_mwGHqbCK5g@infradead.org> <aS2AAKmGcNYgJzx6@casper.infradead.org>
In-Reply-To: <aS2AAKmGcNYgJzx6@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Dec 2025 06:54:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-utvawg2MT3j-t-NOusVJ6MOe47cNBpbQs1U36=cTnPQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk6yOwSj0VF2eYOQnOETwSIvUVTqt7jUjUYmpEUDioRUGNvCGeXu1ad_-4
Message-ID: <CAKYAXd-utvawg2MT3j-t-NOusVJ6MOe47cNBpbQs1U36=cTnPQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and headers
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@lst.de, tytso@mit.edu, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 8:46=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Dec 01, 2025 at 03:22:43AM -0800, Christoph Hellwig wrote:
> > On Mon, Dec 01, 2025 at 07:13:49PM +0900, Namjae Jeon wrote:
> > > CPU intensive spinning only occurs if signals are delivered extremely
> > > frequently...
> > > Are there any ways to improve this EINTR handling?
> > > Thanks!
> >
> > Have an option to not abort when fatal signals are pending?
>
> I'd rather not add a sixth argument to do_read_cache_folio().
>
> And I'm not sure the right question is being asked here.  Storage can
> disappear at any moment -- somebody unplugs the USB device, the NBD
> device that's hosting the filesystem experiences a network outage, etc.
>
> So every filesystem _should_ handle fatal signals gracefully.  The task
> must die, even if it's in the middle of reading metadata.  I know that's
> not always the easiest thing to do, but it is the right thing to do.
Okay, I will look into ways to improve it. Thank you for your feedback.

