Return-Path: <linux-fsdevel+bounces-73371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6FD16848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 04:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F9F3039847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 03:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB034B1A6;
	Tue, 13 Jan 2026 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpmp715a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0E284B54;
	Tue, 13 Jan 2026 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275213; cv=none; b=ft+HZIf6YaFtVrDz1/Ir6oTRVgA+Xlv+u7CQbfbxtc5isDtOHaqaijWY1ZVwENPg38xE0I4DtQ6hlAXGVP6oJOzrabSEZoAFJjIqSxrfa4tasGdzkXx9tVovsPhsYZqyKyzynTq1ffazwgcE9ClqWLhwTf48H6oRyEir6UpZ3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275213; c=relaxed/simple;
	bh=sgTKCfGG+ujwKC4Dd64UEjm0eoToqgRObMoSTSjLZXI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t2b7Dj2EPA5xhyfLouDgq2zHJuZuvbra/66hdgn56aPHKeDgEV6p0c2zAG8MxwwlDCQppdvvHbgwp0JD5kYYho5a1spPyw8G8U//axnD07U6BPDn2M04a87pCIsb/vwpbt1kOabyUaWpsmqFLbSrbRvJom06eDUKDH3tRTexFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpmp715a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5A1C4AF09;
	Tue, 13 Jan 2026 03:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275213;
	bh=sgTKCfGG+ujwKC4Dd64UEjm0eoToqgRObMoSTSjLZXI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gpmp715aEfjdGQRP1Lsy2r9WnRwxooF4LBHteETys7E9S/B4AasmzbM9fCX6h+3sG
	 mx+e2/0p7Drd8yIuHQZFr1ulX314ftQQqLwD9zVG5P7rS3XnOhA0AF2jiawsCSmcl3
	 vfR5mn0VnFPR8lGZy1csRlIAU84Mz27Lg8HaO/tXRO/aXyMxst5MC1reJS9E55YnIe
	 ufSLK3aXwEchtOBEMHe+xnG8RegKllS1ZXNu8I0CxBJ3aAXaPyO8gQZplqnX6kQwVp
	 O0RIDZOTjlSCeamfAwdPviopfRpZNcfSn9TxofFA0k+eFJd+ylTEPlMWCG1nQT/Upw
	 iLtQVk4ax3o6g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF59FF40068;
	Mon, 12 Jan 2026 22:33:31 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 22:33:31 -0500
X-ME-Sender: <xms:C71laZTSvFftyQUq7Fso7o5Q4dyoUTE-4uhN5qTY6WsLIadic9rAuA>
    <xme:C71ladl0lVRJEtiaQ2kMNsU9UPlgPiOOc3YeANP_pNL_b-Zo_mMEp3GUiqHbZIN_e
    YBU0cqLZffQ7nXHdzMYNBUX2hCua-ogzwXOGy66PgaqhfKkT4TNvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrlhhmvghiugesihhgrghl
    ihgrrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdrtghomh
    dprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghorhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:C71laX12KT62jCgJVH1DIh3MjTLZqmVvD7KKznDP-_MfRQvSvwD_JQ>
    <xmx:C71laUeryqxK-dQw6SWpNK8ZYdAb-Yay47668xkP5zFLem9ILWbMkw>
    <xmx:C71laT5wDJuAa36sVzQWEcl8ELv0IbbgbfxZfLseOECNaZL1dX5gxw>
    <xmx:C71laf8Upy7a_7AaLZ1nTEfYaFx87F05uNvr_-bs8VXWCSx_CQ14Zg>
    <xmx:C71laSIs34B4Pu6cEkSUTR-BMI_avWjiKs710G9gCqzctDGwpMgQ3ZyJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ADA6E780054; Mon, 12 Jan 2026 22:33:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkghU2ftp2PN
Date: Mon, 12 Jan 2026 22:33:11 -0500
From: "Chuck Lever" <cel@kernel.org>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Message-Id: <7ac583b8-3480-4a54-bcd7-9b1a8689a7f7@app.fastmail.com>
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
Subject: Re: [PATCH 0/4] exportfs: Some kernel-doc fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Jan 12, 2026, at 8:51 PM, Andr=C3=A9 Almeida wrote:
> This short series removes some duplicated documentation and address so=
me
> kernel-doc issues:
>
> WARNING: ../include/linux/exportfs.h:289 struct member 'get_uuid' not=20
> described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'map_blocks' no=
t=20
> described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'commit_blocks'=20
> not described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'permission' no=
t=20
> described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'open' not=20
> described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'flags' not=20
> described in 'export_operations'
>
> ---
> Andr=C3=A9 Almeida (4):
>       exportfs: Fix kernel-doc output for get_name()
>       exportfs: Mark struct export_operations functions at kernel-doc
>       exportfs: Complete kernel-doc for struct export_operations
>       docs: exportfs: Use source code struct documentation
>
>  Documentation/filesystems/nfs/exporting.rst | 42 ++++----------------=
---------
>  include/linux/exportfs.h                    | 33 ++++++++++++++++----=
---
>  2 files changed, 28 insertions(+), 47 deletions(-)
> ---
> base-commit: 9c7ef209cd0f7c1a92ed61eed3e835d6e4abc66c
> change-id: 20260112-tonyk-fs_uuid-973d5fdfc76f
>
> Best regards,
> --=20
> Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


--=20
Chuck Lever

