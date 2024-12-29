Return-Path: <linux-fsdevel+bounces-38243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA49FDFE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 17:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D5161B9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED418C31;
	Sun, 29 Dec 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iI8B8Vv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA02594BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735490317; cv=none; b=XgkE0lz1otFDxqoD1bBQ0BkVi8SpXpkHcPrl7JEe7rUnXExqipsfizhJQEbnyu3rg1xBPYxuc7xkyT+nW8cWX45dHZznK9GCMGkybUtMgav9raS6uByMIRSGczcqchS+Y4a7qKO7v948bZ6DYV+lr+JEPBvN6rCvoeJVv4l+vU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735490317; c=relaxed/simple;
	bh=BNzPdrDVYQvh2CGEfOJ5oAwxV6B5ck9/fcCnlPt/l+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9eml+XPFniZ9n8NgEnnQXQQuZddXSWbiTiL4/E1TcBmR9D34E42hC5n8VgcsNnEP10ij8XKHl9WS8BA9QjUq/QCDl4yOYMM/H/St/TvL1O+hKeYMWLGhgrx0iQMMFiNlU7t63p+5ZCWepChya0SbRDyEj20XrFtSsFpwFV1weM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iI8B8Vv3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HoXuEaHQy5Kg88RS3UiTN7as1bDBDlUrSayAW8r9y7c=; b=iI8B8Vv3lZMD3SShzAROa1l3BS
	KiZGl5cOvVp6ezEqwk+ZTCysEnb7LM34bOU8wj44Cl4SKcVZQOJ4qKN5g++pCQssH69KWX1buTkGs
	3EG+rAiPWM1Wja+xI7MW8mKqe8b1n/6kuVLEeSJ2vkB6cRjulTQZBXsTMp/6JD1NuIGIs92idQsVf
	3PSuNKBmxmnWcOkeuNlQW0TM/ljqXBNe/3ZiokY00xzD3HUGY1a1X2CRDwpmdK20U4fSZ4FSrjCnS
	WeDk9JfkU9vFGAMkKc2GgORRkHL0jAcT2NRTHH7Dq5YHR/tlCNU0Q1/00CmTeR5Ih4H3rYvsdRWsI
	dIuyUD/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRwJE-0000000DWUH-2dew;
	Sun, 29 Dec 2024 16:38:32 +0000
Date: Sun, 29 Dec 2024 16:38:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: Re: [PATCH 20/20] saner replacement for debugfs_rename()
Message-ID: <20241229163832.GZ1977892@ZenIV>
References: <20241229080948.GY1977892@ZenIV>
 <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
 <20241229081223.3193228-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229081223.3193228-20-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 29, 2024 at 08:12:23AM +0000, Al Viro wrote:

> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
> index b19492a7f6ad..2b78be129770 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -63,13 +63,8 @@ void bond_debug_unregister(struct bonding *bond)
>  
>  void bond_debug_reregister(struct bonding *bond)
>  {
> -	struct dentry *d;
> -
> -	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
> -			   bonding_debug_root, bond->dev->name);
> -	if (!IS_ERR(d)) {
> -		bond->debug_dir = d;
> -	} else {
> +	err = debugfs_change_name(bond->debug_dir, "%s", bond->dev->name);

That should be
+	int err = debugfs_change_name(bond->debug_dir, "%s", bond->dev->name);

obviously...

