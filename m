Return-Path: <linux-fsdevel+bounces-45767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC180A7BE3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A33A1776D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559881F0E38;
	Fri,  4 Apr 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlnd9DsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4142E62C4;
	Fri,  4 Apr 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774395; cv=none; b=kgwTYV3gh2NQHkamRnfZ3G17Uin9/KsUeihBmD0cvXalE0mIRS2MgjucS1Z8S5oVj0S0G50Usib6KvdfNaxalpNZE2pWQZzI/oT3dCBBvWy3JSwMMJZ8socDXduh87ES7usgUT10FpPaSGjMA5HSTJlDt9e+Jenacm154XMf5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774395; c=relaxed/simple;
	bh=pLBXfMZtfu0Wdhea/G2lSDI2TOWAUHpUTKmHZ6giqh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+z6gOuCLY8IveQS6EWLtw2M8neMHv8CHwubhg6dlLmQx2pMlf2JUEJAMKS8YrT2eyZ68AQSTUT+goa/V0EyXlofOf1XvQEpM43bUATVv6iV8+xEnOBvLxyMCpH9pNK8pSxDxFWDbITXhJJdp5h+OGSMkNtUf9jh9LC5zay3RfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlnd9DsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E9BC4CEDD;
	Fri,  4 Apr 2025 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743774395;
	bh=pLBXfMZtfu0Wdhea/G2lSDI2TOWAUHpUTKmHZ6giqh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xlnd9DsGGlLdmpC/48a2DXtoiQCwvqTjyJWjO6nXr6sc3tC7/gjDoR/5PEsSxMZ16
	 VqMKRZ1WqBdvHvv/O9nPEgf4DLEnX6XCixLRYFfpNbGnfBpJySTXMdsxe8xpRJApES
	 Ho0pi+LYwI14D+A9mIlYCk4HXGwxMlr2hBsZ9/GAcRDVyjo+aCPr3vlWfsuFU2ExA5
	 ubOfFXYlQZsJigjglIOvdqnpeE/IIWz38WLM87cXXrrqUW2tcHhx2SKUhA7uZ8INZz
	 mYnVYokBVLykN9GwWJ0ts2dUVaMfK2Q+Z8VMCQ2yEz9cvUvoZw3JIb5UKfPmmrNg8F
	 NYcZjaFY2cPTw==
Date: Fri, 4 Apr 2025 15:46:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: David Howells <dhowells@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
Message-ID: <20250404-waldarbeiten-entern-d0ae4513ee41@brauner>
References: <>
 <3170778.1742479489@warthog.procyon.org.uk>
 <174312469657.9342.13122047478058505480@noble.neil.brown.name>
 <20250404-fanpost-wirkt-9af345e9ebd6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404-fanpost-wirkt-9af345e9ebd6@brauner>

On Fri, Apr 04, 2025 at 03:41:01PM +0200, Christian Brauner wrote:
> On Fri, Mar 28, 2025 at 12:18:16PM +1100, NeilBrown wrote:
> > On Fri, 21 Mar 2025, David Howells wrote:
> > > NeilBrown <neil@brown.name> wrote:
> > > 
> > > > Also the path component name is passed as "name" and "len" which are
> > > > (confusingly?) separate by the "base".  In some cases the len in simply
> > > > "strlen" and so passing a qstr using QSTR() would make the calling
> > > > clearer.
> > > > Other callers do pass separate name and len which are stored in a
> > > > struct.  Sometimes these are already stored in a qstr, other times it
> > > > easily could be.
> > > > 
> > > > So this patch changes these three functions to receive a 'struct qstr',
> > > > and improves the documentation.
> > > 
> > > You did want 'struct qstr' not 'struct qstr *' right?  I think there are
> > > arches where this will cause the compiler to skip a register argument or two
> > > if it's the second argument or third argument - i386 for example.  Plus you
> > > have an 8-byte alignment requirement because of the u64 in it that may suck if
> > > passed through several layers of function.
> > 
> > I don't think it is passed through several layers - except where the
> > intermediate are inlined.
> > And gcc enforces 16 byte alignment of the stack on function calls for
> > i386, so I don't think alignment will be an issue.
> > 
> > I thought 'struct qstr' would result in slightly cleaner calling.  But I
> > cannot make a strong argument in favour of it so I'm willing to change
> > if there are concerns.
> 
> Fwiw, I massaged the whole series to pass struct qstr * instead of
> struct qstr. I just forgot to finish that rebase and push.
> /me doing so now.

Fwiw, there were a bunch of build failures for me when I built the
individual commits that I fixed up. I generally do:

git rebase -i HEAD~XXXXX -x "make -j512"

with an allmodconfig to make sure that it cleanly builds at each commit.

