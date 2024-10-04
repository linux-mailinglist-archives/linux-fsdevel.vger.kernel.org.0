Return-Path: <linux-fsdevel+bounces-30972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9E9902C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70FE283058
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653615C13C;
	Fri,  4 Oct 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PU2W09TE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6815B0FF;
	Fri,  4 Oct 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044079; cv=none; b=smTN1pUaNPfn+yV5EsIMSLINyjCtJLUvGj/38pqTxFPEgGnE19aL3Ow7N3ewbSrNKFhd+f8Q3zT30qY8M6euoufoqpHgulPIYQszQT7CGxJFijMh1FDDF0nIKgEj+wcFw8EBdnBwdMIuVG0mxT4V9iCSDjdkAZ7wGdq3u3GypcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044079; c=relaxed/simple;
	bh=9PPLlK1ccyzDFpw+b+MDJFtdCCKRfJD+OQMnxoX30s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PafkcuF8PLpknhJYEHn9YCQw0wo8JHEUodTGncUbl0k2Y+BgSWGdFRMzOSQ063fUYu45VSXSB7L6ogwYAFub2JoeoknDWzPUKth9jpkXTMFfDYxcWeoU85bIZpQVOJ9poVGyOvJHRcJlwYMX8PWjWHEJ3do11iCLwO7ORlLc7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PU2W09TE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g6vBL1gA3+PxhIH3omajxsBuXtvGPDUikCn7RpNpROs=; b=PU2W09TETmz65qYt7/hG0zBv3F
	AUZl3xxevjAipthUCnSR4UM74U+ujoDUswdUlUI7A7tGpYjXZ/ESkIt22i1ELlqcYNNBwfeoFQuVb
	h3J2B8a54amGBxtocafqrV/qPC11F4ujntp0OB2p7/qtAtr0ECMezbOs2jeLL3ahnUQMdW6iuCvRH
	DZeNr9ygFI75DJl4SvIi1Vz8xahMUda0hY0l3lTEuEc1bMQUYMYAn2ClPzj2KutgKe1YqcuIDOa2n
	ILvJ9KQR3oPkaQFgDARoEkcwARP6GWi3dnA5yMujlr8g306LlEQabL313OD3wHq86tBov4Eup0/gL
	J6zLwicg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swhCe-0000000CGSU-3Vxl;
	Fri, 04 Oct 2024 12:14:36 +0000
Date: Fri, 4 Oct 2024 05:14:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <Zv_cLNUpBxpLUe1Q@infradead.org>
References: <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <Zv6J34fwj3vNOrIH@infradead.org>
 <20241003122657.mrqwyc5tzeggrzbt@quack3>
 <Zv6Qe-9O44g6qnSu@infradead.org>
 <20241003125650.jtkqezmtnzfoysb2@quack3>
 <Zv6jV40xKIJYuePA@dread.disaster.area>
 <20241003161731.kwveypqzu4bivesv@quack3>
 <Zv8648YMT10TMXSL@dread.disaster.area>
 <20241004-abgemacht-amortisieren-9d54cca35cab@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-abgemacht-amortisieren-9d54cca35cab@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 09:21:19AM +0200, Christian Brauner wrote:
> > But screwing with LSM instructure looks ....  obnoxiously complex
> > from the outside...
> 
> Imho, please just focus on the immediate feedback and ignore all the
> extra bells and whistles that we could or should do. I prefer all of
> that to be done after this series lands.

For the LSM mess: absolutely.  For fsnotify it seems like Dave has
a good idea to integrate it, and it removes the somewhat awkward
need for the reffed flag.  So if that delayed notify idea works out
I'd prefer to see that in over the flag.

