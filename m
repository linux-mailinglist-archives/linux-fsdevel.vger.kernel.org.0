Return-Path: <linux-fsdevel+bounces-22368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1608916B3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4FA281D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3B16E888;
	Tue, 25 Jun 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJDWR5Eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4F170825;
	Tue, 25 Jun 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327283; cv=none; b=e/R95Rw71x/UgLQgepjqh/hPEOkfaxLg/XrLhJpC0puLUnrSYGd9K/9lEukC92SfouFyi2e6cnX7w2Umc8sN2Yp7U+QFQwXsp7hQByhAj5pXiRO2FfkzPBWZ3lZWPHP62AmcEb0nJ2U9ciGBBJUoyq9IzReYpcDNuSPNH9qWAbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327283; c=relaxed/simple;
	bh=OnlecF0L+WuiOOe//vNstn8JovvMxwxc6c0feuDVQJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKTIXEZbV+E7TUeRoX/Tcr/FBLzwMJob+2GfIfShuSvOE91W2juIUA7uicOFPMBywyc32tLIUAephVO00T7spF90THHLYUFrktIJsR1c1isfY8lJcodm3DzMAPlYwU4C3YxyIPRVDHzErVZ05Bc3niktjgd+ctY2kqHR64KSsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJDWR5Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CDBC32786;
	Tue, 25 Jun 2024 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327283;
	bh=OnlecF0L+WuiOOe//vNstn8JovvMxwxc6c0feuDVQJs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gJDWR5EhbVC6GZbZadZAFf7L+GhlVlKDhry5FwnN+wa0K8mmi1Qcuvtz6zbKkZK3i
	 bF0f/9w9yGTBMz0ii0BiyL6eM9eDIS6sH+eSeN2Zjx65DPLW9qKCKhz0an3vvLkQNq
	 QTumE9xPp4cAh26FRje2V0IX4r4J6GLzDHYdfs2u5FFR+/AEiTEijIs5nSrFvMgGTs
	 Jer9upuIHAseZVGwnXJ7rEuwCrs2CH33/dGvrlSm9257uirjGJ634gsSAYSQXU+Kwt
	 WQJRSGrctibMhPZ0Xlkh6EWDc5PMNIyWx6p0/cyJF8zw9yycJdQWW7craS0UrNhAOC
	 MhEppcMevufFg==
Message-ID: <2545edf023b2a364672f73d3ae6d90c702310b3f.camel@kernel.org>
Subject: Re: [PATCH v2] netfs: Fix netfs_page_mkwrite() to check
 folio->mapping is valid
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Matthew Wilcox
 <willy@infradead.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 10:54:40 -0400
In-Reply-To: <780211.1719318546@warthog.procyon.org.uk>
References: <614257.1719228181@warthog.procyon.org.uk>
	 <780211.1719318546@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 13:29 +0100, David Howells wrote:
> =C2=A0=C2=A0=C2=A0=20
> Fix netfs_page_mkwrite() to check that folio->mapping is valid once
> it has
> taken the folio lock (as filemap_page_mkwrite() does).=C2=A0 Without this=
,
> generic/247 occasionally oopses with something like the following:
>=20
> =C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, address: 0000000=
000000000
> =C2=A0=C2=A0=C2=A0 #PF: supervisor read access in kernel mode
> =C2=A0=C2=A0=C2=A0 #PF: error_code(0x0000) - not-present page
>=20
> =C2=A0=C2=A0=C2=A0 RIP: 0010:trace_event_raw_event_netfs_folio+0x61/0xc0
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 Call Trace:
> =C2=A0=C2=A0=C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0=C2=A0=C2=A0 ? __die_body+0x1a/0x60
> =C2=A0=C2=A0=C2=A0=C2=A0 ? page_fault_oops+0x6e/0xa0
> =C2=A0=C2=A0=C2=A0=C2=A0 ? exc_page_fault+0xc2/0xe0
> =C2=A0=C2=A0=C2=A0=C2=A0 ? asm_exc_page_fault+0x22/0x30
> =C2=A0=C2=A0=C2=A0=C2=A0 ? trace_event_raw_event_netfs_folio+0x61/0xc0
> =C2=A0=C2=A0=C2=A0=C2=A0 trace_netfs_folio+0x39/0x40
> =C2=A0=C2=A0=C2=A0=C2=A0 netfs_page_mkwrite+0x14c/0x1d0
> =C2=A0=C2=A0=C2=A0=C2=A0 do_page_mkwrite+0x50/0x90
> =C2=A0=C2=A0=C2=A0=C2=A0 do_pte_missing+0x184/0x200
> =C2=A0=C2=A0=C2=A0=C2=A0 __handle_mm_fault+0x42d/0x500
> =C2=A0=C2=A0=C2=A0=C2=A0 handle_mm_fault+0x121/0x1f0
> =C2=A0=C2=A0=C2=A0=C2=A0 do_user_addr_fault+0x23e/0x3c0
> =C2=A0=C2=A0=C2=A0=C2=A0 exc_page_fault+0xc2/0xe0
> =C2=A0=C2=A0=C2=A0=C2=A0 asm_exc_page_fault+0x22/0x30
>=20
> This is due to the invalidate_inode_pages2_range() issued at the end
> of the
> DIO write interfering with the mmap'd writes.
>=20
> Fixes: 102a7e2c598c ("netfs: Allow buffered shared-writeable mmap
> through netfs_page_mkwrite()")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: netfs@lists.linux.dev
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> ---
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #2)
> =C2=A0- Actually unlock the folio rather than returning VM_FAULT_LOCKED
> with
> =C2=A0=C2=A0 VM_FAULT_NOPAGE.
>=20
> =C2=A0fs/netfs/buffered_write.c |=C2=A0=C2=A0=C2=A0 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 07bc1fd43530..270f8ebf8328 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -523,6 +523,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault
> *vmf, struct netfs_group *netfs_gr
> =C2=A0	struct netfs_group *group;
> =C2=A0	struct folio *folio =3D page_folio(vmf->page);
> =C2=A0	struct file *file =3D vmf->vma->vm_file;
> +	struct address_space *mapping =3D file->f_mapping;
> =C2=A0	struct inode *inode =3D file_inode(file);
> =C2=A0	struct netfs_inode *ictx =3D netfs_inode(inode);
> =C2=A0	vm_fault_t ret =3D VM_FAULT_RETRY;
> @@ -534,6 +535,11 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault
> *vmf, struct netfs_group *netfs_gr
> =C2=A0
> =C2=A0	if (folio_lock_killable(folio) < 0)
> =C2=A0		goto out;
> +	if (folio->mapping !=3D mapping) {
> +		folio_unlock(folio);
> +		ret =3D VM_FAULT_NOPAGE;
> +		goto out;
> +	}
> =C2=A0
> =C2=A0	if (folio_wait_writeback_killable(folio)) {
> =C2=A0		ret =3D VM_FAULT_LOCKED;
> @@ -549,7 +555,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault
> *vmf, struct netfs_group *netfs_gr
> =C2=A0	group =3D netfs_folio_group(folio);
> =C2=A0	if (group !=3D netfs_group && group !=3D
> NETFS_FOLIO_COPY_TO_CACHE) {
> =C2=A0		folio_unlock(folio);
> -		err =3D filemap_fdatawait_range(inode->i_mapping,
> +		err =3D filemap_fdatawait_range(mapping,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_pos(folio),
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_pos(folio) +
> folio_size(folio));
> =C2=A0		switch (err) {
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

