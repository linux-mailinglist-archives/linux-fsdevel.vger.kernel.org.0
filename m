Return-Path: <linux-fsdevel+bounces-76436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBATKN2PhGkh3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:41:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40622F2B34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBFE83052AFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044783D3D0E;
	Thu,  5 Feb 2026 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSHNMtIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8083AE70E;
	Thu,  5 Feb 2026 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295087; cv=none; b=Gw/+IHJsseLpRf3hz83Izk7yBR+Xda2v74AEvNRZjw5yckwm8pVmY8hv/xrqkIwRhCnKXeJbNb/6ZS8Zzj/AGxlYkwsn4XzEFMnK2hWzwKmXXwAgVrn12DqsaM2a3XjoEuZWMLtgDEl+eg8vK2hyclHDEZ2HLH/ssjRWPPVzMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295087; c=relaxed/simple;
	bh=QbRCtR0CacyYKzFJoIJunN+5tZHIJYiysqUP3sn1Aqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nm847cGv8l1pFxgDv1xUQDcoEOTr3CQ4i6zE2qx1tEqj2KRcbljJQYdY0zqODudVnAX+/VCeYdaKm7MLeCvXyOuXFrX4CMJ9hrFeOZQK+avdcj3PhWTmE42mVqFbsHE6apZzN2LinlM7/d3mjQrPYqA961taicyMCWLKrELhnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSHNMtIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A69C16AAE;
	Thu,  5 Feb 2026 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770295087;
	bh=QbRCtR0CacyYKzFJoIJunN+5tZHIJYiysqUP3sn1Aqc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qSHNMtIn2aYx7PISfiGAyJQ1vWR63E1VyXMRnILSIUleY28dg+XQ8lfpFgpLmC5lI
	 5JY94j5zofPxM4tDfogBiYojMv291jnvC/1OTe6kQTRGBXHBosRlUQhQ/MPMmV1XaO
	 pbD0VlyOR4TJP2mKeJvVP7wFkUFs+ySFPCAe0dKdCGM0j35SzMe4GOrt931U+yEKP+
	 c4Lb6rd5NKQFR30D0YqwATn9IP/9nCvVcFInpXmBon+VwCbRVidWZm+K6dMagp9DTB
	 rD6r/o8JQ7mpqJ836GNtcImMjLksL9+c3djR4Xmtyg4XQyabJOIlKkIeaUEnQsqJ35
	 l0tdvX9eXc0Gw==
Message-ID: <5d273a008fc51a2fded785efbe30e5bd2a89b985.camel@kernel.org>
Subject: Re: [PATCH 08/13] ovl: Simplify ovl_lookup_real_one()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, David Howells
 <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever
 <chuck.lever@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir
 Goldstein	 <amir73il@gmail.com>, John Johansen
 <john.johansen@canonical.com>, Paul Moore	 <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn"	 <serge@hallyn.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date: Thu, 05 Feb 2026 07:38:03 -0500
