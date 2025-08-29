Return-Path: <linux-fsdevel+bounces-59601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64114B3B077
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 03:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E291BA5B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52711F3BB5;
	Fri, 29 Aug 2025 01:25:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4921D61BB;
	Fri, 29 Aug 2025 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430740; cv=none; b=LSiMShp4IxF/iCSBNOAgdso6hU8iYAsD+joNxqqRnp75hsYGiTVnybv3dLfhh6IQ+51vd9Or24+VWuFgRM55OzRrMUtN1JUbbeEWXKf2+wfDmt0uWqoDCT/JL/U2k3nLoDcf3qHqSyoySPvunWy+3+zVzn7cixDMjTZmsSTUprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430740; c=relaxed/simple;
	bh=HTik/mRy0YAuUpRxyKqqPX/Z8owfs1XAdZfL0aBgMEA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QvYHvbRfSCyN41vrxmpr0psZtbPfd3cLftPeTg+OnXEJkzGwUOTF+U/uRhhAC1YAMgdNvtxnkWL13A/SlYNzgErhTiyAKLBbm/U82Qn5bYobWnbEekjZtNVqTuipkZkjgWdf3n8RAyxTE9RDBsspigzcKyIECl+5my+5rhOWlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1urnrp-007Xii-4T;
	Fri, 29 Aug 2025 01:25:26 +0000
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
 <CAOQ4uxhJfFgpUKHy0c23i0dsvxZoRuGxMVXbasEn3zf3s0ORYg@mail.gmail.com>
References:
 <>, <CAOQ4uxhJfFgpUKHy0c23i0dsvxZoRuGxMVXbasEn3zf3s0ORYg@mail.gmail.com>
Date: Fri, 29 Aug 2025 11:25:26 +1000
Message-id: <175643072654.2234665.6159276626818244997@noble.neil.brown.name>

On Thu, 28 Aug 2025, Amir Goldstein wrote:
>=20
> Neil,
>=20
> FYI, if your future work for vfs assumes that fs will alway have the
> dentry hashed after create, you may want to look at:
>=20
> static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
> ...
>         /* Force lookup of new upper hardlink to find its lower */
>         if (hardlink)
>                 d_drop(dentry);
>=20
>         return 0;
> }
>=20
> If your assumption is not true for overlayfs, it may not be true for other =
fs
> as well. How could you verify that it is correct?

I don't need the dentry to be hashed after the create has completed (or
failed).
I only need it to be hashed when the create starts, and ideally for the
duration of the creation process.
Several filesystems d_drop() a newly created dentry so as to trigger a
lookup - overlayfs is not unique.

>=20
> I really hope that you have some opt-in strategy in mind, so those new
> dirops assumptions would not have to include all possible filesystems.

Filesystems will need to opt-in to not having the parent locked.  If
a fs still has the parent locked across operations it doesn't really
matter when the d_drop() happens.  However I want to move all the
d_drop()s to the end (which is where ovl has it) to ensure there are no
structural issues that mean an early d_drop() is needed.  e.g. Some
filesystems d_drop() and then d_splice_alias() and I want to add a new
d_splice_alias() variant that doesn't require the d_drop().

So it is only at the start of an operation (create, remove, rename) that
I need the dentry to be hashed.  That raises questions about ext4_lookup
not hashing a negative dentry as a lookup-create pair in do_mknodat or
lookup_open could call vfs_create with a non-hashed dentry.
That isn't *actually* a problem (I think - I should double-check) as the
dentry is still d_in_lookup() so it is hashed in the separate
in_lookup_hashtable().  So a d_lookup() will find it even though it
isn't hashed.

That suggests an alternate fix for ovl_parent_lock().  Rather than
insisting that the child is hashed, we can insist that either
    d_in_lookup(child) || !d_unhashed(child)

Such a dentry really is hashed: it might be hashed in one table, it
might be hashed in the other.

However that wouldn't protect against filesystems which deliberately
d_drop() during create, so I think ovl still needs to perform a lookup
after a create and before a rename - if the create succeeds but the
dentry is negative.

Thanks,
NeilBrown

