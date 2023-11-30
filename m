Return-Path: <linux-fsdevel+bounces-4440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA867FF67F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE2C1C21102
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACFB54F9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo3AlOb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96E524C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 16:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C32C433C8;
	Thu, 30 Nov 2023 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701361664;
	bh=djhr8I4dYyedFsxx13sC0A7qZaNLy5eVuXMCyRrl6RA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mo3AlOb4zCS3ZEiLjfOw65xhMqQxeJruRLMExGW0uyhREc4GlmZmk6DiZ4n1+s0DA
	 IwuSaDZkonTALPf2UfGYXyrf3RuCCUJhrtlGRRkMW1AsGjSGnzVZuVMJrpEjfMT169
	 sG+o2Y9xsSifx22RMmDBM2JhKw7RBlChfvZFzACjAnIPOb1b8iIUp9dQj2YjB4x7l6
	 3zw6gvPMYjtgaSIcQNVQ98Tzccown55XTXCnRicp90sDwvb0jOh/BXJW3wRFXsKYCz
	 PlZl8WFVndKhJvtCfoYpHraXPbOmfAxc2YxKapwuN4/ieodj4MOvrHtrRSxnpvmaEa
	 uXQlxMRvBSAXA==
Message-ID: <a0011d31ad58112a13a0cad5746095f508a3eb99.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from
 do_splice_direct()
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, Jan
 Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, Jens Axboe
 <axboe@kernel.dk>,  Miklos Szeredi <miklos@szeredi.hu>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Nov 2023 11:27:42 -0500
