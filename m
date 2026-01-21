Return-Path: <linux-fsdevel+bounces-74847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDMUClXCcGnzZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:11:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC53568DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5CE174C8D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DC40B6FF;
	Wed, 21 Jan 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7pt8lYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93793D3496;
	Wed, 21 Jan 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996591; cv=none; b=Cn28S/BT4p7k5Mj0YnQ2exklCNOCU9NqMz7a8HADJqMu9MOtDWPJsjRpVkAgTJeVkd6LZ7QVVvdASsoa+nwi/3EPRX0Z9ekSrcYiPn2dJist6hJjSCJ4Z6NizseKkCnjXjeDZKlANODAWr9FEGCdGcs3suW/G6DPglxhFIrYqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996591; c=relaxed/simple;
	bh=s/nN+L4tO0ReDIA8U1XnXBFUBSeAf8wqtBg+Qg7q5K4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PtUuTg+KZTCP5o6ILkJ4bcP1rrFUC2sJZDnwRkOOl3tJcE0fmRkJRLgeQMSjfra3INA4fXSR6Pp7h9UI8HzB7EfqelYGA6FTvXaQ4nPrVAjR5viV9453dOW4DtMpAa+mq+KvPNgl1K7c835DndQIf6yaRoeWymHfUfFB5Y41/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7pt8lYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66C2C116D0;
	Wed, 21 Jan 2026 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768996590;
	bh=s/nN+L4tO0ReDIA8U1XnXBFUBSeAf8wqtBg+Qg7q5K4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o7pt8lYKcUwkZvaQYgMOv1MWde4CBIVwy9O43WuDtOJkfnyhx+ILjgaeVDsOB+n90
	 Wzv3lDFAv2Yi2u489yNATguHULfFyCtdbQQ6tXlpv4795y7peYcCGAUVncgMrN5p3a
	 IxqDgkJQpFmkx63hA1fZV6u1Kcyew1+GSTlkgVnpzLn7uScpHcGW2vSaF60Q6y48CC
	 Jfic/yn5QBazLrPcnDuzuXeiu5nFNS1Itu4mHSga96VVOMKQI0UziTWm+ljaiesjOU
	 geoVzVwprwRYHhzxB9PrHzj9d6BcoiRGNR8Vk6s4aBGy7uWtGPTvI19A9Lm+XRweyG
	 j8vwsVKIsxu9Q==
Message-ID: <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig	
 <hch@infradead.org>, Amir Goldstein <amir73il@gmail.com>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Hugh Dickins	 <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger	
 <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang
 <xiang@kernel.org>,  Chao Yu <chao@kernel.org>, Yue Hu
 <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,  Sandeep
 Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai
 Guo <guochunhai@vivo.com>,  Carlos Maiolino	 <cem@kernel.org>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze	 <amarkuze@redhat.com>, Viacheslav
 Dubeyko <slava@dubeyko.com>, Chris Mason	 <clm@fb.com>, David Sterba
 <dsterba@suse.com>, Luis de Bethencourt	 <luisbg@kernel.org>, Salah Triki
 <salah.triki@gmail.com>, Phillip Lougher	 <phillip@squashfs.org.uk>, Steve
 French <sfrench@samba.org>, Paulo Alcantara	 <pc@manguebit.org>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N	
 <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, Miklos
 Szeredi	 <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, Martin
 Brandenburg	 <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel
 Becker	 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>,  Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, David
 Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan
 Kara <jack@suse.cz>,  Andreas Gruenbacher	 <agruenba@redhat.com>, OGAWA
 Hirofumi <hirofumi@mail.parknet.co.jp>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, 	ceph-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, 	devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 21 Jan 2026 06:56:22 -0500
In-Reply-To: <176896790525.16766.11792073987699294594@noble.neil.brown.name>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
	, <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
	, <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
	, <176877859306.16766.15009835437490907207@noble.neil.brown.name>
	, <aW3SAKIr_QsnEE5Q@infradead.org>
	, <176880736225.16766.4203157325432990313@noble.neil.brown.name>
	, <20260119-kanufahren-meerjungfrau-775048806544@brauner>
	, <176885553525.16766.291581709413217562@noble.neil.brown.name>
	, <20260120-entmilitarisieren-wanken-afd04b910897@brauner>
	, <176890211061.16766.16354247063052030403@noble.neil.brown.name>
	, <20260120-hacken-revision-88209121ac2c@brauner>
	, <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
	 <176896790525.16766.11792073987699294594@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74847-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AEC53568DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-01-21 at 14:58 +1100, NeilBrown wrote:
