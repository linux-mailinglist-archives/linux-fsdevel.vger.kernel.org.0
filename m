Return-Path: <linux-fsdevel+bounces-74829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLURNWajcGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:59:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5E54CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B77C602074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6C847DF97;
	Wed, 21 Jan 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eMN/lMeg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yi8kFdlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806234EEF3;
	Wed, 21 Jan 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989052; cv=none; b=kVTamg5Tz7pAFXAm+u7gFt4qiYqNS3zfKGEmyDsK+3oekUMJp51/XuLDT82RFpGFUnP6INu1lvCymhru3fihVAgqbMF2xVPp3Fs4jqpChviaLkDCDx8cA3fbhln65oL2CGokKFemBEHLsAobzDp5ngWwio198OlX7trTVqPWDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989052; c=relaxed/simple;
	bh=pHqudABIDdcD5woMz+bnxxVGyZ26dGxW93u10XDsAZ8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Axon0M3KU6w2xCQdbUZh9XVkjVwDRQyx/vq8RU5mIh+Hy3UUSpCkDzS19ZBiBcDg4M+NpHtUVTZ8+5IhHUAGLoZVibWJLWpei50bzr8R2Uqbk/8w0H/l3zI1hq4Dg1MDwbQbtiZqFIKnOnWhe5teb9LGKjM33qDs4mrTd1mURC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eMN/lMeg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yi8kFdlR; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 443D71D00082;
	Wed, 21 Jan 2026 04:50:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 04:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768989047; x=1769075447; bh=bD1lEv2YLNQCmRcVgKiCRGPHK3fMhagqCKb
	erwgwhpc=; b=eMN/lMegShBJNWoqFmBOZYannPY2LLl9ocxC3tqmxiBDJvyAQWt
	sGyDpj8tSYuy6iJ4WDdckWqkPD3QxFIh2O6zZRSRvPm9PF3K5KlkNjhtDC1mg8Io
	hKWQBcDeMysU/YcDvlu058eSjhKj26GSSBamZu4ExW3x0KumEmLlzdy708yzZwTm
	P+UXNbLWG0cPBtzmpmFbg0yWpzb16/gUSO0ibi6iVEXdxaMO0pPLPbsPvx3vEPW+
	AKRMN7+w6YxDGn/7jpLwffX/ZixzuMWnhWOinIDNZclF461O1ep+Vxiv9+xoIw5W
	lz+7vT7WRTccxDNOXIFfSpwZJ1zALlpn0SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768989047; x=
	1769075447; bh=bD1lEv2YLNQCmRcVgKiCRGPHK3fMhagqCKberwgwhpc=; b=Y
	i8kFdlRuSloOogB0tsFW1hEl7fTtTFGB99qmw+6W6he2UIIn9ZVLZDWZP4mRrPvj
	YaXWfKt0QMNDkdrRqlulGA0s2YHIlIXZf9D7R/Nbewk1SM6a7X0RhZMXJMuK5OPO
	xgZsE/eP7U7Ap1HtXkuWRyZhVP8X+BEHacOWMvoLUWc4TjD1jy7n6pTh8DZI+oIJ
	o5Jey43Eqibhe4QCrVVmmICaBYmFVubQYNeiNcsbfbK3kDESzI7UzGEfI3XstJ0M
	8nFUuaabPVL56z8Gu3kWUh2YcIV1VL66OHHyHA+1FU8JMQl43YykkTt+kUNS7c8U
	LfUm2WIjoDahJ0UpCWzfg==
X-ME-Sender: <xms:dqFwaYhF2GBsnqPdYP6-1UM6BhIXCMaWkSZoOE_QP0Ovv0h71OCjOg>
    <xme:dqFwabDo1ghM13-djbkM6ge8peTg6lYF3Djv9KK0OVrBr3AJ084jKXx8iWQXPPrC-
    GOGThRhtFsgYq4nkFkVmN3NurU9CyTcw9zxKK_bPAmwc0hwJA>
X-ME-Received: <xmr:dqFwaWvBDSOO3_KT5ZA6SgeE9QoWFrk9hH6OUu6z0JQ88pPNoRJ7l4yP3E7xir1jJjiulkg6THYzHQY6FKCAi-PDUulO0H2anw6A6nHpt_07>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhessh
    hushgvrdgtiidprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dqFwaXd6_UEy3trzGdvTmfqumOw5KrHRK6OfPTDn5dGgPMPfTtMtjg>
    <xmx:dqFwaT9fa29M3uvkW1YDrLUhpEnWfM7QfvmUM5s-Suvf4wDbaDAAXA>
    <xmx:dqFwaSQIEov4tRCM_ZVcendoX0DZIiFGS9rIrSomGaEyM1acK_Z_5w>
    <xmx:dqFwaUqkS6rKSDqmLvs-hBHaSeUr-Db9atMM7cAG7hRd1UJBrFP97Q>
    <xmx:d6FwaX2tHV9viJXdCOTRuUyZo3I4VgvHkJUoV1RCiQuXS-UzcQn7NEzk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 04:50:43 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: do not allow exporting of special kernel filesystems
