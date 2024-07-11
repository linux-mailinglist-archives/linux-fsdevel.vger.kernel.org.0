Return-Path: <linux-fsdevel+bounces-23594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948A592EFB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C86D2821D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8516F0EF;
	Thu, 11 Jul 2024 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqB1bZzx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19A16D4D0;
	Thu, 11 Jul 2024 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726485; cv=none; b=GAvy8+fegPvOhO5jkx/W43DkxKGaDTkUqogTotO5QkG/XuZZyaSiXHldTQCMHVueb3Vg4U9vBncUYNG2XtngpCkSDhycU0OiSPwB9cDy/E+z1+mM0UNbhsM7gkzxVPOyCxtW3jP67i63/PMxL0PxtgMbMEtVFCZStmGY/05Vgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726485; c=relaxed/simple;
	bh=kJJFqsRUTpnZUvC9gjbodY1mFdLFbYJ1T6UYMtoz1eA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6RpbbWHNfuUGs7as3s2A7ktBS8xY8OGq6+8KpiIfTEyryyBzs6AVTjfjlgBAhJtcJemMuyYwnbsetnTdgpALOSAefiDw8lGlDEthZWBRCKTa5hpwc4c4cyg1afNloVBoztlRh1FF4n0AWqN9tylx/0qynt2gtM/QJV0R/AVzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqB1bZzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCB5C116B1;
	Thu, 11 Jul 2024 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720726485;
	bh=kJJFqsRUTpnZUvC9gjbodY1mFdLFbYJ1T6UYMtoz1eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SqB1bZzxJJ5PZX+U0lymEysobu5cDXWfx0aq/RA8c3/32Bts24KnMvdVkrpAdk6mA
	 f7nqh5nFp4FjTdj17xLN8iNLYSAEpkRKqScRg8mXaAZNnB8gY7J72e0gz9w563T7UB
	 Eh9GEJ2ELOySG2sxdlBf+FeA/IhrIQsgG8HSJdX9vjwsJf6mPAW3YBQdUyeaEtKOlz
	 d9ciA7RBMXcSX6OTtNp3Ez23CfBd7v9tBcifguTkV/l5+aM7LMdowBf9SXfLKCXdh0
	 U8S5hOQGcBPAH8bxE8Mk4Ls1ZaATpmaWJbw6T7IquK2KgSui9DjtckP9H3sICQvNMk
	 4ozh7o0DT2j1Q==
Message-ID: <6ee462004f5dae76233242de948bcb3c54ca5d85.camel@kernel.org>
Subject: Re: [PATCH v5 5/9] Documentation: add a new file documenting
 multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chandan Babu R
 <chandan.babu@oracle.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>,  Dave Chinner <david@fromorbit.com>, Andi Kleen
 <ak@linux.intel.com>, Christoph Hellwig <hch@infradead.org>,  Uros Bizjak
 <ubizjak@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>,  Randy Dunlap <rdunlap@infradead.org>,
 kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
  linux-doc@vger.kernel.org
Date: Thu, 11 Jul 2024 15:34:41 -0400
In-Reply-To: <20240711191239.GR612460@frogsfrogsfrogs>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
	 <20240711-mgtime-v5-5-37bb5b465feb@kernel.org>
	 <20240711191239.GR612460@frogsfrogsfrogs>
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
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 12:12 -0700, Darrick J. Wong wrote:
> On Thu, Jul 11, 2024 at 07:08:09AM -0400, Jeff Layton wrote:
> > Add a high-level document that describes how multigrain timestamps work=
,
> > rationale for them, and some info about implementation and tradeoffs.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++++++++=
++++++++
> >  1 file changed, 120 insertions(+)
> >=20
> > diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentatio=
n/filesystems/multigrain-ts.rst
> > new file mode 100644
> > index 000000000000..5cefc204ecec
> > --- /dev/null
> > +++ b/Documentation/filesystems/multigrain-ts.rst
> > @@ -0,0 +1,120 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Multigrain Timestamps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Historically, the kernel has always used coarse time values to stamp
> > +inodes. This value is updated on every jiffy, so any change that happe=
ns
> > +within that jiffy will end up with the same timestamp.
> > +
> > +When the kernel goes to stamp an inode (due to a read or write), it fi=
rst gets
> > +the current time and then compares it to the existing timestamp(s) to =
see
> > +whether anything will change. If nothing changed, then it can avoid up=
dating
> > +the inode's metadata.
> > +
> > +Coarse timestamps are therefore good from a performance standpoint, si=
nce they
> > +reduce the need for metadata updates, but bad from the standpoint of
> > +determining whether anything has changed, since a lot of things can ha=
ppen in a
> > +jiffy.
> > +
> > +They are particularly troublesome with NFSv3, where unchanging timesta=
mps can
> > +make it difficult to tell whether to invalidate caches. NFSv4 provides=
 a
