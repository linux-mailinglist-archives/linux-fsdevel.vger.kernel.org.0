Return-Path: <linux-fsdevel+bounces-11294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D053852808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 05:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8E41F23D04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C811717;
	Tue, 13 Feb 2024 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LfISUuXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB828EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707799340; cv=none; b=dJ+wkrYrkUAZtG9VJjheqssa6FeZWEiKk5k+wCVUaP9nPnjRdGlDmnK0enYWHa467+qLLCRnbb0e91gbPZeJ/DRJnnItXBAdJ/U3DjDff68eEqDTZUxz5ktQDUR4kBXShyhuFTG9dkh5o2Seg5rzhvZS3rnhCRUKiGzwnNOce3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707799340; c=relaxed/simple;
	bh=PRAmC1/dycT/2sO29lTO5SgH2NkcXvwM9+NdTTnsMUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGBdvBcJiW5LD3qvaWdLPWPhDLbAd627iGhfvC5fApXmvTeZVYjwxEJgt1msQPiWyxBIKsdwd+SQsUftD7Aw1DmewuGQ9Q1/qWL0ZBV+JLTxCMwrM/XfyK3bNBn/4JuFDx9NDGilbXiHVLWp9Xq9G6siWBX8fV9tkcHtaP7w3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LfISUuXN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=COXchp7eIqTYW68oauuJLRtxMnUicJ8mlN++MsL5YM0=; b=LfISUuXNf3Yo19eTh0o2/8NZAR
	jO9I9Q6UgR7H9Vuf+3fr++f/G4F4tgHUi1JJ93yOrLOaxoIZtpu3MnWBKn01cOxsN3/z2mZfPy0SD
	KW994Jd9c+lA+HokzhepFl+5eOT44G77uSWA+RvKcSRmssQc2KgzwoTS9rH89tB5chG0y2nN7mBso
	QeDvfder7Y2FtJEtcRH5DzjG3eIqoOmvFvLisBGrMFWa9waL2Cexi51/fyKzk62d1BPRe1DY5PhUW
	v1FIxxtrZKL95nSkvMkT+L5zvBHDVEXvr6RvVhItLssqjHNTPSeML3okxb8AAwBRyw59htUPNJ4e4
	wNwt9seg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rZkcY-007RA1-0D;
	Tue, 13 Feb 2024 04:42:14 +0000
Date: Tue, 13 Feb 2024 04:42:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] dcache: rename d_genocide()
Message-ID: <20240213044214.GA1768094@ZenIV>
References: <20240210100643.2207350-1-amir73il@gmail.com>
 <20240210232718.GG608142@ZenIV>
 <CAOQ4uxhs9y27Z5VWm=5dA-VL61-YthtNK14_-7URWs3be53QFw@mail.gmail.com>
 <20240211184438.GH608142@ZenIV>
 <CAOQ4uxhizxoZWKrcRkpC641evkFBx-oZynm1r1htWBE7hNXc-g@mail.gmail.com>
 <20240212080926.GJ608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212080926.GJ608142@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 12, 2024 at 08:09:26AM +0000, Al Viro wrote:

> Bloody bad idea, IMO.  Note that straight use of kill_anon_super()
> pretty much forces you into doing everything from ->put_super().
> And that leads to rather clumsy failure exits in foo_fill_super(),
> since you *won't* get ->put_super() called unless you've got to
> setting ->s_root.
> 
> Considering how easily the failure exits rot, I'd rather discourage
> that variant.

BTW, take a look at fs/ext2/super.c and compare the mess in failure
exits in ext2_fill_super() with ext2_put_super().  See the amount of
duplication?

In case of ext2_fill_super() success eventual ->kill_sb() will call
->put_super() (from generic_shutdown_super(), from kill_block_super()).

What happens in case of ext2_fill_super() failure?  ->kill_sb() is called,
but ->put_super() is only called if ->s_root is non-NULL (and at the very
least it requires ->s_op to have been set).  So in that case we have
ext2_fill_super() manually undo the allocations, etc. it had managed to do,
same as ext2_put_super() would've done.

If that stuff gets lifted into ->kill_sb(), we get the bulk of ext2_put_super()
moved into ext2_kill_super() (I wouldn't be surprised if ext2_put_super()
completely disappeared, actually), with all those goto failed_mount<something>
in ext2_fill_super() turning into plain return -E...