> On Tue, 20 Jan 2026, Jeff Layton wrote:
> > On Tue, 2026-01-20 at 11:31 +0100, Christian Brauner wrote:
> > > On Tue, Jan 20, 2026 at 08:41:50PM +1100, NeilBrown wrote:
> > > > On Tue, 20 Jan 2026, Christian Brauner wrote:
> > > > > On Tue, Jan 20, 2026 at 07:45:35AM +1100, NeilBrown wrote:
> > > > > > On Mon, 19 Jan 2026, Christian Brauner wrote:
> > > > > > > On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> > > > > > > > On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> > > > > > > > > On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote=
:
> > > > > > > > > > > This was Chuck's suggested name. His point was that S=
TABLE means that
> > > > > > > > > > > the FH's don't change during the lifetime of the file=
.
> > > > > > > > > > >=20
> > > > > > > > > > > I don't much care about the flag name, so if everyone=
 likes PERSISTENT
> > > > > > > > > > > better I'll roll with that.
> > > > > > > > > >=20
> > > > > > > > > > I don't like PERSISTENT.
> > > > > > > > > > I'd rather call a spade a spade.
> > > > > > > > > >=20
> > > > > > > > > >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > > > > > > > > > or
> > > > > > > > > >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > > > > > > > > >=20
> > > > > > > > > > The issue here is NFS export and indirection doesn't br=
ing any benefits.
> > > > > > > > >=20
> > > > > > > > > No, it absolutely is not.  And the whole concept of calli=
ng something
> > > > > > > > > after the initial or main use is a recipe for a mess.
> > > > > > > >=20
> > > > > > > > We are calling it for it's only use.  If there was ever ano=
ther use, we
> > > > > > > > could change the name if that made sense.  It is not a publ=
ic name, it
> > > > > > > > is easy to change.
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Pick a name that conveys what the flag is about, and docu=
ment those
> > > > > > > > > semantics well.  This flag is about the fact that for a g=
iven file,
> > > > > > > > > as long as that file exists in the file system the handle=
 is stable.
> > > > > > > > > Both stable and persistent are suitable for that, nfs is =
everything
> > > > > > > > > but.
> > > > > > > >=20
> > > > > > > > My understanding is that kernfs would not get the flag.
> > > > > > > > kernfs filehandles do not change as long as the file exist.
> > > > > > > > But this is not sufficient for the files to be usefully exp=
orted.
> > > > > > > >=20
> > > > > > > > I suspect kernfs does re-use filehandles relatively soon af=
ter the
> > > > > > > > file/object has been destroyed.  Maybe that is the real pro=
blem here:
> > > > > > > > filehandle reuse, not filehandle stability.
> > > > > > > >=20
> > > > > > > > Jeff: could you please give details (and preserve them in f=
uture cover
> > > > > > > > letters) of which filesystems are known to have problems an=
d what
> > > > > > > > exactly those problems are?
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Remember nfs also support volatile file handles, and othe=
r applications
> > > > > > > > > might rely on this (I know of quite a few user space appl=
ications that
> > > > > > > > > do, but they are kinda hardwired to xfs anyway).
> > > > > > > >=20
> > > > > > > > The NFS protocol supports volatile file handles.  knfsd doe=
s not.
> > > > > > > > So maybe
> > > > > > > >   EXPORT_OP_NOT_NFSD_COMPATIBLE
> > > > > > > > might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> > > > > > > > (I prefer opt-out rather than opt-in because nfsd export wa=
s the
> > > > > > > > original purpose of export_operations, but it isn't somethi=
ng
> > > > > > > > I would fight for)
> > > > > > >=20
> > > > > > > I prefer one of the variants you proposed here but I don't pa=
rticularly
> > > > > > > care. It's not a hill worth dying on. So if Christoph insists=
 on the
> > > > > > > other name then I say let's just go with it.
> > > > > > >=20
> > > > > >=20
> > > > > > This sounds like you are recommending that we give in to bullyi=
ng.
> > > > > > I would rather the decision be made based on the facts of the c=
ase, not
> > > > > > the opinions that are stated most bluntly.
> > > > > >=20
> > > > > > I actually think that what Christoph wants is actually quite di=
fferent
> > > > > > from what Jeff wants, and maybe two flags are needed.  But I do=
n't yet
> > > > > > have a clear understanding of what Christoph wants, so I cannot=
 be sure.
> > > > >=20
> > > > > I've tried to indirectly ask whether you would be willing to comp=
romise
> > > > > here or whether you want to insist on your alternative name. Appa=
rently
> > > > > that didn't come through.
> > > >=20
> > > > This would be the "not a hill worthy dying on" part of your stateme=
nt.
> > > > I think I see that implication now.
> > > > But no, I don't think compromise is relevant.  I think the problem
> > > > statement as originally given by Jeff is misleading, and people hav=
e
> > > > been misled to an incorrect name.
> > > >=20
> > > > >=20
> > > > > I'm unclear what your goal is in suggesting that I recommend "we"=
 give
