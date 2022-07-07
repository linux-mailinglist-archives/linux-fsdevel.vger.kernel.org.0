Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A0A56A9FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiGGRsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiGGRsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:48:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0EF2A73D;
        Thu,  7 Jul 2022 10:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEF73B82037;
        Thu,  7 Jul 2022 17:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E424C3411E;
        Thu,  7 Jul 2022 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657216130;
        bh=WWqMeXR37ziGMXxHOCbZPbT0EVejUM9d+ON0cjIfEr4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dpaIzrk3rI+A5gb9/sMEHE7yDpHz/GNHKoe6TNqSDFGJ/bVH+hvrXFxExSkf35tpQ
         M6+d2dRLjfD4Hhe2gvZEAYnPC6YnDt7xU1l2+OihKBzjQLSEPDYZUzalpxFQUsXCM5
         w8ygFVIKRLoEWB9l/NxfIHpjM53riUNZVaHsCw9GflSSks9Mo8b+/ZHoCj0GqKg2i8
         W3wTe4M6B7UgRR9aauHMyK6Bx7gdipyBdoZ4vSZZQwjFftDKaB1id+QB+Q3fPJphff
         nj3xQp5tZgp78wczCdBvq1esI2Y0abOpZmBgdvEa9EAcQ2jv04ATSPGNecrQi/oQeX
         GecRtPoMD8zrA==
Message-ID: <763ba47fb850282b62c36eca6084c446a0952336.camel@kernel.org>
Subject: Re: [RFC] Convert ceph_page_mkwrite to use a folio
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 07 Jul 2022 13:48:48 -0400
In-Reply-To: <YsbzAoGAAZtlxsrd@casper.infradead.org>
References: <YsbzAoGAAZtlxsrd@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-07-07 at 15:51 +0100, Matthew Wilcox wrote:
> There are some latent bugs that I fix here (eg, you can't call
> thp_size() on a tail page), but the real question is how Ceph in
> particular (and FS in general) want to handle mkwrite in a world
> of multi-page folios.
>=20
> If we have a multi-page folio which is occupying an entire PMD, then
> no question, we have to mark all 2MB (or whatever) as dirty.  But
> if it's being mapped with PTEs, either because it's mapped misaligned,
> or it's smaller than a PMD, then we have a choice.  We can either
> work in 4kB chunks, marking each one dirty (and storing the sub-folio
> dirty state in the fs private data) like a write might.  Or we can
> just say "Hey, the whole folio is dirty now" and not try to track
> dirtiness on a per-page granularity.
>=20
> The latter course seems to have been taken, modulo the bugs, but I
> don't know if any thought was taken or whether it was done by rote.
>=20

Done by rote, I'm pretty sure.

If each individual page retains its own dirty bit, what does
folio_test_dirty return when its pages are only partially dirty? I guess
the folio is still dirty even if some of its pages are clean?

Ceph can do a vectored write if a folio has disjoint dirty regions that
we need to flush. Hashing out an API to handle that with the netfs layer
is going to be "interesting" though.

> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6dee88815491..fb346b929f65 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1503,8 +1503,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault=
 *vmf)
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
>  	struct ceph_file_info *fi =3D vma->vm_file->private_data;
>  	struct ceph_cap_flush *prealloc_cf;
> -	struct page *page =3D vmf->page;
> -	loff_t off =3D page_offset(page);
> +	struct folio *folio =3D page_folio(vmf->page);
> +	loff_t pos =3D folio_pos(folio);
>  	loff_t size =3D i_size_read(inode);
>  	size_t len;
>  	int want, got, err;
> @@ -1521,50 +1521,50 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fau=
lt *vmf)
>  	sb_start_pagefault(inode->i_sb);
>  	ceph_block_sigs(&oldset);
> =20
> -	if (off + thp_size(page) <=3D size)
> -		len =3D thp_size(page);
> +	if (pos + folio_size(folio) <=3D size)
> +		len =3D folio_size(folio);
>  	else
> -		len =3D offset_in_thp(page, size);
> +		len =3D offset_in_folio(folio, size);
> =20
>  	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
> -	     inode, ceph_vinop(inode), off, len, size);
> +	     inode, ceph_vinop(inode), pos, len, size);
>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>  		want =3D CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
>  	else
>  		want =3D CEPH_CAP_FILE_BUFFER;
> =20
>  	got =3D 0;
> -	err =3D ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, off + len, =
&got);
> +	err =3D ceph_get_caps(vma->vm_file, CEPH_CAP_FILE_WR, want, pos + len, =
&got);
>  	if (err < 0)
>  		goto out_free;
> =20
>  	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
> -	     inode, off, len, ceph_cap_string(got));
> +	     inode, pos, len, ceph_cap_string(got));
> =20
> -	/* Update time before taking page lock */
> +	/* Update time before taking folio lock */
>  	file_update_time(vma->vm_file);
>  	inode_inc_iversion_raw(inode);
> =20
>  	do {
>  		struct ceph_snap_context *snapc;
> =20
> -		lock_page(page);
> +		folio_lock(folio);
> =20
> -		if (page_mkwrite_check_truncate(page, inode) < 0) {
> -			unlock_page(page);
> +		if (folio_mkwrite_check_truncate(folio, inode) < 0) {
> +			folio_unlock(folio);
>  			ret =3D VM_FAULT_NOPAGE;
>  			break;
>  		}
> =20
> -		snapc =3D ceph_find_incompatible(page);
> +		snapc =3D ceph_find_incompatible(&folio->page);
>  		if (!snapc) {
> -			/* success.  we'll keep the page locked. */
> -			set_page_dirty(page);
> +			/* success.  we'll keep the folio locked. */
> +			folio_mark_dirty(folio);
>  			ret =3D VM_FAULT_LOCKED;
>  			break;
>  		}
> =20
> -		unlock_page(page);
> +		folio_unlock(folio);
> =20
>  		if (IS_ERR(snapc)) {
>  			ret =3D VM_FAULT_SIGBUS;
> @@ -1588,7 +1588,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault=
 *vmf)
>  	}
> =20
>  	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
> -	     inode, off, len, ceph_cap_string(got), ret);
> +	     inode, pos, len, ceph_cap_string(got), ret);
>  	ceph_put_cap_refs_async(ci, got);
>  out_free:
>  	ceph_restore_sigs(&oldset);

--=20
Jeff Layton <jlayton@kernel.org>
