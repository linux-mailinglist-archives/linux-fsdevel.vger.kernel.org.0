Return-Path: <linux-fsdevel+bounces-37633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C2E9F4CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A97A30F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6F1F4287;
	Tue, 17 Dec 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqiF8bCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543041F427C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443537; cv=none; b=aijCALwxKw9ZFnFFFhYxhkR7oWD++TWuIcxgRNdXhB5t2vXd4xhibAhl1wXOtYmC7X8iAL0FVli1DMc+N7ORHPT2ETFKqkbAx9cOuxNxh8mZ2XBTSGjr7QoKPn9xvaQ3YHeIOQaE5iWW9wO4Tj5Sitnk0CSJfU5dwJkamIs73Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443537; c=relaxed/simple;
	bh=uJliKymn1wyVmcRLuZ1pjhZjiLTeQ9qBCcN0BzYEzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5dimu8uvR/IQV4ix1Kv9m/rQbQVhcxCfQueUZ4bijWlcRGymbrHbceGQz6DQR5N/0Hm3w+dDzP23ARmXDMZJQvL3CTWdOpdZb+IKpvUWXVXSgHrdvm7TanZCrcah47MKn6oEtkIkBkYG2aIfUqrzdStI3mmrxjsWMvPK5VqyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqiF8bCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1798C4CED4;
	Tue, 17 Dec 2024 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734443535;
	bh=uJliKymn1wyVmcRLuZ1pjhZjiLTeQ9qBCcN0BzYEzZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqiF8bCVXBmfYk1sZP4aKTPWWfiTwC5jpARMmhnrpqj8wi0GI3cqKoU6I+l2xoxTZ
	 HXJiJNIQ/+QXqvsMO1UbjxhP/l0siN21vLOPPMsh7hqrvSg6pu0KRyCzo6gEoqVvZl
	 W4tkI6+zATi2yMWXt0cU9zAqdsIpleM3GOr8wPX5IDU+qSs3BYQrttI033Qk13HhEW
	 h0Oa+L9UvIL3oKEHuLEo6FxvQsNknFoLlPxSXo9HwCLyUsjR7hEis9EJAKlYE9YlQ1
	 LLgp9haCXtOtyO2sCPkoeOPEdxtEqm4wHofGcPcPv2PZcnHQXL5A1Mc8rwNcj/Kxvy
	 tbthIS/ZeunlQ==
Date: Tue, 17 Dec 2024 14:52:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use xarray for old mount id
Message-ID: <20241217-tippen-medium-cae7a909222c@brauner>
References: <20241217-erhielten-regung-44bb1604ca8f@brauner>
 <CAJfpegsn+anx7nHQbD7HCf301DyvaWqg-pAi6FUAgfhGLiZurA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsn+anx7nHQbD7HCf301DyvaWqg-pAi6FUAgfhGLiZurA@mail.gmail.com>

On Tue, Dec 17, 2024 at 01:35:09PM +0100, Miklos Szeredi wrote:
> On Tue, 17 Dec 2024 at 13:23, Christian Brauner <brauner@kernel.org> wrote:
> 
> > @@ -270,18 +270,19 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
> >
> >  static int mnt_alloc_id(struct mount *mnt)
> >  {
> > -       int res = ida_alloc(&mnt_id_ida, GFP_KERNEL);
> > +       int res;
> >
> > -       if (res < 0)
> > -               return res;
> > -       mnt->mnt_id = res;
> > -       mnt->mnt_id_unique = atomic64_inc_return(&mnt_id_ctr);
> > +       xa_lock(&mnt_id_xa);
> > +       res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
> 
> This uses a different allocation strategy, right?  That would be a
> user visible change, which is somewhat risky.

Maybe, but afaict, xa_alloc() just uses the first available key similar
to ida_alloc(). A while ago I even asked Karel whether he would mind
allocating the old mount id cyclically via ida_alloc_cyclic() and he
said he won't care and it won't matter (to him at least). I doubt that
userspace expects mount ids to be in any specific sequence. A long time
ago we even did cyclic allocation and switched to non-cyclic allocation.
Right now, if I mount and unmount immediately afterwards and no one
managed to get their mount in between I get the same id assigned. That's
true of xa_alloc() as well from my testing. So I think we can just risk
it.

> 
> > +       if (!res)
> > +               mnt->mnt_id_unique = ++mnt_id_ctr;
> > +       xa_unlock(&mnt_id_xa);
> >         return 0;
> 
>         return res;

Bah, thanks. Fixed.

