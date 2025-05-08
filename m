Return-Path: <linux-fsdevel+bounces-48433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87FBAAEFD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 02:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3521C2538D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F679F2;
	Thu,  8 May 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGSwcQHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD494A21;
	Thu,  8 May 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746662976; cv=none; b=gOvgE74hgQ5mw2UuXXBZaB1wzH/94nig/wbR7YlkjfKiNrZ4dvePBw1NhonQntA5qym3UP1dD+vjJnzJfS1RrV4XcwB0neqHGxT5yLD4IyWJDSGXAQ4l5/BTwuK/8BzXK6tvI6Td27T5/z0KCtmF0bHtAnSYWMHsUc8KFvPlyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746662976; c=relaxed/simple;
	bh=NBve6BMY1P8BZw3IMCI+r4WUbtxtXi2TNkbOJ38enF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTBEge2vzgSdunsEpurDjtM92aeIhg4a+N2JngfPm6UHZ7X3otafKFiN9oXQYrscKmTh9H0Z977NAxqFclkikf2TAU0Egbd+7M8tQm7HPY3DxtBZiCJN0RJDdU74PmVgLbXpj/JDmQ2V1o2lYt3c4VZaKFaMFBRmHIVSS9U7sMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGSwcQHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE04BC4CEE2;
	Thu,  8 May 2025 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746662975;
	bh=NBve6BMY1P8BZw3IMCI+r4WUbtxtXi2TNkbOJ38enF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZGSwcQHEGVF+cIKzUsmun1RKvQp3q61crwGPgiEKe5Fln/O8mVND42X1FqUK2sBJD
	 SRazYjXWB/VUrieAMQ4hOqGfrsoszqqyFFS21zgR/fa+ythQy5HCtuyDTmtLa0C/Nm
	 aqX+ZI5J0pEt8lXhEKYcK/QUHXDWyTS1GhDYTOWVMYh+GrcLjvcjxdGlH6zws0wjPm
	 JRYFjXLHj8+pgH18/7dnaTBcr6PnRemGsvSu1EKoc2/NPBhPX6OfMKhsIWk47VVaCW
	 /kpOoMLPFRLgklQwozdvrm06wnOMFYp5NTuQwVYeVtoHlI/DP+vVrASH6PrZgTew/V
	 nNvhp9sbqZIWg==
Message-ID: <3c770b46f3dc5d4618d87b44158c4c5af00e3b3a.camel@kernel.org>
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, Chuck Lever	
 <chuck.lever@oracle.com>, Trond Myklebust <trondmy@hammerspace.com>, Jens
 Axboe	 <axboe@kernel.dk>, Chris Mason <clm@meta.com>, Anna Schumaker
 <anna@kernel.org>
Date: Wed, 07 May 2025 20:09:33 -0400
In-Reply-To: <aBvVltbDKdHXMtLL@kernel.org>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
	 <aBqNtfPwFBvQCgeT@dread.disaster.area>
	 <8039661b7a4c4f10452180372bd985c0440f1e1d.camel@kernel.org>
	 <aBrKbOoj4dgUvz8f@dread.disaster.area> <aBvVltbDKdHXMtLL@kernel.org>
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
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-07 at 17:50 -0400, Mike Snitzer wrote:
> Hey Dave,
>=20
> Thanks for providing your thoughts on all this.  More inlined below.
>=20
> On Wed, May 07, 2025 at 12:50:20PM +1000, Dave Chinner wrote:
> > On Tue, May 06, 2025 at 08:06:51PM -0400, Jeff Layton wrote:
> > > On Wed, 2025-05-07 at 08:31 +1000, Dave Chinner wrote:
> > > > On Tue, May 06, 2025 at 01:40:35PM -0400, Jeff Layton wrote:
> > > > > FYI I decided to try and get some numbers with Mike's RWF_DONTCAC=
HE
> > > > > patches for nfsd [1]. Those add a module param that make all read=
s and
> > > > > writes use RWF_DONTCACHE.
> > > > >=20
> > > > > I had one host that was running knfsd with an XFS export, and a s=
econd
> > > > > that was acting as NFS client. Both machines have tons of memory,=
 so
