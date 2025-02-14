Return-Path: <linux-fsdevel+bounces-41698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84BA3554B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 04:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98A61890E2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717431519BF;
	Fri, 14 Feb 2025 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Hgm5Sv9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB115198F;
	Fri, 14 Feb 2025 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503705; cv=none; b=eyixSSTW3LVbDxG4/M2W8T3TKCT5+4rwTgiOcTVOnJ6fm67PPD1A0yGiO0uBkq0zsD7Wrdg5LMdAkTDKuF58RqgH5nUK1fVYowbi6dZ9xuhAj0xJJnTkUV2e2mCv6pkl5qDIzauI7joTI9HW7lCAOYUEzNYq4NlwYn/cT8cRaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503705; c=relaxed/simple;
	bh=EbdT5fo0UmzJd8IaYPgmBJ6D/bWCmMkwfFS8jPGWrls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhAhuA994vgfjsiRfuhpmCx/SkNYORnc5NXoyPGcIU3gP0KI2wQ4XXEnjYolEHTsiT7w7xOYVQUt+qs9jPVKPEC7cJWKuJagBRfbpHyP9utkz/9ov2i51txy9WlM5JNFL4VH3M+HUQg7rZbqruF2zdrbFdhaLTKg46ylxv7eDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Hgm5Sv9X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kIz13BQu3zkuqApgtTTlMdbPa1rb7EihsKaluvsEDwM=; b=Hgm5Sv9XnFOUU+BKWqtuQuN+fu
	hK+t9FhrjWFdp5PHE7Hopk9A0g679LpX+glka707UoK7krs/Cr/PN8yKUt12/j9JdlnedkPKmmOGa
	b10E6Hxcz1m4IOPslgypu0m+asOiXQ/veWOgAhG5WC6qm9iX9Mqmdr4KZP9GzPPgzJCgBqFNDkdlS
	Ws79CVN2UboEYM0BpV+LMka5sLIx2QkJOz3u9tU1OxizRkZ0o+X/9KV5gJnf9U0g/KqG35ANiKY0E
	beTuxsKrZGnKOpeO6/sT71CBk9PNeBjWpqZsrob83ZWX6uW9HHvaz3l0cMKyJtgycXV95JPo0yEQj
	MxbEsc0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1timNI-0000000DJOb-2TKw;
	Fri, 14 Feb 2025 03:28:20 +0000
Date: Fri, 14 Feb 2025 03:28:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
Message-ID: <20250214032820.GZ1977892@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214024756.GY1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 14, 2025 at 02:47:56AM +0000, Al Viro wrote:

[snip]

> Am I missing something subtle here?  Can elen be non-positive at that point?

Another fun question: for dentries with name of form _<something>_<inumber>
we end up looking at fscrypt_has_encryption_key() not for the parent,
but for inode with inumber encoded in dentry name.  Fair enough, but...
what happens if we run into such dentry in ceph_mdsc_build_path()?

There the call of ceph_encode_encrypted_fname() is under
	if (fscrypt_has_encryption_key(d_inode(parent)))

Do we need the keys for both?

