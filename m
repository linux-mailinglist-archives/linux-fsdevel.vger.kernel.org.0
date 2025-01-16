Return-Path: <linux-fsdevel+bounces-39356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA74A1323A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6181667BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589A1428E7;
	Thu, 16 Jan 2025 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YBk94LgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AD4A05
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 05:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004371; cv=none; b=S37hZO2aZz0diazcsqoqaWG7EFJnJnu+TDBStAOGgZmXhQUsgrNSelC4bdYBVE6FiTCSAEZju0GyHPown28Hi/n+pnhmJPJynPeSfGvGo/0wBAw30It19WDjeP8XkJwyEnbjay+s7Z2kpLwcufpFLVxO/Y4oPz+97lRQ2fF2wGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004371; c=relaxed/simple;
	bh=133C9FQsg5c9jc9IkEymeajHMKJhZ8Gr1hW5NdM2z8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnL1sj8E3ACB0zpxUthBpnCywQWK1BCEVFKieS00iNcF84y8P0cNkoHDg308lM7YfEoaCooijrndWmILkBzYMEnqJ6DHcf36axMhAyxLPwAAmqm1zPpmsW/RGUHmJ2UX5ItgKxt6Wb4rpKoeWrM68UV/E0vxc2nCe+PMnN3vIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YBk94LgJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8UiJoYT4u2rLbnO1Vitk0BKl6Heq5XW4J4Pn7vCdS9E=; b=YBk94LgJLdGWpnNXEkzTzr/9Qq
	cfwnm+yiK0kHqaEb5N1ha6085sKRxsK6Dc9jj0HxTmU8wrqhQtKtyipXfY8ixaLLsVDl6wRB6xFwq
	AXvRpqWfNeQwyTKfN/S7nYQYKRbxeZxuGB82i4FYQZ6GOVE7Ext4LA2XyFq6F4fs0aB/liSdg9Xu0
	IhhNVSAFmyYbw/qV5+TWe5ATh53WdK2QHHWvvBkZ4gP/q2dBFs0t038SXih6xQDBWGqPqyT4yrKoY
	lZtvqlM837ouoc14g+78Ka9woqpCMGQ0otoS2t/1TbjPbfPFF/2e2L21pQwMCRg6dq74E6ChOiJfr
	USSvax+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYIBT-000000021ef-1jhi;
	Thu, 16 Jan 2025 05:12:47 +0000
Date: Thu, 16 Jan 2025 05:12:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Boris Burkov <boris@bur.io>
Cc: linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250116051247.GE1977892@ZenIV>
References: <20250115185608.GA2223535@zen.localdomain>
 <20250116041459.GC1977892@ZenIV>
 <20250116045241.GA2456181@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116045241.GA2456181@zen.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 15, 2025 at 08:52:41PM -0800, Boris Burkov wrote:
> So in your opinion, what is the bug here?
> 
> btrfs started using d_path and checking that the device source file was
> in /dev, to avoid putting nonsense like /proc/self/fd/3 into the mount
> table, where it makes userspace fall over. 
>
> (https://bugzilla.suse.com/show_bug.cgi?id=1230641)
> 
> I'd be loathe to call the userspace program hitting the
> 'unshare; open; unshare' sequence buggy, as we don't fail any of the
> syscalls in a particularly sensible way. And if you use unshare -m, you
> now have to vet the program you call doesn't use unshare itself?
> 
> You've taught me that d_path is working as intended in the face of the
> namespace lifetime, so we can't rely on it to produce the "real"
> (original?) path, in general.
> 
> So, to me, that leaves the bug as
> "btrfs shouldn't assume/validate that device files will be in /dev."
> 
> We can do the d_path resolution thing anyway to cover the common case,
> in the bugzilla, but shouldn't fail on something like /loop0 when that
> is what we get out of d_path?

You are asking for a pathname associated with an open file on a mount
that is not within your namespace.  "The path from the root of whatever
namespace it's in starts with /dev" is an odd predicate to check.

Note that the same namespace may have a very different meaning in your
namespace, so...  I'd say that predicate is very likely not doing what
your userland expects anyway.

What is that code trying to do?  is_good_path() looks very... misguided.

