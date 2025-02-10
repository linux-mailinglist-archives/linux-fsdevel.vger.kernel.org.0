Return-Path: <linux-fsdevel+bounces-41382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA882A2E80C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122621889B67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72B1C5499;
	Mon, 10 Feb 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYJXSU3W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E2185935;
	Mon, 10 Feb 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180528; cv=none; b=TZCA2nVIgNclickwBsOSlRdxyEPAg9zRF2WSkEjg4ZOF1U7RrRTRvC/cXa/T7m9rKmZkyVsh27O7yk10DTK1o2DdPu8Zn+ONCmT622KiS6TS0HiPLbUAVlpF7oxoRE9qCivFDeTbJj+j7X9DbknLHOa4AbrBeG+UJt9fjWjNM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180528; c=relaxed/simple;
	bh=/rwxf/BzGy+fmNxwMUlA/oFiUzSI1GSGACuPSGqyoFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIOJRFILwHH/O7a+Agd88RT+o/b3yvvCaz+TcJZY+Sk9RGIYxU0NSWdmdq4wpaTe1BXUGrQeB37nKLuJcGy4J1tmVJ2LlThdBppUTq+QdjubAdg5dPaN32rdf79ewe7E/z9gxpEk917Hh+xKzvuo5+Z+fB/65KvrSpAtiPA6MWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYJXSU3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED48C4CED1;
	Mon, 10 Feb 2025 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739180527;
	bh=/rwxf/BzGy+fmNxwMUlA/oFiUzSI1GSGACuPSGqyoFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYJXSU3W5Y1qR3ODXR+3tw3P2jtt260lDrNbIznB2Juq6IzB/2jfd0t9Iq6xqioGC
	 Bkodgv2OcaxfY0JOrXr/dORGa9Jw+R3KKjFrqRn8BcEgu0MJxL5jc7lSVYM3lAtI/K
	 3hv609zSrqNxGX/HcSsG2QbcGea8JSGTEmEpOqe1GI4/tJBiX7CtUFvPPSKAbES5l4
	 SbN8UL0wiDe3yTUEMOPDLyKtzJ7SwRSaS6Ej9gHpt0TmN1Jdbnx3zo71Q5rUbLHFt3
	 xZpjVNTm0eJefl7CUE1GShH9OTVHbAueynu80RE/vy+NYTodJHeTI1qoyy5NwDeNwl
	 PpcMB6z3/cP9w==
Date: Mon, 10 Feb 2025 10:41:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neilb@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <sfrench@samba.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	audit@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] VFS: minor improvements to a couple of interfaces
Message-ID: <20250210-abrieb-aspekt-80b6455a99de@brauner>
References: <20250207034040.3402438-1-neilb@suse.de>
 <20250210-enten-aufkochen-ffecc8b4d829@brauner>
 <20250210084246.GB1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210084246.GB1977892@ZenIV>

On Mon, Feb 10, 2025 at 08:42:46AM +0000, Al Viro wrote:
> On Mon, Feb 10, 2025 at 09:25:26AM +0100, Christian Brauner wrote:
> > On Fri, 07 Feb 2025 14:36:46 +1100, NeilBrown wrote:
> > >  I found these opportunities for simplification as part of my work to
> > >  enhance filesystem directory operations to not require an exclusive
> > >  lock on the directory.
> > >  There are quite a collection of users of these interfaces incluing NFS,
> > >  smb/server, bcachefs, devtmpfs, and audit.  Hence the long Cc line.
> > > 
> > > NeilBrown
> > > 
> > > [...]
> > 
> > I've taken your first cleanup. Thanks for splitting those out of the
> > other series.
> > 
> > ---
> > 
> > Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.15.misc branch should appear in linux-next soon.
> 
> Might be better to put it into a separate branch, so that further
> work in that direction wouldn't be mixed with other stuff...

Yep, good call:

vfs-6.15.async.dir

