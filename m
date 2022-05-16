Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4D52817D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiEPKII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 06:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbiEPKHf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 06:07:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45E29FFA;
        Mon, 16 May 2022 03:07:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so19824794wrg.3;
        Mon, 16 May 2022 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHy1DxskfYtTzR10hFBW7KtNkaksqkV+HwXuSa/N4gY=;
        b=oHg1d6xCKDdsdL8NE3bwuG0bBwUAYpTjeAn1LP/Tc3cG+Ohr9OyXruxPKDzu4MafuG
         bJPbjUwD6tPDUc0O9jQAjhoustpTvj4NbfSYuKXxuT6OEzH3Gl4utxzVC/bdWsrWDkrA
         gpzgjL0IEkPmqu+ab5r5K4gXSZMmpODSlO7CkeDEY/nr32hkZYxB5TKe7N5F1/3lqwaA
         Z12iGlkOUQHHYWBLWPLlb9UWzw7pSJDKWTiYygUNoN/Oz9EYRLplKNF3qp7zqT5uS+eZ
         9/agR7NiVUUqFqCricljbOy/b6qxIuv2hv0p+Ei42WX7ya+V5I9SDNmdIZiKMgrTaNFO
         cPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHy1DxskfYtTzR10hFBW7KtNkaksqkV+HwXuSa/N4gY=;
        b=Ykg1hG/luQ4yhkUGwQHtbEX/zoDaVeFsHbd+WPoatkoesakDxLtvz5VVt/tTMZ+VxC
         2Ih4U4Ao0uLsBx0oMJGpIf+BYOso/hRu3wnzyUZ+KicvXYatg8MJCVKTUmIrn+gbsXFk
         RNFhM6CDWfkpcxWiAGFw/gnFU2iKPwyiwD80YptD9W3jrv0voWOu9Mkh86KywMv873Eh
         WecNuQCDP22kVOM11R/YQXUppfNCUCsMdHBHv99SvgzEi8mlYb/4p1L2E4fAlFEr4YKs
         QWMvD0GFtCilp6/F1jNkOP4CJJlj1eIDIfRcXB5CUvw6s1DS2/es/t0wtW8C8JvmkYHD
         6MQA==
X-Gm-Message-State: AOAM531kcq/eTUz/wIfeKeh0ssQexVoDodrVXJvkcAxs83fRBi2hCUSI
        kDUwcDUvqv34Hlw26KcXdy8=
X-Google-Smtp-Source: ABdhPJy/6QfJ7ppvNa6HTP7+zrPrP1+x08PdImq+qjJ/69VIe1VDgNed6Ps0e/Ei+JDetfbC3ad/sg==
X-Received: by 2002:a05:6000:1848:b0:20c:713b:8e1e with SMTP id c8-20020a056000184800b0020c713b8e1emr14059824wri.640.1652695639241;
        Mon, 16 May 2022 03:07:19 -0700 (PDT)
