Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF123F234C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 00:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhHSWjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 18:39:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhHSWjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:39:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3382620144;
        Thu, 19 Aug 2021 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629412712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIlNR3os7VWLYEIEuZeizUmXv4o3hIO6pJoCRjYpwu0=;
        b=2BLXZ/dJ/iIbD5PwYjOx9gh5RhDxJbD9N+WB4gaaXxWb6n4cWVuS7RJKruwFGGH2ChCaHL
        qb+hje5xJIvxiM5owZakZX8wJe/l/4avmKNxhDe9UF5TRe/iE40ATMnGTLHhul57ajREhw
        iB+NPBVYppgLxMCyFUP+qK29w2h2208=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629412712;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIlNR3os7VWLYEIEuZeizUmXv4o3hIO6pJoCRjYpwu0=;
        b=FTM6sKWWwtXCxBU/BiDHnvO9dDX8tf7U2rBRuER3sbHMV7W7kVaepCB8WcWfBDdnBuE9ui
        4C1ztLwi9foUv8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D2FA13BB0;
        Thu, 19 Aug 2021 22:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8tdhDmTdHmHlCAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 19 Aug 2021 22:38:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "David Howells" <dhowells@redhat.com>
Cc:     willy@infradead.org, "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Trond Myklebust" <trond.myklebust@primarydata.com>,
        linux-nfs@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] nfs: Fix write to swapfile failure due to
 generic_write_checks()
In-reply-to: <162879972678.3306668.10709543333474121000.stgit@warthog.procyon.org.uk>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>,
 <162879972678.3306668.10709543333474121000.stgit@warthog.procyon.org.uk>
Date:   Fri, 20 Aug 2021 08:38:25 +1000
Message-id: <162941270551.9892.11928487819470058113@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 13 Aug 2021, David Howells wrote:
> Trying to use a swapfile on NFS results in every DIO write failing with
> ETXTBSY because generic_write_checks(), as called by nfs_direct_write()
> from nfs_direct_IO(), forbids writes to swapfiles.

Could we just remove this check from generic_write_checks(), and instead
call deny_write_access() in swap_on?
Then user-space wouldn't be able to open a swap-file for write, so there
would be no need to check on every single write.

NeilBrown


>=20
> Fix this by introducing a new kiocb flag, IOCB_SWAP, that's set by the swap
> code to indicate that the swapper is doing this operation and so overrule
> the check in generic_write_checks().
>=20
> Without this patch, the following is seen:
>=20
> 	Write error on dio swapfile (3800334336)
>=20
> Altering __swap_writepage() to show the error shows:
>=20
> 	Write error (-26) on dio swapfile (3800334336)
>=20
> Tested by swapping off all swap partitions and then swapping on a prepared
> NFS file (CONFIG_NFS_SWAP=3Dy is also needed).  Enough copies of the
> following program then need to be run to force swapping to occur (at least
> one per gigabyte of RAM):
>=20
> 	#include <stdbool.h>
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <unistd.h>
> 	#include <sys/mman.h>
> 	int main()
> 	{
> 		unsigned int pid =3D getpid(), iterations =3D 0;
> 		size_t i, j, size =3D 1024 * 1024 * 1024;
> 		char *p;
> 		bool mismatch;
> 		p =3D malloc(size);
> 		if (!p) {
> 			perror("malloc");
> 			exit(1);
> 		}
> 		srand(pid);
> 		for (i =3D 0; i < size; i +=3D 4)
> 			*(unsigned int *)(p + i) =3D rand();
> 		do {
> 			for (j =3D 0; j < 16; j++) {
> 				for (i =3D 0; i < size; i +=3D 4096)
> 					*(unsigned int *)(p + i) +=3D 1;
> 				iterations++;
> 			}
> 			mismatch =3D false;
> 			srand(pid);
> 			for (i =3D 0; i < size; i +=3D 4) {
> 				unsigned int r =3D rand();
> 				unsigned int v =3D *(unsigned int *)(p + i);
> 				if (i % 4096 =3D=3D 0)
> 					v -=3D iterations;
> 				if (v !=3D r) {
> 					fprintf(stderr, "mismatch %zx: %x !=3D %x (diff %x)\n",
> 						i, v, r, v - r);
> 					mismatch =3D true;
> 				}
> 			}
> 		} while (!mismatch);
> 		exit(1);
> 	}
>=20
>=20
> Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Darrick J. Wong <darrick.wong@oracle.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Trond Myklebust <trond.myklebust@primarydata.com>
> cc: linux-nfs@vger.kernel.org
> ---
>=20
>  fs/read_write.c    |    2 +-
>  include/linux/fs.h |    1 +
>  mm/page_io.c       |    7 ++++---
>  3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 9db7adf160d2..daef721ca67e 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1646,7 +1646,7 @@ ssize_t generic_write_checks(struct kiocb *iocb, stru=
ct iov_iter *from)
>  	loff_t count;
>  	int ret;
> =20
> -	if (IS_SWAPFILE(inode))
> +	if (IS_SWAPFILE(inode) && !(iocb->ki_flags & IOCB_SWAP))
>  		return -ETXTBSY;
> =20
>  	if (!iov_iter_count(from))
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640574294216..b3e6a20f28ef 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -319,6 +319,7 @@ enum rw_hint {
>  /* iocb->ki_waitq is valid */
>  #define IOCB_WAITQ		(1 << 19)
>  #define IOCB_NOIO		(1 << 20)
> +#define IOCB_SWAP		(1 << 21)	/* This is a swap request */
> =20
>  struct kiocb {
>  	struct file		*ki_filp;
> diff --git a/mm/page_io.c b/mm/page_io.c
> index d597bc6e6e45..edb72bf624d2 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -303,7 +303,8 @@ int __swap_writepage(struct page *page, struct writebac=
k_control *wbc,
> =20
>  		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
>  		init_sync_kiocb(&kiocb, swap_file);
> -		kiocb.ki_pos =3D page_file_offset(page);
> +		kiocb.ki_pos	=3D page_file_offset(page);
> +		kiocb.ki_flags	=3D IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
> =20
>  		set_page_writeback(page);
>  		unlock_page(page);
> @@ -324,8 +325,8 @@ int __swap_writepage(struct page *page, struct writebac=
k_control *wbc,
>  			 */
>  			set_page_dirty(page);
>  			ClearPageReclaim(page);
> -			pr_err_ratelimited("Write error on dio swapfile (%llu)\n",
> -					   page_file_offset(page));
> +			pr_err_ratelimited("Write error (%d) on dio swapfile (%llu)\n",
> +					   ret, page_file_offset(page));
>  		}
>  		end_page_writeback(page);
>  		return ret;
>=20
>=20
>=20
