Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B153651159
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiLSRuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 12:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLSRug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:50:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA2FAD3;
        Mon, 19 Dec 2022 09:50:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so7060392wms.2;
        Mon, 19 Dec 2022 09:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/B7gkzEOEryB52AsLQOlC7U/7aoouPr03YHCUavnNQ8=;
        b=bfoHtIDEPOwPnUZVEPgM54bB1sAk3v/faLtzbE8oyODpKn3RpCL93vFhrqZjDUlo+I
         bOIu1Pw4k4BhTBGo7VyXwaRNawg80KeX18WWRC9pdg3sLhces22GTCOnoM8x5zFr5x+z
         MuoqmpBpXPTRKe998wgwsv36Kw1dfgQ90vHFwc3/PTbJQFwlsUE6WbHFiIBbqhHIGm5s
         50p6Yt6RVF+CQh7LoBev2cnGmhUhBD72fhnYu9yDSrE2i+aRRZwLZl0yI44wTntLJLwE
         9uAmxG3FF29/qtGKVDbedZVCMs6xMIuMWhZ5H8LNovjEBzwsi4rWWkj1gCxbJ125acoo
         FWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/B7gkzEOEryB52AsLQOlC7U/7aoouPr03YHCUavnNQ8=;
        b=QGw4uX3yGg7OThtI0vwXIcL9aOpPmrwMEqyQcCIfZ5A0edxv4dPSHyMciSdf+PkxfJ
         cbq2ZuYiBN0zlkG1nN3Al7S1+16xXSRQZ49OoQNBFJIZm50n8j1MY3+jo5JpW6h6NHVn
         F2z/2d5Em0zhyijP6m8XOezx3Fkp1trpbiH3WeKUL3lka5R2jEBUnxVKjlGjeoQQteyH
         cmxc3Ln9ZmJcDJcDCleieceJ3xyCk7x4NsfQzD3cv7xcBHIN7Q4ofqLW5MGMyuxiLu6X
         DVLyfVU/V9JDThrMxv8ABNgVo7jthYhIdf5zBdvtxywfB6re21KaZWy6EgGnYVktSMNH
         /8Xg==
X-Gm-Message-State: ANoB5pn8UQOF5PJGrsfhEhU0ijKBu8LiUsTJD/TMHWJseKekTQdYsB9g
        LtbebB4LC9oxvHE4Kjgtg+U=
X-Google-Smtp-Source: AA0mqf6TzAcVwbpOnYPqXAcd6O9vko8QeVZ7rfmF+msO+tHvYRmLfN/IzqChwOz3nDsz47BgST2/Ng==
X-Received: by 2002:a05:600c:1da7:b0:3d2:2b70:f2fd with SMTP id p39-20020a05600c1da700b003d22b70f2fdmr21247827wms.21.1671472232216;
        Mon, 19 Dec 2022 09:50:32 -0800 (PST)
Received: from suse.localnet (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003c7087f6c9asm20150565wmq.32.2022.12.19.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:50:31 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 19 Dec 2022 18:50:30 +0100
Message-ID: <1788562.8hzESeGDPO@suse>
In-Reply-To: <20221217184749.968-4-fmdefrancesco@gmail.com>
References: <20221217184749.968-1-fmdefrancesco@gmail.com>
 <20221217184749.968-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On sabato 17 dicembre 2022 19:47:49 CET Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in fs/ufs is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> requires the mapping address, so return that address from ufs_get_page()
> to be used in ufs_put_page().
>=20
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ufs/dir.c | 75 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 29 deletions(-)
>=20
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 9fa86614d2d1..a9dd5023b604 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t p=
os,
> unsigned len) return err;
>  }
>=20
> -static inline void ufs_put_page(struct page *page)
> +static inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap((void *)((unsigned long)page_addr & PAGE_MASK));

While working on patch 3/3 of a similar series for fs/sysv a few minutes ag=
o,=20
I noticed this call to kunmap() instead of kunmap_local().

I will wait a day or two before sending the next version, to leave addition=
al=20
time for those who want to comment / review.

=46abio

