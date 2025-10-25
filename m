Return-Path: <linux-fsdevel+bounces-65617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85624C08A6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 05:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148E61CC7749
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C5273D6C;
	Sat, 25 Oct 2025 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Fub/+nVe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AB215F6B;
	Sat, 25 Oct 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363370; cv=none; b=JICCbzV0tNo1WD7WebZ1osNVU/uDHRBZ/WuldBnYfb6ZfEg67VKmqPf9fk3muV2GHCjOj0dv6dldEgaydvB9T3gEFMaSM97c9PcXW3xUpdmNs6SD8Y+mKVJSHKGWBDrKVoNuOnw4mNINS6EfrPRUsIG5vw/hlvMuTSitFPvvQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363370; c=relaxed/simple;
	bh=KiON0OU+Y/RR/jXzP9+/gwwp+JIlFiRQgsnXLMPprwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBxDA0DXt3MafxH+7qMYiDrmjCG1RZgi3yEltEscVqk8zBOEIT4QkO8URkTuFYSFtnddikjnK8rv3E1U0aSiC8L9HPrIpULF/00AQN4GoGHwNEpf7wi1s8ilkFB9kUcfRU80t0QqjwxaOYQFEy3/IsUcKKthiWuKTLC47S5/SJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Fub/+nVe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cbugbZ+qcT/wMKq21rqYgDFNKpMW8Ujxzcq00HGBWCs=; b=Fub/+nVe73IoydgDcQfwiwEOT+
	yVfeo1JMxWigGVonx9kafO5yX5RhmBeZzQ2np82JYDmOzBFCwd11Z9DHEDdM4nyw3awdDVX7yXv1/
	T47wKmTOCQcN2NC1LhUTjIK8+HDdt5AiMZn4aYJq5O+MbYW/O4EC8MYoN8RIMnIUBiO9lApBMzDiN
	3+An56UwxbaRLd4wYMRgPfwpWVJvNgvyg59j60IZjbNzHdEk4ZNbokaWPvEju35D+rL0V2UrN5rBH
	4x8SAlJaF4iIUpxeRvyYZxxmF7Qlk2J6FdPfd6PNzJHMAer9wkKK9xWYxk+5LVurXBLx2gVyWbNIa
	bK/cEZTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCV4U-00000009yw1-08Ph;
	Sat, 25 Oct 2025 03:36:02 +0000
Date: Sat, 25 Oct 2025 04:36:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: GuangFei Luo <luogf2025@163.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mount: fix duplicate mounts using the new mount API
Message-ID: <20251025033601.GJ2441659@ZenIV>
References: <20251025024934.1350492-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025024934.1350492-1-luogf2025@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 25, 2025 at 10:49:34AM +0800, GuangFei Luo wrote:

> @@ -4427,6 +4427,7 @@ SYSCALL_DEFINE5(move_mount,
>  {
>  	struct path to_path __free(path_put) = {};
>  	struct path from_path __free(path_put) = {};
> +	struct path path __free(path_put) = {};
>  	struct filename *to_name __free(putname) = NULL;
>  	struct filename *from_name __free(putname) = NULL;
>  	unsigned int lflags, uflags;
> @@ -4472,6 +4473,14 @@ SYSCALL_DEFINE5(move_mount,
>  			return ret;
>  	}
>  
> +	ret = user_path_at(AT_FDCWD, to_pathname, LOOKUP_FOLLOW, &path);
> +	if (ret)
> +		return ret;
> +
> +	/* Refuse the same filesystem on the same mount point */
> +	if (path.mnt->mnt_sb == to_path.mnt->mnt_sb && path_mounted(&path))
> +		return -EBUSY;

Races galore:
	* who said that string pointed to by to_pathname will remain
the same bothe for user_path_at() and getname_maybe_null()?
	* assuming it is not changed, who said that it will resolve
to the same location the second time around?
	* not a race but... the fact that to_dfd does not affect anything
in that check looks odd, doesn't it?  And if you try to pass it instead
of AT_FDCWD... who said that descriptor will correspond to the same
opened file for both?

Besides... assuming that nothing's changing under you, your test is basically
"we are not moving anything on top of existing mountpoint" - both path and
to_path come from resolving to_pathname, after all.  It doesn't depend upon
the thing you are asked to move over there - the check is done before you
even look at from_pathname.

What's more, you are breaking the case of mount --move, which had never had
that constraint of plain mount.  Same for mount --bind, for that matter.

I agree that it's a regression in mount(8) conversion to new API, but this
is not a fix.

