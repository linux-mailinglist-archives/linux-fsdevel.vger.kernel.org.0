Return-Path: <linux-fsdevel+bounces-15917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99301895D37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5115028AEC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E715B0E8;
	Tue,  2 Apr 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="dHrd5vKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJlQJ0A9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8315AAA1;
	Tue,  2 Apr 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088048; cv=none; b=Ez4gxm3MN4Sx+9+v6XDEQsxgZWVuZ69nAb540xLV7912iOsH4M/tiFfnilnTwYcbsdYThgbVye5r4n6vhzcvySJpp9b+qtMlLOuoFKEUVijwAUHHBre1FniHGlhpc9gH0tyfIieH5zklzGv63fYa1yo9Dcr65TRh2WYZjgFaWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088048; c=relaxed/simple;
	bh=oQG74lIw7JzbfZaqhhdIPaSHwhkDfjMfH91CA0M6Fz0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=u8hqNO0QHkYRlgmH/Jt5d2hCkP5r1LmjrBuv9cclpff55QbDYzgmlLV/uo0iNEzbxBSI/teCUKGGM7fQSbrf9VAKSFHRELZDbN3KjC95BKvtLV3r7FySW4Ly8B/EYLpRGT3923DSRdaeIwD9fRTJESh/imw3ff1LiHYm8gqnDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=dHrd5vKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJlQJ0A9; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4692718000AA;
	Tue,  2 Apr 2024 16:00:45 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 16:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712088044; x=1712174444; bh=OW/hxEQUut
	Xp7x5hTZ4AAb/775nuMaqmDiM9VHgDKFk=; b=dHrd5vKKARetFhs2l68SvwcprX
	ioKAlXeUlwsOvxxA49OKRLCqfLNDPRuDOKnyuvHTk/CF+CbTOPEdyBVyLe0ScA4j
	HHA0ApLbcW7hAhUSnxQN/EV267GxUdDsY8nJnfaXok433e4Bh5AVEVXWR5Y38prp
	zb8eU7arUZrvYkWFoM6++GAPGHX6aZdyvBMOYiL3+9dEWfGgVgmLRhE0X8KOSj0L
	r3AcIK1EtEhSyEAL1vUr00x7IPAQZOsjcn7JbzlYN3fQC5kfxfx2IS0ymaUvZ/xq
	8Wm6XATlbpfYEQJOuJRRokD9FAMss5qW9hplrTw+H0jZI7VEMpMY3/f9Gcbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712088044; x=1712174444; bh=OW/hxEQUutXp7x5hTZ4AAb/775nu
	MaqmDiM9VHgDKFk=; b=YJlQJ0A9QysXP6BIBmidXnVuYD9xE2CsFFvTBnnjW7pY
	vfnCNn0HX7WCd99iElTcukxGjzjUxcE9b0t1cS+MCuXmd1sCaJA8YFiIyFl/R3Sb
	m9jwEQ7EX2KPmQDbYesggRHMHXx1FasbAyyUMtoVIRZ56Hqgp2mg8/Zxxor+blko
	z8p6eHfuyPNAfeKe9FAxslk3IGWidL0gFf89i8WmNJG7ZH0ZlJeIMJmAFbXNSfMV
	/IArAaNLJDiBqprZ+M2NbxiN1c3+PQl4sMnxIPyjSRerHJBLk1wZkNa1/6QgC1D/
	GH+aLzYoKHI12dYlwXp9kp9BmEdGgdpJ0xCqpbO8mg==
X-ME-Sender: <xms:7GMMZrGaDHYL0raARx7IDtuM-qMNLWS-tmdjtwzlFrrqu_2cL5dUiQ>
    <xme:7GMMZoX_evcaB7kzFKIJ2l49ZS2u2iASUEg6KGEvWgwfbPYSPHiEhRmMP85UzzjMf
    8LCxgQN77uFrSyv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfejuddthedtgfeuueeltdekfeekvdfgveeifeduteekheff
    jefgieehheekgeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:7GMMZtKh7LwQTiHt5G9YL6mgxpAKysOKoIUcM9mut0RgOCP1XseZ7Q>
    <xmx:7GMMZpH-nphrXeADRlUrz0lXIn1EE93x68S4waR4LDl8lmhxd3Ybww>
    <xmx:7GMMZhVuWHzjk-ytc1LdCstihbgJFtvkBhb4e_6n1Uw4fPlMLKUL4A>
    <xmx:7GMMZkNZ0JZqZZuq_bE2CHOmQXhNgm18nJxS75fhMYSMmbr0P4CWLw>
    <xmx:7GMMZjIOCjYXlxRv_bVWTm7MbGiOLxaU0fUm5gaOBoActf47nGBSX2Ui>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22EDD2A2008B; Tue,  2 Apr 2024 16:00:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
In-Reply-To: 
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
Date: Tue, 02 Apr 2024 16:00:06 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Darrick J. Wong" <djwong@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, aalbersh@redhat.com
Cc: xfs <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the fsverity
 metadata is damaged
Content-Type: text/plain



On Fri, Mar 29, 2024, at 8:43 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> There are more things that one can do with an open file descriptor on
> XFS -- query extended attributes, scan for metadata damage, repair
> metadata, etc.  None of this is possible if the fsverity metadata are
> damaged, because that prevents the file from being opened.
>
> Ignore a selective set of error codes that we know fsverity_file_open to
> return if the verity descriptor is nonsense.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    8 ++++++++
>  fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9f9d929dfeebc..e68a15b72dbdd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const struct 
> iomap_iter *iter,
>  	size_t poff, plen;
>  	sector_t sector;
> 
> +	/*
> +	 * If this verity file hasn't been activated, fail read attempts.  This
> +	 * can happen if the calling filesystem allows files to be opened even
> +	 * with damaged verity metadata.
> +	 */
> +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> +		return -EIO;
> +
>  	if (iomap->type == IOMAP_INLINE)
>  		return iomap_read_inline_data(iter, folio);
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index c0b3e8146b753..36034eaefbf55 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1431,8 +1431,25 @@ xfs_file_open(
>  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> 
>  	error = fsverity_file_open(inode, file);
> -	if (error)
> +	switch (error) {
> +	case -EFBIG:
> +	case -EINVAL:
> +	case -EMSGSIZE:
> +	case -EFSCORRUPTED:
> +		/*
> +		 * Be selective about which fsverity errors we propagate to
> +		 * userspace; we still want to be able to open this file even
> +		 * if reads don't work.  Someone might want to perform an
> +		 * online repair.
> +		 */
> +		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
> +			break;

As I understand it, fsverity (and dm-verity) are desirable in high-safety and integrity requirement cases where the goal is for the system to "fail closed" if errors in general are detected; anything that would have the system be in an ill-defined state.

A lot of ambient processes are going to have CAP_SYS_ADMIN and this will just swallow these errors for those (will things the EFSCORRUPTED path at least have been logged by a lower level function?)...whereas this is only needed just for a very few tools.

At least for composefs the quoted cases of "query extended attributes, scan for metadata damage, repair metadata" are all things that canonically live in the composefs metadata (EROFS) blob, so in theory there's a lot less of a need to query/inspect it for those use cases.  (Maybe for composefs we should force canonicalize all the underlying files to have mode 0400 and no xattrs or something and add that to its repair).

I hesitate to say it but maybe there should be some ioctl for online repair use cases only, or perhaps a new O_NOVERITY special flag to openat2()?




