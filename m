Return-Path: <linux-fsdevel+bounces-69142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3EC71073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 21:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EE2F524227
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A11325493;
	Wed, 19 Nov 2025 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bbujY7Qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3D372AA3;
	Wed, 19 Nov 2025 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763583843; cv=none; b=Atp84fpjpOa6X8X5wAR7WwKSpIxJsGz2GMVvGHVsydcMnq+E2zRGWzZHvLnT8L0pvqXAPj+wZOjgIs/F2eOBykPiWll6itxdlE9UBABjG35oFn4fcx7H7p0XeNQMxXz8l5X5SnDq9LYhnD/VxiguM9e6fgJGKYLjKjzDZsODBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763583843; c=relaxed/simple;
	bh=pU70W1q1v6P1jFf5PiTMIlWcXdwWshMqEw8DcjGOW1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN9ChnZQVcbo45wsWzuIikZIiNR+NYDOmkPwe9GsRrTkA/pEQ4RayF3Fty3Wa6iJ+/3t8epcqyrrWCGmNRt3Cp6ChcGJQI1mZfX9xh2N7g2e69OTkdB0z+Piyl/AAKQFI9jU9nLi1LN9da0pKJlt2zHTpLxpNW2WS3ztyZt8bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bbujY7Qb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GIsZ4k+WB5zgRgzSJ6GIPmmh1kCSr8IpGmP3YjYjqW4=; b=bbujY7Qbm0REHw2kioR0e0QBPJ
	0oaUDGKpAfkBzN7OlBOmoenzQnqHMcW6SxpWJrEGDegLeI6hD2gflv+BdkOoJxok55Re1xl0zJK5p
	Ds0sVMB1J5yLdEjft+k7xd9qEL0DnEnIN/9JAAsVHV4FjwxGb7SlTANgv0RfYveoUR4f0FGysqI/x
	mualhOc9F9n6XI0Pg80hoTdyg//wSmrvcmE5h6htvmyUK6JkWj5dTEZLpixLbLZ+WEBX7iGuSvxYl
	lkHONgUl6Y9gjz/ISgi7ZCTzYGPnZ8LQ5a1suXhE1UWlpPkHQqzeyT7aPx2QGvw34EtAEk0xAQwT+
	KRiqeBbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLoid-00000009xPY-2Pxc;
	Wed, 19 Nov 2025 20:23:59 +0000
Date: Wed, 19 Nov 2025 20:23:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: inline step_into() and walk_component()
Message-ID: <20251119202359.GP2441659@ZenIV>
References: <20251119184001.2942865-1-mjguzik@gmail.com>
 <20251119194210.GO2441659@ZenIV>
 <CAGudoHHroVs1pNe575f7wNDKm_+ZVvK3tJhOhk_+5ZgYjFkxCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHroVs1pNe575f7wNDKm_+ZVvK3tJhOhk_+5ZgYjFkxCA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 19, 2025 at 08:49:36PM +0100, Mateusz Guzik wrote:

> this keeps the style of the current step_into, which I can stick with
> 
> The gotos, while uglier, imo provide easier handling should one try to
> mess with the checks, but I'm not going to die on that hill.

The problem is that compiler is not the only audience to care about -
humans occasionally need to read and understand that as well, and
barrier-related logics in that area had caused quite a bit of PITA
over the years.

> btw, is there a way to combine DCACHE_MANAGED_DENTRY + symlink check
> into one branch? The compiler refuses at the moment due to type being
> a bitfield. Given how few free flags are remaining this is quite a
> bummer.

Is that really worth bothering with?  Condition is "bits 15..17 are 000
and bits 19..21 are _not_ 110" and I don't see any clean way to change
the encoding so that it could be done in one test.  In theory we could
do something like swapping the "type" and "managed" bits and use the
fact that 6 (symlink) is the maximal type we might run into, turning
that into flags & ((7<<15)|(7<<19))) < (6<<15), but...  *ewww*

If nothing else, it would
	* require us to remember that "managed" bits must be higher
than "type" ones
	* require us to remember that 7 is never to be used as type
	* require every sodding human reader to figure out what the
bleeding fuck is that test about
and I really don't believe that shaving a couple of cycles is worth
that.

