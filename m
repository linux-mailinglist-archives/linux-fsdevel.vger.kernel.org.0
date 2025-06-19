Return-Path: <linux-fsdevel+bounces-52146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6FADFB47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 04:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC27917FFB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E7231831;
	Thu, 19 Jun 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V3i3iqPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BF21FF57
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300523; cv=none; b=khp3E3NhRMIfeRK2Vani8p4e/uBTccQYSs1UREzaqQM5DKhCQVIQpPyEq1HavBJyD4Pdtg76i2Tb+xR8PQReQ9YN5I41NNtRjplLBsmSIXpvXRLZbjgO3eqRsv8uIMAz1ujBHsx2BS3Eoagzc4AY3YhYVKtTERhgdhPBnboZzx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300523; c=relaxed/simple;
	bh=hqZQcUNs7o7B+mOvnc0QewI+V6z1oWhOMUqK7OYFn9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZuI0PZb5uOIEVOPsm12nx4667NvynFRSgiQJnOumIdXQ5R8tGRvOPhvTMwspTjK1jNkjF3YYg2+vioBjFnlU5kpGIeYU5E+TKtge31q18sdjoDSOOjTrroXEXXTs4XJkYsbQJgBpOws4QFQgko462qLpFkq6925MHEJR/ZD2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V3i3iqPS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T9yUyHB4MlHhnvLU4Berxn5Njc613ew8Qs5tFDPBWQs=; b=V3i3iqPSGx/d9OyZzfGdOF5OYB
	+J63XbDpLDhYKWFRN10CXlc+7fVf23nozcEhjX8iNZQl9OsKPmrUN3mqHFSrvptVKqWp2a5pgxgnt
	ZWckZyEi0Ot12mjPpwPjNzO4yYpmw+dE9ydB7Q1zi8p21XAWZlN7L3Qm12acwQR9ngjlXUlHbREhf
	uWqQgc8xZG5bxz1n8bQL/KeuI0dUB9JUfBJ4Km9UAtfhqD6yQArep/A5KYlzs0Kaqrf8pytuaMVQP
	a5JEA4mFRkE3+jAv/gtAeYBpSQlOiddw6iveJ8ieHKbR6+3IyrUoUjtY4vJVLbVA8eWDhYpF4f8uR
	puP0le3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS57X-0000000GZuU-1Gqd;
	Thu, 19 Jun 2025 02:35:19 +0000
Date: Thu, 19 Jun 2025 03:35:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG][RFC] broken use of __lookup_mnt() in path_overmounted()
Message-ID: <20250619023519.GT1880847@ZenIV>
References: <20250531205700.GD3574388@ZenIV>
 <20250602-zugeneigt-abgepfiffen-c041e047f96e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-zugeneigt-abgepfiffen-c041e047f96e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 02, 2025 at 11:17:25AM +0200, Christian Brauner wrote:

> Fwiw, I have pointed this out in one of my really early submission of
> this work and had asked whether we generally want the same check. That's
> also why I added the shadow-mount check into the automount path because
> that could be used for that sort of issue to afair but my memory is
> fuzzy here.

Actually, the check in do_move_mount() is too early.  Look:
(after having made sure . is on a private mount)
mount -t tmpfs none A
mkdir A/x
mount --make-shared A
mount --bind A/x B
mount --make-slave B
mount -t tmpfs other A/x
umount B

... and now move_mount() B beneath A/x.  See what happens?  We get one
secondary copy, attached on top of the root of primary.  _After_ we'd
entered attach_recursive_mnt(), so all checks in do_move_mount() have
nothing to catch - yet.  So we end up with that secondary being side-by-side
with the "other" tmpfs...

The unpleasant part is that we'll need to backport that stuff, so it
has to be done _before_ the do_move_mount()/attach_recursive_mnt()
cleanups ;-/

Once the side-by-side thing is eliminated, we can (and IMO should) add
mnt->mnt_overmount pointing to whatever's mounted on top of root of
mnt (NULL if nothing is).  That simplifies quite a few things, including
the prevention of side-by-side shite, but we can't do it first, more's
the pity...

Hell knows, maybe MNT_OVERMOUNTED as the first step would be doable -
it would allow for simpler (and lower-overhead) intermediate step
before the introduction of ->mnt_overmount and further simplifications...

