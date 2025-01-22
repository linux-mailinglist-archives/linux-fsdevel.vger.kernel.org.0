Return-Path: <linux-fsdevel+bounces-39865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE5A19A15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3743A7AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B570C1C5D4C;
	Wed, 22 Jan 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d7LcHWjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429C8F7D;
	Wed, 22 Jan 2025 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737579692; cv=none; b=Rw16jC8AZsGBqtpSnhE9c3yTuIQUxxjkT20jgWUCVn/Xulr2NERYnbnCTZoHJH7wcvTFj2b91+An8RodvmFJjW1xssjDeJ7fWpjhVkux69vsNtTpPBzJcoQAWKJCP5RYxnPqUYVxcggQOuVzEmKEx6s8qxlI9V1mHvaLaF4RHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737579692; c=relaxed/simple;
	bh=VSPzq3NK16Y7VJXRn++oFdJG5QMgUGfHnjIpSJFU2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUbwxoL3YbHyWDBxgPEL06lssYgvrpxhdBD2pSg00jtinnPp6VtgZrovVa4SGhwvTyFzebsR24XKxK41FDSbHsS/jMOmhKb8wFEAwpxs0LugmcE2dQaWJjCF/3MV6cZVPWUhmyt78ukC6Dm9xh+TTk4taa7XDyi7aSmL1YijiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d7LcHWjK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tLIDvWnGQCG3Cd82qPCqfbQonk5WsLWbLleh1ilSwnk=; b=d7LcHWjK/ZhFIoHO3ggC3z4v2q
	GFGy9t5uNTPHlR75tfyAb9oBZDUH2mVPsPxVl1OYxaRlvcivzy4ae+zztTVY18Z59hi6pAAHdN7Vi
	YJ6Dzxcb3E/7aFtkrULaG+FST1MGF12P4mkFbjIel417k20FCOqQ784uUFmTlBq9T8U3M2JQ6NHn7
	ZMbBBUA7CDfdfF8FYdkSloTTSAyVHbAg81cvUtmjwHMKrUitwKrHr71qM5vSKeGxhhiVd2XZPnlor
	2/C0sNeyWYCE3ZtlPHpA9HUu4h18KRW3pUznReG79RSK1TnoXCAEYRO3yx9RaMtTwv1c4q5RjKK7z
	vODVZ7LQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tahqm-000000081uG-1m54;
	Wed, 22 Jan 2025 21:01:24 +0000
Date: Wed, 22 Jan 2025 21:01:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, hubcap@omnibond.com,
	jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org,
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 08/20] afs_d_revalidate(): use stable name and parent
 inode passed by caller
Message-ID: <20250122210124.GZ1977892@ZenIV>
References: <20250116052317.485356-8-viro@zeniv.linux.org.uk>
 <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
 <2066311.1737577661@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2066311.1737577661@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 22, 2025 at 08:27:41PM +0000, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > -	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
> > +	_enter("{%lu},{%s},", dir->i_ino, name->name);
> 
> I don't think that name->name is guaranteed to be NUL-terminated after
> name->len characters.  The following:
> 
> 	_enter("{%lu},{%*s},", dir->i_ino, name->len, name->name);
> 
> might be better, though:
> 
> 	_enter("{%lu},{%*.*s},", dir->i_ino, name->len, name->len, name->name);
> 
> might be necessary.

Good catch (and that definitely needs to be documented in previous commit),
but what's wrong with
	_enter("{%lu},{%.*s},", dir->i_ino, name->len, name->name);

After looking through the rest of the series, fuse and orangefs patches
need to be adjusted.  Not caught in testing since there similar braino
manifests as stray invalidates ;-/

