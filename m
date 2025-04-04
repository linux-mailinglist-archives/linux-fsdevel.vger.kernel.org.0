Return-Path: <linux-fsdevel+bounces-45765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8547A7BE1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963E01888A30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880771F0986;
	Fri,  4 Apr 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvXEJ6n8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479B1624C9;
	Fri,  4 Apr 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774067; cv=none; b=PhPSbsnfOpgxC5TE0KVzwo34NBDpLiTxvFgkW9e2qO5gRxT69D6IrTxU84xCK3bnIxeJbDJWSTmHgz7tWmQ5vKgupLeTsbQcMPLd7O+X6yQQZmfPJvWnE9KlKS/HOdfVYJLFrZVZYi55NsV1evyrwKM3n9fJOoQ4aR2/8Nf9eUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774067; c=relaxed/simple;
	bh=Q4xnhejB5l0SgKBzeLzuppiBD0WWWZ+in4TshRMzkSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRqXaoqlWqVTdzSuccJIlP+zKFZ2D3i2X2DkYSj/XelujFhARerXTMyVLpZCulT1uPDcjfgBeX+gh0EQZ1d+cT3p9mtSTDap3xwo+ekcRQ4ApkGuEm+zn1vIfzevGu86JywXu9zPLbZCchNOMu9pF3o1MmUQlJEDoKFMujsayRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvXEJ6n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F711C4CEDD;
	Fri,  4 Apr 2025 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743774066;
	bh=Q4xnhejB5l0SgKBzeLzuppiBD0WWWZ+in4TshRMzkSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvXEJ6n8cQ+7fHMaSLfPQsjm+XICKAtB3/I0UHEZtQHNuwQjg/CxvVMaYu9BBy3Mc
	 yB99qP6kzbZ2ylaPLAr+SRN0BW/4HBFp+aUcSFxY8EY57MFnb0qzEjhmbuWysUBpJ9
	 L++XYjgLMugmCuUlXCBV4dfBWYS5LyC6NEciz0R3kS33JAzId1MW87oHcAfGJt5II2
	 cbxNiuyzfDhK1Yry+onA38EjZNo1ok3GBTqcrW6oprcWyM68c/GUz+N4wJOrtAnKgR
	 5PgVIYYi2wDRukuYCvGuXEulx6hu7vYHEil6q00WvjBna5Zl4mJB9vH3gv5UnZjhqL
	 8itdHW6B7Bzfg==
Date: Fri, 4 Apr 2025 15:41:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: David Howells <dhowells@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
Message-ID: <20250404-fanpost-wirkt-9af345e9ebd6@brauner>
References: <>
 <3170778.1742479489@warthog.procyon.org.uk>
 <174312469657.9342.13122047478058505480@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174312469657.9342.13122047478058505480@noble.neil.brown.name>

On Fri, Mar 28, 2025 at 12:18:16PM +1100, NeilBrown wrote:
> On Fri, 21 Mar 2025, David Howells wrote:
> > NeilBrown <neil@brown.name> wrote:
> > 
> > > Also the path component name is passed as "name" and "len" which are
> > > (confusingly?) separate by the "base".  In some cases the len in simply
> > > "strlen" and so passing a qstr using QSTR() would make the calling
> > > clearer.
> > > Other callers do pass separate name and len which are stored in a
> > > struct.  Sometimes these are already stored in a qstr, other times it
> > > easily could be.
> > > 
> > > So this patch changes these three functions to receive a 'struct qstr',
> > > and improves the documentation.
> > 
> > You did want 'struct qstr' not 'struct qstr *' right?  I think there are
> > arches where this will cause the compiler to skip a register argument or two
> > if it's the second argument or third argument - i386 for example.  Plus you
> > have an 8-byte alignment requirement because of the u64 in it that may suck if
> > passed through several layers of function.
> 
> I don't think it is passed through several layers - except where the
> intermediate are inlined.
> And gcc enforces 16 byte alignment of the stack on function calls for
> i386, so I don't think alignment will be an issue.
> 
> I thought 'struct qstr' would result in slightly cleaner calling.  But I
> cannot make a strong argument in favour of it so I'm willing to change
> if there are concerns.

Fwiw, I massaged the whole series to pass struct qstr * instead of
struct qstr. I just forgot to finish that rebase and push.
/me doing so now.