> > +dedicated change attribute that should always show a visible change, b=
ut not
> > +all filesystems implement this properly, causing the NFS server to sub=
stitute
> > +the ctime in many cases.
> > +
> > +Multigrain timestamps aim to remedy this by selectively using fine-gra=
ined
> > +timestamps when a file has had its timestamps queried recently, and th=
e current
> > +coarse-grained time does not cause a change.
> > +
> > +Inode Timestamps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +There are currently 3 timestamps in the inode that are updated to the =
current
> > +wallclock time on different activity:
> > +
> > +ctime:
> > +  The inode change time. This is stamped with the current time wheneve=
r
> > +  the inode's metadata is changed. Note that this value is not settabl=
e
> > +  from userland.
> > +
> > +mtime:
> > +  The inode modification time. This is stamped with the current time
> > +  any time a file's contents change.
> > +
> > +atime:
> > +  The inode access time. This is stamped whenever an inode's contents =
are
> > +  read. Widely considered to be a terrible mistake. Usually avoided wi=
th
> > +  options like noatime or relatime.
>=20
> And for btime/crtime (aka creation time) a filesystem can take the
> coarse timestamp, right?  It's not settable by userspace, and I think
> statx is the only way those are ever exposed.  QUERIED is never set when
> the file is being created.
>=20

Yep. I'd just copy the ctime to the btime after it's set on creation so
that everything lines up nicely.

> > +Updating the mtime always implies a change to the ctime, but updating =
the
> > +atime due to a read request does not.
> > +
> > +Multigrain timestamps are only tracked for the ctime and the mtime. at=
imes are
> > +not affected and always use the coarse-grained value (subject to the f=
loor).
>=20
> Is it ok if an atime update uses the same timespec as was used for a
> ctime update?  There's a pending update for 6.11 that changes
> xfs_trans_ichgtime to do:
>
> 	tv =3D current_time(inode);
>=20
> 	if (flags & XFS_ICHGTIME_MOD)
> 		inode_set_mtime_to_ts(inode, tv);
> 	if (flags & XFS_ICHGTIME_CHG)
> 		inode_set_ctime_to_ts(inode, tv);
> 	if (flags & XFS_ICHGTIME_ACCESS)
> 		inode_set_atime_to_ts(inode, tv);
> 	if (flags & XFS_ICHGTIME_CREATE)
> 		ip->i_crtime =3D tv;
>=20

Yeah, that should be fine. If you were doing some (hypothetical)
operation that needs to set both the ctime and the atime, then the
natural thing to do is to just let the atime's value "flow" from the
updated ctime.

> So I guess xfs could do something like this to set @tv:
>=20
> 	if (flags & XFS_ICHGTIME_CHG)
> 		tv =3D inode_set_ctime_current(inode);
> 	else
> 		tv =3D current_time();
> ...
> 	if (flags & XFS_ICHGTIME_ACCESS)
> 		inode_set_atime_to_ts(inode, tv);
>
> Thoughts?
>=20

