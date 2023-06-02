Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EE71FFC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjFBKvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjFBKvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:51:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5AFC0;
        Fri,  2 Jun 2023 03:51:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so18079165e9.3;
        Fri, 02 Jun 2023 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685703094; x=1688295094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/KYrzVd1/Zo7zWt5C68T2c7SnctdTTPmX3X8b9/4AQ=;
        b=F+1/UettnBoea3LhX9X4pJtECG2FUQwaHunFuIFXSaM2RsKCzNu/t7J24SBIR7ip30
         dgDOIeCYxfX5sD99r4HI0P5Ma4sbWmNPSm76v6PHlzF3lghd1eN5tA87OIXKRDEaesXT
         FYpPZSpfkxg5DoB+OD76Qsr3alROGHa0wCEWP8cUleTsKAUD0MZOq6i1bjG5V56PiQAb
         0QAC9fqnAo+YRnrL6PYe3o+R6NJsM2JHOJQN1i7uqeYJ0uqVbUQMSmhTgUaJIoDH59rF
         fyWanEJx4Q+AEJnffwiHSP9Re5b8MxRc7AhYfqij7oeiR96c5t8Huz0hTfT37J2GtGGC
         hqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685703094; x=1688295094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/KYrzVd1/Zo7zWt5C68T2c7SnctdTTPmX3X8b9/4AQ=;
        b=iLzFC9xa8dFYWmkzAIcDylW0hBVWdvYqg1deZoW5CQXqz9QxS+lqFY9Spmx+QOZ2qy
         zr6MvqlwVBYW6MX4JPzBICWJNK2hwDVrNf2o6bB09/MFf8GqUpJFq0TzpgVlqIPYDBST
         v8jhbbopIxfjJIIvT+AejlssQi3QSHp6J2/R5U8IpMLcbFQDg3PXJtKnpdFCapixUwo3
         gPXRrkZyCeNdomBucZYvyGNN2dbYUtrjXe/FRe9JDYrsCZxV1uEBseA5wPe9eoUhx85k
         2gc5UFYK0SiRNJrmIfqMyeMtyj88zMH2/Nx7VUzPAumt8E+gEhWks32Ucw2fZHkg/X0s
         tt2g==
X-Gm-Message-State: AC+VfDxlZHQ2douhPVCcP+UoISq3ScfwLMe/eI67X45nfU/wcCbAwBaL
        VHB65Va92jcRdVzMvvsyuoY=
X-Google-Smtp-Source: ACHHUZ5CnE4e8fyiYSt91vsZOK7eUlMko+3L5M/roWJ/XFtwAEbghAH7KEHaAQztGTtsjY7fCvCPag==
X-Received: by 2002:a7b:ce86:0:b0:3f6:1c0:aa7a with SMTP id q6-20020a7bce86000000b003f601c0aa7amr1638075wmj.29.1685703094262;
        Fri, 02 Jun 2023 03:51:34 -0700 (PDT)
Received: from suse.localnet (host-79-23-99-244.retail.telecomitalia.it. [79.23.99.244])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm13556922wmb.2.2023.06.02.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:51:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Rename put_and_unmap_page() to unmap_and_put_page()
Date:   Fri, 02 Jun 2023 12:51:31 +0200
Message-ID: <4859757.31r3eYUQgx@suse>
In-Reply-To: <20230601132317.13606-1-fmdefrancesco@gmail.com>
References: <20230601132317.13606-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 1 giugno 2023 15:23:17 CEST Fabio M. De Francesco wrote:
> With commit 849ad04cf562a ("new helper: put_and_unmap_page()"), Al Viro
> introduced the put_and_unmap_page() to use in those many places where we
> have a common pattern consisting of calls to kunmap_local() +
> put_page().
>=20
> Obviously, first we unmap and then we put pages. Instead, the original
> name of this helper seems to imply that we first put and then unmap.
>=20
> Therefore, rename the helper and change the only known upstreamed user
> (i.e., fs/sysv) before this helper enters common use and might become
> difficult to find all call sites and break the Kernel builds.
>=20
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> This is an RFC=20

Please discard this RFC.

I just sent the real patch at
https://lore.kernel.org/linux-fsdevel/20230602103307.5637-1-fmdefrancesco@g=
mail.com/T/#u

and added linux-mm to the list of recipients.

Thanks,

=46abio

