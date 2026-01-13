Return-Path: <linux-fsdevel+bounces-73441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E02D19727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658CA3047922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751F2BDC26;
	Tue, 13 Jan 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKOKD7zq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413B284682;
	Tue, 13 Jan 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314443; cv=none; b=gQDCop9I3/6jFWU3QrI2lmfwAFdN7Nc51wGlveE6kgNU2oYTj1OGpIwzqm8VcuzQCDOMFcbXR5UBs64O5Wn108MGF6AFulzYo9MCJxmRe//h7gBbmFEFIK82lMekTm+YuRJxkAcI3MYA3OAgZxr5stPXfuLtEI30cvJY+JzOBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314443; c=relaxed/simple;
	bh=voYb0DywiBp6FZyvGWnVpLV+F3/B5O4eT1B8kp+Veyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/b3YeK9yOXZJq/p6HiW0MKBIJGV1MmsGyDu7/mwUVyZerStxPSB/TQ7C+0VYuFU+Du9G1rE5V8bS3p7F5/lkkSa/7INKp+oppzCJ2qY8lnnoG473Lystzd/rOYxwOJpJC/AdrHbfbmsUjGBdSkcsDG1HfisylMJpJYUR649i3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKOKD7zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C53C116C6;
	Tue, 13 Jan 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768314443;
	bh=voYb0DywiBp6FZyvGWnVpLV+F3/B5O4eT1B8kp+Veyg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UKOKD7zq7ZENrVufNp/hM9Mf0esyBXwtSb1sraVHk7Kuw5JckEtlSzd4ownbobJ2a
	 Z6hXRiwc+r9lFFNguJyyzRISM+lnaXmTVbRwnM+g/OMPuuuDDH3+MLb2waHm+/zlZI
	 XGM8HcLNIcpQWROLZPkoKCcaAsdOF0maoXn+pjHKao6g/ryZpSURBrh8k3+NHno34A
	 Rhcj8av4r26P7UQZS7Ipu+vsshBmFzpjCfOuQPdiXfjb6dSx6DN201oYh/kJPONRvB
	 VM4kvbs0zqDEJqHusQNNJjr4AmHBhYOcEZfs5aY4qhISBIwfaX17P5qjKtI5qLJSn6
	 qFu6bkPuVOV8g==
Message-ID: <594043c04e431992f6585d7430b39cff2b770655.camel@kernel.org>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Christian Brauner
 <brauner@kernel.org>,  Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Salah
 Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Christoph
 Hellwig	 <hch@infradead.org>, Anders Larsen <al@alarsen.net>, Alexander
 Viro	 <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris
 Mason	 <clm@fb.com>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Yue Hu	 <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>, Sandeep Dhavale	 <dhavale@google.com>, Hongbo
 Li <lihongbo22@huawei.com>, Chunhai Guo	 <guochunhai@vivo.com>, Jan Kara
 <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA
 Hirofumi	 <hirofumi@mail.parknet.co.jp>, David Woodhouse
 <dwmw2@infradead.org>,  Richard Weinberger	 <richard@nod.at>, Dave Kleikamp
 <shaggy@kernel.org>, Ryusuke Konishi	 <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,  Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker	 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mike Marshall	 <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Miklos Szeredi	 <miklos@szeredi.hu>, Phillip Lougher
 <phillip@squashfs.org.uk>, Carlos Maiolino	 <cem@kernel.org>, Hugh Dickins
 <hughd@google.com>, Baolin Wang	 <baolin.wang@linux.alibaba.com>, Andrew
 Morton <akpm@linux-foundation.org>,  Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo	 <yuezhang.mo@sony.com>,
 Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher
 <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox
 (Oracle)"	 <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck	 <linux_oss@crudebyte.com>,
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov	 <idryomov@gmail.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker	 <anna@kernel.org>, Steve
 French <sfrench@samba.org>, Paulo Alcantara	 <pc@manguebit.org>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N	
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, 	devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, 	linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, gfs2@lists.linux.dev, 	linux-doc@vger.kernel.org,
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org
Date: Tue, 13 Jan 2026 09:27:14 -0500
In-Reply-To: <5809690c-bc87-4e66-9604-3f3ee58e2902@oracle.com>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
	 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
	 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
	 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
	 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
	 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
	 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
	 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
	 <4a38de737a64e9b32092ea1f8a25a61b33705034.camel@kernel.org>
	 <5809690c-bc87-4e66-9604-3f3ee58e2902@oracle.com>
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

