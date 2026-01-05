Return-Path: <linux-fsdevel+bounces-72401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B479CF4FE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94008303F9AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDD52F12D9;
	Mon,  5 Jan 2026 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3PksEop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C033C514;
	Mon,  5 Jan 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633980; cv=none; b=DiQkSbED4+/3mgT9Vnbc6dDJW08cO7SncEZ3XCow1JkxLcMx7LbCVwMUwKMqKi1kUmOm4uZkdi/qUXGntVfdSokzNqLm78tZxsBJaJExwshBaJ7hb5k/+n1snSOjc0EwC0QsrVsI/kdNdy4le6HzFyevRZPIbxixEmlgzetUDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633980; c=relaxed/simple;
	bh=SykrCjOThSCOTyBCvtQFA5OVoQRr6sTQwUlL1i50TZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRYwZcVFZjKNIPzSIxGAOceHjgwH4NMmR5qHAqX729VG6KCSp0esZETSdJ5qXiGn0o4WTzObbN32g+EyT8fC8qDmqNhOdvri/9uO59XumLW5ogcjVaix/5hFN3Olwf+9m2n4RiLk6UYOI4oZGpLT75znVv7gb9GVCDx5e0RiPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3PksEop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C6C116D0;
	Mon,  5 Jan 2026 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633978;
	bh=SykrCjOThSCOTyBCvtQFA5OVoQRr6sTQwUlL1i50TZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3PksEoplxOiVTaFKbKtB/xJ3nD9U0qH5o6F/tNbb3ZHMpGHGYWwtxNYzxqhzcl4J
	 zKiBlkERtRY4lIiznNbKrwz9kNanBaeeGTDgVRvNDlVGWaJKMBNfpKGvTZOlpmfnGu
	 UUhM+kbHXLzLw/yNl08vqu1xvOwC8JCxHXAc/vIhyVtHeq4231so7oByMBru+/yYIN
	 GeWNUUwvgXhcB2j72IQA3oklXbfFC2AIdImB5euZh0X5Hmq5QNjMJY1G2gFFEGYS+k
	 e+lRrzyRQEuXAufnQ1X4RgljcyfJuAwNYSSVKwunnQ+jITqJEBVyTCN67bcLNJ4fhU
	 oyaduFm7byKfw==
Date: Mon, 5 Jan 2026 09:26:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, hch@lst.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: send uevents for filesystem mount events
Message-ID: <20260105172618.GB191481@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
 <20251224-imitieren-flugtauglich-dcef25c57c8d@brauner>
 <284c79aa-7088-40a5-a6f5-31de8404e62f@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284c79aa-7088-40a5-a6f5-31de8404e62f@themaw.net>

On Sat, Dec 27, 2025 at 07:58:10AM +0800, Ian Kent wrote:
> 
> On 24/12/25 20:47, Christian Brauner wrote:
> > On Wed, Dec 17, 2025 at 06:04:29PM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Add the ability to send uevents whenever a filesystem mounts, unmounts,
> > > or goes down.  This will enable XFS to start daemons whenever a
> > > filesystem is first mounted.
> > > 
> > > Regrettably, we can't wire this directly into get_tree_bdev_flags or
> > > generic_shutdown_super because not all filesystems set up a kobject
> > > representation in sysfs, and the VFS has no idea if a filesystem
> > > actually does that.
> > > 
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > I have issues with uevents as a mechanism for this. Uevents are tied to
> > network namespaces and they are not really namespaced appropriately. Any
> > filesystem that hooks into this mechanism will spew uevents into the
> > initial network namespace unconditionally. Any container mountable
> > filesystem that wants to use this interface will spam the host with
> > this event though the even is completely useless without appropriate
> > meta information about the relevant mount namespaces and further
> > parameters. This is a design dead end going forward imho. So please
> > let's not do this.
> > 
> > Instead ties this to fanotify which is the right interface for this.
> > My suggestion would be to tie this to mount namespaces as that's the
> > appropriate object. Fanotify already supports listening for general
> > mount/umount events on mount namespaces. So extend it to send filesystem
> > creation/destruction events so that a caller may listen on the initial
> > mount namespace - where xfs fses can be mounted - you could even make it
> > filterable per filesystem type right away.
> 
> Seconded, there are way too many sources of mount events for them to not
> 
> be specific and targeted.

NP, thanks to you both for the quick feedback. :)

--D

> 
> Just my opinion, ;),
> 
> Ian
> 
> 

