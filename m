Return-Path: <linux-fsdevel+bounces-51347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CEBAD5D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A943A511F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A5225787;
	Wed, 11 Jun 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rezvt1uE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF91CF7AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664301; cv=none; b=jJH8j7lrrbrkOt8DTkZkZrrRAbE2YJ+ehKv3HQsfwaRX4zHoCAuBU8LCWD5wVLhir0zM75z15k/qLaePKTuVheSetJ0NFmpjDeTVf7VyHNiyjSayocJmGUb2hDmVcYI2HY1qCJHXu/k97AW0jKfvEEWbxMl4dFAmWxe/J7zNgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664301; c=relaxed/simple;
	bh=u1RXSUUMXWKEO1QZ04HL7xbf84X4ppfxzjWyelelFsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlbgC/mY0MTzQ4IcnlglyAjLgbC918lYhqLdQLpEpU4y9WboMOS0HHA1JzPUuxid11/Od+oB7WHxPQeOcyb4XttDQ94OxduYuM42tOHDJeV0Gky4f6POf4QO99X32ezlSXHgwvXqtd5b5iRB2ctdi10oFyqgWNcS88ks1q2GFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rezvt1uE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JKVhcOgzFLAUgWH3cidz5Li6EKgKXLrg/gy7EodLbH0=; b=rezvt1uEgZWmqC9o6AwIyNwf/K
	zmROq0TxdqJbLAAlNLNd5Ne72j2fo0PfeHfCaizf5rlye4syGkehoefsnBkLzsK2QT3FmOhzknZO3
	U9PD7oPV2u0BKib8JrMK/DP+/DxtrDn1rYdNeWIY6QF7fqewfZjTZfejk+xgLaqbRfQrQC2cI4q1r
	88pPLsLM4OkjjBOHN3xMpuBCMzejBfPFuxqdgbH1TzToUxY1aOcHCv5ZV/R6kgVEZdAVcLG1aAxVj
	s4QKROjXELlxPqGu6LHPbiDmEYtiWcCdcfOCDjhqHuHF2V/8ILX9mWNMZUGWkJYjIFOOPeZIREK6R
	/YZMRSUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPbs-00000004nFY-2jXF;
	Wed, 11 Jun 2025 17:51:36 +0000
Date: Wed, 11 Jun 2025 18:51:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES][RFC][CFR] mount-related stuff
Message-ID: <20250611175136.GM299672@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250611-ehrbaren-nahbereich-7bb253d46a94@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-ehrbaren-nahbereich-7bb253d46a94@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 12:31:54PM +0200, Christian Brauner wrote:
> On Tue, Jun 10, 2025 at 09:17:58AM +0100, Al Viro wrote:
> > 	The next pile of mount massage; it will grow - there will be
> > further modifications, as well as fixes and documentation, but this is
> > the subset I've got in more or less settled form right now.
> > 
> > 	Review and testing would be very welcome.
> > 
> > 	This series (-rc1-based) sits in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> > individual patches in followups.
> > 
> > 	Rough overview:
> > 
> > Part 1: trivial cleanups and helpers:
> > 
> > 1) copy_tree(): don't set ->mnt_mountpoint on the root of copy
> > 	Ancient bogosity, fortunately harmless, but confusing.
> > 2) constify mnt_has_parent()
> > 3) pnode: lift peers() into pnode.h
> > 4) new predicate: mount_is_ancestor()
> > 	Incidentally, I wonder if the "early bail out on move
> > of anon into the same anon" was not due to (now eliminated)
> > corner case in loop detection...  Christian?
> 
> No, that wasn't the reason. When moving mounts between anonymous mount
> namespaces I wanted a very simple visual barrier that moving mounts into
> the same anonymous mount namespace is not possible.
> 
> I even mentioned in the comment that this would be caught later but that
> I like it being explicitly checked for.

OK...  AFAICS, the way those tests were done it would not be caught later.
At the merge time loop detection had been the same as in mainline now:
        for (; mnt_has_parent(p); p = p->mnt_parent)
		if (p == old)
			goto out;
and that will never reach that goto out if mnt_has_parent(old) is false.
The early bailout avoided that problem, thus the question if that's where
it came from...

