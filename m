Return-Path: <linux-fsdevel+bounces-24463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53693F9DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE7EB21F69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4315AAC8;
	Mon, 29 Jul 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaV8kUDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAC8004F;
	Mon, 29 Jul 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268281; cv=none; b=J1yglG9t0O+FajhOAz1R8BZawXezp8Zkz7aNoiaequugwgieSse/7XW6TzM7PavFzDld9nQ6L28gT0vdnL67BVzu6mMW0uFRXi5yaaqu19HvwGVvE6ebXfvkbDngHfaQCqBDqzz2YsFSSNngEGD82EY3OK2sY+If4d2agfNz1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268281; c=relaxed/simple;
	bh=Xjk9/3K2La58GqYFP1mT6tUiDmazLKWz3gdhSQvHVoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2kE5KBisqtYNzBmq/AmgicFq70eIczzUEdeRCtjl1w/yY4sIODzUhLlqhCXsUyqEFNPpsweYyB+QWE5UqbX4pon1eyXH+nYpZwAu/YOfd1POnjJA31vdVkverpRMAGC/z50CzkyrS58VcLjhp0RbySc5kg11hl4RmZ1CPnryLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaV8kUDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC964C32786;
	Mon, 29 Jul 2024 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722268281;
	bh=Xjk9/3K2La58GqYFP1mT6tUiDmazLKWz3gdhSQvHVoA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qaV8kUDbcoLuDqbBio3SBFAPhJn3z2pExnW07qRef4jQS7O0tUzd/ABSIAaT594na
	 FOmDVoYDPMAaSPRXGmcNSDbr6d9rsIFw+hMjJyMQaJx4y0pWgtYTm4WuLTfsD1Qcon
	 Hs4S9kZ6qW69jd1hVA4aQlzSursiCpjwa4bT+WwCs5xSFzy3lKH6XeNOpX2VOgXfOh
	 WN41CL6BfX6wbLRXSJgFnA4/p7KsPhO4+2RlwVxT+TBNzsKW1Bz8DvE3XyT/GlTwn0
	 ehLGSOe1zf0ksfaBfQ8m3OA5Ibm3oh5bYduvv09K01yVipZWKeX1GbIPOCBrxEmQ/I
	 nN4rpjfyMpU+w==
Message-ID: <422ab8b216ea792156d12f5321f9fa1a12dbb93d.camel@kernel.org>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete
 "using_pgpriv2" flag
From: Jeff Layton <jlayton@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>, dhowells@redhat.com
Cc: willy@infradead.org, linux-cachefs@redhat.com, 
 linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 29 Jul 2024 11:51:18 -0400
In-Reply-To: <CAKPOu+8fgsNi3UVfrZQf9WBHwrXq_D=6oauqWJeiOqSeQedgaw@mail.gmail.com>
References: <20240729091532.855688-1-max.kellermann@ionos.com>
	 <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
	 <CAKPOu+8fgsNi3UVfrZQf9WBHwrXq_D=6oauqWJeiOqSeQedgaw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedY
	xp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZQiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/D
	CmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnokkZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 17:35 +0200, Max Kellermann wrote:
> On Mon, Jul 29, 2024 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> wrote:
> > Either way, you can add this to both patches:
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Stop the merge :-)
>=20
> I just found that my patch introduces another lockup; copy_file_range
> locks up this way:
>=20
> =C2=A0[<0>] folio_wait_private_2+0xd9/0x140
> =C2=A0[<0>] ceph_write_begin+0x56/0x90
> =C2=A0[<0>] generic_perform_write+0xc0/0x210
> =C2=A0[<0>] ceph_write_iter+0x4e2/0x650
> =C2=A0[<0>] iter_file_splice_write+0x30d/0x550
> =C2=A0[<0>] splice_file_range_actor+0x2c/0x40
> =C2=A0[<0>] splice_direct_to_actor+0xee/0x270
> =C2=A0[<0>] splice_file_range+0x80/0xc0
> =C2=A0[<0>] ceph_copy_file_range+0xbb/0x5b0
> =C2=A0[<0>] vfs_copy_file_range+0x33e/0x5d0
> =C2=A0[<0>] __x64_sys_copy_file_range+0xf7/0x200
> =C2=A0[<0>] do_syscall_64+0x64/0x100
> =C2=A0[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> Turns out that there are still private_2 users left in both fs/ceph
> and fs/netfs. My patches fix one problem, but cause another problem.
> Too bad!
>=20
> This leaves me confused again: how shall I fix this? Can all
> folio_wait_private_2() calls simply be removed?
> This looks like some refactoring gone wrong, and some parts don't
> make
> sense (like netfs and ceph claim ownership of the folio_private
> pointer). I could try to fix the mess, but I need to know how this is
> meant to be. David, can you enlighten me?
>=20
> Max

I suspect the folio_wait_private_2 call in ceph_write_begin should have
also been removed in ae678317b95, and it just got missed somehow in the
original patch. All of the other callsites that did anything with
private_2 were removed in that patch.

David, can you confirm that?
--=20
Jeff Layton <jlayton@kernel.org>

