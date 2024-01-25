Return-Path: <linux-fsdevel+bounces-9021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEC83D12F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 01:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFE2B24610
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 00:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198313DB86;
	Thu, 25 Jan 2024 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9bk/xiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBC1AAAE;
	Thu, 25 Jan 2024 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227131; cv=none; b=et/ZCkHUfjvmfwXwMrhMe5XNgLgfd+raf26gEZDUQhP67KV8McK/OqwYHVCeHFDGmbJo58QBfZxPE4hKMWs6FkpypzMamy11h2WZO7H6oRnDYUo4w/TRKNcM9fbIDp8hgqoKJfDq+pQ53qzp5RqmILQP7/4qwq4HaR3lEmETtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227131; c=relaxed/simple;
	bh=w8Z2v8eWoiJq1KFQQoVyrYEjjqrH587hUb7OHEk3JzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=as7ZF//oWWOHk4lhy8Uowf5cVBM436y1X47oBjdRJYcKQIWq3sgFzaJIXiRSSaKpUSMwhkJ4GtTyjsHzi4lWcegS8tijNmGaU3yeNNW6lhbnDvnRUrkkTb4ucFB1UTdm+eV6wSPWrqiVIFDO+IeZKYp1WeEWl8+vcK7+6e2/EYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9bk/xiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB8DC433F1;
	Thu, 25 Jan 2024 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706227130;
	bh=w8Z2v8eWoiJq1KFQQoVyrYEjjqrH587hUb7OHEk3JzE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R9bk/xiqu9MU45vfFwXI2QGlTSHXdVAez2C/YS831sj+G4W1ZbQJQwBqiYggnPkGE
	 3ANq4+eudHEK1a9BOT+J0eyPmhaWicZ7G19OMnghg595eUwmOFEV+dEyd3wLnKKxen
	 uBUWXWzjobhCrDKjD7taM4NOtWN5UElfsyATilByPAQ9voFN7EUxCHoW5y3Zu42dbx
	 gLYJHmrfyWwqOp2KFV0GRsczxwUygBS2cLlPPIKaxJi3eqepWT2qFGnejKppQGDSnA
	 008+rAFQBh3UAUzkAsm5Cm3Y+Ks38mdSQwZj2EsFCJmIxTGATnod2MeV4zDIya+iG8
	 I8/8jPHXHyeIg==
Message-ID: <0d95c18c9142b5e9e542280806afbb47734f0f95.camel@kernel.org>
Subject: Re: [PATCH v2 00/41] filelock: split struct file_lock into
 file_lock and file_lease structs
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alexander Aring <aahringo@redhat.com>, David Teigland
 <teigland@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Andreas
 Gruenbacher <agruenba@redhat.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>,  Anna Schumaker <anna@kernel.org>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Jan Kara <jack@suse.cz>,  Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>,  Namjae Jeon <linkinjeon@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>,  linux-kernel@vger.kernel.org,
 v9fs@lists.linux.dev,  linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 18:58:46 -0500
In-Reply-To: <170622208395.21664.2510213291504081000@noble.neil.brown.name>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
	, <ZbJ2zc3I3uBwF/RE@tissot.1015granger.net>
	 <170622208395.21664.2510213291504081000@noble.neil.brown.name>
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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 09:34 +1100, NeilBrown wrote:
> On Fri, 26 Jan 2024, Chuck Lever wrote:
> > On Thu, Jan 25, 2024 at 05:42:41AM -0500, Jeff Layton wrote:
> > > Long ago, file locks used to hang off of a singly-linked list in stru=
ct
> > > inode. Because of this, when leases were added, they were added to th=
e
> > > same list and so they had to be tracked using the same sort of
> > > structure.
> > >=20
> > > Several years ago, we added struct file_lock_context, which allowed u=
s
> > > to use separate lists to track different types of file locks. Given
> > > that, leases no longer need to be tracked using struct file_lock.
> > >=20
> > > That said, a lot of the underlying infrastructure _is_ the same betwe=
en
> > > file leases and locks, so we can't completely separate everything.
> > >=20
> > > This patchset first splits a group of fields used by both file locks =
and
> > > leases into a new struct file_lock_core, that is then embedded in str=
uct
> > > file_lock. Coccinelle was then used to convert a lot of the callers t=
o
> > > deal with the move, with the remaining 25% or so converted by hand.
> > >=20
> > > It then converts several internal functions in fs/locks.c to work
> > > with struct file_lock_core. Lastly, struct file_lock is split into
> > > struct file_lock and file_lease, and the lease-related APIs converted=
 to