>  	put_page(page);
>  }
>=20
> @@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct=
=20
qstr
> *qstr) de =3D ufs_find_entry(dir, qstr, &page);
>  	if (de) {
>  		res =3D fs32_to_cpu(dir->i_sb, de->d_ino);
> -		ufs_put_page(page);
> +		ufs_put_page(page, de);
>  	}
>  	return res;
>  }
> @@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct=20
ufs_dir_entry
> *de, ufs_set_de_type(dir->i_sb, de, inode->i_mode);
>=20
>  	err =3D ufs_commit_chunk(page, pos, len);
> -	ufs_put_page(page);
> +	ufs_put_page(page, de);
>  	if (update_times)
>  		dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
>  	mark_inode_dirty(dir);
>  }
>=20
>=20
> -static bool ufs_check_page(struct page *page)
> +static bool ufs_check_page(struct page *page, char *kaddr)
>  {
>  	struct inode *dir =3D page->mapping->host;
>  	struct super_block *sb =3D dir->i_sb;
> -	char *kaddr =3D page_address(page);
>  	unsigned offs, rec_len;
>  	unsigned limit =3D PAGE_SIZE;
>  	const unsigned chunk_mask =3D UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> @@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
>  	return false;
>  }
>=20
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> + * and must be treated accordingly for nesting purposes.
> + */
>  static void *ufs_get_page(struct inode *dir, unsigned long n, struct page
> **p) {
> +	char *kaddr;
> +
>  	struct address_space *mapping =3D dir->i_mapping;
>  	struct page *page =3D read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(page)) {
> -		kmap(page);
> +		kaddr =3D kmap_local_page(page);
>  		if (unlikely(!PageChecked(page))) {
> -			if (!ufs_check_page(page))
> +			if (!ufs_check_page(page, kaddr))
>  				goto fail;
>  		}
>  		*p =3D page;
> -		return page_address(page);
> +		return kaddr;
>  	}
>  	return ERR_CAST(page);
>=20
>  fail:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return ERR_PTR(-EIO);
>  }
>=20
> @@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct
> ufs_dir_entry *p) fs16_to_cpu(sb, p->d_reclen));
>  }
>=20
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
> + * accordingly for nesting purposes.
> + */
>  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>  {
>  	struct ufs_dir_entry *de =3D ufs_get_page(dir, 0, p);
> @@ -238,12 +253,15 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir,
> struct page **p) }
>=20
>  /*
> - *	ufs_find_entry()
> + * Finds an entry in the specified directory with the wanted name. It=20
returns
> a + * pointer to the directory's entry. The page in which the entry was=20
found
> is + * in the res_page out parameter. The page is returned mapped and
> unlocked. + * The entry is guaranteed to be valid.
>   *
> - * finds an entry in the specified directory with the wanted name. It
> - * returns the page in which the entry was found, and the entry itself
> - * (as a parameter - res_dir). Page is returned mapped and unlocked.
> - * Entry is guaranteed to be valid.
> + * On Success ufs_put_page() should be called on *res_page.
> + *
> + * ufs_find_entry() acts as a call to ufs_get_page() and must be treated
> + * accordingly for nesting purposes.
>   */
>  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr
> *qstr, struct page **res_page)
> @@ -282,7 +300,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *di=
r,
> const struct qstr *qstr, goto found;
>  				de =3D ufs_next_entry(sb, de);
>  			}
> -			ufs_put_page(page);
> +			ufs_put_page(page, kaddr);
>  		}
>  		if (++n >=3D npages)
>  			n =3D 0;
> @@ -360,7 +378,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> *inode) de =3D (struct ufs_dir_entry *) ((char *) de + rec_len);
>  		}
>  		unlock_page(page);
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	BUG();
>  	return -EINVAL;
> @@ -390,7 +408,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> *inode) mark_inode_dirty(dir);
>  	/* OFFSET_CACHE */
>  out_put:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -468,13 +486,13 @@ ufs_readdir(struct file *file, struct dir_context=20
*ctx)
>  					       ufs_get_de_namlen(sb,=20
de),
>  					       fs32_to_cpu(sb, de-
>d_ino),
>  					       d_type)) {
> -					ufs_put_page(page);
> +					ufs_put_page(page, kaddr);
>  					return 0;
>  				}
>  			}
>  			ctx->pos +=3D fs16_to_cpu(sb, de->d_reclen);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -485,10 +503,10 @@ ufs_readdir(struct file *file, struct dir_context=20
*ctx)
>   * previous entry.
>   */
>  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> -		     struct page * page)
> +		     struct page *page)
>  {
>  	struct super_block *sb =3D inode->i_sb;
> -	char *kaddr =3D page_address(page);
> +	char *kaddr =3D (char *)((unsigned long)dir & PAGE_MASK);
>  	unsigned int from =3D offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi-
>s_dirblksize
> - 1); unsigned int to =3D offset_in_page(dir) + fs16_to_cpu(sb, dir-
>d_reclen);
> loff_t pos;
> @@ -527,7 +545,7 @@ int ufs_delete_entry(struct inode *inode, struct
> ufs_dir_entry *dir, inode->i_ctime =3D inode->i_mtime =3D current_time(in=
ode);
>  	mark_inode_dirty(inode);
>  out:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	UFSD("EXIT\n");
>  	return err;
>  }
> @@ -551,8 +569,7 @@ int ufs_make_empty(struct inode * inode, struct inode
> *dir) goto fail;
>  	}
>=20
> -	kmap(page);
> -	base =3D (char*)page_address(page);
> +	base =3D kmap_local_page(page);
>  	memset(base, 0, PAGE_SIZE);
>=20
>  	de =3D (struct ufs_dir_entry *) base;
> @@ -569,7 +586,7 @@ int ufs_make_empty(struct inode * inode, struct inode
> *dir) de->d_reclen =3D cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
>  	ufs_set_de_namlen(sb, de, 2);
>  	strcpy (de->d_name, "..");
> -	kunmap(page);
> +	kunmap_local(base);
>=20
>  	err =3D ufs_commit_chunk(page, 0, chunk_size);
>  fail:
> @@ -585,9 +602,9 @@ int ufs_empty_dir(struct inode * inode)
>  	struct super_block *sb =3D inode->i_sb;
>  	struct page *page =3D NULL;
>  	unsigned long i, npages =3D dir_pages(inode);
> +	char *kaddr;
>=20
>  	for (i =3D 0; i < npages; i++) {
> -		char *kaddr;
>  		struct ufs_dir_entry *de;
>=20
>  		kaddr =3D ufs_get_page(inode, i, &page);
> @@ -620,12 +637,12 @@ int ufs_empty_dir(struct inode * inode)
>  			}
>  			de =3D ufs_next_entry(sb, de);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 1;
>=20
>  not_empty:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	return 0;
>  }
>=20
> --
> 2.39.0




