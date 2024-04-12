Return-Path: <linux-fsdevel+bounces-16780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF28A27C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B046E1F2540D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 07:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78050487B3;
	Fri, 12 Apr 2024 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TqNsOly8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DD2C6BC;
	Fri, 12 Apr 2024 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906036; cv=none; b=FhRbnVgBkABBhKCmw0/VxqUmIZ8XZiRz35Z4d7kpT930ENXhXRPoiOINwnw/nuGhAhv+SFQb86hy4bYAEiD56uWstPO2dX+pEA2yZ1WsB8b5ljaLeX++9SVNK9/3cE0K2B5GxqY3EKvrDpwyRMWH6264zyoZ6A76w2V6WFVa6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906036; c=relaxed/simple;
	bh=M8235PILhIKLaN4nd3lywgT/vPpbjyVUSJmu5Q3WyVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4l8qsgndNZb3WAlEYfgAh/OHMMhbFvCaRqXVuizg1M+2xgwiG8lxiu3vmbjvV7xlzI02VrjIVi5pCnFDXPJVIqiIPbFLeFR6s8/lkEVPehuoiSvxXVwdgIVeGGk+yqdX3IzO7AtSh7yeZxKeg6K+7OLuACpHoOJH0dhezDp/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TqNsOly8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=at5btSZH+gLRt37WejpY+SpURUxuc/+V27xCVOARzsk=; b=TqNsOly8zDH88IkAVf+J7oGL4G
	yOFPrT+n71JJ8tGkzopI01ywjj83dQequQsjX6C3zFttUA/ubKgav8TChPYsQbemb6gAZ20gtKMWk
	d6zvClNSXi0TML6G6dYmfFQAktDaAgaArFC8i49mJ01ryjzflJEPPv/X7ohS9Bc8H2assvjWIjTWF
	XxC63NjoKYrkWVwXtcEU96RfruxicfFn7vEoEtr2nwjOArHD/EVxWC+EWSpHlEw4+2gp+QX6bfN10
	X5VxuhAf/NiiI4LgUGXwwdOa136OCaEIPwhre7FmOrtsSJmAsYzZcvRix7q9qQ90e9O236SvvIoRX
	rDtmn7zA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rvB6X-00B0ak-1l;
	Fri, 12 Apr 2024 07:13:45 +0000
Date: Fri, 12 Apr 2024 08:13:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240412071345.GM2118490@ZenIV>
References: <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240411144930.GI2118490@ZenIV>
 <d89916c0-6220-449e-ff5f-f299fd4a1483@huaweicloud.com>
 <20240412025910.GJ2118490@ZenIV>
 <20240412044116.GL2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412044116.GL2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 05:41:16AM +0100, Al Viro wrote:

> Christoph, do you have any problems with that approach?
> 
> COMPLETELY UNTESTED patch along those lines follows; if it works,
> it would need to be carved up.  And I would probably switch the
> places where we do if (bdev->bd_partno) to if (bdev_is_partition(bdev)),
> for better readability.

See 
git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git bd_flags
for a carve-up

