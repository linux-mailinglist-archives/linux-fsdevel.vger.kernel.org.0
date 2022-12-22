Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93706542EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiLVO1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 09:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiLVO1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:27:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A97F2937C;
        Thu, 22 Dec 2022 06:27:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a17so1791002wrt.11;
        Thu, 22 Dec 2022 06:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ4QUwxa2kqDBT4/Q2PZoVrlupcYXqtxCtZcztuQGJA=;
        b=j8gzil4udi4y4TfA/y1t9rwmPfyz3IJhXQ7TDH1nA7EaUptIrbDlP1lg1nqlvaFFEw
         0qFZEoDfk1EYEg+2hOYwImfjuOwru0GfO2AN9Wu2w/VQMmBC1jKcxuiQDsOr6G4N1VYU
         Cc9lhPmdR5Nhc3c/28Nm1UehD87T5wp4r1mgHAp38SbOdYYnJP3qyuV+zJvpDrRldVCl
         vY3wXwp8VWQfFc3wiKWEJK2z0RqBMg1+RI8/c/8cuIRPiCbKWtl4FQPyZSGgq0rzdNEg
         ZWAYrFBO280WkIDNYzGoc+A2OHV0uh+IExGO40vFXl3KdXXMZHmEtD3lPiesO8iXiZzY
         bsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ4QUwxa2kqDBT4/Q2PZoVrlupcYXqtxCtZcztuQGJA=;
        b=zTbwqtE2iEsbLjs5RZJnIt5p6r9FLVeAdBPR5NFqrQ9o87gcyDA7sCyD0j4fxdU4tB
         hIwpzFDbwNg1r5fQfnV4Mq0qA7zESgehQFOmrOCJ4rNr/70xsRVkMYC917ObPits9Rxz
         4WhfVIVG1pu5PBgBRS4VXwXIPlUGYDqrilABB+GCg+h9AGPtJOJlELOmZaemgz8PGieI
         e1wBk2QG24xLY2iqdFlUMXLd66B8e0sBrP69IGeMRG2gT4AWk3mufS/pwsgkoA0cRyhR
         LEHWUPzahUg3ZV+UMJX13Ml7lkW414nN6D1jnzV881bXcmQu+0pZ/5CgMs+cDM5xaxJn
         TxGw==
X-Gm-Message-State: AFqh2kqimV86+2oofQx2+loSNU0gDOVDgCWQ3EDNvHqgLV8VN7VCzK+U
        kU447cN0vGFWilKvkgYrqP8=
X-Google-Smtp-Source: AMrXdXuY+SL8QN18Pyel9DFeEGBLkhS9OJM9rlFjcWLsJ+0Yq9yJJ8H0dL4VLGPf0i1oOAMGeCgZng==
X-Received: by 2002:a5d:4803:0:b0:26a:b8e3:b772 with SMTP id l3-20020a5d4803000000b0026ab8e3b772mr3552073wrq.23.1671719230808;
        Thu, 22 Dec 2022 06:27:10 -0800 (PST)
