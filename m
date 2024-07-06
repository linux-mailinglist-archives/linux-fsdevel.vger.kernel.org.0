Return-Path: <linux-fsdevel+bounces-23256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D09291AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 10:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257BC1F21D3A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791E3E49D;
	Sat,  6 Jul 2024 07:59:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C7A95B;
	Sat,  6 Jul 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252793; cv=none; b=rt6MuOpRjMq41QjMdIy/bdiQTAiclnEd93uSw7qmKJr0c1VJjVdBO9NivoQape4TwD5Yzs3OPcsha6LJly3d7cA7zouUvPnI782m2TlWgZJLdzvOTc0pPkcujc914OAi2Kc2sqw+SBPsruOT/7cIlBkxJ7F3i5iSdROdvCb+vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252793; c=relaxed/simple;
	bh=4Is1fl9+XVfPQbWOYW0V70tCBSJi6otXstucqqs+T/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbxGY/hdFPyqk7yvpxpj3q7CT6rtwTEL2wTQ6q4IA4gxUGaVJcJdMwhTrsGBycVGcy5sgRg1gS8k5nLkiYyuD1B00KoJB63l5JkL3ECfiQWluQ1dQSnve6i4Nm/3G2FYve508GTK1BdknEDvHm5Z2dRRnbZeN6qZ30BlSuISAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28FEB68AA6; Sat,  6 Jul 2024 09:59:49 +0200 (CEST)
Date: Sat, 6 Jul 2024 09:59:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
	hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 11/13] xfs: Only free full extents for forcealign
Message-ID: <20240706075948.GD15212@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705162450.3481169-12-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	if (xfs_inode_has_forcealign(ip)) {
> +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
> +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
> +	} else if (xfs_inode_has_bigrtalloc(ip)) {
>  		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
>  		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);

And just like elsewhere this should use common helpers.

I mean in the end the rtextsize is basically a special case of force
align.  The checks should be able to cover both easily.