> > > > > pagecache utilization is irrelevant for this test.
> > > >=20
> > > > Does RWF_DONTCACHE result in server side STABLE write requests from
> > > > the NFS client, or are they still unstable and require a post-write
> > > > completion COMMIT operation from the client to trigger server side
> > > > writeback before the client can discard the page cache?
> > > >=20
> > >=20
> > > The latter. I didn't change the client at all here (other than to all=
ow
> > > it to do bigger writes on the wire). It's just doing bog-standard
> > > buffered I/O. nfsd is adding RWF_DONTCACHE to every write via Mike's
> > > patch.
> >=20
> > Ok, that wasn't clear that it was only server side RWF_DONTCACHE.
> >=20
> > I have some more context from a different (internal) discussion
> > thread about how poorly the NFSD read side performs with
> > RWF_DONTCACHE compared to O_DIRECT. This is because there is massive
> > page allocator spin lock contention due to all the concurrent reads
> > being serviced.
>=20
> That discussion started with: its a very chaotic workload "read a
> bunch of large files that cause memory to be oversubscribed 2.5x
> across 8 servers".  Many knfsd threads (~240) per server handling 1MB
> IO to 8 XFS on NVMe.. (so 8 servers, each with 8 NVMe devices).
>=20
> For others' benefit here is the flamegraph for this heavy
> nfsd.nfsd_dontcache=3DY read workload as seen on 1 of the 8 servers:
> https://original.art/dontcache_read.svg
>=20
> Dave offered this additional analysis:
> "the flame graph indicates massive lock contention in the page
> allocator (i.e. on the page free lists). There's a chunk of time in
> data copying (copy_page_to_iter), but 70% of the CPU usage looks to be
> page allocator spinlock contention."
>=20
> All this causes RWF_DONTCACHE reads to be considerably slower than
> normal buffered reads (only getting 40-66% of normal buffered reads,
> worse read performance occurs when the system is less loaded).  How
> knfsd is handling the IO seems to be contributing to the 100% cpu
> usage.  If fio is used (with pvsync2 and uncached=3D1) directly to a
> single XFS then CPU is ~50%.
>=20
> (Jeff: not following why you were seeing EOPNOTSUPP for RWF_DONTCACHE
> reads, is that somehow due to the rsize/wsize patches from Chuck?
> RWF_DONTCACHE reads work with my patch you quoted as "[1]").
>=20

Possibly. I'm not sure either. I hit that error on reads with the
RWF_DONTCACHE enabled and decided to focus on writes for the moment.
I'll run it down when I get a chance.

> > The buffered write path locking is different, but I suspect
> > something similar is occurring and I'm going to ask you to confirm
> > it...
>=20

I started collecting perf traces today, but I'm having trouble getting
meaningful reports out of it. So, I'm working on it, but stay tuned.

> With knfsd to XFS on NVMe, favorable difference for RWF_DONTCACHE
> writes is that despite also seeing 100% CPU usage, due to lock
> contention et al, RWF_DONTCACHE does perform 0-54% better compared to
> normal buffered writes that exceed the system's memory by 2.5x
> (largest gains seen with most extreme load).
>=20
> Without RWF_DONTCACHE the system gets pushed to reclaim and the
> associated work really hurts.
>=20

That makes total sense. The boxes I've been testing on have gobs of
memory. The system never gets pushed into reclaim. It sounds like I
need to do some testing with small memory sizes (maybe in VMs).

> As tested with knfsd we've been generally unable to see the
> reduced CPU usage that is documented in Jens' commit headers:
>   for reads:  https://git.kernel.org/linus/8026e49bff9b
>   for writes: https://git.kernel.org/linus/d47c670061b5
> But as mentioned above, eliminating knfsd and testing XFS directly
> with fio does generally reflect what Jens documented.
>=20
> So more work needed to address knfsd RWF_DONTCACHE inefficiencies.
>=20

