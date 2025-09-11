Return-Path: <linux-fsdevel+bounces-60964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66907B538B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC883AF4B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2E35334F;
	Thu, 11 Sep 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="poKw9EBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D753126D3;
	Thu, 11 Sep 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606754; cv=none; b=DuUFyqm05U4+8dccYECBNEhiPMUW2ceRrJwBtZg5PXvu8xBqMpx05bAjIEdwlb5yS2pC3fLg0FMGKuArjIRa3lXs1DOZngOI/g6grQoEtPyfxi/kaNhFL2JAEencWfIcezY0uboLlXzKBLijE9szmOAvecGS5WxI+kCuol+33bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606754; c=relaxed/simple;
	bh=jPNMM0XFGQLRCAjmdEnlSrkDcHtec4sstty0pjCkwr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWKI0mg2+CBOCC34F0xtkFpKEnQM5Tvqnk3vFU6OzCLTNTva9ijKhgpWCPQomSsNRI+LxTYKX86ZKw2R+9RfdP8encgJcVAF5PuZnp+UqCTOc84gihLZZ/zUsdv+yerI+7ZVlBDuA11bvmjHVpVlFMZjHmCgUtVWvMmNhMSzYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=poKw9EBL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EFx4Vqa9zJWE7Jeya+Q4yCI5zp7fiGP6897Y8zTry2g=; b=poKw9EBLnZyXc4ieUlV327C/95
	33bFyd0/2blp1Sc3m0uXideMpGKMPiboP7v+KEQeBPaxbiNF4Sn6SKjj2Baj5aDzF9Penjntj8Uo4
	2RGuwHwEr5N9AXEy/lW90vFjlZeYpWRI0+zL3Q6nfByBBsXcGx24lo5TIZ4Cvxj34CMiMSeYlGgC4
	Rk1WAle2Eu3HQXlriW12AXW+8D3FVEtBP2HvzHVCYD9eDT9xkJfoNRktVRuowGHqqot7XCJ3k0XGY
	Zd9f0lfee+Lc4ETOE8uyB07e0d2QQUni9bUccdA6sLNklD2HlTE108D6WUdXYIIQqCfWwml28Sita
	7zOYF2xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjnw-00000002QaG-3BWl;
	Thu, 11 Sep 2025 16:05:48 +0000
Date: Thu, 11 Sep 2025 17:05:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: buggered I_CREATING implementation?
Message-ID: <20250911160548.GV39973@ZenIV>
References: <lsqpkeiqraemymog6l5msgx3x4nczbyxg55ffelntnzp43grop@bdk6ezmz5wg5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsqpkeiqraemymog6l5msgx3x4nczbyxg55ffelntnzp43grop@bdk6ezmz5wg5>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 11, 2025 at 05:15:47PM +0200, Mateusz Guzik wrote:

> So as far as I understand the intent was to make it so that discarded
> inodes can be tested for with:
> 	(inode->i_state & (I_NEW | I_CREATING) == I_CREATING)

It is not the intent.  The problem is dealing with incoming fhandle that
has guessed the inumber of freshly created (and not yet linked) inode.

> This means another call for the same inode will find it and:
> 
>                 if (unlikely(old->i_state & I_CREATING)) {
>                         spin_unlock(&old->i_lock);
>                         spin_unlock(&inode_hash_lock);
>                         return -EBUSY;
>                 }
> 
> ... return with -EBUSY instead of waiting to check what will happen with it.

What's there to wait for?

