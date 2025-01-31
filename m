Return-Path: <linux-fsdevel+bounces-40462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A3BA23879
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 02:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB2C188906F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D741EB44;
	Fri, 31 Jan 2025 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTG1alsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B130182BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738285616; cv=none; b=iqhg4C1vjMZXkWBbnrbV3zBM74QSzyDOejm2S5jX7pHf1tdGxFcL8UcoTBS+HJXpfnuZFu+4Qlp+Ri3yA6s4gTwtH6N/St/GtLc7OGc/+zO25Me4hE0+qrZid0pu8cD7clAhg0772HKvFAUNdsY0Dzm71vvtOVNxtzzRCrejjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738285616; c=relaxed/simple;
	bh=llWgEmUm0MfKWLzatNT3tW9v2W7HOdvboys9fFGzUqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqfZ3jiQEHGbxMMYxE1BmrutPFugxdUcLqN/jrEjA9xRo58j8FEyiv9Rap+tdbuaDqsEYaqk8s9GdUVfrhhut9ldZIHpVUj7jPatNyEW9JnQV4ge8MP6sNFpPdI44BwDw5KI0uPNXqQ64TS9oRUioBJiy5ASaq1Pi0XegXF5ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTG1alsl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Jan 2025 20:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738285601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIIpTB72Yll8nCHH7rurXHugZD6Z4U2oOU17E7ajD2g=;
	b=RTG1alsl5aQ1FjLxWnlJl0A3Lyt7+hXs6ym/ZE/sHn15oXdtMcqkbKFvAn/CVoOH/DXuep
	2vn7Wgq93+o6Y8X1MThejTholXrpjG6pbmDGkadFS2zJmr06xm+Dl1m27XN14wfXn9ppsl
	OMYVRdS+dFcv7Pu39lfzAy24+MPJD/4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, miklos@szeredi.hu, 
	linux-bcachefs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
Message-ID: <ncewetc7vpijallpvplti4ham7m3dmver6jkymabdedid4iedb@muodfjq2io3m>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
 <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
 <Z5vw3SBNkD-CTuVE@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5vw3SBNkD-CTuVE@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 31, 2025 at 08:36:29AM +1100, Dave Chinner wrote:
> On Thu, Jan 30, 2025 at 08:04:49AM -0800, Dave Hansen wrote:
> > On 1/29/25 23:44, Kent Overstreet wrote:
> > > On Wed, Jan 29, 2025 at 10:17:49AM -0800, Dave Hansen wrote:
> > >> tl;dr: The VFS and several filesystems have some suspect prefaulting
> > >> code. It is unnecessarily slow for the common case where a write's
> > >> source buffer is resident and does not need to be faulted in.
> > >>
> > >> Move these "prefaulting" operations to slow paths where they ensure
> > >> forward progress but they do not slow down the fast paths. This
> > >> optimizes the fast path to touch userspace once instead of twice.
> > >>
> > >> Also update somewhat dubious comments about the need for prefaulting.
> > >>
> > >> This has been very lightly tested. I have not tested any of the fs/
> > >> code explicitly.
> > > 
> > > Q: what is preventing us from posting code to the list that's been
> > > properly tested?
> > > 
> > > I just got another bcachefs patch series that blew up immediately when I
> > > threw it at my CI.
> > > 
> > > This is getting _utterly ridiculous_.
> 
> That's a bit of an over-reaction, Kent.
> 
> IMO, the developers and/or maintainers of each filesystem have some
> responsibility to test changes like this themselves as part of their
> review process.
> 
> That's what you have just done, Kent. Good work!
> 
> However, it is not OK to rant about how the proposed change failed
> because it was not exhaustively tested on every filesytem before it
> was posted.

This is just tone policing.

> I agree with Dave - it is difficult for someone to test widepsread
> changes in code outside their specific expertise. In many cases, the
> test infrastructure just doesn't exist or, if it does, requires
> specialised knowledge and tools to run.

No, it exists - I built it.

> In such cases, we have to acknowledge that best effort testing is
> about as good as we can do without overly burdening the author of
> such a change. In these cases, it is best left to the maintainer of
> that subsystem to exhaustively test the change to their
> subsystem....

I keep having the same conversations in code review:
"Did you test this?"
"No really, did you test this?"
"See that error path you modified, that our automated tests definitely
don't cover? You need to test that manually".

Developers don't think enough about testing - and if the excuse is that
the tools suck, then we need to address that. I'm not going to babysit
and do a bunch of manual work - I spend quite enough of my day staring
at test dashboards already, thank you very much.

> > For bcachefs specifically, how should we move forward? If you're happy
> > with the concept, would you prefer that I do some manual bcachefs
> > testing? Or leave a branch sitting there for a week and pray the robots
> > test it?
> 
> The public automated test robots are horribly unreliable with their
> coverage of proposed changes. Hence my comment above about the
> subsystem maintainers bearing some responsibility to test the code
> as part of their review process....

AFAIK the public test robots don't run xfstests at all.

