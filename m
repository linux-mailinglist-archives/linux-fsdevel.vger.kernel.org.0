Return-Path: <linux-fsdevel+bounces-40109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBDA1C31E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 13:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40273A6D72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C72080D2;
	Sat, 25 Jan 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDZ+ZVB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D21DD866;
	Sat, 25 Jan 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807911; cv=none; b=H5SiigMYsvSVD55tD8FyhKBrrc+z4b6nMnXU/x6DyVk7H2wGhgBhJzEJ5FeFzEJvd9mmfi71bLDweGMGnzKC+x4L4X9aYPfX8FPRs6fRCLrtX+oz/q7zM1Vv609VQppZNBaNx5PiQqQy84uoBdaLz1FjLXuhR+7mZthWzI8U+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807911; c=relaxed/simple;
	bh=8Lw+SSA2CWUmdE/uxkA4KIyZhEePXJbVlAiBkFHjI7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FUPMvlu714Lqxp7p59mfj1M+uUMxoJs/gwU04BAq8nBGy3Uw2KOYgHtNzz+cAGBpSM/psoMSM0aw3B6lsv7WypXscK/Wt3qs2fbeepB6sbYGzwLYgANjwYPNjap9IWz3VnGUZ3ZrHkhQZhTHTiYZ1zgmKrJt/wI61DfLmKQi7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDZ+ZVB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584F8C4CED6;
	Sat, 25 Jan 2025 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807910;
	bh=8Lw+SSA2CWUmdE/uxkA4KIyZhEePXJbVlAiBkFHjI7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WDZ+ZVB+Vgy4ULL3/gIMFv0GSp4rEnnzFjm6/8jBrPLguQbM6X/sQihj1rNnmymFa
	 AsUtpohvoU8IEVrPPyZwsuqVnOfzZH9eOViaIQ4OA9C+HlCe6uaEfckglEur9Gi9NF
	 ioUMlmgMn3HrW4TvqKRN+LrnIuHWiGTO3VuRoTNZSov8WBUTVizA1V3FqWlJMbBi/P
	 K09iRO3z4y7z+NGypPzVtiFsyWM6ZsM3F7XK+GI9J4WrHwiayQIF0Nc8ygk5onKQty
	 fRB7lV0smhiEmHtwf89ViYa0g+4ZjwGd5bX4k9lfE5A714WFNGRNPACNAd6mVvXBJF
	 xadPAsCjOt9+Q==
Message-ID: <7e6eb0d6f42ec77779e2da211db8854dffa6dbcd.camel@kernel.org>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation
 framework
