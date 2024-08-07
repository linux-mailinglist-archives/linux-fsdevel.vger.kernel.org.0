Return-Path: <linux-fsdevel+bounces-25216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A03949E50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA701C21483
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14C191F60;
	Wed,  7 Aug 2024 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F6CYRYPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD39433BB;
	Wed,  7 Aug 2024 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001906; cv=none; b=rfnMU4bf8GGbx2aR/k2UorgqfmY9EUY4G7/bfGhR0olT0uD7DSee3Bzn8ngbqDX35KdVgt2l3VMUzihW34A/6i8y59FrWRktKKA5SNtnT6CKSux5h5nI1xY7HJVLJV6YUIDrIIj/PIr9nskz6WtE6ZR/aNFA7cZiWhKndalA/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001906; c=relaxed/simple;
	bh=n7K26IFYadrogACCn1wjHepgBJNfjFO93kUwnpijaTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHSii5aseTPWWfpilGaXXXDAcXTRnO+EUf1cnZbWMBxYM3rmaAZU1vf0vDpfQog5WA8J3rgiOyawk8kGxK7cmIvK5EURTSbYTqRLmKDhI3I6xk1I43IcHGoN9qPYzN+FHFgCCgDQ6X4tkDUYVgFrOBGkpPrxU1RjQVqLCjvg1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F6CYRYPn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x04CPEwFzXiLJZI5LYcEdT0KXHdqtDShGTVN9ZcE9Ew=; b=F6CYRYPnVTBkB7IsWQNLrCjBH0
	TBq8OsrCyHdY81fK0m73g0NULxzP1v09mNU6IJnWHEJdUTx45k1EjxcJ2inxe+9XYg8K0UMhyL+oW
	bzT7Bn8/Xrlp1CK1Z4IvynoV4XevbOxr5x6eC6kC4Tin046WLZDt6tCV34PpOOfeyZFW/1vUuuIlp
	ZMGf8qVQ2R0EN9Sd3UPw3jPf4KZTl+kICWXmFIsqNHD2gHckj+BKciCPCBt9P/EJmMZ49FzIehQAr
	wR6E+EUioG5lDVc21KFvld3MXh2uKT2b6vgc0rFsgpj3PLFeGScKZlGyNBkqT1gpaz+7f53BhKUca
	r8aqxTDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbXVE-00000002DJM-3XvO;
	Wed, 07 Aug 2024 03:38:20 +0000
Date: Wed, 7 Aug 2024 04:38:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807033820.GS5334@ZenIV>
References: <20240806144628.874350-1-mjguzik@gmail.com>
 <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 06:09:43PM +0200, Mateusz Guzik wrote:

> It is supposed to indicate that both nd->path.mnt and nd->path.dentry
> are no longer usable and must not even be looked at. Ideally code
> which *does* look at them despite the flag (== there is a bug) traps.
> 
> However, I did not find a handy macro or anything of the sort to
> "poison" these pointers. Instead I found tons of NULL checks all over,
> including in lookup clean up.

Unless I'm misreading you, those existing NULLs have nothing to do with
poisoning of any sort.  Or any kind of defensive programming, while we are
at it.  Those are about the cleanups on failed transition from lazy mode;
if we have already legitimized some of the references (i.e. bumped the
refcounts there) by the time we'd run into a stale one, we need to drop
the ones we'd grabbed on the way out.  And the easiest way to do that
is to leave that until terminate_walk(), when we'll be out of RCU mode.
The references that were *NOT* grabbed obviously should be left alone
rather than dropped.  Which is where those NULL assignments come from.

