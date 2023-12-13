Return-Path: <linux-fsdevel+bounces-5774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F781065B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CC01C20E18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC17F9;
	Wed, 13 Dec 2023 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GRx2bjRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC9212D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 16:14:41 -0800 (PST)
Date: Tue, 12 Dec 2023 19:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702426479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoQdXnPlw7+K8gDMKe/XiSIAl15r1VRcBtvYXz8Qz5U=;
	b=GRx2bjRQeAG4Jtq7yGbtg0HNKw/Et/qZ+gTKtqh10eKgV3HWXBRHP9YfZrPM6kTZEf4Bq4
	S8dHPDlmrR/BLmosojSmkiv0uMjfUMDS9RNWYRNp5JH9RxgEfstw9BbAS7YTvfJ6GhDwQy
	JJli2x1TZ0+Z/bW0SmJRqFU59RcHrfI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: David Howells <dhowells@redhat.com>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231213001437.xfqr6hgko35y4uvg@moria.home.lan>
References: <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <2799307.1702338016@warthog.procyon.org.uk>
 <20231212205929.op6tq3pqobwmix5a@moria.home.lan>
 <170242184299.12910.16703366490924138473@noble.neil.brown.name>
 <20231212234348.ojllavmflwipxo2j@moria.home.lan>
 <170242574922.12910.6678164161619832398@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170242574922.12910.6678164161619832398@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 13, 2023 at 11:02:29AM +1100, NeilBrown wrote:
> On Wed, 13 Dec 2023, Kent Overstreet wrote:
> > On Wed, Dec 13, 2023 at 09:57:22AM +1100, NeilBrown wrote:
> > > On Wed, 13 Dec 2023, Kent Overstreet wrote:
> > > > On Mon, Dec 11, 2023 at 11:40:16PM +0000, David Howells wrote:
> > > > > Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > 
> > > > > > I was chatting a bit with David Howells on IRC about this, and floated
> > > > > > adding the file handle to statx. It looks like there's enough space
> > > > > > reserved to make this feasible - probably going with a fixed maximum
> > > > > > size of 128-256 bits.
> > > > > 
> > > > > We can always save the last bit to indicate extension space/extension record,
> > > > > so we're not that strapped for space.
> > > > 
> > > > So we'll need that if we want to round trip NFSv4 filehandles, they
> > > > won't fit in existing struct statx (nfsv4 specs 128 bytes, statx has 96
> > > > bytes reserved).
> > > > 
> > > > Obvious question (Neal): do/will real world implementations ever come
> > > > close to making use of this, or was this a "future proofing gone wild"
> > > > thing?
> > > 
> > > I have no useful data.  I have seen lots of filehandles but I don't pay
> > > much attention to their length.  Certainly some are longer than 32 bytes.
> > > 
> > > > 
> > > > Say we do decide we want to spec it that large: _can_ we extend struct
> > > > statx? I'm wondering if the userspace side was thought through, I'm
> > > > sure glibc people will have something to say.
> > > 
> > > The man page says:
> > > 
> > >      Therefore, do not simply set mask to UINT_MAX (all bits set), as
> > >      one or more bits may, in the future, be used to specify an
> > >      extension to the buffer.
> > > 
> > > I suspect the glibc people read that.
> > 
> > The trouble is that C has no notion of which types are safe to pass
> > across a dynamic library boundary, so if we increase the size of struct
> > statx and someone's doing that things will break in nasty ways.
> > 
> 
> Maybe we don't increase the size of struct statx.
> Maybe we declare
> 
>    struct statx2 {
>      struct statx base;
>      __u8 stx_handle[128];
>    }
> 
> and pass then when we request STX_HANDLE.

yeah, I think that's what would be required.

David was originally proposing having userspace just pass in a size_t
for the buffer size, and I really think that would've been better - if
this thing can ever change size, we need to make that explicit in the
API.