From: Jeff Layton <jlayton@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org
Cc: linux-mm@kvack.org, javier.gonz@samsung.com, Slava.Dubeyko@ibm.com
Date: Sat, 25 Jan 2025 07:25:08 -0500
In-Reply-To: <20250123202455.11338-1-slava@dubeyko.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
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
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-23 at 12:24 -0800, Viacheslav Dubeyko wrote:
> [PROBLEM DECLARATION]
> Efficient data placement policy is a Holy Grail for data
> storage and file system engineers. Achieving this goal is
> equally important and really hard. Multiple data storage
> and file system technologies have been invented to manage
> the data placement policy (for example, COW, ZNS, FDP, etc).
> But these technologies still require the hints related to
> nature of data from application side.
>=20
> [DATA "TEMPERATURE" CONCEPT]
> One of the widely used and intuitively clear idea of data
> nature definition is data "temperature" (cold, warm,
> hot data). However, data "temperature" is as intuitively
> sound as illusive definition of data nature. Generally
> speaking, thermodynamics defines temperature as a way
> to estimate the average kinetic energy of vibrating
> atoms in a substance. But we cannot see a direct analogy
> between data "temperature" and temperature in physics
> because data is not something that has kinetic energy.
>=20
> [WHAT IS GENERALIZED DATA "TEMPERATURE" ESTIMATION]
> We usually imply that if some data is updated more
> frequently, then such data is more hot than other one.
> But, it is possible to see several problems here:
> (1) How can we estimate the data "hotness" in
> quantitative way? (2) We can state that data is "hot"
> after some number of updates. It means that this
> definition implies state of the data in the past.
> Will this data continue to be "hot" in the future?
> Generally speaking, the crucial problem is how to define
> the data nature or data "temperature" in the future.
> Because, this knowledge is the fundamental basis for
> elaboration an efficient data placement policy.
> Generalized data "temperature" estimation framework
> suggests the way to define a future state of the data
> and the basis for quantitative measurement of data
> "temperature".
>=20
> [ARCHITECTURE OF FRAMEWORK]
> Usually, file system has a page cache for every inode. And
> initially memory pages become dirty in page cache. Finally,
> dirty pages will be sent to storage device. Technically
> speaking, the number of dirty pages in a particular page
> cache is the quantitative measurement of current "hotness"
> of a file. But number of dirty pages is still not stable
> basis for quantitative measurement of data "temperature".
> It is possible to suggest of using the total number of
> logical blocks in a file as a unit of one degree of data
> "temperature". As a result, if the whole file was updated
> several times, then "temperature" of the file has been
> increased for several degrees. And if the file is under
> continous updates, then the file "temperature" is growing.
>=20
> We need to keep not only current number of dirty pages,
> but also the number of updated pages in the near past
> for accumulating the total "temperature" of a file.
> Generally speaking, total number of updated pages in the
> nearest past defines the aggregated "temperature" of file.
> And number of dirty pages defines the delta of
> "temperature" growth for current update operation.
> This approach defines the mechanism of "temperature" growth.
>=20
> But if we have no more updates for the file, then
> "temperature" needs to decrease. Starting and ending
> timestamps of update operation can work as a basis for
> decreasing "temperature" of a file. If we know the number
> of updated logical blocks of the file, then we can divide
> the duration of update operation on number of updated
> logical blocks. As a result, this is the way to define
> a time duration per one logical block. By means of
> multiplying this value (time duration per one logical
> block) on total number of logical blocks in file, we
> can calculate the time duration of "temperature"
> decreasing for one degree. Finally, the operation of
> division the time range (between end of last update
> operation and begin of new update operation) on
> the time duration of "temperature" decreasing for
> one degree provides the way to define how many
> degrees should be subtracted from current "temperature"
> of the file.
>=20
> [HOW TO USE THE APPROACH]
> The lifetime of data "temperature" value for a file
> can be explained by steps: (1) iget() method sets
> the data "temperature" object; (2) folio_account_dirtied()
> method accounts the number of dirty memory pages and
> tries to estimate the current temperature of the file;
> (3) folio_clear_dirty_for_io() decrease number of dirty
> memory pages and increases number of updated pages;
> (4) folio_account_dirtied() also decreases file's
> "temperature" if updates hasn't happened some time;
> (5) file system can get file's temperature and
> to share the hint with block layer; (6) inode
> eviction method removes and free the data "temperature"
> object.
>=20
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
>  fs/Kconfig                             |   2 +
>  fs/Makefile                            |   1 +
>  fs/data-temperature/Kconfig            |  11 +
>  fs/data-temperature/Makefile           |   3 +
>  fs/data-temperature/data_temperature.c | 347 +++++++++++++++++++++++++
>  include/linux/data_temperature.h       | 124 +++++++++
>  include/linux/fs.h                     |   4 +
>  mm/page-writeback.c                    |   9 +
>  8 files changed, 501 insertions(+)
>  create mode 100644 fs/data-temperature/Kconfig
>  create mode 100644 fs/data-temperature/Makefile
>  create mode 100644 fs/data-temperature/data_temperature.c
>  create mode 100644 include/linux/data_temperature.h
>=20


This seems like an interesting idea, but how do you intend to use the
temperature?

With this patch, it looks like you're just calculating it, but there is
nothing that uses it and there is no way to access the temperature from
userland. It would be nice to see this value used by an existing
subsystem to drive data placement so we can see how it will help
things.

