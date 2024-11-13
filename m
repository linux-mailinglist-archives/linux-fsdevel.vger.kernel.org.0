Return-Path: <linux-fsdevel+bounces-34574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E189C6618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFEE2861A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DCCB676;
	Wed, 13 Nov 2024 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc3rhb7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADF3C2F;
	Wed, 13 Nov 2024 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458251; cv=none; b=sE8FsYxTMlvMNZIaMeel76aIWtn6mBIHaCAGcv6Xzuj7RZtnm3QQfdQAzgZJp3UEv7UcSE4Y47Ox/dDVE/Ai693keu6egejpiOi6uMjd9diWaxa4imjT0XKshXTg/JyY8uOIYIN49ZUn3z64yXKzNYxWgMYLBBOKTsvzI3oKLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458251; c=relaxed/simple;
	bh=u4Y2rROCN38fXmIjh1RCebYosHQ9wEz8A1Dqj4OqFbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD0BbsXuBzliWBnSXd8vHeC+et4N8ZynJIudg/nDEZ3N2wfS+kQEi6Ne9gA1hDgZQQ2Ii9SixctvP83B5uovrUX08q9VjFg6Sk+wDgJ6xxYr1twS1dT/eYRNdbI809x1/GAUeHBz2OHBVCplovQnmUzg/dfMFg799dlM+MHEOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc3rhb7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74489C4CECD;
	Wed, 13 Nov 2024 00:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731458250;
	bh=u4Y2rROCN38fXmIjh1RCebYosHQ9wEz8A1Dqj4OqFbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fc3rhb7/d6chjb5VMDcKrhioVwhcqSdGYcqNn2j6u5X60TQmFZafpSrPZaD0zOfFE
	 Wh+iQyd6FVbXnmViG78MTsXHRE0eOAjjJmhmT7CIwVqiBIZ6Wn3vyDis9RTaoRN/+r
	 sDOg1VycXA64xFUQqzmy7zVe0aIWnttbIs7abtbzZGyUWegTW98k44u9c/OnqRXCYA
	 25FQ/ZDvoncwyY3ZDQxdjCwmhSQZ4nzPYl5w/6g1sbPpfla6nz/IQLKah+eUEcr5g9
	 26RtBo+So/aaifUigDNHvjhrri+ojLiF/u18W6qezlDKUlVdIRPzbtJswIOgbFR8Le
	 i88PXoH9W3oag==
Date: Tue, 12 Nov 2024 16:37:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, christian@brauner.io,
	paul@paul-moore.com, bluca@debian.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/4] pidfs: implement file handle support
Message-ID: <20241113003729.GF9421@frogsfrogsfrogs>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241112-banknoten-ehebett-211d59cb101e@brauner>
 <45e2da5392c07cfc139a014fbac512bfe14113a7.camel@kernel.org>
 <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu>

On Tue, Nov 12, 2024 at 11:43:13PM +0100, Erin Shepherd wrote:
> On 12/11/2024 14:57, Jeff Layton wrote:
> > On Tue, 2024-11-12 at 14:10 +0100, Christian Brauner wrote:
> > We should really just move to storing 64-bit inode numbers internally
> > on 32-bit machines. That would at least make statx() give you all 64
> > bits on 32-bit host.
> 
> I think that would be ideal from the perspective of exposing it to
> userspace.
> It does leave the question of going back from inode to pidfd unsolved
> though.I like the name_to_handle_at/open_by_handle_at approach because
> it neatly solves both sides of the problem with APIs we already have and
> understand
> 
> > Hmm... I guess pid namespaces don't have a convenient 64-bit ID like
> > mount namespaces do? In that case, stashing the pid from init_ns is
> > probably the next best thing.
> 
> Not that I could identify, no; so stashing the PID seemed like the most
> pragmatic
> approach.
> 
> I'm not 100% sure it should be a documented property of the file
> handle format; I somewhat think that everything after the PID inode
> should be opaque to userspace and subject to change in the future (to
> the point I considered xoring it with a magic constant to make it less
> obvious to userspace/make it more obvious that its not to be relied
> upon; but that to my knowledge is not something that the kernel has
> done elsewhere).

It's a handle, the internal details of its layout of it is supposed to
be opaque to userspace.  I wonder how well userspace deals with weirdly
sized handles though...

--D

> - Erin
> 
> 

