Return-Path: <linux-fsdevel+bounces-57090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A0B1E9FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A369FAA020C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D527E1B1;
	Fri,  8 Aug 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9gIT0hV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E0EAF9;
	Fri,  8 Aug 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662203; cv=none; b=B/TmOuBMdFrtX4ioRPjhg6t02VevqEs+9GpD/3KMEmZOrmvfnp/+z04e1hURq8vEZ4p3Ie+ZSAEry1/vI/050jDWponJmnchjkkhmGQmWXr78gxUOu7AJ2tfjgpaybq5KXAQsFKTV+3fvHGonPhkt9pyC1IhadtS3QAiCkdgXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662203; c=relaxed/simple;
	bh=c+tJGSE1kVOEJc+fqWaxQew8R9k0tADAYnXJUS2UMAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RksBn7cAAkhBW0JQaQOBHVHyevGnmDRpz/pgG/jZa5AMD0PGb9ARSy1doiRJojQ/XbloPk0eRJeZeVcFzvc508JZVYA/e/QlAXuaSKLIAJdWQV3J1oHB98jXSeWum/lr6Hhr6zcG+tCa7puaqCrvHDnHOqbmvHWeFGDZLkqehao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9gIT0hV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DB3C4CEED;
	Fri,  8 Aug 2025 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754662202;
	bh=c+tJGSE1kVOEJc+fqWaxQew8R9k0tADAYnXJUS2UMAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9gIT0hVpFdMcHPf5lG4Z06B5oBym7Tto9V3PjID66JBmGBrQxSBGyBjHkLB1l/g3
	 gfBUBf79hzudX/Ta1zBJ6QUxsTynvw8JfkjUdSYx0Di9g8wAqucAhPzvdABaHyYWqH
	 ez95kCmYwi7iu5he5uyyup9P1VoVJAnJm1zGkGj+4nNOUvCIQbqSBCxjKBNl3TmatD
	 qNrUZyb5tqdpGRRWtC17AxkKWIQZrKbPXMDoBPlJErEKlfLIrebfabMNsUv4bgSB7T
	 AGTRhxq5jnA4lOhrtNLf7s4G6QHq26t7tA2RCZJ4g9VYfU0v5fB6ERFsnvZtk2ADq6
	 cKWelb0hKqpJQ==
Date: Fri, 8 Aug 2025 16:09:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, amir73il@gmail.com, 
	corbet@lwn.net, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, luto@amacapital.net, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
Message-ID: <20250808-kurswechsel-angekauft-ec6bfc2efa79@brauner>
References: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
 <20250806102501.75104-1-safinaskar@zohomail.com>
 <2025-08-06.1754489257-elated-baubles-defiant-growls-beloved-jewelry-9Ofm2b@cyphar.com>
 <2025-08-07.1754550206-glad-sneeze-upstate-sorts-swank-courts-YKmj7E@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754550206-glad-sneeze-upstate-sorts-swank-courts-YKmj7E@cyphar.com>

On Thu, Aug 07, 2025 at 05:17:56PM +1000, Aleksa Sarai wrote:
> On 2025-08-07, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2025-08-06, Askar Safin <safinaskar@zohomail.com> wrote:
> > > > I just realised that we probably also want to support FSCONFIG_SET_PATH
> > > 
> > > I just checked kernel code. Indeed nobody uses FSCONFIG_SET_PATH.
> > > Moreover, fsparam_path macro is present since 5.1. And for all this
> > > time nobody used it. So, let's just remove FSCONFIG_SET_PATH. Nobody
> > > used it, so this will not break anything.
> > > 
> > > If you okay with that, I can submit patch, removing it.
> > 
> > I would prefer you didn't -- "*at()" semantics are very useful to a lot
> > of programs (*especially* AT_EMPTY_PATH). I would like the pidns= stuff
> > to support it, and probably also overlayfs...
> > 
> > I suspect the primary issue is that when migrating to the new mount API,
> > filesystem devs just went with the easiest thing to use
> > (FSCONFIG_SET_STRING) even though FSCONFIG_SET_PATH would be better. I
> > suspect the lack of documentation around fsconfig(2) played a part too.
> > 
> > My impression is that interest in the minutia about fsconfig(2) is quite
> > low on the list of priorities for most filesystem devs, and so the neat
> > aspects of fsconfig(2) haven't been fully utilised. (In LPC last year,
> > we struggled to come to an agreement on how filesystems should use the
> > read(2)-based error interface.)
> > 
> > We can very easily move fsparam_string() or fsparam_file_or_string()
> > parameters to fsparam_path() and a future fsparam_file_or_path(). I
> > would much prefer that as a user.
> 
> Actually, fsparam_bdev() accepts FSCONFIG_SET_PATH in a very roundabout
> way (and the checker doesn't verify anything...?). So there is at least
> one user (ext4's "journal_path"), it's just not well-documented (which
> I'm trying to fix ;]).
> 
> My plan is to update fs_lookup_param() to be more useful for the (fairly
> common) use-case of wanting to support paths and file descriptors, and
> going through to clean up some of these unused fsparam_* helpers (or
> fsparam_* helpers being abused to implement stuff that the fs_parser
> core already supports).
> 
> At the very least, overlayfs, ext4, and this procfs patchset can make
> use of it.

I've never bothered with actually iplementing FSCONFIG_SET_PATH
semantics because I think it's really weird to allow *at semantics when
setting filesystem parameters. I always thought it's better to force
userspace to provide a file descriptor for the final destination instead
of doing some arcane lookup variant for mount configuration. But I'm
happy to be convinced of its usefulness...

