Return-Path: <linux-fsdevel+bounces-28408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B4296A0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E029B1F2237B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21E1F937;
	Tue,  3 Sep 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo/1koHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232513D278;
	Tue,  3 Sep 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374430; cv=none; b=ftRGO+i7+Pg9PVShuoSSxgcJD4kN+Yi3Mk/q15cu+S0Pltc2gInTYmmxUR6IqbiVZVQA2Q6/K3m1XILNE8Nxjm6+nmd1HsLs5K0iT14u8qRK5iLIfoPCN/RxZwaFQSVEMHmDPEGQ40kjF0r4zIxI1cwP62yPDz2NnWvJfyeqZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374430; c=relaxed/simple;
	bh=nN3Oad2MShm7iw41e7lEUXNxvnPVyXpBrnxL4+zRq+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pne30H1VzT6MaZQ4RVa4KuynCXxdm7TrgFvDiM3KCmAmDsqTUSAvQ0e1MXAY44gnVW6k7+b8YvxlZQ6MPQ43KXfH7ZhwQ34oYi7Qk6WeRLDpFk6RXXwnClkKvD6TFjswWh/jHPtnx+1Q6YC+WAcibcoBKTGvCKujLuLveG8E6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo/1koHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D625C4CEC4;
	Tue,  3 Sep 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374430;
	bh=nN3Oad2MShm7iw41e7lEUXNxvnPVyXpBrnxL4+zRq+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jo/1koHaZZsmaEZgpU5KggR0M0hBaFApgbASdeHXkXQ5KLeOGAhjAscFoy5FmYzbt
	 XD9ryXxqR9FOd0ykHuqJdZLcyoc564iZZWbdTfTZc44NysV4YyWJkNO63yoJzZqQq/
	 C4GsKk102Jc7KZdvSURig3MtDWS9rZxUC2lzrIixszIgGFKPv0ijGwSXEuruFBBYbc
	 WqbQjasdq5Lb/2gX3ciUmuPi5jcPLWZhAqrICH2hwrzaEvSQ4x2fm2OZwZ+p1C9euO
	 dbReu1pIscDZ01E9qNpFX2OWsPMavIPqTJO+IOE2X5bq0aOcNDU1CYI3I/aivsMdm1
	 PTfRwzq+pJvTQ==
Message-ID: <cd02bbdc0059afaff52d0aab1da0ecf91d101a0a.camel@kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, Trond
 Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Tue, 03 Sep 2024 10:40:28 -0400
