Return-Path: <linux-fsdevel+bounces-24365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D893DFCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D726D1F21BA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CD1802A5;
	Sat, 27 Jul 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJdzF1oO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529D18003C
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722091951; cv=none; b=sPd/6T74+d6M321KSqsb2qGz0FTbLDwIOZaLVAW/UCkiBCy72ml0JMdaFkY/SD2R0aomEI47LnFDIU8b79qHXaRVlH2U0Qza4+ts8tf2urXBYD1bYBWdPsF9w9Jkqnfl5zLz4il0R1XovP0R/1dNfEHWVjlH4HTRW2UpWuVZHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722091951; c=relaxed/simple;
	bh=K6NxWWNL2QqGdfUs+BXB/kW5QQcfEqNmqGcANuzcQGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH3z1LKo2R78WctQhUEHwJOkmOWJMAyD18Q+eAabizi3V5RTZrzJc0Xb3AEDbRVEU4GbWTiB+nFQR3p4ZStuPbtlQeNVGL0a/SeVbn40jrhJsWac/stJGuyy1+Wru+P7qiwC8gUN1ti9II5mJkLY8q6eMkVLIpK3Yye7w36FXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aJdzF1oO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UrVcCwUbiNWo86A31hbf2V6PwUgVZZxFzYmDkpri+fU=; b=aJdzF1oOhi04inpLbfh9ssab7A
	SY5fGThBcQmMX/IILXRp9nc4Y3kSUHv14jK3O4XrTMxrpJAfhPn0Mo8AOMGmy2mi2LtbKs8g5+GD0
	T1GBSBUK5gS0flH/pdE9Ik3/e5Mhr96MnsoghOMTEW+/aINc7Wqrf0DfpgwPy8S8r2pzzAhkXh2hq
	Jh4tcJr60oDtFSkvGoobNCsSHNU5C3Nj+Sbh2F9t251aNcb7iGz0+rmNPv/mbwoz22ofcGzLSr/pX
	0fMLL8GfFQQROjk3Q52Yaeu9bbLb6uSZ18qg5URINkvwRyrVBHoOaMHME7sKzfA6QP20iN4RzV8eR
	fL2a2pBw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXimX-0000000BQSc-0NFZ;
	Sat, 27 Jul 2024 14:52:25 +0000
Date: Sat, 27 Jul 2024 15:52:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] hfsplus: Initialize directory subfolders in
 hfsplus_mknod
Message-ID: <ZqUJqAWIuFjtcccA@casper.infradead.org>
References: <20240727061303.115044-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727061303.115044-1-simeddon@gmail.com>

On Sat, Jul 27, 2024 at 11:43:04AM +0530, Siddharth Menon wrote:
> Addresses uninitialized subfolders attribute being used in 
> `hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.

This is a really poor commit message.  It needs to be more descriptive.
How can this happen?  Is it just a fuzzing thing?

> Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
> Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
> Removed changes that was accidentally added while debugging
> and reformatted the message.
> 
>  fs/hfsplus/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -485,6 +485,9 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  
>  	mutex_lock(&sbi->vh_mutex);
>  	inode = hfsplus_new_inode(dir->i_sb, dir, mode);
> +	if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
> +		HFSPLUS_I(dir)->subfolders = 0;
> +
>  	if (!inode)
>  		goto out;
>  
> -- 
> 2.39.2
> 
> 