> diff --git a/fs/Kconfig b/fs/Kconfig
> index 64d420e3c475..ae117c2e3ce2 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -139,6 +139,8 @@ source "fs/autofs/Kconfig"
>  source "fs/fuse/Kconfig"
>  source "fs/overlayfs/Kconfig"
> =20
> +source "fs/data-temperature/Kconfig"
> +
>  menu "Caches"
> =20
>  source "fs/netfs/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 15df0a923d3a..c7e6ccac633d 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EROFS_FS)		+=3D erofs/
>  obj-$(CONFIG_VBOXSF_FS)		+=3D vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)		+=3D zonefs/
>  obj-$(CONFIG_BPF_LSM)		+=3D bpf_fs_kfuncs.o
> +obj-$(CONFIG_DATA_TEMPERATURE)	+=3D data-temperature/
> diff --git a/fs/data-temperature/Kconfig b/fs/data-temperature/Kconfig
> new file mode 100644
> index 000000000000..1cade2741982
> --- /dev/null
> +++ b/fs/data-temperature/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config DATA_TEMPERATURE
> +	bool "Data temperature approach for efficient data placement"
> +	help
> +	  Enable data "temperature" estimation for efficient data
> +	  placement policy. This approach is file based and
> +	  it estimates "temperature" for every file independently.
> +	  The goal of the approach is to provide valuable hints
> +	  to file system or/and SSD for isolation and proper
> +	  managament of data with different temperatures.
> diff --git a/fs/data-temperature/Makefile b/fs/data-temperature/Makefile
> new file mode 100644
> index 000000000000..8e089a681360
> --- /dev/null
> +++ b/fs/data-temperature/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_DATA_TEMPERATURE) +=3D data_temperature.o
> diff --git a/fs/data-temperature/data_temperature.c b/fs/data-temperature=
/data_temperature.c
> new file mode 100644
> index 000000000000..ea43fbfc3976
> --- /dev/null
> +++ b/fs/data-temperature/data_temperature.c
> @@ -0,0 +1,347 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data "temperature" paradigm implementation
> + *
> + * Copyright (c) 2024-2025 Viacheslav Dubeyko <slava@dubeyko.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pagemap.h>
> +#include <linux/data_temperature.h>
> +#include <linux/fs.h>
> +
> +#define TIME_IS_UNKNOWN		(U64_MAX)
> +
> +struct kmem_cache *data_temperature_info_cachep;
> +
> +static inline
> +void create_data_temperature_info(struct data_temperature *dt_info)
> +{
> +	if (!dt_info)
> +		return;
> +
> +	atomic_set(&dt_info->temperature, 0);
> +	dt_info->updated_blocks =3D 0;
> +	dt_info->dirty_blocks =3D 0;
> +	dt_info->start_timestamp =3D TIME_IS_UNKNOWN;
> +	dt_info->end_timestamp =3D TIME_IS_UNKNOWN;
> +	dt_info->state =3D DATA_TEMPERATURE_CREATED;
> +}
> +
> +static inline
> +void free_data_temperature_info(struct data_temperature *dt_info)
> +{
> +	if (!dt_info)
> +		return;
> +
> +	kmem_cache_free(data_temperature_info_cachep, dt_info);
> +}
> +
> +int __set_data_temperature_info(struct inode *inode)
> +{
> +	struct data_temperature *dt_info;
> +
> +	dt_info =3D kmem_cache_zalloc(data_temperature_info_cachep, GFP_KERNEL)=
;
> +	if (!dt_info)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&dt_info->change_lock);
> +	create_data_temperature_info(dt_info);
> +
> +	if (cmpxchg_release(&inode->i_data_temperature_info,
> +					NULL, dt_info) !=3D NULL) {
> +		free_data_temperature_info(dt_info);
> +		get_data_temperature_info(inode);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__set_data_temperature_info);
> +
> +void __remove_data_temperature_info(struct inode *inode)
> +{
> +	free_data_temperature_info(inode->i_data_temperature_info);
> +	inode->i_data_temperature_info =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(__remove_data_temperature_info);
> +
> +int __get_data_temperature(const struct inode *inode)
> +{
> +	struct data_temperature *dt_info;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +
> +	dt_info =3D get_data_temperature_info(inode);
> +	if (IS_ERR_OR_NULL(dt_info))
> +		return 0;
> +
> +	return atomic_read(&dt_info->temperature);
> +}
> +EXPORT_SYMBOL_GPL(__get_data_temperature);
> +
> +static inline
> +bool is_timestamp_invalid(struct data_temperature *dt_info)
> +{
> +	if (!dt_info)
> +		return false;
> +
> +	if (dt_info->start_timestamp =3D=3D TIME_IS_UNKNOWN ||
> +	    dt_info->end_timestamp =3D=3D TIME_IS_UNKNOWN)
> +		return true;
> +
> +	if (dt_info->start_timestamp > dt_info->end_timestamp)
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline
> +u64 get_current_timestamp(void)
> +{
> +	return ktime_get_boottime_ns();
> +}
> +
> +static inline
> +void start_account_data_temperature_info(struct data_temperature *dt_inf=
o)
> +{
> +	if (!dt_info)
> +		return;
> +
> +	dt_info->dirty_blocks =3D 1;
> +	dt_info->start_timestamp =3D get_current_timestamp();
> +	dt_info->end_timestamp =3D TIME_IS_UNKNOWN;
> +	dt_info->state =3D DATA_TEMPERATURE_UPDATE_STARTED;
> +}
> +
> +static inline
> +void __increase_data_temperature(struct inode *inode,
> +				 struct data_temperature *dt_info)
> +{
> +	u64 bytes_count;
> +	u64 file_blocks;
> +	u32 block_bytes;
> +	int dirty_blocks_ratio;
> +	int updated_blocks_ratio;
> +	int old_temperature;
> +	int calculated;
> +
> +	if (!inode || !dt_info)
> +		return;
> +
> +	block_bytes =3D 1 << inode->i_blkbits;
> +	bytes_count =3D i_size_read(inode) + block_bytes - 1;
> +	file_blocks =3D bytes_count >> inode->i_blkbits;
> +
> +	dt_info->dirty_blocks++;
> +
> +	if (file_blocks > 0) {
> +		old_temperature =3D atomic_read(&dt_info->temperature);
> +
> +		dirty_blocks_ratio =3D div_u64(dt_info->dirty_blocks,
> +						file_blocks);
> +		updated_blocks_ratio =3D div_u64(dt_info->updated_blocks,
> +						file_blocks);
> +		calculated =3D max_t(int, dirty_blocks_ratio,
> +					updated_blocks_ratio);
> +
> +		if (calculated > 0 && old_temperature < calculated)
> +			atomic_set(&dt_info->temperature, calculated);
> +	}
> +}
> +
> +static inline
> +void __decrease_data_temperature(struct inode *inode,
> +				 struct data_temperature *dt_info)
> +{
> +	u64 timestamp;
> +	u64 time_range;
> +	u64 time_diff;
> +	u64 bytes_count;
> +	u64 file_blocks;
> +	u32 block_bytes;
> +	u64 blks_per_temperature_degree;
> +	u64 ns_per_block;
> +	u64 temperature_diff;
> +
> +	if (!inode || !dt_info)
> +		return;
> +
> +	if (is_timestamp_invalid(dt_info)) {
> +		create_data_temperature_info(dt_info);
> +		return;
> +	}
> +
> +	timestamp =3D get_current_timestamp();
> +
> +	if (dt_info->end_timestamp > timestamp) {
> +		create_data_temperature_info(dt_info);
> +		return;
> +	}
> +
> +	time_range =3D dt_info->end_timestamp - dt_info->start_timestamp;
> +	time_diff =3D timestamp - dt_info->end_timestamp;
> +
> +	block_bytes =3D 1 << inode->i_blkbits;
> +	bytes_count =3D i_size_read(inode) + block_bytes - 1;
> +	file_blocks =3D bytes_count >> inode->i_blkbits;
> +
> +	blks_per_temperature_degree =3D file_blocks;
> +	if (blks_per_temperature_degree =3D=3D 0) {
> +		start_account_data_temperature_info(dt_info);
> +		return;
> +	}
> +
> +	if (dt_info->updated_blocks =3D=3D 0 || time_range =3D=3D 0) {
> +		start_account_data_temperature_info(dt_info);
> +		return;
> +	}
> +
> +	ns_per_block =3D div_u64(time_range, dt_info->updated_blocks);
> +	if (ns_per_block =3D=3D 0)
> +		ns_per_block =3D 1;
> +
> +	if (time_diff =3D=3D 0) {
> +		start_account_data_temperature_info(dt_info);
> +		return;
> +	}
> +
> +	temperature_diff =3D div_u64(time_diff, ns_per_block);
> +	temperature_diff =3D div_u64(temperature_diff,
> +					blks_per_temperature_degree);
> +
> +	if (temperature_diff =3D=3D 0)
> +		return;
> +
> +	if (temperature_diff <=3D atomic_read(&dt_info->temperature)) {
> +		atomic_sub(temperature_diff, &dt_info->temperature);
> +		dt_info->updated_blocks -=3D
> +			temperature_diff * blks_per_temperature_degree;
> +	} else {
> +		atomic_set(&dt_info->temperature, 0);
> +		dt_info->updated_blocks =3D 0;
> +	}
> +}
> +
> +int __increase_data_temperature_by_dirty_folio(struct folio *folio)
> +{
> +	struct inode *inode;
> +	struct data_temperature *dt_info;
> +
> +	if (!folio || !folio->mapping)
> +		return 0;
> +
> +	inode =3D folio_inode(folio);
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +
> +	dt_info =3D get_data_temperature_info(inode);
> +	if (IS_ERR_OR_NULL(dt_info))
> +		return 0;
> +
> +	spin_lock(&dt_info->change_lock);
> +	switch (dt_info->state) {
> +	case DATA_TEMPERATURE_CREATED:
> +		atomic_set(&dt_info->temperature, 0);
> +		start_account_data_temperature_info(dt_info);
> +		break;
> +
> +	case DATA_TEMPERATURE_UPDATE_STARTED:
> +		__increase_data_temperature(inode, dt_info);
> +		break;
> +
> +	case DATA_TEMPERATURE_UPDATE_FINISHED:
> +		__decrease_data_temperature(inode, dt_info);
> +		start_account_data_temperature_info(dt_info);
> +		break;
> +
> +	default:
> +		/* do nothing */
> +		break;
> +	}
> +	spin_unlock(&dt_info->change_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__increase_data_temperature_by_dirty_folio);
> +
> +static inline
> +void decrement_dirty_blocks(struct data_temperature *dt_info)
> +{
> +	if (!dt_info)
> +		return;
> +
> +	if (dt_info->dirty_blocks > 0) {
> +		dt_info->dirty_blocks--;
> +		dt_info->updated_blocks++;
> +	}
> +}
> +
> +static inline
> +void finish_increasing_data_temperature(struct data_temperature *dt_info=
)
> +{
> +	if (!dt_info)
> +		return;
> +
> +	if (dt_info->dirty_blocks =3D=3D 0) {
> +		dt_info->end_timestamp =3D get_current_timestamp();
> +		dt_info->state =3D DATA_TEMPERATURE_UPDATE_FINISHED;
> +	}
> +}
> +
> +int __account_flushed_folio_by_data_temperature(struct folio *folio)
> +{
> +	struct inode *inode;
> +	struct data_temperature *dt_info;
> +
> +	if (!folio || !folio->mapping)
> +		return 0;
> +
> +	inode =3D folio_inode(folio);
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +
> +	dt_info =3D get_data_temperature_info(inode);
> +	if (IS_ERR_OR_NULL(dt_info))
> +		return 0;
> +
> +	spin_lock(&dt_info->change_lock);
> +	switch (dt_info->state) {
> +	case DATA_TEMPERATURE_CREATED:
> +		create_data_temperature_info(dt_info);
> +		break;
> +
> +	case DATA_TEMPERATURE_UPDATE_STARTED:
> +		if (dt_info->dirty_blocks > 0)
> +			decrement_dirty_blocks(dt_info);
> +		if (dt_info->dirty_blocks =3D=3D 0)
> +			finish_increasing_data_temperature(dt_info);
> +		break;
> +
> +	case DATA_TEMPERATURE_UPDATE_FINISHED:
> +		/* do nothing */
> +		break;
> +
> +	default:
> +		/* do nothing */
> +		break;
> +	}
> +	spin_unlock(&dt_info->change_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(__account_flushed_folio_by_data_temperature);
> +
> +static int __init data_temperature_init(void)
> +{
> +	data_temperature_info_cachep =3D KMEM_CACHE(data_temperature,
> +						  SLAB_RECLAIM_ACCOUNT);
> +	if (!data_temperature_info_cachep)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +late_initcall(data_temperature_init)
> diff --git a/include/linux/data_temperature.h b/include/linux/data_temper=
ature.h
> new file mode 100644
> index 000000000000..40abf6322385
> --- /dev/null
> +++ b/include/linux/data_temperature.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data "temperature" paradigm declarations
> + *
> + * Copyright (c) 2024-2025 Viacheslav Dubeyko <slava@dubeyko.com>
> + */
> +
> +#ifndef _LINUX_DATA_TEMPERATURE_H
> +#define _LINUX_DATA_TEMPERATURE_H
> +
> +/*
> + * struct data_temperature - data temperature definition
> + * @temperature: current temperature of a file
> + * @change_lock: modification lock
> + * @state: current state of data temperature object
> + * @dirty_blocks: current number of dirty blocks in page cache
> + * @updated_blocks: number of updated blocks [start_timestamp, end_times=
tamp]
> + * @start_timestamp: starting timestamp of update operations
> + * @end_timestamp: finishing timestamp of update operations
> + */
> +struct data_temperature {
> +	atomic_t temperature;
> +
> +	spinlock_t change_lock;
> +	int state;
> +	u64 dirty_blocks;
> +	u64 updated_blocks;
> +	u64 start_timestamp;
> +	u64 end_timestamp;
> +};
> +
> +enum data_temperature_state {
> +	DATA_TEMPERATURE_UNKNOWN_STATE,
> +	DATA_TEMPERATURE_CREATED,
> +	DATA_TEMPERATURE_UPDATE_STARTED,
> +	DATA_TEMPERATURE_UPDATE_FINISHED,
> +	DATA_TEMPERATURE_STATE_MAX
> +};
> +
> +#ifdef CONFIG_DATA_TEMPERATURE
> +
> +int __set_data_temperature_info(struct inode *inode);
> +void __remove_data_temperature_info(struct inode *inode);
> +int __get_data_temperature(const struct inode *inode);
> +int __increase_data_temperature_by_dirty_folio(struct folio *folio);
> +int __account_flushed_folio_by_data_temperature(struct folio *folio);
> +
> +static inline
> +struct data_temperature *get_data_temperature_info(const struct inode *i=
node)
> +{
> +	return smp_load_acquire(&inode->i_data_temperature_info);
> +}
> +
> +static inline
> +int set_data_temperature_info(struct inode *inode)
> +{
> +	return __set_data_temperature_info(inode);
> +}
> +
> +static inline
> +void remove_data_temperature_info(struct inode *inode)
> +{
> +	__remove_data_temperature_info(inode);
> +}
> +
> +static inline
> +int get_data_temperature(const struct inode *inode)
> +{
> +	return __get_data_temperature(inode);
> +}
> +
> +static inline
> +int increase_data_temperature_by_dirty_folio(struct folio *folio)
> +{
> +	return __increase_data_temperature_by_dirty_folio(folio);
> +}
> +
> +static inline
> +int account_flushed_folio_by_data_temperature(struct folio *folio)
> +{
> +	return __account_flushed_folio_by_data_temperature(folio);
> +}
> +
> +#else  /* !CONFIG_DATA_TEMPERATURE */
> +
> +static inline
> +int set_data_temperature_info(struct inode *inode)
> +{
> +	return 0;
> +}
> +
> +static inline
> +void remove_data_temperature_info(struct inode *inode)
> +{
> +	return;
> +}
> +
> +static inline
> +struct data_temperature *get_data_temperature_info(const struct inode *i=
node)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline
> +int get_data_temperature(const struct inode *inode)
> +{
> +	return 0;
> +}
> +
> +static inline
> +int increase_data_temperature_by_dirty_folio(struct folio *folio)
> +{
> +	return 0;
> +}
> +
> +static inline
> +int account_flushed_folio_by_data_temperature(struct folio *folio)
> +{
> +	return 0;
> +}
> +
> +#endif	/* CONFIG_DATA_TEMPERATURE */
> +
> +#endif	/* _LINUX_DATA_TEMPERATURE_H */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a4af70367f8a..57c4810a28a0 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -753,6 +753,10 @@ struct inode {
>  	struct fsverity_info	*i_verity_info;
>  #endif
> =20
> +#ifdef CONFIG_DATA_TEMPERATURE
> +	struct data_temperature		*i_data_temperature_info;
> +#endif
> +
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
> =20
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index d9861e42b2bd..5de458b7fefc 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -38,6 +38,7 @@
>  #include <linux/sched/rt.h>
>  #include <linux/sched/signal.h>
>  #include <linux/mm_inline.h>
> +#include <linux/data_temperature.h>
>  #include <trace/events/writeback.h>
> =20
>  #include "internal.h"
> @@ -2775,6 +2776,10 @@ static void folio_account_dirtied(struct folio *fo=
lio,
>  		__this_cpu_add(bdp_ratelimits, nr);
> =20
>  		mem_cgroup_track_foreign_dirty(folio, wb);
> +
> +#ifdef CONFIG_DATA_TEMPERATURE
> +		increase_data_temperature_by_dirty_folio(folio);
> +#endif	/* CONFIG_DATA_TEMPERATURE */
>  	}
>  }
> =20
> @@ -3006,6 +3011,10 @@ bool folio_clear_dirty_for_io(struct folio *folio)
> =20
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> =20
> +#ifdef CONFIG_DATA_TEMPERATURE
> +	account_flushed_folio_by_data_temperature(folio);
> +#endif	/* CONFIG_DATA_TEMPERATURE */
> +
>  	if (mapping && mapping_can_writeback(mapping)) {
>  		struct inode *inode =3D mapping->host;
>  		struct bdi_writeback *wb;

--=20
Jeff Layton <jlayton@kernel.org>

