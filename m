Return-Path: <linux-fsdevel+bounces-25184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E14949956
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D52876F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC0916BE26;
	Tue,  6 Aug 2024 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvv/qNRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AE7BB17;
	Tue,  6 Aug 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976975; cv=none; b=k/a2SHK701hjyUSbL/kfakYBpzESRHVOMaOf7gXRLewoLBL94f36q1uxMN1PWEaRlolVH0sjSyllV2uOQ192LuC/cGLCswbdcRK2nfkFx1iUpclRwwTq2n9qv/GTQwYtImBfWlhvWHUZVnHvdI6Lry30zIrrV0rNDvZDX0o7SEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976975; c=relaxed/simple;
	bh=8LuP9vLbd2qUuLXccenfFFOrwX2LpnruGO2VF8J6Vl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RLlZNRr6xhXX0DRBgMiUU0TJ+ccKIrj/1fML+o6G//AVIDRKnnhkak2rnI2UjCCR+3pX9hMkW2TUHC/4iDNjE74LwT5lbtkAsTEb8VDrTav+oEM+w1x2GhEdraolCVkHtbWhNgF45FzL5TEv7n8S/C1VsDYPCjPCzVs3PLmV678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvv/qNRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A7CC32786;
	Tue,  6 Aug 2024 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976975;
	bh=8LuP9vLbd2qUuLXccenfFFOrwX2LpnruGO2VF8J6Vl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gvv/qNRnSkrKozcp+5AT40YUjoAjK/57gttZ9JZBO99lAnSejuP4Pt5IiXMfQ+Twq
	 zVHVL7IPS7XB3yiBNftezmEeOtsE/qo8A/Jkubdn7FqMbrwzACo45D9xNiLuDZCI6F
	 y/dXVEZQLKp4kTgeG0vTxvEtNdGmLolgm6dQa7ZbnVcB372hr9wTxcYciNmI8ICXXD
	 JZJGjT1KZYkwoIE3rjcQ2yRKpTA607nJ9goo2LChZq+/NxniRm5Dk0cgB6WkQXv0o0
	 bbguM2YhcRElYHVu+nfSrVkFfhFPSn3yiMvPhNPmtoo0gY/v0m04yhTLHHLnHG87+3
	 2b1R4hwfGPRbw==
Message-ID: <e7a71f770a5a29325bafee0966adcf9b72d241e3.camel@kernel.org>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, Andi Kleen <ak@linux.intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	 <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Aug 2024 16:42:47 -0400
In-Reply-To: <CAGudoHHu42+VP6snbtg9gXog0UYaMv68eekxYt+2=5arrhZffg@mail.gmail.com>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
	 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
	 <87ikwdtqiy.fsf@linux.intel.com>
	 <CAGudoHHu42+VP6snbtg9gXog0UYaMv68eekxYt+2=5arrhZffg@mail.gmail.com>
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
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 21:22 +0200, Mateusz Guzik wrote:
> On Tue, Aug 6, 2024 at 9:11=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wr=
ote:
> >=20
> > Mateusz Guzik <mjguzik@gmail.com> writes:
> > >=20
> > > I would bench with that myself, but I temporarily don't have
> > > handy
> > > access to bigger hw. Even so, the below is completely optional
> > > and
> > > perhaps more of a suggestion for the future :)
> > >=20
> > > I hacked up the test case based on tests/open1.c.
> >=20
> > Don't you need two test cases? One where the file exists and one
> > where it doesn't. Because the "doesn't exist" will likely be slower
> > than before because it will do the lookups twice,
> > and it will likely even slow single threaded.
> >=20
> > I assume the penalty will also depend on the number of entries
> > in the path.
> >=20
> > That all seem to be an important considerations in judging the
> > benefits
> > of the patch.
> >=20
>=20
> This is why I suggested separately running "unlink1" which is
> guaranteed to create a file every time -- all iterations will fail
> the
> proposed fast path.
>=20
> Unless you meant a mixed variant where only some of the threads
> create
> files. Perhaps worthwhile to add, not hard to do (one can switch the
> mode based on passed worker number).
>=20

Well...

    # ./unlink1_processes -t 70 -s 100

    average:
    v6.10:		114455
    v6.10 + patch:	149513

I suspect what's happening here is that this patch relieves contention
for the inode_lock and that allows the unlinks to proceed faster.

Running it with a single process though:

    average:
    v6.10:		200106
    v6.10 + patch:	199188

So, ~.4% degradation there? That doesn't seem too bad given the gain in
the threaded test.
--=20
Jeff Layton <jlayton@kernel.org>