Received: from leap.localnet (host-79-50-182-226.retail.telecomitalia.it. [79.50.182.226])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b0039482d95ab7sm9820684wmc.24.2022.05.16.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:07:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 16 May 2022 12:07:14 +0200
Message-ID: <13020190.uLZWGnKmhe@leap>
In-Reply-To: <YoGSjZlucCKjSxVX@iweiny-desk3>
References: <20220509071207.16176-1-fmdefrancesco@gmail.com> <YoGSjZlucCKjSxVX@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On luned=C3=AC 16 maggio 2022 01:53:49 CEST Ira Weiny wrote:
> On Mon, May 09, 2022 at 09:12:07AM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is thread-local, CPU-local and not=20
globally
> > visible.
> >=20
> > The usage of kmap_local_page() in fs/ufs is thread-local, therefore=20
replace
> > kmap() / kunmap() calls with kmap_local_page() / kunmap_local().
> >=20
> > kunmap_local() requires the mapping address, so return that address=20
from
> > ufs_get_page() to be used in ufs_put_page().
> >=20
> > These changes are essentially ported from fs/ext2 and relie largely on
> > commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").
> >=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> > v1 -> v2: Correct some style's issues reported by checkpatch.pl.
> > 	  Remove "inline" compiler directive from fs/ufs/ufs.h,
> > 	  Reported-by: kernel test robot <lkp@intel.com>
> >=20
> >  fs/ufs/dir.c   | 116 +++++++++++++++++++++++++++++++------------------
> >  fs/ufs/namei.c |  38 ++++++++--------
> >  fs/ufs/ufs.h   |  12 +++--
> >  3 files changed, 102 insertions(+), 64 deletions(-)
> >=20
> >
> > [snip]
> >  =20
> > @@ -250,27 +251,31 @@ static int ufs_rename(struct user_namespace=20
*mnt_userns, struct inode *old_dir,
> >  	struct inode *old_inode =3D d_inode(old_dentry);
> >  	struct inode *new_inode =3D d_inode(new_dentry);
> >  	struct page *dir_page =3D NULL;
> > +	void *dir_page_addr;
> >  	struct ufs_dir_entry * dir_de =3D NULL;
> >  	struct page *old_page;
> > +	void *old_page_addr;
> >  	struct ufs_dir_entry *old_de;
> >  	int err =3D -ENOENT;
> > =20
> >  	if (flags & ~RENAME_NOREPLACE)
> >  		return -EINVAL;
> > =20
> > -	old_de =3D ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
> > +	old_de =3D ufs_find_entry(old_dir, &old_dentry->d_name, &old_page,
> > +				&old_page_addr);
> >  	if (!old_de)
> >  		goto out;
> > =20
> >  	if (S_ISDIR(old_inode->i_mode)) {
> >  		err =3D -EIO;
> > -		dir_de =3D ufs_dotdot(old_inode, &dir_page);
> > +		dir_de =3D ufs_dotdot(old_inode, &dir_page,=20
&dir_page_addr);
> >  		if (!dir_de)
> >  			goto out_old;
> >  	}
> > =20
> >  	if (new_inode) {
> >  		struct page *new_page;
> > +		void *page_addr;
>=20
> Nit:
>=20
> It might be good to make this new_page_addr to keep it straight with the=
=20
other
> pages mapped in this function.
>=20

Yes, it should be "new_page_addr" for consistency. I'm going to rename this=
=20
variable and send v3.

>
> Regardless:
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>=20

Thanks!

=46abio

> >  		struct ufs_dir_entry *new_de;
> > =20
> >  		err =3D -ENOTEMPTY;
> > @@ -278,10 +283,11 @@ static int ufs_rename(struct user_namespace=20
*mnt_userns, struct inode *old_dir,
> >  			goto out_dir;
> > =20
> >  		err =3D -ENOENT;
> > -		new_de =3D ufs_find_entry(new_dir, &new_dentry->d_name,=20
&new_page);
> > +		new_de =3D ufs_find_entry(new_dir, &new_dentry->d_name,=20
&new_page,
> > +					&page_addr);
> >  		if (!new_de)
> >  			goto out_dir;
> > -		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
> > +		ufs_set_link(new_dir, new_de, new_page, page_addr,=20
old_inode, 1);
> >  		new_inode->i_ctime =3D current_time(new_inode);
> >  		if (dir_de)
> >  			drop_nlink(new_inode);
> > @@ -300,29 +306,25 @@ static int ufs_rename(struct user_namespace=20
*mnt_userns, struct inode *old_dir,
> >  	 */
> >  	old_inode->i_ctime =3D current_time(old_inode);
> > =20
> > -	ufs_delete_entry(old_dir, old_de, old_page);
> > +	ufs_delete_entry(old_dir, old_de, old_page, old_page_addr);
> >  	mark_inode_dirty(old_inode);
> > =20
> >  	if (dir_de) {
> >  		if (old_dir !=3D new_dir)
> > -			ufs_set_link(old_inode, dir_de, dir_page,=20
new_dir, 0);
> > -		else {
> > -			kunmap(dir_page);
> > -			put_page(dir_page);
> > -		}
> > +			ufs_set_link(old_inode, dir_de, dir_page,
> > +				     dir_page_addr, new_dir, 0);
> > +		else
> > +			ufs_put_page(dir_page, dir_page_addr);
> >  		inode_dec_link_count(old_dir);
> >  	}
> >  	return 0;
> > =20
> > =20
> >  out_dir:
> > -	if (dir_de) {
> > -		kunmap(dir_page);
> > -		put_page(dir_page);
> > -	}
> > +	if (dir_de)
> > +		ufs_put_page(dir_page, dir_page_addr);
> >  out_old:
> > -	kunmap(old_page);
> > -	put_page(old_page);
> > +	ufs_put_page(old_page, old_page_addr);
> >  out:
> >  	return err;
> >  }
> >
> > [snip]
> >


