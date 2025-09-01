Return-Path: <linux-fsdevel+bounces-59922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF56B3F0CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23B0484807
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D3A274B42;
	Mon,  1 Sep 2025 22:03:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965032F747;
	Mon,  1 Sep 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764197; cv=none; b=Y5ikkKmYiVV3+DfSobblZG+lBpnRzGftMku5KUQ2opEASvg0QREf3P41vUVoZJ3ekqLNLEdSYBB+fp/ulbhK9HtpTxjYVFrsyCFiKAKbAw65Pndc/O9ELMWRuLgRtuZuGD7ovEQZE1i0E+qcEZj5H0bwmYBh/CTN44wpwklkSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764197; c=relaxed/simple;
	bh=TK4KyyE7pela5bKG+T+lxTwRhjMbjYUvsPcX0II0ZLo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MXv5a6ZwMwLVdPuyurVWuw7MXjJ089gtf9qjStXlfpKIQpiX/WBeY9C/gUQ1br2mZin9FEQYynpvyBx1G+7GkytkOHl6BQ5sXQ5ibw+4csvDNBxP/9+9JRtlHfwGc8KArOkCNvwvouKU4y4piVQ5kYpFc6K3CLXCTAxd/1Qg5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1utCc5-007yfn-6J;
	Mon, 01 Sep 2025 22:02:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Gabriel Krisman Bertazi" <gabriel@krisman.be>,
 =?utf-8?q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Theodore Tso" <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 kernel-dev@igalia.com
Subject:
 Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
In-reply-to:
 <CAOQ4uxj8mncxy_LOYejGWtokh=C2WpDcGFqj+-k+imVtEk-84A@mail.gmail.com>
References:
 <>, <CAOQ4uxj8mncxy_LOYejGWtokh=C2WpDcGFqj+-k+imVtEk-84A@mail.gmail.com>
Date: Tue, 02 Sep 2025 08:02:58 +1000
Message-id: <175676417816.2234665.1558702055638831789@noble.neil.brown.name>

On Fri, 29 Aug 2025, Amir Goldstein wrote:
> On Fri, Aug 29, 2025 at 3:25=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > On Thu, 28 Aug 2025, Amir Goldstein wrote:
> > >
> > > Neil,
> > >
> > > FYI, if your future work for vfs assumes that fs will alway have the
> > > dentry hashed after create, you may want to look at:
> > >
> > > static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
> > > ...
> > >         /* Force lookup of new upper hardlink to find its lower */
> > >         if (hardlink)
> > >                 d_drop(dentry);
> > >
> > >         return 0;
> > > }
> > >
> > > If your assumption is not true for overlayfs, it may not be true for ot=
her fs
> > > as well. How could you verify that it is correct?
> >
> > I don't need the dentry to be hashed after the create has completed (or
> > failed).
> > I only need it to be hashed when the create starts, and ideally for the
> > duration of the creation process.
> > Several filesystems d_drop() a newly created dentry so as to trigger a
> > lookup - overlayfs is not unique.
> >
> > >
> > > I really hope that you have some opt-in strategy in mind, so those new
> > > dirops assumptions would not have to include all possible filesystems.
> >
> > Filesystems will need to opt-in to not having the parent locked.  If
> > a fs still has the parent locked across operations it doesn't really
> > matter when the d_drop() happens.  However I want to move all the
> > d_drop()s to the end (which is where ovl has it) to ensure there are no
> > structural issues that mean an early d_drop() is needed.  e.g. Some
> > filesystems d_drop() and then d_splice_alias() and I want to add a new
> > d_splice_alias() variant that doesn't require the d_drop().
> >
>=20
> Do you mean revert c971e6a006175 kill d_instantiate_no_diralias()?

Something like that, yes.  Details will probably end up being a bit
different.

>=20
> In any case, I hope that in the end the semantics of state of dentry after
> lookup/create will be more clear than they are now...

That would be nice.  Not just clear, but documented would be the aim.

NeilBrown