In-reply-to: <20260121085028.558164-1-amir73il@gmail.com>
References: <20260121085028.558164-1-amir73il@gmail.com>
Date: Wed, 21 Jan 2026 20:50:40 +1100
Message-id: <176898904083.16766.14818617047357377637@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-74829-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 85C5E54CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026, Amir Goldstein wrote:
> pidfs and nsfs recently gained support for encode/decode of file handles
> via name_to_handle_at(2)/opan_by_handle_at(2).
>=20
> These special kernel filesystems have custom ->open() and ->permission()
> export methods, which nfsd does not respect and it was never meant to be
> used for exporting those filesystems by nfsd.
>=20
> Therefore, do not allow nfsd to export filesystems with custom ->open()
> or ->permission() methods.
>=20
> Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/export.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> Christian,
>=20
> I had enough of the stable file handles discussion [1].
>=20
> This patch which I already suggested [2] on week ago, states a justified
> technical reason why pidfs and nsfs should not be exported by nfsd,
> so let's use this technical reasoning and stop the philosophic discussions
> about what is a stable file handle is please.
>=20
> Regarding cgroupfs, we can either deal with it later or not - it is not
> a clear but as pidfs and nsfs which absolutely should be fixed
> retroactively in stable kernels.
>=20
> If you think that cgroupfs could benefit from "exhaustive" file handles [3]
> then we can implement open_by_handle_at(FD_CGROUPFS_ROOT, ... and that
> would classify cgroupfs the same as pidfs and nsfs.
>=20
> Thanks,
> Amir.
>=20
> [1] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-0-1a24=
7645cef5@kernel.org/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhkaGFtQRzTj2xaf2GJucoAY5CG=
iyUjB=3D8YA2zTbOtFvw@mail.gmail.com/
> [3] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-29-1a2=
47645cef5@kernel.org/
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 2a1499f2ad196..232dacac611e9 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -405,6 +405,7 @@ static struct svc_export *svc_export_lookup(struct svc_=
export *);
>  static int check_export(const struct path *path, int *flags, unsigned char=
 *uuid)
>  {
>  	struct inode *inode =3D d_inode(path->dentry);
> +	const struct export_operations *nop =3D inode->i_sb->s_export_op;
> =20
>  	/*
>  	 * We currently export only dirs, regular files, and (for v4
> @@ -422,13 +423,12 @@ static int check_export(const struct path *path, int =
*flags, unsigned char *uuid
>  	if (*flags & NFSEXP_V4ROOT)
>  		*flags |=3D NFSEXP_READONLY;
> =20
> -	/* There are two requirements on a filesystem to be exportable.
> -	 * 1:  We must be able to identify the filesystem from a number.
> -	 *       either a device number (so FS_REQUIRES_DEV needed)
> -	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> -	 * 2:  We must be able to find an inode from a filehandle.
> -	 *       This means that s_export_op must be set.
> -	 * 3: We must not currently be on an idmapped mount.
> +	/*
> +	 * The requirements for a filesystem to be exportable:
> +	 * 1. The filehandle must identify a filesystem by number
> +	 * 2. The filehandle must uniquely identify an inode
> +	 * 3. The filesystem must not have custom filehandle open/perm methods
> +	 * 4. The requested file must not reside on an idmapped mount
>  	 */
>  	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
>  	    !(*flags & NFSEXP_FSID) &&
> @@ -437,11 +437,16 @@ static int check_export(const struct path *path, int =
*flags, unsigned char *uuid
>  		return -EINVAL;
>  	}
> =20
> -	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +	if (!exportfs_can_decode_fh(nop)) {
>  		dprintk("exp_export: export of invalid fs type.\n");
>  		return -EINVAL;
>  	}
> =20
> +	if (nop->open || nop->permission) {
> +		dprintk("exp_export: export of non-standard fs type.\n");
> +		return -EINVAL;
> +	}
> +

It is not immediately obvious that this is safe when nop is NULL, but it
is because exportfs_can_decode_fh() checks for that case.  As that is a
static inline a static analyser can easily confirm this.  So it is
probably OK.

"non-standard" is not totally clear.  "special" might be better, or it
might not.  It is only a dprintk so it probably doesn't matter much.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks for posting this.  I think this is a good check to have whether
or not we decide to add a flag.

Thanks,
NeilBrown

>  	if (is_idmapped_mnt(path->mnt)) {
>  		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
>  		return -EINVAL;
> --=20
> 2.52.0
>=20
>=20
>=20


