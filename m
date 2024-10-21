Return-Path: <linux-fsdevel+bounces-32510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE39A7068
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2876B21AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BE1EBA1A;
	Mon, 21 Oct 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HzbdOBNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8EF5FEE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530111; cv=none; b=iSozfC3PrX+JzhK6yTv43nCVufWR/tM1CKuUmt/kQ8gg1an9X9/+ktZdEjC01xbWoQPi9i6GBKb7bSTzXCoje+B6Ta6U6mPkEltGUxdJxSnrUQmhKxQn/QqIcdnNweo6uY5SbvUElSakcEkaQdiEde5Mpc5s8y1sNyOqML77EIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530111; c=relaxed/simple;
	bh=9ozNo+33nRBhfBxHORCkYdaQAR7lx7bVJs9HZkF16IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sea+a3f5RCDv5Y5AmoDXLsf51+3gNNq8nLTDHFO93S7vIdRu3D9ToYfyMOpRbiLk95qFGwGj+UpCewm7USnmyFkY64RLB0mdEmKyrAyeu1sQIoR3886oHsEyPpymIz7tGBK6Z/AK4m+xo/pUtw9r0foj4RoCbCexGS6WNnh+D0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HzbdOBNP; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Oct 2024 10:01:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729530106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qkyKip8HVy4uBOgJOwasMtM+gaqkeqOoz7QkU43yFDM=;
	b=HzbdOBNPkNqkKcMnxLjXRHP/eQCjnPme3CcqVlevQn1RY7kLGv3MEvJ3Gyy82YUPx0tUbh
	2v9TRbmVvw8K209ILvW8ZwVTr1554Cs+Y6/BRpHvTv5zWlq40Fxby73TwaKUyHPdMtx7Ly
	JdLdR0mJJ/48AE/FJYMgShPmowDZFj0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <egn6ds56teqq6i2dgn37oa6rmy7u5xtvvv3y277ul6ldhgdnsl@fdhkkxvznwkb>
References: <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 12:15:36PM GMT, Miklos Szeredi wrote:
> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > I feel like this is too much restrictive and I am still not sure why
> > blocking on fuse folios served by non-privileges fuse server is worse
> > than blocking on folios served from the network.
> 
> Might be.  But historically fuse had this behavior and I'd be very
> reluctant to change that unconditionally.
> 
> With a systemwide maximal timeout for fuse requests it might make
> sense to allow sync(2), etc. to wait for fuse writeback.
> 
> Without a timeout allowing fuse servers to block sync(2) indefinitely
> seems rather risky.
> 

Thanks Miklos for the response. Just to be clear on where we disagree, let
me point out what I think is right and please tell me where you
disagree:

1. Fuse server should never access fuse folios (and files, directories,
   mounts, etc) directly it is providing.

2. Fuse server should not get blocked indirectly on the fuse folios (and
   related objects). This series is removing one such scenario caused
   due to reclaim.

3. Non fuse server processes can be blocked on fuse folios (and related
   objects) directly and indirectly.

Am I understanding correctly that we disagree on (3)?

thanks,
Shakeel