Received: from suse.localnet (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id n16-20020adffe10000000b002367ad808a9sm677734wrr.30.2022.12.22.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:27:10 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Thu, 22 Dec 2022 15:27:08 +0100
Message-ID: <1884934.6tgchFWduM@suse>
In-Reply-To: <Y6Pt7QXbXjaFpNjx@iweiny-desk3>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
 <20221221172802.18743-4-fmdefrancesco@gmail.com>
 <Y6Pt7QXbXjaFpNjx@iweiny-desk3>
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

On gioved=C3=AC 22 dicembre 2022 06:41:01 CET Ira Weiny wrote:
> On Wed, Dec 21, 2022 at 06:28:02PM +0100, Fabio M. De Francesco wrote:
> > kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > There are two main problems with kmap(): (1) It comes with an overhead =
as
> > the mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when t=
he
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> >=20
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, t=
he
> > kernel virtual addresses are restored and still valid.
> >=20
> > Since its use in fs/ufs is safe everywhere, it should be preferred.
> >=20
> > Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_loca=
l()
> > requires the mapping address, so return that address from ufs_get_page()
> > to be used in ufs_put_page().
>=20
> I don't see the calls to kunmap() in ufs_rename converted here?
>=20
> Did I miss them?
>

No, it's my fault.
I must have used "grep" on all files in fs/ufs, but I forgot to run it :-(

While at this... I'm wondering whether or not we could benefit from a WARNI=
NG=20
about the use of kunmap(). I'm talking about adding this too to checkpatch.=
pl,=20
exactly as we already have it for catching the deprecated use of kmap().=20
=20
>
> I think those calls need to be changed to ufs_put_page() calls in a=20
precursor
> patch to this one unless I'm missing something.
>=20

Again I think that you are not missing anything and that your suggestion=20
sounds good.

I'll replace the three kunmap() + put_page() with three calls to=20
ufs_put_page() in ufs_rename(). I'll do these changes in patch 3/4. Instead=
=20
the current 3/4 patch will move ahead and become 4/4.

>
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> >  fs/ufs/dir.c | 75 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 46 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> > index 9fa86614d2d1..ed3568da29a8 100644
> > --- a/fs/ufs/dir.c
> > +++ b/fs/ufs/dir.c
> > @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t=
=20
pos,
> > unsigned len)>=20
> >  	return err;
> > =20
> >  }
> >=20
> > -static inline void ufs_put_page(struct page *page)
> > +static inline void ufs_put_page(struct page *page, void *page_addr)
> >=20
> >  {
> >=20
> > -	kunmap(page);
> > +	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
>=20
> Any address in the page can be passed to kunmap_local() as this mask is d=
one
> internally.
>=20

I know that any address can be passed and that the bitwise and is performed=
=20
internally in kunmap_local_indexed(). This is why I've never done something=
=20
like this in any other of my precedent conversions.=20

However, I thought that Al should have had reasons to suggest to call=20
kunmap_local() this way. Copy-pasted from one of his message (https://
lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/) while commenting the one patc=
h=20
old conversions:

=2D-- begin ---

 -static inline void ufs_put_page(struct page *page)
> +inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap_local(page_addr);

Make that
	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
and things become much easier.

>  	put_page(page);
>  }

=2D-- end ---

Did I misinterpret his words?
However, it's my fault again because I should have asked why :-(

