Return-Path: <linux-fsdevel+bounces-16102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E689834D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 10:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE80B28737
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6C71B30;
	Thu,  4 Apr 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lLV7uu3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2851E86F;
	Thu,  4 Apr 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220016; cv=none; b=qaer2eMkm4JPe2fEW7s669rbyxcsDQq0x8yYiPkpHhv7PYWgWdlBtHR6KC7BjzT4dDyeV1rwaeHsT6tox9s6fC2RgMcM2/t7cAecPdav5avghgSQr0E7XrcjKf+j0oTRTtNsV4FuBwUzN+OEUWwhbTFz21vCFKjirV/R7PRulME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220016; c=relaxed/simple;
	bh=nu2xamLL/1Lp3Kabf5EBo8dr2TBNEAPViVPLxkTCtZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYvk9YydvNvMtslxBDM1vJwyh+41ddloLRf3D872y2mVcxJKW9x+oHy7A5uN1kTKk96LJ8W7q1vcShlz2k6kMZB62pAuHSFMa69Hw81yUDP5r04GcnlVAY2Jexep4vRtu6AxlNOc0lPdnY7V2ybrcjgESEAOAJ0PEihyZmkTzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lLV7uu3w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mh1tS4YBpeQpEOMQvTRN1ABwZ4FVhqqFeSUifn51SkU=; b=lLV7uu3wHBn23R2nt5JOwZXJ9L
	e3uVtdKkJep/jj7ZFI9NIBFgvD1+Wd5Fyvm0jB7KzgnEm7eNcANhL7jMuCa1cAjyw7jdXT0PDsOVw
	tEcBVvRtfslABSr4M0fWPnuu8merb3rglMtKBtx/FaJp9ZWOSr21vpsX3I5fy73tOrQDsRGbwQO1g
	lDpFkqkvqWLI0JeKjg87TAjQV0HvPD9LaBitqqNNJcmcYABVfOrvF5ViQSeiSKNqqcu9bZ0ViNP8z
	Ja+HfCsvXkSboF1lu3cMx/hAIBzOyFu0FWtKjo30KubY9v89V/Zw/Bm3Yt1we5SbpzqaynDXr8Z4i
	Ig+USciQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsIdl-005SY0-0V;
	Thu, 04 Apr 2024 08:40:09 +0000
Date: Thu, 4 Apr 2024 09:40:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, valesini@yandex-team.ru,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240404084009.GS538574@ZenIV>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404082110.GR538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 04, 2024 at 09:21:10AM +0100, Al Viro wrote:

> Similar question applies to ovl_write_iter() - why do you
> need to hold the overlayfs inode locked during the call of
> backing_file_write_iter()?

Consider the scenario when unlink() is called on that sucker
during the write() that triggers that pathwalk.  We have

unlink: blocked on overlayfs inode of file, while holding the parent directory.
write: holding the overlayfs inode of file and trying to resolve a pathname
that contains .../power/suspend_stats/../../...; blocked on attempt to lock
parent so we could do a lookup in it.

No llseek involved anywhere, kernfs of->mutex held, but not contended,
deadlock purely on ->i_rwsem of overlayfs inodes.

Holding overlayfs inode locked during the call of lookup_bdev() is really
no-go.

