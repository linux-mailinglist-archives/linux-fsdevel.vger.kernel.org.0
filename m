Return-Path: <linux-fsdevel+bounces-55166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0EB0772D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F553A2FBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9875A1DED63;
	Wed, 16 Jul 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iycR6MFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950B1C6FE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673295; cv=none; b=MQGXiwj9iZfyiwN1wMyNuVjV+dkpu54HDLlqz0PGjLj2VLP5l0PINLtmnUtTNj8aJ5cMyrZgwBU5mf0RLr754s5azcbgccy0CPWMPgIdqF6feQJe3iGuHL3u+3BEcUAezg30Ae9aEGlpMxtnpr4PMyfIW+JJSM87nOVhKjiI4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673295; c=relaxed/simple;
	bh=w34y13oVPcGiPMPKFHafFSnLwEx1/TFb+HWQ6zxD7O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otAWrC5KCmIDZfDv889jt2tFNCCS6FNPeAB6yiPaIgbolZS8WuqNlDUX620HDX4fz9FQa2C781KNl5DfcKbYCdmbsVXEVmYh2jyU/lx2vXkNAk7wfHK/iP6rqYZxxHC6krNmCqDyRsrKpR+blSz6foGKnCGl8q5swNOOaPUe5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iycR6MFB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=O2GwvrHsokxpmz8mgDLDPJAm4Kj1zwDCvRP5GxtkhXM=; b=iycR6MFBVJh6aEhupW1+OAwTg+
	+jKi6NetzMbPQA+kIb5Of7fkjaTV5eJm46NLw/7xpwFELVJnfGsJifcUYQ0pt+1C0Fb8HscTtTSfu
	KbmCxcExOVVCRo+eNyjri04zC2VnqXTM2OX2MEJ+MplYLfozK4hgb1CQ2P75PB4CQUwgNt+81qwYf
	/3y/dsScXQqbwcSq3aBLdu5zGsUxJvJdTF5sXcsugflDhWL1Q45l010kzWfhifdEwu+wTKY0tYqLs
	2W201odoCxp5OdMLGr0Maz0s3It+saAq2mMg8EhnCRLZyK1D6Qdw4eMWGth+DglGse41ORleJ7oCE
	qkMfjxuw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2O3-0000000GizQ-0obq;
	Wed, 16 Jul 2025 13:41:31 +0000
Date: Wed, 16 Jul 2025 14:41:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alex <alex.fcyrx@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
Message-ID: <aHesCjzSInq8w757@casper.infradead.org>
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
 <20250716131250.GC2580412@ZenIV>
 <CAKawSAmp668+zUcaThnnhMtU8hmyTOKifHqxfE02WKYYpWxVHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKawSAmp668+zUcaThnnhMtU8hmyTOKifHqxfE02WKYYpWxVHg@mail.gmail.com>

On Wed, Jul 16, 2025 at 09:28:29PM +0800, Alex wrote:
> On Wed, Jul 16, 2025 at 9:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Jul 16, 2025 at 08:53:04PM +0800, Alex wrote:
> > > The logic is used to protect load/store tearing on 32 bit platforms,
> > > for example, after i_size_read returned, there is no guarantee that
> > > inode->size won't be changed. Therefore, READ/WRITE_ONCE suffice, which
> > > is already implied by smp_load_acquire/smp_store_release.
> >
> > Sorry, what?  The problem is not a _later_ change, it's getting the
> > upper and lower 32bit halves from different values.
> >
> > Before: position is 0xffffffff
> > After: position is 0x100000000
> > The value that might be returned by your variant: 0x1ffffffff.
> 
> I mean the sequence lock here is used to only avoid load/store tearing,
> smp_load_acquire/smp_store_release already protects that.

Why do you think that?  You're wrong, but it'd be useful to understand
what misled you into thinking that.