In-Reply-To: <20260204050726.177283-9-neilb@ownmail.net>
References: <20260204050726.177283-1-neilb@ownmail.net>
	 <20260204050726.177283-9-neilb@ownmail.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76436-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[brown.name,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: 40622F2B34
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 15:57 +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> The primary purpose of this patch is to remove the locking from
> ovl_lookup_real_one() as part of centralising all locking of directories
> for name operations.
>=20
> The locking here isn't needed.  By performing consistency tests after
> the lookup we can be sure that the result of the lookup was valid at
> least for a moment, which is all the original code promised.
>=20
> lookup_noperm_unlocked() is used for the lookup and it will take the
> lock if needed only where it is needed.
>=20
> Also:
>  - don't take a reference to real->d_parent.  The parent is
>    only use for a pointer comparison, and no reference is needed for
>    that.
>  - Several "if" statements have a "goto" followed by "else" - the
>    else isn't needed: the following statement can directly follow
>    the "if" as a new statement
>  - Use a consistent pattern of setting "err" before performing a test
>    and possibly going to "fail".
>  - remove the "out" label (now that we don't need to dput(parent) or
>    unlock) and simply return from fail:.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/export.c | 61 ++++++++++++++++++-------------------------
>  1 file changed, 26 insertions(+), 35 deletions(-)
>=20
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb1567..dcd28ffc4705 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -359,59 +359,50 @@ static struct dentry *ovl_lookup_real_one(struct de=
ntry *connected,
>  					  struct dentry *real,
>  					  const struct ovl_layer *layer)
>  {
> -	struct inode *dir =3D d_inode(connected);
> -	struct dentry *this, *parent =3D NULL;
> +	struct dentry *this;
>  	struct name_snapshot name;
>  	int err;
> =20
>  	/*
> -	 * Lookup child overlay dentry by real name. The dir mutex protects us
> -	 * from racing with overlay rename. If the overlay dentry that is above
> -	 * real has already been moved to a parent that is not under the
> -	 * connected overlay dir, we return -ECHILD and restart the lookup of
> -	 * connected real path from the top.
> +	 * @connected is a directory in the overlay and @real is an object
> +	 * on @layer which is expected to be a child of @connected.
> +	 * The goal is to return a dentry from the overlay which corresponds
> +	 * to @real.  This is done by looking up the name from @real in
> +	 * @connected and checking that the result meets expectations.
> +	 *
> +	 * Return %-ECHILD if the parent of @real no-longer corresponds to
> +	 * @connected, and %-ESTALE if the dentry found by lookup doesn't
> +	 * correspond to @real.
>  	 */
> -	inode_lock_nested(dir, I_MUTEX_PARENT);
> -	err =3D -ECHILD;
> -	parent =3D dget_parent(real);
> -	if (ovl_dentry_real_at(connected, layer->idx) !=3D parent)
> -		goto fail;
> =20
> -	/*
> -	 * We also need to take a snapshot of real dentry name to protect us
> -	 * from racing with underlying layer rename. In this case, we don't
> -	 * care about returning ESTALE, only from dereferencing a free name
> -	 * pointer because we hold no lock on the real dentry.
> -	 */
>  	take_dentry_name_snapshot(&name, real);
> -	/*
> -	 * No idmap handling here: it's an internal lookup.
> -	 */
> -	this =3D lookup_noperm(&name.name, connected);
> +	this =3D lookup_noperm_unlocked(&name.name, connected);
>  	release_dentry_name_snapshot(&name);
> +
> +	err =3D -ECHILD;
> +	if (ovl_dentry_real_at(connected, layer->idx) !=3D real->d_parent)
> +		goto fail;
> +
>  	err =3D PTR_ERR(this);
> -	if (IS_ERR(this)) {
> +	if (IS_ERR(this))
>  		goto fail;
> -	} else if (!this || !this->d_inode) {
> -		dput(this);
> -		err =3D -ENOENT;
> +
> +	err =3D -ENOENT;
> +	if (!this || !this->d_inode)
>  		goto fail;
> -	} else if (ovl_dentry_real_at(this, layer->idx) !=3D real) {
> -		dput(this);
> -		err =3D -ESTALE;
> +
> +	err =3D -ESTALE;
> +	if (ovl_dentry_real_at(this, layer->idx) !=3D real)
>  		goto fail;
> -	}
> =20
> -out:
> -	dput(parent);
> -	inode_unlock(dir);
>  	return this;
> =20
>  fail:
>  	pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=3D%d, co=
nnected=3D%pd2, err=3D%i)\n",
>  			    real, layer->idx, connected, err);
> -	this =3D ERR_PTR(err);
> -	goto out;
> +	if (!IS_ERR(this))
> +		dput(this);
> +	return ERR_PTR(err);
>  }
> =20
>  static struct dentry *ovl_lookup_real(struct super_block *sb,

Reviewed-by: Jeff Layton <jlayton@kernel.org>