> > > > > into bullying. All it achieved was to further derail this thread.
> > > > >=20
> > > >=20
> > > > The "We" is the same as the "us" in "let's just go with it".
> > > >=20
> > > >=20
> > > > > I also think it's not very helpful at v6 of the discussion to sta=
rt
> > > > > figuring out what the actual key rift between Jeff's and Christop=
h's
> > > > > position is. If you've figured it out and gotten an agreement and=
 this
> > > > > is already in, send a follow-up series.
> > > >=20
> > > > v6?  v2 was posted today.  But maybe you are referring the some oth=
er
> > > > precursors.
> > > >=20
> > > > The introductory statement in v2 is
> > > >=20
> > > >    This patchset adds a flag that indicates whether the filesystem =
supports
> > > >    stable filehandles (i.e. that they don't change over the life of=
 the
> > > >    file). It then makes any filesystem that doesn't set that flag
> > > >    ineligible for nfsd export.
> > > >=20
> > > > Nobody else questioned the validity of that.  I do.
> > > > No evidence was given that there are *any* filesystems that don't
> > > > support stable filehandles.  The only filesystem mentioned is cgrou=
ps
> > > > and it DOES provide stable filehandles.
> > >=20
> >=20
> > Across reboot? Not really.
>=20
> Across reboot all the files are deleted and then new ones are created.
> So there is nothing that needs to be stable.
>=20
> >=20
> > It's quite possible that we may end up with the same "id" numbers in
> > cgroupfs on a new incarnation of the filesystem after a reboot. The
> > files in there are not the same ones as the ones before, but their
> > filehandles may match because kernfs doesn't factor in an i_generation
> > number.
>=20
> That is is about filehandle re-use, not about filehandle stability.
>=20
> >=20
> > Could we fix it by adding a random i_generation value or something?
> > Possibly, but there really isn't a good use-case that I can see for
> > allowing cgroupfs to be exported via nfsd. Best to disallow it until
> > someone comes up with one.
>=20
> 100% agree.
>=20
> >=20
> > > Oh yes we did. And this is a merry-go-round.
> > >=20
> > > It is very much fine for a filesystems to support file handles withou=
t
> > > wanting to support exporting via NFS. That is especially true for
> > > in-kernel pseudo filesystems.
> > >=20
> > > As I've said before multiple times I want a way to allow filesystems
> > > such as pidfs and nsfs to use file handles without supporting export.
> > > Whatever that fscking flag is called at this point I fundamentally do=
n't
> > > care. And we are reliving the same arguments over and over.
> > >=20
> > > I will _hard NAK_ anything that starts mandating that export of
> > > filesystems must be allowed simply because their file handles fit exp=
ort
> > > criteria. I do not care whether pidfs or nsfs file handles fit the bi=
ll.
> > > They will not be exported.
> >=20
> > I don't really care what we call the flag. I do care a little about
> > what its semantics are, but the effect should be to ensure that fs
> > maintainers make a conscious decision about whether nfsd export should
> > be allowed on the filesystem.=C2=A0
>=20
> Why do you need a conscious decision so much that you want to try to
> force it.

As I said before, filesystems are growing export_operations for other
reasons than nfs export. I simply want to the fs maintainers to take a
conscious step to say "yes, this should be available via nfsd if it's
exported". Hopefully they'll also validate that it actually _works_
too.

> Of course we want conscious decisions and hope they are always made, but
> trying to manipulate people to doing things often fails.  How sure are
> you that fs developers won't just copy-paste some other implementation
> and not think about the implications of the flag?
>
> What is the down side?  What is the harm from allowing export (should the
> admin attempt it)?
> If there were serious security concerns - then sure, make it harder to
> do the dangerous thing.
> But if it is just "it doesn't make sense", then there is no harm in
> letting people get away with not reading the documentation, and fixing
> things later as complaints arrive.  That is generally how the process
> works.
>=20

Some of the more exotic filesystems could end up causing kernel panics
or something if exported when they haven't been validated to actually
work with nfsd. That's mostly FUD though -- I don't have any examples.

> But if you really really want to set this new flag on almost every
> export_operations, can I ask that you please set it on EVERY export
> operations, then allow maintainers to remove it as they see fit.
> I think that approach would be much easier to review.
>=20

We could probably do that, but I think the main ones that excludes it
are kernfs, pidfs and nsfs. ovl and fuse also have export ops in
certain modes that exclude NFS access, so the flag was left off of
those as well.

> With your current series it is non-trivial to determine which
> export_operations you have chosen not to set the flag on.  If you had
> one patch that set it everywhere, then individual patches to remove it,
> that would be a lot easier to review.

Noted. At this point I'm debating whether to pursue this further, or
just drop this for now until we can come to a better consensus. Maybe
we need a discussion about this at LSF?

--=20
Jeff Layton <jlayton@kernel.org>

