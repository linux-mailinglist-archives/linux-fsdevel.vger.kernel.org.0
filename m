Return-Path: <linux-fsdevel+bounces-43795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED59A5DBF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B993A6940
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84D23F393;
	Wed, 12 Mar 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pnHxY4Ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC523C8A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780199; cv=none; b=h3C8820avOcVQLhHr0wJklp/IWdhsn5z4Hql8KvmFghTt6IKB3Zncq4F/D7R03GVHHTjWYMHkf3fTluF5jnyCu4KzImsSOkLHADRIZ+2HtGfPk62vJhYM9fNgZFNdP/EzcFcD9eaFJqJtLjfR9i33MCLGuCm0NzCmUWUPoPoLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780199; c=relaxed/simple;
	bh=+mMmTVdZzs8xN4brEzKMTRsvfKzOqUqVXDEoX0o8ZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmkqycF9/VJORX6VdcJXub03F3WC4ICNB2H3+wrS2wThs2pXoAjzcNUmS3M1maDXpG8Pn9aK/1NjFyr4Vv+lHpQsHyaPBlmgZ30XDScwOPG5bAdc5Ef8US61GVOYxlJIk5lBEAQr/aCHpJqleCyiypmKoKxS4/+15CIOaD/MWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pnHxY4Ck; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZCTSp1D2vzT0T;
	Wed, 12 Mar 2025 12:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741780186;
	bh=QsMaPBu1IdHzdlDOxIMhl0ux6i83ae+8laogwKMHg4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnHxY4CkcbNWRlhF+0O04kIcRmdPYDbpgI+WOpzOfWHvSLy7lTggqVebTowzFqwE3
	 LCle8bhFRwogHcVtA/FFLQrSTJEBuumvjl3dkpFsS23OOGMNZQNhzEKxrv+wn1oNOC
	 vUAdikjehEJdBJwLV4lPqFD7UWSXxCxAWODt9MyA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZCTSn3XYtzPvN;
	Wed, 12 Mar 2025 12:49:45 +0100 (CET)
Date: Wed, 12 Mar 2025 12:49:44 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
Message-ID: <20250312.uo7QuoiZ7iu1@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
 <543c242b-0850-4398-804c-961470275c9e@maowtm.org>
 <20250311.laiGhooquu1p@digikod.net>
 <63681c08-dd9e-4f8f-9c41-f87762ea536c@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63681c08-dd9e-4f8f-9c41-f87762ea536c@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 11, 2025 at 11:18:49PM +0000, Tingmao Wang wrote:
> On 3/11/25 19:28, Mickaël Salaün wrote:
> > On Mon, Mar 10, 2025 at 12:39:04AM +0000, Tingmao Wang wrote:
> > > On 3/6/25 03:05, Tingmao Wang wrote:
> > > [...]
> > > > This is also motivated by the potential UX I'm thinking of. For example,
> > > > if a newly installed application tries to create ~/.app-name, it will be
> > > > much more reassuring and convenient to the user if we can show something
> > > > like
> > > > 
> > > >       [program] wants to mkdir ~/.app-name. Allow this and future
> > > >       access to the new directory?
> > > > 
> > > > rather than just "[program] wants to mkdir under ~". (The "Allow this
> > > > and future access to the new directory" bit is made possible by the
> > > > supervisor knowing the name of the file/directory being created, and can
> > > > remember them / write them out to a persistent profile etc)
> > > 
> > > Another significant motivation, which I forgot to mention, is to auto-grant
> > > access to newly created files/sockets etc under things like /tmp,
> > > $XDG_RUNTIME_DIR, or ~/Downloads.
> > 
> > What do you mean?  What is not currently possible?
> 
> It is not currently possible with landlock to say "I will allow this
> application access to create and open new file/folders under this directory,
> change or delete the files it creates, but not touch any existing files".
> Landlock supervisor can make this possible (keeping track via its own state
> to allow future requests on the new file, or modifying the domain if we
> support that), but for that the supervisor has to know what file the
> application tried to create, hence motivating sending filename.

This capability would be at least inconsistent, and dangerous at worse,
because of policy inconsistencies over time.  A sandbox policy should be
seen over several invocations of the same sandbox.  See related deny
listing issues: https://github.com/landlock-lsm/linux/issues/28

Let's say a first instance of the sandbox can create files and access
them, but not other existing files in the same directory.  A second
instance of this sandbox would not be able to access the files the same
application created, so it will not be able to clean them if required.
That could be OK in the case of the ~/Downloads directory but I think it
would be weird for users to not be able to open their previous
downloaded files from the browser, whereas it was allowed before.

For such use case, if we want to avoid new browser instances to access
old downloaded files, I'd recommand to create a new download directory
per browser/sandbox launch.

> 
> (I can see this kind of policy being applied to dirs like /tmp or my
> Downloads folder. $XDG_RUNTIME_DIR is also a sensible place for this
> behaviour due to the common pattern of creating a lock/pid file/socket
> there, although on second thought a GUI sandbox probably will want to create
> a private copy of that dir anyway for each app, to do dbus filtering etc)

An $XDG_RUNTIME_DIR per sandbox looks reasonable, but in practice we
also need secure proxies/portals to still share some user's resources.
This part should be implemented in user space because the kernel doesn't
know about this semantic (e.g. DBus requests).

