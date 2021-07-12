Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F813C5763
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 12:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354258AbhGLIcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 04:32:23 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55290 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345454AbhGLIbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:31:40 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A71A2B2D645;
        Mon, 12 Jul 2021 10:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626078528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fyjZBcXA93B1OVVzUicTd579FE8mJ+9/BOnPDTG7Ju8=;
        b=XTgQ9cjj0D3fjAgZ+s1ni5ku7a8l097Xj2NuQXusSGx3+xQvD2r0GwZqmzM6KvoKBygQ8x
        lZEI+TgcEvVFcCBqmOp7PvKt3KFMSxQJUMXDa1/kLhlOGMOANDe6IE9wz/Ayp7os54V3D3
        S4UgyB/om+OTnh04K3fe9XxLvBFOqFg=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-fsdevel@vger.kernel.org,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [PATCH v26 04/10] fs/ntfs3: Add file operations and implementation
Date:   Mon, 12 Jul 2021 10:28:44 +0200
Message-ID: <1963819.OlitOqP6fi@spock>
In-Reply-To: <20210402155347.64594-5-almaz.alexandrovich@paragon-software.com>
References: <20210402155347.64594-1-almaz.alexandrovich@paragon-software.com> <20210402155347.64594-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On p=E1tek 2. dubna 2021 17:53:41 CEST Konstantin Komarov wrote:
> ...
> +/*helper for ntfs_file_write_iter (compressed files)*/
> +static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter
> *from) +{
> +	int err;
> +	struct file *file =3D iocb->ki_filp;
> +	size_t count =3D iov_iter_count(from);
> +	loff_t pos =3D iocb->ki_pos;
> +	struct inode *inode =3D file_inode(file);
> +	loff_t i_size =3D inode->i_size;
> +	struct address_space *mapping =3D inode->i_mapping;
> +	struct ntfs_inode *ni =3D ntfs_i(inode);
> +	u64 valid =3D ni->i_valid;
> +	struct ntfs_sb_info *sbi =3D ni->mi.sbi;
> +	struct page *page, **pages =3D NULL;
> +	size_t written =3D 0;
> +	u8 frame_bits =3D NTFS_LZNT_CUNIT + sbi->cluster_bits;
> +	u32 frame_size =3D 1u << frame_bits;
> +	u32 pages_per_frame =3D frame_size >> PAGE_SHIFT;
> +	u32 ip, off;
> +	CLST frame;
> +	u64 frame_vbo;
> +	pgoff_t index;
> +	bool frame_uptodate;
> +
> +	if (frame_size < PAGE_SIZE) {
> +		/*
> +		 * frame_size =3D=3D 8K if cluster 512
> +		 * frame_size =3D=3D 64K if cluster 4096
> +		 */
> +		ntfs_inode_warn(inode, "page size is bigger than frame size");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	pages =3D ntfs_malloc(pages_per_frame * sizeof(struct page *));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	current->backing_dev_info =3D inode_to_bdi(inode);
> +	err =3D file_remove_privs(file);
> +	if (err)
> +		goto out;
> +
> +	err =3D file_update_time(file);
> +	if (err)
> +		goto out;
> +
> +	/* zero range [valid : pos) */
> +	while (valid < pos) {
> +		CLST lcn, clen;
> +
> +		frame =3D valid >> frame_bits;
> +		frame_vbo =3D valid & ~(frame_size - 1);
> +		off =3D valid & (frame_size - 1);
> +
> +		err =3D attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 0,=20
&lcn,
> +					  &clen, NULL);
> +		if (err)
> +			goto out;
> +
> +		if (lcn =3D=3D SPARSE_LCN) {
> +			ni->i_valid =3D valid =3D
> +				frame_vbo + ((u64)clen << sbi->cluster_bits);
> +			continue;
> +		}
> +
> +		/* Load full frame */
> +		err =3D ntfs_get_frame_pages(mapping, frame_vbo >> PAGE_SHIFT,
> +					   pages, pages_per_frame,
> +					   &frame_uptodate);
> +		if (err)
> +			goto out;
> +
> +		if (!frame_uptodate && off) {
> +			err =3D ni_read_frame(ni, frame_vbo, pages,
> +					    pages_per_frame);
> +			if (err) {
> +				for (ip =3D 0; ip < pages_per_frame; ip++) {
> +					page =3D pages[ip];
> +					unlock_page(page);
> +					put_page(page);
> +				}
> +				goto out;
> +			}
> +		}
> +
> +		ip =3D off >> PAGE_SHIFT;
> +		off =3D offset_in_page(valid);
> +		for (; ip < pages_per_frame; ip++, off =3D 0) {
> +			page =3D pages[ip];
> +			zero_user_segment(page, off, PAGE_SIZE);
> +			flush_dcache_page(page);
> +			SetPageUptodate(page);
> +		}
> +
> +		ni_lock(ni);
> +		err =3D ni_write_frame(ni, pages, pages_per_frame);
> +		ni_unlock(ni);
> +
> +		for (ip =3D 0; ip < pages_per_frame; ip++) {
> +			page =3D pages[ip];
> +			SetPageUptodate(page);
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +
> +		if (err)
> +			goto out;
> +
> +		ni->i_valid =3D valid =3D frame_vbo + frame_size;
> +	}
> +
> +	/* copy user data [pos : pos + count) */
> +	while (count) {
> +		size_t copied, bytes;
> +
> +		off =3D pos & (frame_size - 1);
> +		bytes =3D frame_size - off;
> +		if (bytes > count)
> +			bytes =3D count;
> +
> +		frame =3D pos >> frame_bits;
> +		frame_vbo =3D pos & ~(frame_size - 1);
> +		index =3D frame_vbo >> PAGE_SHIFT;
> +
> +		if (unlikely(iov_iter_fault_in_readable(from, bytes))) {
> +			err =3D -EFAULT;
> +			goto out;
> +		}
> +
> +		/* Load full frame */
> +		err =3D ntfs_get_frame_pages(mapping, index, pages,
> +					   pages_per_frame, &frame_uptodate);
> +		if (err)
> +			goto out;
> +
> +		if (!frame_uptodate) {
> +			loff_t to =3D pos + bytes;
> +
> +			if (off || (to < i_size && (to & (frame_size - 1)))) {
> +				err =3D ni_read_frame(ni, frame_vbo, pages,
> +						    pages_per_frame);
> +				if (err) {
> +					for (ip =3D 0; ip < pages_per_frame;
> +					     ip++) {
> +						page =3D pages[ip];
> +						unlock_page(page);
> +						put_page(page);
> +					}
> +					goto out;
> +				}
> +			}
> +		}
> +
> +		WARN_ON(!bytes);
> +		copied =3D 0;
> +		ip =3D off >> PAGE_SHIFT;
> +		off =3D offset_in_page(pos);
> +
> +		/* copy user data to pages */
> +		for (;;) {
> +			size_t cp, tail =3D PAGE_SIZE - off;
> +
> +			page =3D pages[ip];
> +			cp =3D iov_iter_copy_from_user_atomic(page, from, off,
> +							    min(tail, bytes));

=46or 5.14, iov_iter_copy_from_user_atomic() has to be replaced by=20
copy_page_from_iter_atomic().

> +			flush_dcache_page(page);
> +			iov_iter_advance(from, cp);

And iov_iter_advance() should be removed then.

Please see upstream commit f0b65f39ac505e8f1dcdaa165aa7b8c0bd6fd454 for=20
detailed explanation.

> +			copied +=3D cp;
> +			bytes -=3D cp;
> +			if (!bytes || !cp)
> +				break;
> +
> +			if (cp < tail) {
> +				off +=3D cp;
> +			} else {
> +				ip++;
> +				off =3D 0;
> +			}
> +		}
> +
> +		ni_lock(ni);
> +		err =3D ni_write_frame(ni, pages, pages_per_frame);
> +		ni_unlock(ni);
> +
> +		for (ip =3D 0; ip < pages_per_frame; ip++) {
> +			page =3D pages[ip];
> +			ClearPageDirty(page);
> +			SetPageUptodate(page);
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +
> +		if (err)
> +			goto out;
> +
> +		/*
> +		 * We can loop for a long time in here. Be nice and allow
> +		 * us to schedule out to avoid softlocking if preempt
> +		 * is disabled.
> +		 */
> +		cond_resched();
> +
> +		pos +=3D copied;
> +		written +=3D copied;
> +
> +		count =3D iov_iter_count(from);
> +	}
> +
> +out:
> +	ntfs_free(pages);
> +
> +	current->backing_dev_info =3D NULL;
> +
> +	if (err < 0)
> +		return err;
> +
> +	iocb->ki_pos +=3D written;
> +	if (iocb->ki_pos > ni->i_valid)
> +		ni->i_valid =3D iocb->ki_pos;
> +
> +	return written;
> +}
> ...

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


