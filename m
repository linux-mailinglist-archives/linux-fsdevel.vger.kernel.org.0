Return-Path: <linux-fsdevel+bounces-24354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02693DD50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 06:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D6A1C22FE3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 04:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7D171D8;
	Sat, 27 Jul 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tnfBm+0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A21B86EA
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722056074; cv=none; b=EkFTQqD6LRFW+Fd9KLkaQfO5LtMwcxef4+5Kd8QJEDIMuW1tqTSTJDK9k93RLCyX2uq/hXv+fHo+xcO9VFC1Vg3UY110L6yPlmlyWTIM0iS9fIASdW9zfc6JpVNdG5uyRoL+vSVRVJ36ye5Z7aYN4xvaMvS/KLw1ShoYrFgezK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722056074; c=relaxed/simple;
	bh=e6C5AcGDW5odeEs9RqEVGCL0fJd/n/qfjve8IIa+5ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5qlNY0N3L2bmJKpyelbfpQXTEp+h8042VKRHW9Yyg5wtC4/axOYOvc1PMCznyivOe1yB9neZWUYy8pB6m+lsNMs4uPw7rgHp1uPueaSyTyqbwbcc3LDs8QXa5ILa/tapcXvJLMNdU5iFDexCxSnMSKYugm8PEVCTNS073nNz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tnfBm+0i; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nUtHhk8ZAVlInJGOT06jW7niZwCf2d8NToEnw7afd5o=; b=tnfBm+0iMmBSyLkygQ1WoCpJHX
	MZW20fTx7pSYjssc6R28ocxrWq7iVFqsVzhpdX6DHlZab9N9eBBA6R5zPAWPbiB4kanVlYBrrWPQW
	CP1M0Vg0tY3Zl/7BkdmM5sNcfFqTinJWlGO63EyrVFIXGf8PSlxuPWhTkfdzJdes84kuEbBKfQJbx
	Q+JPSrY4xQZQstRw2EkxZX+NG8siLSLBUd2ZYHGMWL2+Am+l9w30U5mz0wPKw6pVB2RwduPP+ExUL
	/ldeEC4WZ0O05DjQ63YAAhbqA2frvHRKEJEbAFNjKN7CG9UkJp4g3Nt5VnzY/5BAeEaubML9GYkqw
	N4Kh///g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXZRt-00000002KYy-0T7z;
	Sat, 27 Jul 2024 04:54:29 +0000
Date: Sat, 27 Jul 2024 05:54:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: hfsplus: Initialize directory subfolders in hfsplus_mknod
Message-ID: <20240727045429.GG99483@ZenIV>
References: <20240727045127.54746-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727045127.54746-1-simeddon@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 27, 2024 at 10:21:29AM +0530, Siddharth Menon wrote:

> -	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISFIFO(mode) || S_ISSOCK(mode))
> -		init_special_inode(inode, mode, rdev);
> +	if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISFIFO(mode) || S_ISSOCK(mode)){
> +		init_special_inode(inode, mode, rdev);}

Huh?  What's that chunk about?