In-Reply-To: <20231130141624.3338942-2-amir73il@gmail.com>
References: <20231130141624.3338942-1-amir73il@gmail.com>
	 <20231130141624.3338942-2-amir73il@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/
	r0kmR/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2BrQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRIONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZWf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQOlDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7RjiR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27XiQQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBMYXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9qLqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoac8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3FLpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx
	3bri75n1TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y+jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5dHxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBMBAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4hN9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPepnaQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQRERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8EewP8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0XzhaKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyA
	nLqRgDgR+wTQT6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7hdMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjruymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItuAXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfDFOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbosZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDvqrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51asjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qGIcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbLUO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0
	b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSUapy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5ddhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7eflPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7BAKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuac
	BOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZ
	QiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/DCmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnok
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 16:16 +0200, Amir Goldstein wrote:
> In preparation of calling do_splice_direct() without file_start_write()
> held, create a new helper splice_file_range(), to be called from context
> of ->copy_file_range() methods instead of do_splice_direct().
>=20
> Currently, the only difference is that splice_file_range() does not take
> flags argument and that it asserts that file_start_write() is held, but
> we factor out a common helper do_splice_direct_actor() that will be used
> later.
>=20
> Use the new helper from __ceph_copy_file_range(), that was incorrectly
> passing to do_splice_direct() the copy flags argument as splice flags.
> The value of copy flags in ceph is always 0, so it is a smenatic bug fix.
>=20
> Move the declaration of both helpers to linux/splice.h.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ceph/file.c         |  9 +++---
>  fs/read_write.c        |  6 ++--
>  fs/splice.c            | 71 ++++++++++++++++++++++++++++++------------
>  include/linux/fs.h     |  2 --
>  include/linux/splice.h | 13 +++++---
>  5 files changed, 66 insertions(+), 35 deletions(-)
>=20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3b5aae29e944..f11de6e1f1c1 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -12,6 +12,7 @@
>  #include <linux/falloc.h>
>  #include <linux/iversion.h>
>  #include <linux/ktime.h>
> +#include <linux/splice.h>
> =20
>  #include "super.h"
>  #include "mds_client.h"
> @@ -3010,8 +3011,8 @@ static ssize_t __ceph_copy_file_range(struct file *=
src_file, loff_t src_off,
>  		 * {read,write}_iter, which will get caps again.
>  		 */
>  		put_rd_wr_caps(src_ci, src_got, dst_ci, dst_got);
> -		ret =3D do_splice_direct(src_file, &src_off, dst_file,
> -				       &dst_off, src_objlen, flags);
> +		ret =3D splice_file_range(src_file, &src_off, dst_file, &dst_off,
> +					src_objlen);
>  		/* Abort on short copies or on error */
>  		if (ret < (long)src_objlen) {
>  			doutc(cl, "Failed partial copy (%zd)\n", ret);
> @@ -3065,8 +3066,8 @@ static ssize_t __ceph_copy_file_range(struct file *=
src_file, loff_t src_off,
>  	 */
>  	if (len && (len < src_ci->i_layout.object_size)) {
>  		doutc(cl, "Final partial copy of %zu bytes\n", len);
> -		bytes =3D do_splice_direct(src_file, &src_off, dst_file,
> -					 &dst_off, len, flags);
> +		bytes =3D splice_file_range(src_file, &src_off, dst_file,
> +					  &dst_off, len);
>  		if (bytes > 0)
>  			ret +=3D bytes;
>  		else
> diff --git a/fs/read_write.c b/fs/read_write.c
> index f791555fa246..642c7ce1ced1 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1423,10 +1423,8 @@ ssize_t generic_copy_file_range(struct file *file_=
in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {
> -	lockdep_assert(file_write_started(file_out));
> -
> -	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> +	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
> +				 min_t(size_t, len, MAX_RW_COUNT));
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
> =20
> diff --git a/fs/splice.c b/fs/splice.c
> index 3fce5f6072dd..9007b2c8baa8 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1170,25 +1170,10 @@ static void direct_file_splice_eof(struct splice_=
desc *sd)
>  		file->f_op->splice_eof(file);
>  }
> =20
> -/**
> - * do_splice_direct - splices data directly between two files
> - * @in:		file to splice from
> - * @ppos:	input file offset
> - * @out:	file to splice to
> - * @opos:	output file offset
> - * @len:	number of bytes to splice
> - * @flags:	splice modifier flags
> - *
> - * Description:
> - *    For use by do_sendfile(). splice can easily emulate sendfile, but
> - *    doing it in the application would incur an extra system call
> - *    (splice in + splice out, as compared to just sendfile()). So this =
helper
> - *    can splice directly through a process-private pipe.
> - *
> - * Callers already called rw_verify_area() on the entire range.
> - */
> -long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> -		      loff_t *opos, size_t len, unsigned int flags)
> +static long do_splice_direct_actor(struct file *in, loff_t *ppos,
> +				   struct file *out, loff_t *opos,
> +				   size_t len, unsigned int flags,
> +				   splice_direct_actor *actor)
>  {
>  	struct splice_desc sd =3D {
>  		.len		=3D len,
> @@ -1207,14 +1192,60 @@ long do_splice_direct(struct file *in, loff_t *pp=
os, struct file *out,
>  	if (unlikely(out->f_flags & O_APPEND))
>  		return -EINVAL;
> =20
> -	ret =3D splice_direct_to_actor(in, &sd, direct_splice_actor);
> +	ret =3D splice_direct_to_actor(in, &sd, actor);
>  	if (ret > 0)
>  		*ppos =3D sd.pos;
> =20
>  	return ret;
>  }
> +/**
> + * do_splice_direct - splices data directly between two files
> + * @in:		file to splice from
> + * @ppos:	input file offset
> + * @out:	file to splice to
> + * @opos:	output file offset
> + * @len:	number of bytes to splice
> + * @flags:	splice modifier flags
> + *
> + * Description:
> + *    For use by do_sendfile(). splice can easily emulate sendfile, but
> + *    doing it in the application would incur an extra system call
> + *    (splice in + splice out, as compared to just sendfile()). So this =
helper
> + *    can splice directly through a process-private pipe.
> + *
> + * Callers already called rw_verify_area() on the entire range.
> + */
> +long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> +		      loff_t *opos, size_t len, unsigned int flags)
> +{
> +	return do_splice_direct_actor(in, ppos, out, opos, len, flags,
> +				      direct_splice_actor);
> +}
>  EXPORT_SYMBOL(do_splice_direct);
> =20
> +/**
> + * splice_file_range - splices data between two files for copy_file_rang=
e()
> + * @in:		file to splice from
> + * @ppos:	input file offset
> + * @out:	file to splice to
> + * @opos:	output file offset
> + * @len:	number of bytes to splice
> + *
> + * Description:
> + *    For use by generic_copy_file_range() and ->copy_file_range() metho=
ds.
> + *
> + * Callers already called rw_verify_area() on the entire range.
> + */
> +long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
> +		       loff_t *opos, size_t len)
> +{
> +	lockdep_assert(file_write_started(out));
> +
> +	return do_splice_direct_actor(in, ppos, out, opos, len, 0,
> +				      direct_splice_actor);
> +}
> +EXPORT_SYMBOL(splice_file_range);
> +
>  static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
>  {
>  	for (;;) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ae0e2fb7bcea..04422a0eccdd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3052,8 +3052,6 @@ ssize_t copy_splice_read(struct file *in, loff_t *p=
pos,
>  			 size_t len, unsigned int flags);
>  extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
>  		struct file *, loff_t *, size_t, unsigned int);
> -extern long do_splice_direct(struct file *in, loff_t *ppos, struct file =
*out,
> -		loff_t *opos, size_t len, unsigned int flags);
> =20
> =20
>  extern void
> diff --git a/include/linux/splice.h b/include/linux/splice.h
> index 6c461573434d..49532d5dda52 100644
> --- a/include/linux/splice.h
> +++ b/include/linux/splice.h
> @@ -80,11 +80,14 @@ extern ssize_t add_to_pipe(struct pipe_inode_info *,
>  long vfs_splice_read(struct file *in, loff_t *ppos,
>  		     struct pipe_inode_info *pipe, size_t len,
>  		     unsigned int flags);
> -extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc =
*,
> -				      splice_direct_actor *);
> -extern long do_splice(struct file *in, loff_t *off_in,
> -		      struct file *out, loff_t *off_out,
> -		      size_t len, unsigned int flags);
> +ssize_t splice_direct_to_actor(struct file *file, struct splice_desc *sd=
,
> +			       splice_direct_actor *actor);
> +long do_splice(struct file *in, loff_t *off_in, struct file *out,
> +	       loff_t *off_out, size_t len, unsigned int flags);
> +long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> +		      loff_t *opos, size_t len, unsigned int flags);
> +long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
> +		       loff_t *opos, size_t len);
> =20
>  extern long do_tee(struct file *in, struct file *out, size_t len,
>  		   unsigned int flags);

Looks OK to me:

Acked-by: Jeff Layton <jlayton@kernel.org>

