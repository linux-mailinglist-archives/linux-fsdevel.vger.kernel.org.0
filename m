Return-Path: <linux-fsdevel+bounces-16316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797989AE66
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 06:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889DA1C218AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CE3D8E;
	Sun,  7 Apr 2024 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ns6CXbnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36C17C9;
	Sun,  7 Apr 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712462913; cv=none; b=XoR2lNEYICAsJe81IWqDDyeOlWQNAhbXhQyaJilaOzfEabEd9X5fUaSm4tkYwO4qG7w/WX+fkVadPJs23B2rCWv3zpIQOrt/dFOxio7xFL6aOwsyxdAFnO/CPepTHA00oKsG5SWEsw7NmJ/2e1a3BuVEa1Kf6JNOBuT2NztDg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712462913; c=relaxed/simple;
	bh=uaaqIIK+yDzfLxcL2wt8GgA52QiNxYwDJfIViykeOHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT4JgMB0B9Jo0TF+9kDsTc23TfKr1GctFtCnIUYny82mmIsz1pHpSGxClCetZ38kA5e6RW0/0f8tSuGhtL9Za8T8ZwvXTWzBUwrNCgQQkd1PZZw1ddWPeIYY1KYx2L0SR9+Q6VOQYiMpFmAWndJ9t2SGSpURw71sBKWh3CH+M8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ns6CXbnv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=noLWabCDxMyBH7v8fbfhwMl3mDnz8hLoPweGwX4RzvQ=; b=ns6CXbnv6vH0xykaSVHJZaBrFY
	Uxm17WcqfBEzautGkGGPlPz/j7SBAWCRBiUiW6/N++3Uwy7KBunYNK5vBAZi32wgAsyQpNiXwDi6M
	X9/3YowsSDw2gM/eISDYaTndBAkc3emRfA/ZyyCkFD9hfqgkowLjOdq78WLCCUucBwXNyZxD/93lv
	TZDH0S01mpeAhySHikzVNL30k5E87UdduXsi1kIwuQuqahwpzOZrfcasjSL3sUvMEjA5hgqtd2zB0
	zJIuz0bysyuWZHEm7fcnrvzYoOr4B8S4ASomh4QPmWdtaKVTqDtT6ofUCOZYrFOF6o0EeLljpkzWn
	yvKr8ibw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtJpO-007aj8-35;
	Sun, 07 Apr 2024 04:08:23 +0000
Date: Sun, 7 Apr 2024 05:08:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
Message-ID: <20240407040822.GJ538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407040531.GA1791215@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 05:05:31AM +0100, Al Viro wrote:

> IOW, it might make sense to replace erofs_buf->inode with
> pointer to address space.  And use file_mapping() instead of
				     ->f_mapping, that is.
> file_inode() in that patch...
> 

