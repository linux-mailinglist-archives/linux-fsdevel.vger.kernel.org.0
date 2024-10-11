Return-Path: <linux-fsdevel+bounces-31688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87B99A243
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8071C23764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980E21503B;
	Fri, 11 Oct 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lof0Uk0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891421503F
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644675; cv=none; b=i6pXPwN4y87px/LRTnoDk6iUU49FEfAuw18lyfjgKMvg2+R1zerCg6lqqF3rmU0BsP8B7geIwqfJpqkn5HSMO8vSWADDxsT4ZOsb45aNymSEKVHUqOtF+objWNWo6YDD091gcW3GgbZgUzwkiN9yqjxMy9JB6zxE9Cx1JsXSK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644675; c=relaxed/simple;
	bh=VPyiv+boH04rAQzfKWU+RIvEJ7tilQRTQhwpGsC5gxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIiLA/dGSEOwhDPQdnhHfiI2jbdYFK/hB6jG94+U1NmyFabwhnpxYFE4tA2QGZ5Ey7iX9StVIx5zSqlg01pyIXU6W2oif4RtbhwhuGJs8tVKKFQzuWN5r5CFo5m9cspnvz/JiDkWHHl9LcZB1t9v35hORAQP2YSO+GHINHljLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lof0Uk0J; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ3fk1NhtztFY;
	Fri, 11 Oct 2024 13:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728644670;
	bh=9Pi1LmPYo8qdspv2MNYu5cluFjYOEW3JdL7e9mPBGs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lof0Uk0J4x/gqYHL7OJpFodgrdbjpTEceSXVnOOrTYQJK0i/79vIk5ONQnB9gMNmo
	 KsKXExCdvaiWj+OaL8ZTEJlda4kZTb1dHmIQdcmg8qtqunQOuh4BCDubt/Mzd2y8si
	 Ux72qe9snzSuQ9q18rKRnItjSaPNPnQMnuu+iFk0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ3fj0d9szRdk;
	Fri, 11 Oct 2024 13:04:29 +0200 (CEST)
Date: Fri, 11 Oct 2024 13:04:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.Di7Yoh5ikeiX@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70645876-0dfe-449b-9cb6-678ce885a073@I-love.SAKURA.ne.jp>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 07:12:17PM +0900, Tetsuo Handa wrote:
> On 2024/10/11 0:26, Mickaël Salaün wrote:
> > When a filesystem manages its own inode numbers, like NFS's fileid shown
> > to user space with getattr(), other part of the kernel may still expose
> > the private inode->ino through kernel logs and audit.
> 
> I can't catch what you are trying to do. What is wrong with that?

My understanding is that tomoyo_get_attributes() is used to log or
expose access requests to user space, including inode numbers.  Is that
correct?  If yes, then the inode numbers might not reflect what user
space sees with stat(2).

> 
> > Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> > whereas the user space's view of an inode number can still be 64 bits.
> 
> Currently, ino_t is 32bits on 32-bit architectures, isn't it?
> Why do you need to use 64bits on 32-bit architectures?

ino_t is indeed 32 bits on 32-bit architectures, but user space can
still get a 64-bit stat->ino value.

> 
> > Add a new inode_get_ino() helper calling the new struct
> > inode_operations' get_ino() when set, to get the user space's view of an
> > inode number.  inode_get_ino() is called by generic_fillattr().
> 
> What does the user space's view of an inode number mean?

It's the value user space gets with stat(2).

> What does the kernel space's view of an inode number mean?

It's struct inode->i_ino and ino_t variables.