> because I'm pretty sure that Al must have been a good
> reason to use this counter intuitive name for his helper. I'm not
> probably aware of some obscure helpers names convention.
>=20
> Furthermore, I know that Al's VFS tree has already used this helper at
> least in fs/minix and probably in other filesystems.
>=20
> Therefore I didn't want to send a "real" patch.
>=20
> I'm looking forward to hearing from people involved with fs and
> especially from Al before sending a real patch or throwing it away.
>=20
>  fs/sysv/dir.c           | 22 +++++++++++-----------
>  fs/sysv/namei.c         |  8 ++++----
>  include/linux/highmem.h |  2 +-
>  3 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
> index cdb3d632c63d..d6a3bbb550c3 100644
> --- a/fs/sysv/dir.c
> +++ b/fs/sysv/dir.c
> @@ -52,7 +52,7 @@ static int sysv_handle_dirsync(struct inode *dir)
>  }
>=20
>  /*
> - * Calls to dir_get_page()/put_and_unmap_page() must be nested according=
 to
> the + * Calls to dir_get_page()/unmap_and_put_page() must be nested=20
according
> to the * rules documented in mm/highmem.rst.
>   *
>   * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_pag=
e()
> @@ -103,11 +103,11 @@ static int sysv_readdir(struct file *file, struct
> dir_context *ctx) if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
>  					fs16_to_cpu(SYSV_SB(sb), de-
>inode),
>  					DT_UNKNOWN)) {
> -				put_and_unmap_page(page, kaddr);
> +				unmap_and_put_page(page, kaddr);
>  				return 0;
>  			}
>  		}
> -		put_and_unmap_page(page, kaddr);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -131,7 +131,7 @@ static inline int namecompare(int len, int maxlen,
>   * itself (as a parameter - res_dir). It does NOT read the inode of the
>   * entry - you'll have to do that yourself if you want to.
>   *
> - * On Success put_and_unmap_page() should be called on *res_page.
> + * On Success unmap_iand_put_page() should be called on *res_page.
>   *
>   * sysv_find_entry() acts as a call to dir_get_page() and must be treated
>   * accordingly for nesting purposes.
> @@ -166,7 +166,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry
> *dentry, struct page **res_ name, de->name))
>  					goto found;
>  			}
> -			put_and_unmap_page(page, kaddr);
> +			unmap_and_put_page(page, kaddr);
>  		}
>=20
>  		if (++n >=3D npages)
> @@ -209,7 +209,7 @@ int sysv_add_link(struct dentry *dentry, struct inode
> *inode) goto out_page;
>  			de++;
>  		}
> -		put_and_unmap_page(page, kaddr);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	BUG();
>  	return -EINVAL;
> @@ -228,7 +228,7 @@ int sysv_add_link(struct dentry *dentry, struct inode
> *inode) mark_inode_dirty(dir);
>  	err =3D sysv_handle_dirsync(dir);
>  out_page:
> -	put_and_unmap_page(page, kaddr);
> +	unmap_and_put_page(page, kaddr);
>  	return err;
>  out_unlock:
>  	unlock_page(page);
> @@ -321,12 +321,12 @@ int sysv_empty_dir(struct inode * inode)
>  			if (de->name[1] !=3D '.' || de->name[2])
>  				goto not_empty;
>  		}
> -		put_and_unmap_page(page, kaddr);
> +		unmap_and_put_page(page, kaddr);
>  	}
>  	return 1;
>=20
>  not_empty:
> -	put_and_unmap_page(page, kaddr);
> +	unmap_iand_put_page(page, kaddr);
>  	return 0;
>  }
>=20
> @@ -352,7 +352,7 @@ int sysv_set_link(struct sysv_dir_entry *de, struct p=
age
> *page, }
>=20
>  /*
> - * Calls to dir_get_page()/put_and_unmap_page() must be nested according=
 to
> the + * Calls to dir_get_page()/unmap_and_put_page() must be nested=20
according
> to the * rules documented in mm/highmem.rst.
>   *
>   * sysv_dotdot() acts as a call to dir_get_page() and must be treated
> @@ -376,7 +376,7 @@ ino_t sysv_inode_by_name(struct dentry *dentry)
>=20
>  	if (de) {
>  		res =3D fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
> -		put_and_unmap_page(page, de);
> +		unmap_and_put_page(page, de);
>  	}
>  	return res;
>  }
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> index 2b2dba4c4f56..fcf163fea3ad 100644
> --- a/fs/sysv/namei.c
> +++ b/fs/sysv/namei.c
> @@ -164,7 +164,7 @@ static int sysv_unlink(struct inode * dir, struct den=
try=20
*
> dentry) inode->i_ctime =3D dir->i_ctime;
>  		inode_dec_link_count(inode);
>  	}
> -	put_and_unmap_page(page, de);
> +	unmap_and_put_page(page, de);
>  	return err;
>  }
>=20
> @@ -227,7 +227,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct
> inode *old_dir, if (!new_de)
>  			goto out_dir;
>  		err =3D sysv_set_link(new_de, new_page, old_inode);
> -		put_and_unmap_page(new_page, new_de);
> +		unmap_and_put_page(new_page, new_de);
>  		if (err)
>  			goto out_dir;
>  		new_inode->i_ctime =3D current_time(new_inode);
> @@ -256,9 +256,9 @@ static int sysv_rename(struct mnt_idmap *idmap, struct
> inode *old_dir,
>=20
>  out_dir:
>  	if (dir_de)
> -		put_and_unmap_page(dir_page, dir_de);
> +		unmap_and_put_page(dir_page, dir_de);
>  out_old:
> -	put_and_unmap_page(old_page, old_de);
> +	unmap_and_put_page(old_page, old_de);
>  out:
>  	return err;
>  }
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 4de1dbcd3ef6..68da30625a6c 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -507,7 +507,7 @@ static inline void folio_zero_range(struct folio *fol=
io,
>  	zero_user_segments(&folio->page, start, start + length, 0, 0);
>  }
>=20
> -static inline void put_and_unmap_page(struct page *page, void *addr)
> +static inline void unmap_and_put_page(struct page *page, void *addr)
>  {
>  	kunmap_local(addr);
>  	put_page(page);
> --
> 2.40.1



