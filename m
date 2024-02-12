Return-Path: <linux-fsdevel+bounces-11093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B48850EA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A70D1C21407
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11968832;
	Mon, 12 Feb 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VRZwen3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104363D62
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725372; cv=none; b=XiMxeQ17nwz61/SCYDoGJNEjoJOGRchi0iHSfD9wvIsJs8+z2iZpkJndl8LUpumEPlwfk8OqecRAjsSd0UN6ao59Z7GMHUjr9UnvVciYVUVbpjBY7h6Q6bMaAj23P2f6PgDmkP35ArnEoY6q8X8WV5mWUC6XGmh+JCtdT4XwP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725372; c=relaxed/simple;
	bh=uQi1MIgQOV6pWOqWSAEL6+aM2qwOnRQkEdUD9EzUB8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BonH0yea0CI857Uv62n2/NZyV0rpHSqivD3+y4ISVaA8XpJsaiSbDGXDc6Dw6ceb7jaGLdZbtGdgaVXRLr3zWDUoWqwCeQaXE+nKokUFp+K6cRo95mvMk924UkRor6lSfe2BDeGGbdsr+pBdrjpCpAKgoGOfZ8wtKJoN7ckNNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VRZwen3f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9syyEiHriFoBWBLomY00whedrtHpN04cdVGINA7uDzI=; b=VRZwen3fTW5c22ncYuoEGDCLOw
	ZgCr73vXhMbgz67CPLAoDpSo2Vc8BfJETlFtzfIiCm6M8QiJz9srd5ikD4mNk78q9MvyjZorkUDxT
	7me0JHHoy4lBiTg7RB8APSafhJ7DWKuN8OxbXbS3CUDv9C8Ryd/m1tSDcm5pLGk0mdYfvE+QNAaRu
	cPvPdogqN00oZCd7FS9p7Kt4CX4mWR/9Vr4/cP3u/hFsGdcffEM7OXuMjBafQPH7LhRnPk0Khly4n
	tuQ2prKORZvenH7nCwSmSh1t2L4qcVRZtrY0xzYr6uN9M/HuOAfvf5kNgfkRKycEWbKoNQOCv12XS
	jzV4qiDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rZRNW-006aOF-0W;
	Mon, 12 Feb 2024 08:09:26 +0000
Date: Mon, 12 Feb 2024 08:09:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] dcache: rename d_genocide()
Message-ID: <20240212080926.GJ608142@ZenIV>
References: <20240210100643.2207350-1-amir73il@gmail.com>
 <20240210232718.GG608142@ZenIV>
 <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com>
 <20240211184438.GH608142@ZenIV>
 <CAOQ4uxhizxoZWKrcRkpC641evkFBx-oZynm1r1htWBE7hNXc-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhizxoZWKrcRkpC641evkFBx-oZynm1r1htWBE7hNXc-g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 12, 2024 at 09:02:58AM +0200, Amir Goldstein wrote:

> If you are going to make kill_litter_super() an alias of kill_anon_super()
> I suggest going the extra mile and replacing the remaining 30 instances of
> kill_litter_super().
> 
> If the rules become straight forward for the default ->kill_sb(),
> then maybe we should even make ->kill_sb() optional and do:
> 
> diff --git a/fs/super.c b/fs/super.c
> index d35e85295489..6200cac0e4f8 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -458,6 +458,18 @@ static void kill_super_notify(struct super_block *sb)
>         super_wake(sb, SB_DEAD);
>  }
> 
> +static void kill_sb(struct super_block *s)
> +{
> +       struct file_system_type *fs = s->s_type;
> +
> +       if (fs->kill_sb)
> +               fs->kill_sb(s);
> +       else if (fs->fs_flags & FS_REQUIRES_DEV)
> +               kill_block_super(s);
> +       else
> +               kill_anon_super(s);
> +}

Bloody bad idea, IMO.  Note that straight use of kill_anon_super()
pretty much forces you into doing everything from ->put_super().
And that leads to rather clumsy failure exits in foo_fill_super(),
since you *won't* get ->put_super() called unless you've got to
setting ->s_root.

Considering how easily the failure exits rot, I'd rather discourage
that variant.

