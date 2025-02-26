Return-Path: <linux-fsdevel+bounces-42622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5720A45122
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 01:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C068D17B583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B968256D;
	Wed, 26 Feb 2025 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MZpW+jqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9D07F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528197; cv=none; b=oGITAwC7Ax2AtKmmsL8HEYIHTyICTk2JcXI47DFr4KJuk94yFPBuGa/y+SxmzM1HZKb11gYGy7qkNAWUtOBpPWsGeQW/yvPg/TehlKuGV1+uikM6Q9sXtSt2ycnfnEYYtlMuQ95dJsq9riUI2EoJIhfYTQrJbk7iCemSBt1k/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528197; c=relaxed/simple;
	bh=iW+tGFHB6fU9mBR5mF+KUQJCCG66vmV1WhWWRzeGFqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opbO8ZsbPv6LIN5iOioMQFmFGrbvSoTqUXJUORHOMqDgGQKG5nKH9Kyz0NPU3DsgKsckcJisG+8+4M8lJm6rSM1D3r5tO3DX5dvKCXkJFvzkzQhd74lT5ANaMOP0/ulzkP+2b6/JjYBREdORX4un7r1tS65wLClbn4I5aL8Qq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MZpW+jqk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+O3/Y7ff4CdeXMuJX1UESGZHTptQx7hu7FhimEOEic8=; b=MZpW+jqkkq3EP2zII22FEG6waE
	3QU36TDvD25Uw2beCKruDXIksyZKNL4Og3GZlmbNBSPo8O5lNHblERfv7j71LtSvZqrDvFMBEWlA1
	t6CwBAy/ItX19c/rnE8Xf3E7R46ZP1I66IivOWqCVeaNWbg/nnUOj2WuF6fMEXGzTltU/1lSoOsMB
	GzAbhmETwzOLGIOqt9u1l8e8pDJKsoUbaSzLtCUvHlZ2W+pqRiWcl1e4IzJ9V/xzpI02GPXKLTUkx
	4RsuMd+MuiSv7D1UasC2nTMo/BbIMJHtmOP+ZgfhWprdHt9milHdokU+pyxR0dTZBKdXGHPI0Lth6
	24Ekj8kA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn4tN-00000008ao7-3J65;
	Wed, 26 Feb 2025 00:03:13 +0000
Date: Wed, 26 Feb 2025 00:03:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 01/21] procfs: kill ->proc_dops
Message-ID: <20250226000313.GD2023217@ZenIV>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <174052389204.102979.2659504356456752671@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174052389204.102979.2659504356456752671@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 26, 2025 at 09:51:32AM +1100, NeilBrown wrote:
> >  	char inline_name[];
> >  } __randomize_layout;
> >  
> > +#define PROC_ENTRY_FORCE_LOOKUP 2 /* same space as PROC_ENTRY_PERMANENT */
> 
> Should there be a note in include/linux/proc_fs.h say that '2' is in
> use?

Umm...  Point, I guess - or we could just put "all other bits are belong to us"
there ;-)