In-Reply-To: <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
References: <20240831223755.8569-1-snitzer@kernel.org>
	 <20240831223755.8569-17-snitzer@kernel.org>
	 <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
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
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 10:34 -0400, Chuck Lever wrote:
> On Sat, Aug 31, 2024 at 06:37:36PM -0400, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> >=20
> > Add server support for bypassing NFS for localhost reads, writes, and
> > commits. This is only useful when both the client and server are
> > running on the same host.
> >=20
> > If nfsd_open_local_fh() fails then the NFS client will both retry and
> > fallback to normal network-based read, write and commit operations if
> > localio is no longer supported.
> >=20
> > Care is taken to ensure the same NFS security mechanisms are used
> > (authentication, etc) regardless of whether localio or regular NFS
> > access is used.  The auth_domain established as part of the traditional
> > NFS client access to the NFS server is also used for localio.  Store
> > auth_domain for localio in nfsd_uuid_t and transfer it to the client
> > if it is local to the server.
> >=20
> > Relative to containers, localio gives the client access to the network
> > namespace the server has.  This is required to allow the client to
> > access the server's per-namespace nfsd_net struct.
> >=20
> > This commit also introduces the use of NFSD's percpu_ref to interlock
> > nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> > not destroyed while in use by nfsd_open_local_fh and other LOCALIO
> > client code.
> >=20
> > CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.
> >=20
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Co-developed-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> >=20
> > Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/Makefile           |   1 +
> >  fs/nfsd/filecache.c        |   2 +-
> >  fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/netns.h            |   4 ++
> >  fs/nfsd/nfsctl.c           |  25 ++++++++-
> >  fs/nfsd/trace.h            |   3 +-
> >  fs/nfsd/vfs.h              |   2 +
> >  include/linux/nfslocalio.h |   8 +++
> >  8 files changed, 154 insertions(+), 3 deletions(-)
> >  create mode 100644 fs/nfsd/localio.c
> >=20
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index b8736a82e57c..18cbd3fa7691 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayou=
txdr.o
> > +nfsd-$(CONFIG_NFS_LOCALIO) +=3D localio.o
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 89ff380ec31e..348c1b97092e 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -52,7 +52,7 @@
> >  #define NFSD_FILE_CACHE_UP		     (0)
> > =20
> >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCA=
LIO)
> > =20
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > new file mode 100644
> > index 000000000000..75df709c6903
> > --- /dev/null
> > +++ b/fs/nfsd/localio.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NFS server support for local clients to bypass network stack
> > + *
> > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com=
>
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> > + */
> > +
> > +#include <linux/exportfs.h>
> > +#include <linux/sunrpc/svcauth.h>
> > +#include <linux/sunrpc/clnt.h>
> > +#include <linux/nfs.h>
> > +#include <linux/nfs_common.h>
> > +#include <linux/nfslocalio.h>
> > +#include <linux/string.h>
> > +
> > +#include "nfsd.h"
> > +#include "vfs.h"
> > +#include "netns.h"
> > +#include "filecache.h"
> > +
> > +static const struct nfsd_localio_operations nfsd_localio_ops =3D {
> > +	.nfsd_open_local_fh =3D nfsd_open_local_fh,
> > +	.nfsd_file_put_local =3D nfsd_file_put_local,
> > +	.nfsd_file_file =3D nfsd_file_file,
> > +};
> > +
> > +void nfsd_localio_ops_init(void)
> > +{
> > +	memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
> > +}
>=20
> Same comment as Neil: this should surface a pointer to the
> localio_ops struct. Copying the whole set of function pointers is
> generally unnecessary.
>=20
>=20
> > +
> > +/**
> > + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to n=
fsd_file
> > + *
> > + * @uuid: nfs_uuid_t which provides the 'struct net' to get the proper=
 nfsd_net
> > + *        and the 'struct auth_domain' required for LOCALIO access
> > + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr =
and cred
> > + * @cred: cred that the client established
> > + * @nfs_fh: filehandle to lookup
> > + * @fmode: fmode_t to use for open
> > + *
> > + * This function maps a local fh to a path on a local filesystem.
> > + * This is useful when the nfs client has the local server mounted - i=
t can
> > + * avoid all the NFS overhead with reads, writes and commits.
> > + *
> > + * On successful return, returned nfsd_file will have its nf_net membe=
r
> > + * set. Caller (NFS client) is responsible for calling nfsd_serv_put a=
nd
> > + * nfsd_file_put (via nfs_to.nfsd_file_put_local).
> > + */
> > +struct nfsd_file *
> > +nfsd_open_local_fh(nfs_uuid_t *uuid,
> > +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > +	__must_hold(rcu)
> > +{
> > +	int mayflags =3D NFSD_MAY_LOCALIO;
> > +	struct nfsd_net *nn =3D NULL;
> > +	struct net *net;
> > +	struct svc_cred rq_cred;
> > +	struct svc_fh fh;
> > +	struct nfsd_file *localio;
> > +	__be32 beres;
> > +
> > +	if (nfs_fh->size > NFS4_FHSIZE)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	/*
> > +	 * Not running in nfsd context, so must safely get reference on nfsd_=
serv.
> > +	 * But the server may already be shutting down, if so disallow new lo=
calio.
> > +	 * uuid->net is NOT a counted reference, but caller's rcu_read_lock()=
 ensures
> > +	 * that if uuid->net is not NULL, then calling nfsd_serv_try_get() is=
 safe
> > +	 * and if it succeeds we will have an implied reference to the net.
> > +	 */
> > +	net =3D rcu_dereference(uuid->net);
> > +	if (net)
> > +		nn =3D net_generic(net, nfsd_net_id);
> > +	if (unlikely(!nn || !nfsd_serv_try_get(nn)))
> > +		return ERR_PTR(-ENXIO);
> > +
> > +	/* Drop the rcu lock for nfsd_file_acquire_local() */
> > +	rcu_read_unlock();
>=20
> I'm struggling with the locking logistics. Caller takes the RCU read
> lock, this function drops the lock, then takes it again. So:
>=20
>  - A caller might rely on the lock being held continuously, but
>  - The API contract documented above doesn't indicate that this
>    function drops that lock
>  - The __must_hold(rcu) annotation doesn't indicate that this
>    function drops that lock, IIUC
>=20
> Dropping and retaking the lock in here is an anti-pattern that
> should be avoided. I suggest we are better off in the long run if
> the caller does not need to take the RCU read lock, but instead,
> nfsd_open_local_fh takes it right here just for the rcu_dereference.
>=20
> OTOH, Why drop the lock before calling nfsd_file_acquire_local()?
> The RCU read lock can safely be taken more than once in succession.
>=20
> Let's rethink the locking strategy.
>=20


Agreed. The only caller does this:

        rcu_read_lock();
        if (!rcu_access_pointer(uuid->net)) {
                rcu_read_unlock();
                return ERR_PTR(-ENXIO);
        }
        localio =3D nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
                                            nfs_fh, fmode);
        rcu_read_unlock();

Maybe just move the check for uuid->net down into nfsd_open_local_fh,
and it can acquire the rcu_read_lock for itself?

>=20
> > +
> > +	/* nfs_fh -> svc_fh */
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size =3D nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |=3D NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |=3D NFSD_MAY_WRITE;
> > +
> > +	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> > +
> > +	beres =3D nfsd_file_acquire_local(uuid->net, &rq_cred, uuid->dom,
> > +					&fh, mayflags, &localio);
> > +	if (beres) {
> > +		localio =3D ERR_PTR(nfs_stat_to_errno(be32_to_cpu(beres)));
> > +		nfsd_serv_put(nn);
> > +	}
> > +
> > +	fh_put(&fh);
> > +	if (rq_cred.cr_group_info)
> > +		put_group_info(rq_cred.cr_group_info);
> > +
> > +	rcu_read_lock();
> > +	return localio;
> > +}
> > +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index e2d953f21dde..0fd31188a951 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -216,6 +216,10 @@ struct nfsd_net {
> >  	/* last time an admin-revoke happened for NFSv4.0 */
> >  	time64_t		nfs40_last_revoke;
> > =20
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	/* Local clients to be invalidated when net is shut down */
> > +	struct list_head	local_clients;
> > +#endif
> >  };
> > =20
> >  /* Simple check to find out if a given net was properly initialized */
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 64c1b4d649bc..3adbc05ebaac 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/sunrpc/svc.h>
> >  #include <linux/module.h>
> >  #include <linux/fsnotify.h>
> > +#include <linux/nfslocalio.h>
> > =20
> >  #include "idmap.h"
> >  #include "nfsd.h"
> > @@ -2257,7 +2258,9 @@ static __net_init int nfsd_net_init(struct net *n=
et)
> >  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> >  	seqlock_init(&nn->writeverf_lock);
> >  	nfsd_proc_stat_init(net);
> > -
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	INIT_LIST_HEAD(&nn->local_clients);
> > +#endif
> >  	return 0;
> > =20
> >  out_repcache_error:
> > @@ -2268,6 +2271,22 @@ static __net_init int nfsd_net_init(struct net *=
net)
> >  	return retval;
> >  }
> > =20
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +/**
> > + * nfsd_net_pre_exit - Disconnect localio clients from net namespace
> > + * @net: a network namespace that is about to be destroyed
> > + *
> > + * This invalidated ->net pointers held by localio clients
> > + * while they can still safely access nn->counter.
> > + */
> > +static __net_exit void nfsd_net_pre_exit(struct net *net)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +
> > +	nfs_uuid_invalidate_clients(&nn->local_clients);
> > +}
> > +#endif
> > +
> >  /**
> >   * nfsd_net_exit - Release the nfsd_net portion of a net namespace
> >   * @net: a network namespace that is about to be destroyed
> > @@ -2285,6 +2304,9 @@ static __net_exit void nfsd_net_exit(struct net *=
net)
> > =20
> >  static struct pernet_operations nfsd_net_ops =3D {
> >  	.init =3D nfsd_net_init,
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +	.pre_exit =3D nfsd_net_pre_exit,
> > +#endif
> >  	.exit =3D nfsd_net_exit,
> >  	.id   =3D &nfsd_net_id,
> >  	.size =3D sizeof(struct nfsd_net),
> > @@ -2322,6 +2344,7 @@ static int __init init_nfsd(void)
> >  	retval =3D genl_register_family(&nfsd_nl_family);
> >  	if (retval)
> >  		goto out_free_all;
> > +	nfsd_localio_ops_init();
> > =20
> >  	return 0;
> >  out_free_all:
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index d22027e23761..82bcefcd1f21 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> >  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
> >  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> >  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> > -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> > +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> > +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> > =20
> >  TRACE_EVENT(nfsd_compound,
> >  	TP_PROTO(
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 01947561d375..3ff146522556 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -33,6 +33,8 @@
> > =20
> >  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >=
=3D NFSv3 */
> > =20
> > +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio=
 used */
> > +
> >  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> >  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> > =20
> > diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> > index 62419c4bc8f1..61f2c781dd50 100644
> > --- a/include/linux/nfslocalio.h
> > +++ b/include/linux/nfslocalio.h
> > @@ -6,6 +6,8 @@
> >  #ifndef __LINUX_NFSLOCALIO_H
> >  #define __LINUX_NFSLOCALIO_H
> > =20
> > +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > +
> >  #include <linux/module.h>
> >  #include <linux/list.h>
> >  #include <linux/uuid.h>
> > @@ -63,4 +65,10 @@ struct nfsd_localio_operations {
> >  extern void nfsd_localio_ops_init(void);
> >  extern struct nfsd_localio_operations nfs_to;
> > =20
> > +#else   /* CONFIG_NFS_LOCALIO */
> > +static inline void nfsd_localio_ops_init(void)
> > +{
> > +}
> > +#endif  /* CONFIG_NFS_LOCALIO */
> > +
> >  #endif  /* __LINUX_NFSLOCALIO_H */
> > --=20
> > 2.44.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

