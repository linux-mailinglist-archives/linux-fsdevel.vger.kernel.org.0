Return-Path: <linux-fsdevel+bounces-35005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EA9CFC5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 03:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D950285D05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE91547C3;
	Sat, 16 Nov 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V18PyhzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972423C9;
	Sat, 16 Nov 2024 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731724368; cv=none; b=j2lFinUpvNV2qZOIGoLvGJWn9NX3g72jjmlFiGDqsoVTe8n5VFU3b5GiOXSjIH/9Myh3pId3yrhGSY7WSPdoqhzLuBuFm1A46Vrqbbya4ga9/Y5dFxZJzixEopHmKPt9awyq+iAczUTRQuv8vRtM6zqK6MQxRNYuGYfhQqLBmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731724368; c=relaxed/simple;
	bh=mrPqJwW5DmCq5Q98xz8AQAjx4GgSEPHdfp0he8D87tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jud+mlqKtYLM2VgQ3kBVF+2D+zBCSS+tIBflOnWD3syVuan0IRGfQSiBnn7MvWjnatoNzTPtb9RIHdBEQEvxFYLiqp2970UtWaOxSMdUwuQS3DgE9eSKdR7Y7YGwBNqMEbmF1zhuy6BbLAMXWAYQIsZHhjMO25pNvEf9u+F1slQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V18PyhzL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RGZwqT4r3Z/8PYH5DruXwKL/SF2DIpfPKsvdcYocV88=; b=V18PyhzLifBBqE4+oVzEbG2sQp
	bUsvw0PBuSkzVXHHIIUJ01gj0bmHcu19wIfpDfdFyJ8vEjHTzeVg5yAdN5l9tzZY7NyrfHbLwEpA7
	wIgojWRJiTvo90fP6o1V9xm7iRdF4ud0vRwiplPDjnej3AXJ57LAQhryvy1PVHzgL2oe6owyRgZXY
	IxNbgdMBLi9kQp/tiJrU0JTZMJiRE6IkuVu8mEcSVrYEfz06jEzBmstS6NEu2So5XtRPztoVHnQ4Y
	JvbFcOn58p+Svf7jleI+WwO4biygmzDlPmAY+DxhL/QwbDrHdSX2FUwJ9Nsj6KfmcpZ/j8riQsigd
	hs0CGihQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tC8c5-0000000FeJC-2i65;
	Sat, 16 Nov 2024 02:32:41 +0000
Date: Sat, 16 Nov 2024 02:32:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: add check for symlink corrupted
Message-ID: <20241116023241.GZ3387508@ZenIV>
References: <20241115132455.GS3387508@ZenIV>
 <20241116013950.1563199-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116013950.1563199-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 16, 2024 at 09:39:50AM +0800, Lizhi Xu wrote:
> On Fri, 15 Nov 2024 13:24:55 +0000, Al Viro wrote:
> > On Fri, Nov 15, 2024 at 01:06:15PM +0000, Al Viro wrote:
> > > On Fri, Nov 15, 2024 at 05:49:08PM +0800, Lizhi Xu wrote:
> > > > syzbot reported a null-ptr-deref in pick_link. [1]
> > > > When symlink's inode is corrupted, the value of the i_link is 2 in this case,
> > > > it will trigger null pointer deref when accessing *res in pick_link().
> > > >
> > > > To avoid this issue, add a check for inode mode, return -EINVAL when it's
> > > > not symlink.
> > >
> > > NAK.  Don't paper over filesystem bugs at pathwalk time - it's the wrong
> > > place for that.  Fix it at in-core inode creation time.
> > 
> > BTW, seeing that ntfs doesn't even touch ->i_link, you are dealing
> Yes, ntfs3 does not handle the relevant code of i_link.
> > with aftermath of memory corruption, so it's definitely papering over
> > the actual bug here.
> I see that finding out how the value of i_link becomes 2 is the key.

How about 'how the memory currently pointed to by inode had come to be
available for use by something that stored 2 at that particular offset'?