Yes, that should be fine. It's pretty similar to what we do in
inode_update_timestamps():

	if (flags & (S_MTIME|S_CTIME|S_VERSION)) {
		...
                now =3D inode_set_ctime_current(inode);
		...
        } else {
                now =3D current_time(inode);
	}


In practice, a mtime or version change implies a ctime change, whereas
an atime change generally doesn't. Still, I set up the infrastructure
to handle it properly if the ctime and atime are ever updated together.

> > +Inode Timestamp Ordering
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +In addition to just providing info about changes to individual files, =
file
> > +timestamps also serve an important purpose in applications like "make"=
. These
> > +programs measure timestamps in order to determine whether source files=
 might be
> > +newer than cached objects.
> > +
> > +Userland applications like make can only determine ordering based on
> > +operational boundaries. For a syscall those are the syscall entry and =
exit
> > +points. For io_uring or nfsd operations, that's the request submission=
 and
> > +response. In the case of concurrent operations, userland can make no
> > +determination about the order in which things will occur.
> > +
> > +For instance, if a single thread modifies one file, and then another f=
ile in
> > +sequence, the second file must show an equal or later mtime than the f=
irst. The
> > +same is true if two threads are issuing similar operations that do not=
 overlap
> > +in time.
> > +
> > +If however, two threads have racing syscalls that overlap in time, the=
n there
> > +is no such guarantee, and the second file may appear to have been modi=
fied
> > +before, after or at the same time as the first, regardless of which on=
e was
> > +submitted first.
> > +
> > +Multigrain Timestamps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Multigrain timestamps are aimed at ensuring that changes to a single f=
ile are
> > +always recognizable, without violating the ordering guarantees when mu=
ltiple
> > +different files are modified. This affects the mtime and the ctime, bu=
t the
> > +atime will always use coarse-grained timestamps.
> > +
> > +It uses an unused bit in the i_ctime_nsec field to indicate whether th=
e mtime
> > +or ctime has been queried. If either or both have, then the kernel tak=
es
> > +special care to ensure the next timestamp update will display a visibl=
e change.
> > +This ensures tight cache coherency for use-cases like NFS, without sac=
rificing
> > +the benefits of reduced metadata updates when files aren't being watch=
ed.
> > +
> > +The Ctime Floor Value
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +It's not sufficient to simply use fine or coarse-grained timestamps ba=
sed on
> > +whether the mtime or ctime has been queried. A file could get a fine g=
rained
> > +timestamp, and then a second file modified later could get a coarse-gr=
ained one
> > +that appears earlier than the first, which would break the kernel's ti=
mestamp
> > +ordering guarantees.
> > +
> > +To mitigate this problem, we maintain a global floor value that ensure=
s that
> > +this can't happen. The two files in the above example may appear to ha=
ve been
> > +modified at the same time in such a case, but they will never show the=
 reverse
> > +order. To avoid problems with realtime clock jumps, the floor is manag=
ed as a
> > +monotonic ktime_t, and the values are converted to realtime clock valu=
es as
> > +needed.
>=20
> monotonic atomic64_t?
>=20

It is an atomic64_t, but the values come from the ktime_get_*
functions, so we use the value as a ktime_t. Both are typedefs of s64
though, so casting between them is seamless.

I'll see if I can make that clearer in the doc.

> --D
>=20
> > +
> > +Implementation Notes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Multigrain timestamps are intended for use by local filesystems that g=
et
> > +ctime values from the local clock. This is in contrast to network file=
systems
> > +and the like that just mirror timestamp values from a server.
> > +
> > +For most filesystems, it's sufficient to just set the FS_MGTIME flag i=
n the
> > +fstype->fs_flags in order to opt-in, providing the ctime is only ever =
set via
> > +inode_set_ctime_current(). If the filesystem has a ->getattr routine t=
hat
> > +doesn't call generic_fillattr, then you should have it call fill_mg_cm=
time to
> > +fill those values.
> >=20
> > --=20
> > 2.45.2
> >=20
> >=20

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>