> >  	put_page(page);
> > =20
> >  }
> >=20
> > @@ -76,7 +76,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const stru=
ct
> > qstr *qstr)>=20
> >  	de =3D ufs_find_entry(dir, qstr, &page);
> >  	if (de) {
> >  =09
> >  		res =3D fs32_to_cpu(dir->i_sb, de->d_ino);
> >=20
> > -		ufs_put_page(page);
> > +		ufs_put_page(page, de);
> >=20
> >  	}
> >  	return res;
> > =20
> >  }
> >=20
> > @@ -99,18 +99,17 @@ void ufs_set_link(struct inode *dir, struct
> > ufs_dir_entry *de,>=20
> >  	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
> >  =09
> >  	err =3D ufs_commit_chunk(page, pos, len);
> >=20
> > -	ufs_put_page(page);
> > +	ufs_put_page(page, de);
> >=20
> >  	if (update_times)
> >  =09
> >  		dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
> >  =09
> >  	mark_inode_dirty(dir);
> > =20
> >  }
> >=20
> > -static bool ufs_check_page(struct page *page)
> > +static bool ufs_check_page(struct page *page, char *kaddr)
> >=20
> >  {
> > =20
> >  	struct inode *dir =3D page->mapping->host;
> >  	struct super_block *sb =3D dir->i_sb;
> >=20
> > -	char *kaddr =3D page_address(page);
> >=20
> >  	unsigned offs, rec_len;
> >  	unsigned limit =3D PAGE_SIZE;
> >  	const unsigned chunk_mask =3D UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> >=20
> > @@ -185,23 +184,32 @@ static bool ufs_check_page(struct page *page)
> >=20
> >  	return false;
> > =20
> >  }
> >=20
> > +/*
> > + * Calls to ufs_get_page()/ufs_put_page() must be nested according to =
the
> > + * rules documented in kmap_local_page()/kunmap_local().
> > + *
> > + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_pag=
e()
> > + * and must be treated accordingly for nesting purposes.
> > + */
> >=20
> >  static void *ufs_get_page(struct inode *dir, unsigned long n, struct p=
age
> >  **p) {
> >=20
> > +	char *kaddr;
> > +
> >=20
> >  	struct address_space *mapping =3D dir->i_mapping;
> >  	struct page *page =3D read_mapping_page(mapping, n, NULL);
> >  	if (!IS_ERR(page)) {
> >=20
> > -		kmap(page);
> > +		kaddr =3D kmap_local_page(page);
> >=20
> >  		if (unlikely(!PageChecked(page))) {
> >=20
> > -			if (!ufs_check_page(page))
> > +			if (!ufs_check_page(page, kaddr))
> >=20
> >  				goto fail;
> >  	=09
> >  		}
> >  		*p =3D page;
> >=20
> > -		return page_address(page);
> > +		return kaddr;
> >=20
> >  	}
> >  	return ERR_CAST(page);
> > =20
> >  fail:
> > -	ufs_put_page(page);
> > +	ufs_put_page(page, kaddr);
> >=20
> >  	return ERR_PTR(-EIO);
> > =20
> >  }
> >=20
> > @@ -227,6 +235,13 @@ ufs_next_entry(struct super_block *sb, struct
> > ufs_dir_entry *p)>=20
> >  					fs16_to_cpu(sb, p-
>d_reclen));
> > =20
> >  }
> >=20
> > +/*
> > + * Calls to ufs_get_page()/ufs_put_page() must be nested according to =
the
> > + * rules documented in kmap_local_page()/kunmap_local().
> > + *
> > + * ufs_dotdot() acts as a call to ufs_get_page() and must be treated
> > + * accordingly for nesting purposes.
> > + */
> >=20
> >  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> >  {
> > =20
> >  	struct ufs_dir_entry *de =3D ufs_get_page(dir, 0, p);
> >=20
> > @@ -238,12 +253,15 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *di=
r,
> > struct page **p)>=20
> >  }
> > =20
> >  /*
> >=20
> > - *	ufs_find_entry()
> > + * Finds an entry in the specified directory with the wanted name. It
> > returns a + * pointer to the directory's entry. The page in which the=20
entry
> > was found is + * in the res_page out parameter. The page is returned=20
mapped
> > and unlocked. + * The entry is guaranteed to be valid.
> >=20
> >   *
> >=20
> > - * finds an entry in the specified directory with the wanted name. It
> > - * returns the page in which the entry was found, and the entry itself
> > - * (as a parameter - res_dir). Page is returned mapped and unlocked.
> > - * Entry is guaranteed to be valid.
>=20
> I don't follow why this comment needed changing for this patch.  It proba=
bly
> warrants it's own patch.
>=20

Sure, the removal of the name of function is a different logical change, so=
=20
I'll probably leave it as it was.=20

> > + * On Success ufs_put_page() should be called on *res_page.
> > + *
> > + * ufs_find_entry() acts as a call to ufs_get_page() and must be treat=
ed
> > + * accordingly for nesting purposes.
> >=20
> >   */

But this last part should be still added. Am I wrong?

