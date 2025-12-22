Return-Path: <linux-fsdevel+bounces-71817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF9CD5360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 914D930393EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8721FF35;
	Mon, 22 Dec 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AXDcShST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cG0437ix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58281F3BA4;
	Mon, 22 Dec 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393671; cv=none; b=nt+Zv1N+aboCJ/AWtiIt6Fqs7+YWujxH9YSx9iF2bA7Fk+RI9DCb+qn9b4hUpK3Amu2fChaC5X26h5Xhp2opJU7f0NG14FRdgWzQXfF8j/n6klJjDPanCbD8arGV+LDwAJtPm5C5w0aJ29vAbDE9xR8fTsKHGSsDW2aNCOpLht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393671; c=relaxed/simple;
	bh=hXBkUL4bpUJA3ygWep4d0JCg2YhgBKEK21mCJNmapPE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=csLAF6yN2wthdP7YXE+Y5XPAaUSXyHmdQRjTGsn+oWmYz0myFwFtXKsDT9tMgqUJZQKLqojcoFSMX0x8w3VtSnPJpGyCcPGbiO90FZSEueBVBp5HzpzBHbsUJbg9Fqw4GxQz18O6UebHon7hLNQK+Sn9S2s6BEH1FH1hcYv93ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AXDcShST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cG0437ix; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 37A331D0007E;
	Mon, 22 Dec 2025 03:54:29 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766393669;
	 x=1766480069; bh=wvmwf3OpGHoDU2nbu11x0x8a23pnPis6thF+lYtVYNE=; b=
	AXDcShST7/5b6vfoaTzW6t7INMeYJEpyxOjLqkgiFl46fQREmnHWr9jUEKXYlIFz
	+Er1NU9VqjRx3ZdnXt6VYba3G18xPOSExSApfaOYgGlBNzdV/aKPtnS+QYYXJhN0
	3TUYEje+AEKYF8LN8kXoET6fG4SYo10IqG+3eJfw/Ed4E8TTa4jk/PiToO27r9En
	h/pKvhgwWUzhYUCCyP5/2j3Zn4JgKvRhGQDMhlB+TXMEzJzLGL8ze//9iY3KE1L2
	OPMq5a28VuZTS3vAkLcPSvAy2xL1zQmKvw3+GQ42g7pcFgtYS7go6qGXVpS/g153
	O3U5ziYN3baio7bXdMMkNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766393669; x=
	1766480069; bh=wvmwf3OpGHoDU2nbu11x0x8a23pnPis6thF+lYtVYNE=; b=c
	G0437ixZ88pvL1PLkupdCYYWwmlZ5TsLzUwKHaLNxS4z4TsnDQZTOsKzPqgf4xXn
	0DnWa4agafha6LiRO/Ze684qqn+kNXu/Yvi+iAZn5mW54YTYSvKTCLZqtqogqa1k
	DW1mGFRUrWOkgRal1ciz7HNe+ekiAlfmJsw1HVmBN2QUlRpNk/cwNSy2YLwHPvRW
	ZifLKZofKCmuviUsuBbmBkQNfENHd3Y/dRLtcZ9GZ/4XGGo3UA1xKOfRqZlHbSQL
	ws6mDwRPj0++P7kDw5fSJ3bB4MxELAETTiXyTQkOu3h0xpZMrHFd+OGUpZDB3/is
	fDhO0i6FS9be9/6RTZPwg==
X-ME-Sender: <xms:RAdJaT8YUOmKWReqtOO-7Vyc5l6khmMM1ygatZQmsMKnOvsY0vLFIw>
    <xme:RAdJaajAhSS8gnhBicId8jD8KKONNLO1v0SpCrLQVkuVP3Bk2m7EuJPgUpFDgNML3
    FWPIU0V6NsaCnbx_wnz8zyuf5WhQpUfiMhG5RvkS5xol5_KYBYl1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RAdJaYHaXYIK6xQ2YejL92cjJVJ_54brepCUMdA2qP8deL8gucQClQ>
    <xmx:RAdJacw8yG8NrRkCb7aIo3sKxTP64voP7hP0WXfnD4vhmYGh_j7O_w>
    <xmx:RAdJaVo-3Po9i6FS218Mlf3l7P_rJmY6JX8ycrJlz6IR5dbH_Ri0_g>
    <xmx:RAdJaehO8FHbDA1QWt-Jw01W2I5ej5Jidc2-Y2tnSqMwun3mQW4mMw>
    <xmx:RQdJaa6DUZfohbwDPsseqyYHn9ZEZLvl1ZsFqP1Zacu3WtipXtDYR8Xl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1E06C40054; Mon, 22 Dec 2025 03:54:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFH8t3pChEx3
Date: Mon, 22 Dec 2025 09:54:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <43f1fd40-438a-4589-a6f5-7e044a9a3caa@app.fastmail.com>
In-Reply-To: <20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de>
References: <20251222-uapi-fuse-v1-1-85a61b87baa0@linutronix.de>
Subject: Re: [PATCH] fuse: uapi: use UAPI types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025, at 09:06, Thomas Wei=C3=9Fschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
>
> Use the fixed-width integer types provided by the UAPI headers instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please check the whitespace though:

> @@ -307,53 +303,53 @@ struct fuse_attr {
>   * Linux.
>   */
>  struct fuse_sx_time {
> -	int64_t		tv_sec;
> -	uint32_t	tv_nsec;
> -	int32_t		__reserved;
> +	__s64		tv_sec;
> +	__u32	tv_nsec;
> +	__s32		__reserved;
>  };

This looks misaligned now, same for any other struct that
mixes signed and unsigned types, like fuse_open_out.

> @@ -1298,14 +1294,14 @@ enum fuse_uring_cmd {
>   * In the 80B command area of the SQE.
>   */
>  struct fuse_uring_cmd_req {
> -	uint64_t flags;
> +	__u64 flags;
>=20
>  	/* entry identifier for commits */
> -	uint64_t commit_id;
> +	__u64 commit_id;
>=20
>  	/* queue the command is for (queue index) */
> -	uint16_t qid;
> -	uint8_t padding[6];
> +	__u16 qid;
> +	__u8 padding[6];
>  };

Maybe also change this to use tab for alignment like all
the other structures.

    Arnd

