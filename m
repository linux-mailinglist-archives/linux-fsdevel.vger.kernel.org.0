Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E97101E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 23:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfD3VjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 17:39:09 -0400
Received: from kadath.azazel.net ([81.187.231.250]:60758 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfD3VjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:39:08 -0400
X-Greylist: delayed 1688 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 17:39:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yfnI1Lmce+A0N4KHmJXEkFUZ9CW+2IDNBr8KfdOaAKc=; b=bZJot5O0njqxdKFPW4gyGGEA/B
        pUQp1Zg6kmozGZMpsraGKct+ykCHZZttpwdG6W0sXWMlLhBLiOtZNd89w5FUAIrWsZtTqRrDd0Cvp
        5owI93PTAMh0kzmKuvMOW+hg5fPl1eheZvKR8NStbY/+/EmdaIv/gWeqRkVI/xBRldW6IoG57J8NP
        uV/K6WjHvPDWNe3dxgd+bpcDbRPOk5lSYFuPtFo84LHq4oXCH+4GKh4JjUDCgXbZC7RNflOtlbfFK
        LLfbGf1Yk5+UXSGt/5ovwkPfjpNlijnlt8nWEd/1FBK8AO1Q2CU8Cg06T8Oxtbdvu/Mqv+syVDQHQ
        0QVGXsFA==;
Received: from celephais.dreamlands ([192.168.96.3] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jeremy@azazel.net>)
        id 1hLa1P-0007XH-Vb; Tue, 30 Apr 2019 22:10:40 +0100
Date:   Tue, 30 Apr 2019 22:10:38 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, jaegeuk@kernel.org,
        yuchao0@huawei.com, hch@infradead.org
Subject: Re: [PATCH V2 03/13] fsverity: Add call back to decide if verity
 check has to be performed
Message-ID: <20190430211037.GA30337@azazel.net>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-4-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20190428043121.30925-4-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 192.168.96.3
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-04-28, at 10:01:11 +0530, Chandan Rajendra wrote:
> Ext4 and F2FS store verity metadata in data extents (beyond
> inode->i_size) associated with a file. But other filesystems might
> choose alternative means to store verity metadata. Hence this commit
> adds a callback function pointer to 'struct fsverity_operations' to
> help in deciding if verity operation needs to performed against a
> page-cache page holding file data.
>=20
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/ext4/super.c          | 6 ++++++
>  fs/f2fs/super.c          | 6 ++++++
>  fs/read_callbacks.c      | 4 +++-
>  include/linux/fsverity.h | 1 +
>  4 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index aba724f82cc3..63d73b360f1d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1428,10 +1428,16 @@ static struct page *ext4_read_verity_metadata_pag=
e(struct inode *inode,
>  	return read_mapping_page(inode->i_mapping, index, NULL);
>  }
> =20
> +static bool ext4_verity_required(struct inode *inode, pgoff_t index)
> +{
> +	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +}
> +
>  static const struct fsverity_operations ext4_verityops =3D {
>  	.set_verity		=3D ext4_set_verity,
>  	.get_metadata_end	=3D ext4_get_verity_metadata_end,
>  	.read_metadata_page	=3D ext4_read_verity_metadata_page,
> +	.verity_required	=3D ext4_verity_required,
>  };
>  #endif /* CONFIG_FS_VERITY */
> =20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2f75f06c784a..cd1299e1f92d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2257,10 +2257,16 @@ static struct page *f2fs_read_verity_metadata_pag=
e(struct inode *inode,
>  	return read_mapping_page(inode->i_mapping, index, NULL);
>  }
> =20
> +static bool f2fs_verity_required(struct inode *inode, pgoff_t index)
> +{
> +	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +}
> +
>  static const struct fsverity_operations f2fs_verityops =3D {
>  	.set_verity		=3D f2fs_set_verity,
>  	.get_metadata_end	=3D f2fs_get_verity_metadata_end,
>  	.read_metadata_page	=3D f2fs_read_verity_metadata_page,
> +	.verity_required	=3D f2fs_verity_required,
>  };
>  #endif /* CONFIG_FS_VERITY */
> =20
> diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> index b6d5b95e67d7..6dea54b0baa9 100644
> --- a/fs/read_callbacks.c
> +++ b/fs/read_callbacks.c
> @@ -86,7 +86,9 @@ struct read_callbacks_ctx *get_read_callbacks_ctx(struc=
t inode *inode,
>  		read_callbacks_steps |=3D 1 << STEP_DECRYPT;
>  #ifdef CONFIG_FS_VERITY
>  	if (inode->i_verity_info !=3D NULL &&
> -		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> +		((inode->i_sb->s_vop->verity_required
> +			&& inode->i_sb->s_vop->verity_required(inode, index))
> +			|| (inode->i_sb->s_vop->verity_required =3D=3D NULL)))

I think this is a bit easier to follow:

		(inode->i_sb->s_vop->verity_required =3D=3D NULL ||=20
			inode->i_sb->s_vop->verity_required(inode, index)))

>  		read_callbacks_steps |=3D 1 << STEP_VERITY;
>  #endif
>  	if (read_callbacks_steps) {
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 7c33b42abf1b..b83712d6c79a 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -18,6 +18,7 @@ struct fsverity_operations {
>  	int (*set_verity)(struct inode *inode, loff_t data_i_size);
>  	int (*get_metadata_end)(struct inode *inode, loff_t *metadata_end_ret);
>  	struct page *(*read_metadata_page)(struct inode *inode, pgoff_t index);
> +	bool (*verity_required)(struct inode *inode, pgoff_t index);
>  };
> =20
>  #ifdef CONFIG_FS_VERITY
> --=20
> 2.19.1
>
>

J.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZ8d+2N/NBLDbUxIF0Z7UzfnX9sMFAlzIucUACgkQ0Z7UzfnX
9sOkXRAAs0l+X0JkJyKwhOumKmHaSj5HT2VmMeG/UIc6foqj7OA4MD54MqXai/i3
r5/wwc4chDGkoFajjz44ENIrRuAbhYNL/obh0yqcE7GyxxuSREjqENvygKW7GlNZ
185SnNSWPoQeL77oniXnImvZPQ824TMU0LbAAON0RpGWaFc6hm0fFih5aEqBBM+i
O1kHDOV0rOoFT2edo4mSTZRNEAhbltznfgAKuIFRU6kay/tF6b6ie0Okev2XhzVu
e74YCPm31oGXTLecBjvnXI/zDxXIeyvxhNtEh33uK3+IDPrHTnbZOKJeMYha0Rf5
S+r+DQOB2wvLwjhFY2WAo9SKt7NMGjwrvXMvHj55SuyvCfva77uoshEwfEnJy6Ts
e+U39A5gG5/VSHJczktjx7wYGJMdCPPnE8abCAG3BnExPpJDQ2EPYfVtU2JAnioR
v05ULHyZoTB/qwVaay/RxptrHdkhAP2L3l+kYs6ZY0OsNqtBKIVy6EfbFkZuetyh
qbLsZurrkpmKaYsJQpKR2Yx8ih0Q37DRO9ejEh4BOiQimdGBRCmCYv5XeWDpHRlE
xl/T9mQjdKV4YXvZtddzYpG5lYtQHfBGqGw5pY2qjcta94hvsFTVNfB5cFMgKUAT
XoKPnH1IzjerW5Tz6qgPzpY44qIwOXaj6vFvIGdmUBrPH+dCIaE=
=U+NG
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
