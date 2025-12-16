Return-Path: <linux-fsdevel+bounces-71487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B4CC4DA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 19:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F01643039FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2946A33E362;
	Tue, 16 Dec 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="Uv3k/uM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F385B339B52;
	Tue, 16 Dec 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908853; cv=none; b=bNiCzT8NBeXYY3nGxAtU5X1PcybTNNUXZCmOnHQLYo2lQHGKIvS/Ja+7Sdu9gInLJBqyoUtqguGNZf4NBVa7nnOfhFEZ6YS0LbPDvr6JcMckVd8Xga6sNmqPGsAiVOCZmIRPE+LPI8krRuM8UpQk96/2ZL+AsxI9KHzLC5On1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908853; c=relaxed/simple;
	bh=b9AhQQflDubLSEkJ9VYXZBfb/K2hrR04XJ51g2a5Xbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0uOXaXCaM4cV+AR3ddpAEpQLozP4PxC8qEWhlfQWiBv5L1DrtuNH6ZXCp8CbRdR5LUVJwNjV4i2Kgvlc5QDs73wNMZG5Sv/OlxXcf9rVlc2Q9prLgKcM8+KO13GNYPxwLC/8myWiCUS1BOhk4toJN4XSSsYoILHUlWnSmpeGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=Uv3k/uM4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1765908837; x=1766513637; i=j.neuschaefer@gmx.net;
	bh=L8FQ2rgVLCdkD/oF0eHdo9FUsYW9diG97aFUGJ99iGw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Uv3k/uM42oIPhA/ZvpsLkiDMSos0h+YodmndgiX00sDnjeSmatTVNcmN8cOc1Pob
	 5w8k35zIaCjmyImzopDNfOdTzl4Q+Cez891p1HrnqdWdvCf8UUsYDJWfuwH9MfeP1
	 oQaB8G1OGjx7Agg8AfGJjufj9KySKghgkZHQgwHxLefMqCfTh7PxfUztsJ/8xjXGF
	 ygCw9DNzHRteol4H7LF1iSzWwy1yDtdTytXRThC2lbPJxsEupcy1sDE0xaBjqDEoD
	 wigarnoODsqMOifxgVI6Ddl0d7Cl9WawjqQ6IqBz208kYiOY7Y6iJnFnXqJSbPwH5
	 XtBCJ3/gxDFAeISqBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.209.246]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1vjaBE0Yyb-0070dz; Tue, 16
 Dec 2025 19:13:57 +0100
Date: Tue, 16 Dec 2025 19:13:56 +0100
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, miklos@szeredi.hu,
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net, carnil@debian.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-ID: <aUGhZM5pl8JKBGvR@probook>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251215030043.1431306-2-joannelkoong@gmail.com>
X-Provags-ID: V03:K1:2CwlOGn9Hl+M3/cVdNFnPEX6oSIqboEhfldkkQoVU/NHkdValS5
 m7OW2RgwykwP8c5uHHAfFrsqJ8uWwqKrVxoKo/A9ykHJ5Uc46MJzBw0L2GuRMJjqVMAFoRx
 /+1xiQXhpPQmIduaoaHFDhp0e2Ii9rAvHAIFGdJo0bJrLqj3aZmyeBpzcvCrLL3JewntUXO
 Yfzeu7f3FANVFg2foqpog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DjCyqchm0cc=;GX5yp3ip5mQdvDrNweDnQU0+V1F
 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

On Sun, Dec 14, 2025 at 07:00:43PM -0800, Joanne Koong wrote:
> Skip waiting on writeback for inodes that belong to mappings that do not
> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> mapping flag).
>=20
> This restores fuse back to prior behavior where syncs are no-ops. This
> is needed because otherwise, if a system is running a faulty fuse
> server that does not reply to issued write requests, this will cause
> wait_sb_inodes() to wait forever.
>=20
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal=
 rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> Reported-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

I can confirm that this patch fixes the issue I reported.
(Tested by applying it on top of v6.19-rc1)

Tested-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Thank you very much!


> ---
>  fs/fs-writeback.c       |  3 ++-
>  fs/fuse/file.c          |  4 +++-
>  include/linux/pagemap.h | 11 +++++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6800886c4d10..ab2e279ed3c2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
>  		 * do not have the mapping lock. Skip it here, wb completion
>  		 * will remove it.
>  		 */
> -		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> +		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> +		    mapping_no_data_integrity(mapping))
>  			continue;
> =20
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..3b2a171e652f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, un=
signed int flags)
> =20
>  	inode->i_fop =3D &fuse_file_operations;
>  	inode->i_data.a_ops =3D &fuse_file_aops;
> -	if (fc->writeback_cache)
> +	if (fc->writeback_cache) {
>  		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> +		mapping_set_no_data_integrity(&inode->i_data);
> +	}
> =20
>  	INIT_LIST_HEAD(&fi->write_files);
>  	INIT_LIST_HEAD(&fi->queued_writes);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31a848485ad9..ec442af3f886 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -210,6 +210,7 @@ enum mapping_flags {
>  	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM =3D 9,
>  	AS_KERNEL_FILE =3D 10,	/* mapping for a fake kernel file that shouldn'=
t
>  				   account usage to user cgroups */
> +	AS_NO_DATA_INTEGRITY =3D 11, /* no data integrity guarantees */
>  	/* Bits 16-25 are used for FOLIO_ORDER */
>  	AS_FOLIO_ORDER_BITS =3D 5,
>  	AS_FOLIO_ORDER_MIN =3D 16,
> @@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_o=
n_reclaim(const struct addres
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags)=
;
>  }
> =20
> +static inline void mapping_set_no_data_integrity(struct address_space *=
mapping)
> +{
> +	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
> +static inline bool mapping_no_data_integrity(const struct address_space=
 *mapping)
> +{
> +	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
> +}
> +
>  static inline gfp_t mapping_gfp_mask(const struct address_space *mappin=
g)
>  {
>  	return mapping->gfp_mask;
> --=20
> 2.47.3
>=20