Agreed.

> > > > > I tested sequential writes using the fio-seq_write.fio test, both=
 with
> > > > > and without the module param enabled.
> > > > >=20
> > > > > These numbers are from one run each, but they were pretty stable =
over
> > > > > several runs:
> > > > >=20
> > > > > # fio /usr/share/doc/fio/examples/fio-seq-write.fio
> > > >=20
> > > > $ cat /usr/share/doc/fio/examples/fio-seq-write.fio
> > > > cat: /usr/share/doc/fio/examples/fio-seq-write.fio: No such file or=
 directory
> > > > $
> > > >=20
> > > > What are the fio control parameters of the IO you are doing? (e.g.
> > > > is this single threaded IO, does it use the psync, libaio or iourin=
g
> > > > engine, etc)
> > > >=20
> > >=20
> > >=20
> > > ; fio-seq-write.job for fiotest
> > >=20
> > > [global]
> > > name=3Dfio-seq-write
> > > filename=3Dfio-seq-write
> > > rw=3Dwrite
> > > bs=3D256K
> > > direct=3D0
> > > numjobs=3D1
> > > time_based
> > > runtime=3D900
> > >=20
> > > [file1]
> > > size=3D10G
> > > ioengine=3Dlibaio
> > > iodepth=3D16
> >=20
> > Ok, so we are doing AIO writes on the client side, so we have ~16
> > writes on the wire from the client at any given time.
>=20
> Jeff's workload is really underwhelming given he is operating well
> within available memory (so avoiding reclaim, etc).  As such this test
> is really not testing what RWF_DONTCACHE is meant to address (and to
> answer Chuck's question of "what do you hope to get from
> RWF_DONTCACHE?"): the ability to reach steady state where even if
> memory is oversubscribed the network pipes and NVMe devices are as
> close to 100% utilization as possible.
>=20

I'll see about setting up something more memory-constrained on the
server side. That would be more interesting for sure.

> > This also means they are likely not being received by the NFS server
> > in sequential order, and the NFS server is going to be processing
> > roughly 16 write RPCs to the same file concurrently using
> > RWF_DONTCACHE IO.
> >=20
> > These are not going to be exactly sequential - the server side IO
> > pattern to the filesystem is quasi-sequential, with random IOs being
> > out of order and leaving temporary holes in the file until the OO
> > write is processed.
> >=20
> > XFS should handle this fine via the speculative preallocation beyond
> > EOF that is triggered by extending writes (it was designed to
> > mitigate the fragmentation this NFS behaviour causes). However, we
> > should always keep in mind that while client side IO is sequential,
> > what the server is doing to the underlying filesystem needs to be
> > treated as "concurrent IO to a single file" rather than "sequential
> > IO".
>=20
> Hammerspace has definitely seen that 1MB IO coming off the wire is
> fragmented by the time it XFS issues it to underlying storage; so much
> so that IOPs bound devices (e.g. AWS devices that are capped at ~10K
> IOPs) are choking due to all the small IO.
>=20
> So yeah, minimizing the fragmentation is critical (and largely *not*
> solved at this point... hacks like sync mount from NFS client or using
> O_DIRECT at the client, which sets sync bit, helps reduce the
> fragmentation but as soon as you go full buffered the N=3D16+ IOs on the
> wire will fragment each other).
>=20
> Do you recommend any particular tuning to help XFS's speculative
> preallocation work for many competing "sequential" IO threads?  Like
> would having 32 AG allow for 32 speculative preallocation engines?  Or
> is it only possible to split across AG for different inodes?
> (Sorry, I really do aim to get more well-versed with XFS... its only
> been ~17 years that it has featured in IO stacks I've had to
> engineer, ugh...).
>=20
> > > > > wsize=3D1M:
> > > > >=20
> > > > > Normal:      WRITE: bw=3D1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/=
s (1084MB/s-1084MB/s), io=3D910GiB (977GB), run=3D901326-901326msec
> > > > > DONTCACHE:   WRITE: bw=3D649MiB/s (681MB/s), 649MiB/s-649MiB/s (6=
81MB/s-681MB/s), io=3D571GiB (613GB), run=3D900001-900001msec
> > > > >=20
> > > > > DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about =
30%
> > > > > slower. Memory consumption was down, but these boxes have oodles =
of
> > > > > memory, so I didn't notice much change there.
> > > >=20
> > > > So what is the IO pattern that the NFSD is sending to the underlyin=
g
> > > > XFS filesystem?
> > > >=20
> > > > Is it sending 1M RWF_DONTCACHE buffered IOs to XFS as well (i.e. on=
e
> > > > buffered write IO per NFS client write request), or is DONTCACHE
> > > > only being used on the NFS client side?
> > > >=20
> > >=20
> > > It's should be sequential I/O, though the writes would be coming in
> > > from different nfsd threads. nfsd just does standard buffered I/O. Th=
e
> > > WRITE handler calls nfsd_vfs_write(), which calls vfs_write_iter().
> > > With the module parameter enabled, it also adds RWF_DONTCACHE.
> >=20
> > Ok, so buffered writes (even with RWF_DONTCACHE) are not processed
> > concurrently by XFS - there's an exclusive lock on the inode that
> > will be serialising all the buffered write IO.
> >=20
> > Given that most of the work that XFS will be doing during the write
> > will not require releasing the CPU, there is a good chance that
> > there is spin contention on the i_rwsem from the 15 other write
> > waiters.
> >=20
> > That may be a contributing factor to poor performance, so kernel
> > profiles from the NFS server for both the normal buffered write path
> > as well as the RWF_DONTCACHE buffered write path. Having some idea
> > of the total CPU usage of the nfsds during the workload would also
> > be useful.
> >=20
> > > DONTCACHE is only being used on the server side. To be clear, the
> > > protocol doesn't support that flag (yet), so we have no way to projec=
t
> > > DONTCACHE from the client to the server (yet). This is just early
> > > exploration to see whether DONTCACHE offers any benefit to this
> > > workload.
> >=20
> > The nfs client largely aligns all of the page caceh based IO, so I'd
> > think that O_DIRECT on the server side would be much more performant
> > than RWF_DONTCACHE. Especially as XFS will do concurrent O_DIRECT
> > writes all the way down to the storage.....
>=20
> Yes.  We really need to add full-blown O_DIRECT support to knfsd.  And
> Hammerspace wants me to work on it ASAP.  But I welcome all the help I
> can get, I have ideas but look forward to discussing next week at
> Bakeathon and/or in this thread...
>=20
> The first hurdle is coping with the head and/or tail of IO being
> misaligned relative to the underlying storage's logical_block_size.
> Need to cull off misaligned IO and use RWF_DONTCACHE for those but
> O_DIRECT for the aligned middle is needed.
>
> I aim to deal with that for NFS LOCALIO first (NFS client issues
> IO direct to XFS, bypassing knfsd) and then reuse it for knfsd's
> O_DIRECT support.
>

I'll be interested to hear your thoughts on this!

> > > > > I wonder if we need some heuristic that makes generic_write_sync(=
) only
> > > > > kick off writeback immediately if the whole folio is dirty so we =
have
> > > > > more time to gather writes before kicking off writeback?
> > > >=20
> > > > You're doing aligned 1MB IOs - there should be no partially dirty
> > > > large folios in either the client or the server page caches.
> > >=20
> > > Interesting. I wonder what accounts for the slowdown with 1M writes? =
It
> > > seems likely to be related to the more aggressive writeback with
> > > DONTCACHE enabled, but it'd be good to understand this.
> >=20
> > What I suspect is that block layer IO submission latency has
> > increased significantly  with RWF_DONTCACHE and that is slowing down
> > the rate at which it can service buffered writes to a single file.
> >=20
> > The difference between normal buffered writes and RWF_DONTCACHE is
> > that the write() context will marshall the dirty folios into bios
> > and submit them to the block layer (via generic_write_sync()). If
> > the underlying device queues are full, then the bio submission will
> > be throttled to wait for IO completion.
> >=20
> > At this point, all NFSD write processing to that file stalls. All
> > the other nfsds are blocked on the i_rwsem, and that can't be
> > released until the holder is released by the block layer throttling.
> > Hence any time the underlying device queue fills, nfsd processing of
> > incoming writes stalls completely.
> >=20
> > When doing normal buffered writes, this IO submission stalling does
> > not occur because there is no direct writeback occurring in the
> > write() path.
> >=20
> > Remember the bad old days of balance_dirty_pages() doing dirty
> > throttling by submitting dirty pages for IO directly in the write()
> > context? And how much better buffered write performance and write()
> > submission latency became when we started deferring that IO to the
> > writeback threads and waiting on completions?
> >=20
> > We're essentially going back to the bad old days with buffered
> > RWF_DONTCACHE writes. Instead of one nicely formed background
> > writeback stream that can be throttled at the block layer without
> > adversely affecting incoming write throughput, we end up with every
> > write() context submitting IO synchronously and being randomly
> > throttled by the block layer throttle....
> >=20
> > There are a lot of reasons the current RWF_DONTCACHE implementation
> > is sub-optimal for common workloads. This IO spraying and submission
> > side throttling problem
> > is one of the reasons why I suggested very early on that an async
> > write-behind window (similar in concept to async readahead winodws)
> > would likely be a much better generic solution for RWF_DONTCACHE
> > writes. This would retain the "one nicely formed background
> > writeback stream" behaviour that is desirable for buffered writes,
> > but still allow in rapid reclaim of DONTCACHE folios as IO cleans
> > them...
>=20
> I recall you voicing this concern and nobody really seizing on it.
> Could be that Jens is open changing the RWF_DONTCACHE implementation
> if/when more proof is made for the need?
>=20

It does seem like using RWF_DONTCACHE currently leads to a lot of
fragmented I/O. I suspect that doing filemap_fdatawrite_range_kick()
after every DONTCACHE write is the main problem on the write side. We
probably need to come up with a way to make it flush more optimally
when there are streaming DONTCACHE writes.

An async writebehind window could be a solution. How would we implement
that? Some sort of delay before we kick off writeback (and hopefully
for larger ranges)?

> > > > That said, this is part of the reason I asked about both whether th=
e
> > > > client side write is STABLE and  whether RWF_DONTCACHE on
> > > > the server side. i.e. using either of those will trigger writeback
> > > > on the serer side immediately; in the case of the former it will
> > > > also complete before returning to the client and not require a
> > > > subsequent COMMIT RPC to wait for server side IO completion...
> > > >=20
> > >=20
> > > I need to go back and sniff traffic to be sure, but I'm fairly certai=
n
> > > the client is issuing regular UNSTABLE writes and following up with a
> > > later COMMIT, at least for most of them. The occasional STABLE write
> > > might end up getting through, but that should be fairly rare.
> >=20
> > Yeah, I don't think that's an issue given that only the server side
> > is using RWF_DONTCACHE. The COMMIT will effectively just be a
> > journal and/or device cache flush as all the dirty data has already
> > been written back to storage....
>=20
> FYI, most of Hammerspace RWF_DONTCACHE testing has been using O_DIRECT
> for client IO and nfsd.nfsd_dontcache=3DY on the server.

Good to know. I'll switch my testing to O_DIRECT as well. The client-
side pagecache isn't adding any benefit to this.
--
Jeff Layton <jlayton@kernel.org>