> > > take struct file_lease.
> > >=20
> > > After the first few patches (which I left split up for easier review)=
,
> > > the set should be bisectable. I'll plan to squash the first few
> > > together to make sure the resulting set is bisectable before merge.
> > >=20
> > > Finally, I left the coccinelle scripts I used in tree. I had heard it
> > > was preferable to merge those along with the patches that they
> > > generate, but I wasn't sure where they go. I can either move those to=
 a
> > > more appropriate location or we can just drop that commit if it's not
> > > needed.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > v2 looks nicer.
> >=20
> > I would add a few list handling primitives, as I see enough
> > instances of list_for_each_entry, list_for_each_entry_safe,
> > list_first_entry, and list_first_entry_or_null on fl_core.flc_list
> > to make it worth having those.
> >=20
> > Also, there doesn't seem to be benefit for API consumers to have to
> > understand the internal structure of struct file_lock/lease to reach
> > into fl_core. Having accessor functions for common fields like
> > fl_type and fl_flags could be cleaner.
>=20
> I'm not a big fan of accessor functions.  They don't *look* like normal
> field access, so a casual reader has to go find out what the function
> does, just to find the it doesn't really do anything.

I might have been a bit too hasty with the idea. I took a look earlier
today and it gets pretty ugly trying to handle these fields with
accessors. flc_flags, for instance will need both a get and a set
method, which gets wordy after a while.

Some of the flc_list accesses don't involve list walks either so I don't
think we'll ever be able to make this "neat" without a ton of one-off
accessors.

> But neither am I a fan have requiring filesystems to use
> "fl_core.flc_foo".  As you say, reaching into fl_core isn't ideal.
>=20

I too think it's ugly.

> It would be nice if we could make fl_core and anonymous structure, but
> that really requires -fplan9-extensions which Linus is on-record as not
> liking.
> Unless...
>=20
> How horrible would it be to use
>=20
>    union {
>        struct file_lock_core flc_core;
>        struct file_lock_core;
>    };
>=20
> I think that only requires -fms-extensions, which Linus was less
> negative towards.  That would allow access to the members of
> file_lock_core without the "flc_core." prefix, but would still allow
> getting the address of 'flc_core'.
> Maybe it's too ugly.
>=20

I'd rather not rely on special compiler flags.

> While fl_type and fl_flags are most common, fl_pid, fl_owner, fl_file
> and even fl_wait are also used.  Having accessor functions for all of tho=
se
> would be too much I think.
>=20

Some of them need setters too, and some like fl_flags like to be able to
do this:

    fl->fl_flags |=3D FL_SLEEP;

That's hard to deal with in an accessor unless you want to do it with
macros or something.

> Maybe higher-level functions which meet the real need of the filesystem
> might be a useful approach:
>=20
>  locks_wakeup(lock)
>  locks_wait_interruptible(lock, condition)
>  locks_posix_init(lock, type, pid, ...) ??
>  locks_is_unlock() - fl_type is compared with F_UNLCK 22 times.
>=20
> While those are probably a good idea, through don't really help much
> with reducing the need for accessor functions.
>=20

I can take a look at some of those. Reducing the number of instances can
only help.

> I don't suppose we could just leave the #defines in place?  Probably not
> a good idea.
>=20
> Maybe spell "fl_core" as "c"?  lk->c.flc_flags ???
>=20

It's at least a little shorter. I can make that change if it's
preferred.

>=20
> And I wonder if we could have a new fl_flag for 'FOREIGN' locks rather
> than encoding that flag in the sign of the pid.  That seems a bit ...
> clunky?
>=20

The kernel just treats the fl_pid as an opaque value that gets reported
to various consumers. Having it encoded in the sign is actually more
convenient, since reporting "foreign" lock holders as negative pid
values has some precedent in Unix.

flock and posix locks conflict on BSD, and the POSIX lock API reports
fl_pid as '-1' when there is a conflicting flock lock. I think solaris
may also report remote NFS locks as negative numbers too? (not certain
there).

So it works in our favor in this case, but it is a hack.

Now that I look too, I'm not sure why fl_pid is unsigned given that
pid_t is signed. I'll have to look into that as well.
--=20
Jeff Layton <jlayton@kernel.org>