On Tue, 2026-01-13 at 09:03 -0500, Chuck Lever wrote:
> On 1/13/26 6:45 AM, Jeff Layton wrote:
> > On Tue, 2026-01-13 at 09:54 +0100, Christian Brauner wrote:
> > > On Mon, Jan 12, 2026 at 09:50:20AM -0500, Jeff Layton wrote:
> > > > On Mon, 2026-01-12 at 09:31 -0500, Chuck Lever wrote:
> > > > > On 1/12/26 8:34 AM, Jeff Layton wrote:
> > > > > > On Fri, 2026-01-09 at 19:52 +0100, Amir Goldstein wrote:
> > > > > > > On Thu, Jan 8, 2026 at 7:57=E2=80=AFPM Jeff Layton <jlayton@k=
ernel.org> wrote:
> > > > > > > >=20
> > > > > > > > On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> > > > > > > > > On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > > > > > > > > > Yesterday, I sent patches to fix how directory delegati=
on support is
> > > > > > > > > > handled on filesystems where the should be disabled [1]=
. That set is
> > > > > > > > > > appropriate for v6.19. For v7.0, I want to make lease s=
upport be more
> > > > > > > > > > opt-in, rather than opt-out:
> > > > > > > > > >=20
> > > > > > > > > > For historical reasons, when ->setlease() file_operatio=
n is set to NULL,
> > > > > > > > > > the default is to use the kernel-internal lease impleme=
ntation. This
> > > > > > > > > > means that if you want to disable them, you need to exp=
licitly set the
> > > > > > > > > > ->setlease() file_operation to simple_nosetlease() or t=
he equivalent.
> > > > > > > > > >=20
> > > > > > > > > > This has caused a number of problems over the years as =
some filesystems
> > > > > > > > > > have inadvertantly allowed leases to be acquired simply=
 by having left
> > > > > > > > > > it set to NULL. It would be better if filesystems had t=
o opt-in to lease
> > > > > > > > > > support, particularly with the advent of directory dele=
gations.
> > > > > > > > > >=20
> > > > > > > > > > This series has sets the ->setlease() operation in a pi=
le of existing
> > > > > > > > > > local filesystems to generic_setlease() and then change=
s
> > > > > > > > > > kernel_setlease() to return -EINVAL when the setlease()=
 operation is not
> > > > > > > > > > set.
> > > > > > > > > >=20
> > > > > > > > > > With this change, new filesystems will need to explicit=
ly set the
> > > > > > > > > > ->setlease() operations in order to provide lease and d=
elegation
> > > > > > > > > > support.
> > > > > > > > > >=20
> > > > > > > > > > I mainly focused on filesystems that are NFS exportable=
, since NFS and
> > > > > > > > > > SMB are the main users of file leases, and they tend to=
 end up exporting
> > > > > > > > > > the same filesystem types. Let me know if I've missed a=
ny.
> > > > > > > > >=20
> > > > > > > > > So, what about kernfs and fuse? They seem to be exportabl=
e and don't have
> > > > > > > > > .setlease set...
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Yes, FUSE needs this too. I'll add a patch for that.
> > > > > > > >=20
> > > > > > > > As far as kernfs goes: AIUI, that's basically what sysfs an=
d resctrl
> > > > > > > > are built on. Do we really expect people to set leases ther=
e?
> > > > > > > >=20
> > > > > > > > I guess it's technically a regression since you could set t=
hem on those
> > > > > > > > sorts of files earlier, but people don't usually export ker=
nfs based
> > > > > > > > filesystems via NFS or SMB, and that seems like something t=
hat could be
> > > > > > > > used to make mischief.
> > > > > > > >=20
> > > > > > > > AFAICT, kernfs_export_ops is mostly to support open_by_hand=
le_at(). See
> > > > > > > > commit aa8188253474 ("kernfs: add exportfs operations").
> > > > > > > >=20
> > > > > > > > One idea: we could add a wrapper around generic_setlease() =
for
> > > > > > > > filesystems like this that will do a WARN_ONCE() and then c=
all
> > > > > > > > generic_setlease(). That would keep leases working on them =
but we might
> > > > > > > > get some reports that would tell us who's setting leases on=
 these files
