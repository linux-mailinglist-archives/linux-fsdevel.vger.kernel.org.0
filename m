Return-Path: <linux-fsdevel+bounces-41162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE9A2BBD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9FE7A2D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB7199238;
	Fri,  7 Feb 2025 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbR3vVtS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5D15199C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911106; cv=none; b=G4aFq7ZbATrTgNJOpH6hP+Pz7Ms+4xOsmGm1q1eeXKtGOcdGxaqCFA20KGojrxTaP2CgyieY5yYQxWJWoHUvTh2eKqTbwWwOqjSSGDZ9IlvaqYeBnGpqDZFbuGngQFsIio5Jj+OCCkMcdwAIM6IuFY3YU0FiYCtzzU20E9rZDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911106; c=relaxed/simple;
	bh=xh8ZM3QFkkSk+FOMf+3c0vTZV18zOe9kyuRrvfP61IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1r2zTQOA1IidEeRd38GCAA9DppixeJvXmfKp6MngAEMPxFpsZmrE6T5zmX3ZL6dFUKn0oKop1mwThWT3Ugy5FG7B9VkkkhyEASv2tTvA7SZsKPN1mAmTqHHimtyLoe18B7Rb+lc03RrejGf2FvATHK/uJUGjmFyYwJyZhDvvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbR3vVtS; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Feb 2025 01:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738911088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqkw7E8iW/wES+Hraomqy4dQ/FgA7hv7hZ59Xs56vO4=;
	b=jbR3vVtSYanJASGOtIvu3UUK2uJsV3dp7GUOhAsHPo2EaYUkES3FhKIz1dns29fbGShb/i
	jR7B5bNsZFibJK0oA5hlpBUqbasgozVKfew9gpTIizSaq9H9A8iV1CiSXvwMmbjmqjo0M1
	2etK59nIiUX8Q6CISpdX6yGKhBs1UZY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <lfzaikkzt46fatqzqjeanxx2m2cwll46mqdcbizph22cck6stw@rhdne3332qdx>
References: <>
 <7mxksfnkamzqromejfknfsat6cah4taggprj3wxdoputvvwc7f@qnjsm36bsrex>
 <173891006340.22054.12479197204884946914@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173891006340.22054.12479197204884946914@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 07, 2025 at 05:34:23PM +1100, NeilBrown wrote:
> On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > > Do you think there could be a problem with changing the error returned
> > > in this circumstance? i.e. if you try to destroy a subvolume with a
> > > non-existant name on a different filesystem could getting -ENOENT
> > > instead of -EXDEV be noticed?
> > 
> > -EXDEV is the standard error code for "we're crossing a filesystem
> > boundary and we can't or aren't supposed to be", so no, let's not change
> > that.
> > 
> 
> OK.  As bcachefs is the only user of user_path_locked_at() it shouldn't
> be too hard.

Hang on, why does that require keeping user_path_locked_at()? Just
compare i_sb...

