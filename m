Return-Path: <linux-fsdevel+bounces-3838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC97F91F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B868281203
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A4D63C1;
	Sun, 26 Nov 2023 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiTI8Yjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267F46AF
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E8CC433C7;
	Sun, 26 Nov 2023 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700990523;
	bh=5fGYdoGIblQJpo1mn4+o3xb+neWQy88tKKpbrzDyj0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiTI8Yjz57PFPK2FBLZfUkxbEwUIT0iCRyO78sGMjQs4Few2DoFNWdm8q/HKYQpSv
	 SyU5ISgGjwRJ7kWDhWgneapZxkOi2UF6NT2z9EIqMA1px2SH9NkMZkwUJmuBtBWbzy
	 irOo7L3LKNm27dCQnw+u+WKRYvk48F5RlopnQXt6IPqxfn12Bvt9YddzDYdrCBJ+nI
	 EqEItc7X5j3ueJgtsWojRT2q7fdQmu8DhaiuHHwX2pf1K4DwW+aguzULquti+ub++J
	 1hb8lx7oX5JEH44a3w6FlzCTd+rWdTE9odtSpNpgLhq2xnaZXyDMGIfp5nA1ZQkNsr
	 mwNIxMUrV8gMQ==
Date: Sun, 26 Nov 2023 10:21:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
Message-ID: <20231126-luftkammer-sahen-f28150b1e783@brauner>
References: <20231126020834.GC38156@ZenIV>
 <CAHk-=wg=Jo14tKCpvZRd=L-3LUqZnBJfaDk1ur+XumGxvems4A@mail.gmail.com>
 <20231126050824.GE38156@ZenIV>
 <CAHk-=whPy8Dt3OtiW3STVUVKhsAZ2Ca2rHeyNtMpGG-xhSp24w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whPy8Dt3OtiW3STVUVKhsAZ2Ca2rHeyNtMpGG-xhSp24w@mail.gmail.com>

On Sat, Nov 25, 2023 at 09:17:36PM -0800, Linus Torvalds wrote:
> On Sat, 25 Nov 2023 at 21:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Nov 25, 2023 at 08:59:54PM -0800, Linus Torvalds wrote:
> > >
> > >       because I for some reason (probably looking
> > > at Mateusz' original patch too much) re-implemented file_free() as
> > > fput_immediate()..
> >
> > file_free() was with RCU delay at that time, IIRC.
> 
> Ahh, indeed. So it was the SLAB_TYPESAFE_BY_RCU changes that basically

Yes, special-casing this into file_free() wasn't looking very appealing.