> >  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct q=
str=20
*qstr,
> >  				struct page **res_page)
> >=20
> > @@ -282,7 +300,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode=20
*dir,
> > const struct qstr *qstr,>=20
> >  					goto found;
> >  			=09
> >  				de =3D ufs_next_entry(sb, de);
> >  		=09
> >  			}
> >=20
> > -			ufs_put_page(page);
> > +			ufs_put_page(page, kaddr);
> >=20
> >  		}
> >  		if (++n >=3D npages)
> >  	=09
> >  			n =3D 0;
> >=20
> > @@ -360,7 +378,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> > *inode)>=20
> >  			de =3D (struct ufs_dir_entry *) ((char *) de +=20
rec_len);
> >  	=09
> >  		}
> >  		unlock_page(page);
> >=20
> > -		ufs_put_page(page);
> > +		ufs_put_page(page, kaddr);
> >=20
> >  	}
> >  	BUG();
> >  	return -EINVAL;
> >=20
> > @@ -390,7 +408,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> > *inode)>=20
> >  	mark_inode_dirty(dir);
> >  	/* OFFSET_CACHE */
> > =20
> >  out_put:
> > -	ufs_put_page(page);
> > +	ufs_put_page(page, kaddr);
> >=20
> >  	return err;
> > =20
> >  out_unlock:
> >  	unlock_page(page);
> >=20
> > @@ -468,13 +486,13 @@ ufs_readdir(struct file *file, struct dir_context
> > *ctx)
> >=20
> >  					       ufs_get_de_namlen(sb,=20
de),
> >  					       fs32_to_cpu(sb, de-
>d_ino),
> >  					       d_type)) {
> >=20
> > -					ufs_put_page(page);
> > +					ufs_put_page(page, kaddr);
> >=20
> >  					return 0;
> >  			=09
> >  				}
> >  		=09
> >  			}
> >  			ctx->pos +=3D fs16_to_cpu(sb, de->d_reclen);
> >  	=09
> >  		}
> >=20
> > -		ufs_put_page(page);
> > +		ufs_put_page(page, kaddr);
> >=20
> >  	}
> >  	return 0;
> > =20
> >  }
> >=20
> > @@ -485,10 +503,10 @@ ufs_readdir(struct file *file, struct dir_context
> > *ctx)
> >=20
> >   * previous entry.
> >   */
> > =20
> >  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> >=20
> > -		     struct page * page)
> > +		     struct page *page)
> >=20
> >  {
> > =20
> >  	struct super_block *sb =3D inode->i_sb;
> >=20
> > -	char *kaddr =3D page_address(page);
> > +	char *kaddr =3D (char *)((unsigned long)dir & PAGE_MASK);
>=20
> I feel like this deserves a comment to clarify that dir points somewhere =
in
> the page we need the base address of.

OK, it sounds reasonable.

> >  	unsigned int from =3D offset_in_page(dir) &
> >  	~(UFS_SB(sb)->s_uspi->s_dirblksize - 1); unsigned int to =3D
> >  	offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen); loff_t pos;
> >=20
> > @@ -527,7 +545,7 @@ int ufs_delete_entry(struct inode *inode, struct
> > ufs_dir_entry *dir,>=20
> >  	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> >  	mark_inode_dirty(inode);
> > =20
> >  out:
> > -	ufs_put_page(page);
> > +	ufs_put_page(page, kaddr);
> >=20
> >  	UFSD("EXIT\n");
> >  	return err;
> > =20
> >  }
> >=20
> > @@ -551,8 +569,7 @@ int ufs_make_empty(struct inode * inode, struct ino=
de
> > *dir)>=20
> >  		goto fail;
> >  =09
> >  	}
> >=20
> > -	kmap(page);
> > -	base =3D (char*)page_address(page);
> > +	base =3D kmap_local_page(page);
>=20
> NIT: I'd make this conversion a separate patch.
>=20
> Ira
>=20

We've always done multiple conversions at the same time if in the same file=
,=20
even if they were unrelated.

I don't understand why we want to change the usual procedure. Can you pleas=
e=20
elaborate a bit more on this topic?

Thanks so much for finding the missing conversions and for your other comme=
nts=20
and advice on this patch.

=46abio

> >  	memset(base, 0, PAGE_SIZE);
> >  =09
> >  	de =3D (struct ufs_dir_entry *) base;
> >=20
> > @@ -569,7 +586,7 @@ int ufs_make_empty(struct inode * inode, struct ino=
de
> > *dir)>=20
> >  	de->d_reclen =3D cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
> >  	ufs_set_de_namlen(sb, de, 2);
> >  	strcpy (de->d_name, "..");
> >=20
> > -	kunmap(page);
> > +	kunmap_local(base);
> >=20
> >  	err =3D ufs_commit_chunk(page, 0, chunk_size);
> > =20
> >  fail:
> > @@ -585,9 +602,9 @@ int ufs_empty_dir(struct inode * inode)
> >=20
> >  	struct super_block *sb =3D inode->i_sb;
> >  	struct page *page =3D NULL;
> >  	unsigned long i, npages =3D dir_pages(inode);
> >=20
> > +	char *kaddr;
> >=20
> >  	for (i =3D 0; i < npages; i++) {
> >=20
> > -		char *kaddr;
> >=20
> >  		struct ufs_dir_entry *de;
> >  	=09
> >  		kaddr =3D ufs_get_page(inode, i, &page);
> >=20
> > @@ -620,12 +637,12 @@ int ufs_empty_dir(struct inode * inode)
> >=20
> >  			}
> >  			de =3D ufs_next_entry(sb, de);
> >  	=09
> >  		}
> >=20
> > -		ufs_put_page(page);
> > +		ufs_put_page(page, kaddr);
> >=20
> >  	}
> >  	return 1;
> > =20
> >  not_empty:
> > -	ufs_put_page(page);
> > +	ufs_put_page(page, kaddr);
> >=20
> >  	return 0;
> > =20
> >  }
> >=20
> > --
> > 2.39.0




