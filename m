Return-Path: <linux-fsdevel+bounces-33322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7AD9B74AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16321F25029
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D11474BF;
	Thu, 31 Oct 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hLk5HnSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E51465B4;
	Thu, 31 Oct 2024 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356991; cv=none; b=d8WcXg+QLgBMzVuiXx5w5VrZFQmooN1RwJR4eGbAHGU4gAgvaKZurePOe5PcKZPT/+sM+sANSJziid5bC/36v3vvjlzQdWMfS2BTTX35MGqwIS6R/A3N8QNtVRbms9PuhfrPAIhpdlajsbHoFrtisgSuHG0qYu+Q4ZfLUmlHDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356991; c=relaxed/simple;
	bh=IUEIAQA7P1uYn/zqdUVz7OLKFK36rMIQuwpNjaL1YH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/s5vJ2eNYo4qmjFgdgk403KFyasYWLeMONWok3H5nHwiWYJtzsgJMbRN9tXxqytSvASHo9CZ66pUw6KrYI/mR3PIN9Fz4Z9nHUvYKfzyKCwpfn/1qalRPV4ztFTCTazdnBreKoZHCzln/CmSUONaX29pwlmtbPSe4Swpf5gsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hLk5HnSZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CKiWvVEKmcC8Dyu608fHEAVQab08HJJoh41UJxZAbKc=; b=hLk5HnSZMZpyA1kqw6NAcrrsvm
	TS+SBFgi2BGJCOLpuwWQTiWMznyzeCqr8jDL2zhCJhH2Bl/y4xPqqH6Nx/SglwbcrtoGXeOY/rlBd
	4JGfgqunSKi49YudMFaQLaUp88/JbpnEdfroehCvjM5P1v3eATZnUD799qwJmMyfwv5LGcEgJvVLG
	/iJRt1L1k7Lg/P1xYlzxz8msh8BE+pmjBFnXgBk6xQ+2WJHu8E6flAqUJP2xa3cGZZ5XdF58U05Xe
	AbgoqIHSOG61oATdEVkZtxtoCdySXiKHZpbcmG5lr2eGtsyzJBIeyVccz2v+S0rV6CyQmcG20EGR+
	gXZTrjuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Ote-00000009gYV-3PM1;
	Thu, 31 Oct 2024 06:43:06 +0000
Date: Thu, 31 Oct 2024 06:43:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] xattr: remove redundant check on variable err
Message-ID: <20241031064306.GK1350452@ZenIV>
References: <20241030182547.3103729-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030182547.3103729-1-colin.i.king@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 30, 2024 at 06:25:47PM +0000, Colin Ian King wrote:
> Curretly in function generic_listxattr the for_each_xattr_handler loop
> checks err and will return out of the function if err is non-zero.
> It's impossible for err to be non-zero at the end of the function where
> err is checked again for a non-zero value. The final non-zero check is
> therefore redundant and can be removed. Also move the declaration of
> err into the loop.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied (viro/vfs.git #work.xattr2)