> > > > > > > > and why.
> > > > > > >=20
> > > > > > > IMO, you are being too cautious, but whatever.
> > > > > > >=20
> > > > > > > It is not accurate that kernfs filesystems are NFS exportable=
 in general.
> > > > > > > Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
> > > > > > >=20
> > > > > > > If any application is using leases on cgroup files, it must b=
e some
> > > > > > > very advanced runtime (i.e. systemd), so we should know about=
 the
> > > > > > > regression sooner rather than later.
> > > > > > >=20
> > > > > >=20
> > > > > > I think so too. For now, I think I'll not bother with the WARN_=
ONCE().
> > > > > > Let's just leave kernfs out of the set until someone presents a=
 real
> > > > > > use-case.
> > > > > >=20
> > > > > > > There are also the recently added nsfs and pidfs export_opera=
tions.
> > > > > > >=20
> > > > > > > I have a recollection about wanting to be explicit about not =
allowing
> > > > > > > those to be exportable to NFS (nsfs specifically), but I can'=
t see where
> > > > > > > and if that restriction was done.
> > > > > > >=20
> > > > > > > Christian? Do you remember?
> > > > > > >=20
> > > > > >=20
> > > > > > (cc'ing Chuck)
> > > > > >=20
> > > > > > FWIW, you can currently export and mount /sys/fs/cgroup via NFS=
. The
> > > > > > directory doesn't show up when you try to get to it via NFSv4, =
but you
> > > > > > can mount it using v3 and READDIR works. The files are all empt=
y when
> > > > > > you try to read them. I didn't try to do any writes.
> > > > > >=20
> > > > > > Should we add a mechanism to prevent exporting these sorts of
> > > > > > filesystems?
> > > > > >=20
> > > > > > Even better would be to make nfsd exporting explicitly opt-in. =
What if
> > > > > > we were to add a EXPORT_OP_NFSD flag that explicitly allows fil=
esystems
> > > > > > to opt-in to NFS exporting, and check for that in __fh_verify()=
? We'd
> > > > > > have to add it to a bunch of existing filesystems, but that's f=
airly
> > > > > > simple to do with an LLM.
> > > > >=20
> > > > > What's the active harm in exporting /sys/fs/cgroup ? It has to be=
 done
> > > > > explicitly via /etc/exports, so this is under the NFS server admi=
n's
> > > > > control. Is it an attack surface?
> > > > >=20
> > > >=20
> > > > Potentially?
> > > >=20
> > > > I don't see any active harm with exporting cgroupfs. It doesn't wor=
k
> > > > right via nfsd, but it's not crashing the box or anything.
> > > >=20
> > > > At one time, those were only defined by filesystems that wanted to
> > > > allow NFS export. Now we've grown them on filesystems that just wan=
t to
> > > > provide filehandles for open_by_handle_at() and the like. nfsd does=
n't
> > > > care though: if the fs has export operations, it'll happily use the=
m.
> > > >=20
> > > > Having an explicit "I want to allow nfsd" flag see ms like it might
> > > > save us some headaches in the future when other filesystems add exp=
ort
> > > > ops for this sort of filehandle use.
> > >=20
> > > So we are re-hashing a discussion we had a few months ago (Amir was
> > > involved at least).
> > >=20
> >=20
> > Yep, I was lurking on it, but didn't have a lot of input at the time.
> >=20
> > > I don't think we want to expose cgroupfs via NFS that's super weird.
> > > It's like remote partial resource management and it would be very
> > > strange if a remote process suddenly would be able to move things aro=
und
> > > in the cgroup tree. So I would prefer to not do this.
> > >=20
> > > So my preference would be to really sever file handles from the expor=
t
> > > mechanism so that we can allow stuff like pidfs and nsfs and cgroupfs=
 to
> > > use file handles via name_to_handle_at() and open_by_handle_at() with=
out
> > > making them exportable.
> >=20
> > Agreed. I think we want to make NFS export be a deliberate opt-in
> > decision that filesystem developers make.
>=20
> No objection, what about ksmbd, AFS, or Ceph?
>=20

ksmbd doesn't have anything akin to an export_operations. I think it
really has to rely on admins getting the share paths right when
exporting. This is a bit simpler there though since SMB2 doesn't deal
with filehandles.

AFS and Ceph in the kernel are clients. AFS isn't reexportable via NFS,
but Ceph is. We'll need to preserve that ability.
--=20
Jeff Layton <jlayton@kernel.org>

