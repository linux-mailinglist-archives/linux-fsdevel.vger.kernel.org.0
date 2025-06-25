Return-Path: <linux-fsdevel+bounces-52974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE94AE9037
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7356D7B2432
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC52163B2;
	Wed, 25 Jun 2025 21:35:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F2142E83;
	Wed, 25 Jun 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887342; cv=none; b=H2XCW/2nrR2+KzQgfwwKtrZFZ7HW+KG48BEqilRXG5QQwczMwVNODjYYyJ8P/lVW/MTaF7N7jMuV481Y0Aa/rre94G/xKnkBevGTbGAxBWmBTQXWl6Pbdj2BLPkoud/yGUDsbEjdvgaHgmn0TMruSw0+Y+APfhq5xugMrHvMF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887342; c=relaxed/simple;
	bh=RkxESvXxQirzmO14APXaqleohMwwvbxJIyhFK4MoKXo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pHor+nJC6uJblLbfWLM6/46/vIXLN7iXdPEB/TeD+MuYJaSU/c61Ciyq4l5Pipudu7530iI76pL+mLiREssovwOm101Xa+IkCk8M8lIjdGd7hlt7+s50YXWKYeb4UDmyz0LLpParV++6uVBX3PLeyqW55cgfF+O3zIWsw3iFbPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUXmC-004rh0-Ek;
	Wed, 25 Jun 2025 21:35:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/12] ovl: narrow regions protected by directory i_rw_sem
In-reply-to:
 <CAOQ4uxhZbfg-u0w8uRVYPkNe+GXcragA5hwtZrc1_RJ5qznVeg@mail.gmail.com>
References: <20250624230636.3233059-1-neil@brown.name>,
 <CAOQ4uxhZbfg-u0w8uRVYPkNe+GXcragA5hwtZrc1_RJ5qznVeg@mail.gmail.com>
Date: Thu, 26 Jun 2025 07:35:27 +1000
Message-id: <175088732709.2280845.16573886517114282970@noble.neil.brown.name>

On Thu, 26 Jun 2025, Amir Goldstein wrote:
> On Wed, Jun 25, 2025 at 1:07 AM NeilBrown <neil@brown.name> wrote:
> >
> > This series of patches for overlayfs is primarily focussed on preparing
> > for some proposed changes to directory locking.  In the new scheme we
> > wil lock individual dentries in a directory rather than the whole
> > directory.
> >
> > ovl currently will sometimes lock a directory on the upper filesystem
> > and do a few different things while holding the lock.  This is
> > incompatible with the new scheme.
> >
> > This series narrows the region of code protected by the directory lock,
> > taking it multiple times when necessary.  This theoretically open up the
> > possibilty of other changes happening on the upper filesytem between the
> > unlock and the lock.  To some extent the patches guard against that by
> > checking the dentries still have the expect parent after retaking the
> > lock.  In general, I think ovl would have trouble if upperfs were being
> > changed independantly, and I don't think the changes here increase the
> > problem in any important way.
> >
> > The first patch in this series doesn't exactly match the above, but it
> > does relate to directory locking and I think it is a sensible
> > simplificaiton.
> >
> > I have tested this with fstests, both generic and unionfs tests.  I
> > wouldn't be surprised if I missed something though, so please review
> > carefully.
> 
> Can you share a git branch for me to pull and test?

My current work tree can be found at
  https://github.com/neilbrown/linux/tree/pdirops
or branch "pdirops" of 
  https://github.com/neilbrown/linux.git

Thanks for the thorough review - I'll work through it and respond over
coming days.

Thanks,
NeilBrown

