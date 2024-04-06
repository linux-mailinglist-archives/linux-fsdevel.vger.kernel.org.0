Return-Path: <linux-fsdevel+bounces-16249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644FD89A8D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 06:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9EB282E85
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 04:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09C1B80F;
	Sat,  6 Apr 2024 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hFenarQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075E18C31;
	Sat,  6 Apr 2024 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376570; cv=none; b=W6aBfwxjDVlGTt4Vt9ZjjiwPWT//xzGDAuAV4ZuwVXZvYcElupFRhM5qS/MOYYEIfutqf7f3DmH1CO128wtC16wMn/Ih1x7EoBIa2j0R1FReoq4uF4Q3rN8+OpJ8D7tdObxlTjJscAXdfp8HW7T/fimux13XginHzlSWGP28ILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376570; c=relaxed/simple;
	bh=84CEL3L0YsI3XMS0Ylb0DTXEwQky54Jb7NDYFZGjLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDsZ2W/Qw/50lb4w99e9N9+r6dDy1DLKbnbIUvOgeZdq3aFr5QWx2CULpbhMl92QDN+lUeHYUqGAAd4EgfXW7/dQx7u/EoCh0L53mnTci2pXGlqCoYFBq/lYy9DTtqLMLGLP48754Ftaj6b0lDSQCCdVSKW1Z6FG716Jmnjurk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hFenarQp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aNcQLYFcRVUrVIl9SKAc3txdt41VLu+DbhyIjFOO5ys=; b=hFenarQpeRw+HK/7HvJ8l/AvHz
	Lsk7bR95k3PifSQC0xuVGznOgvlMZV+datwfcaaU2K8XFbpMOdNZrMtVc1orR/dSLvOMgF+TS25ke
	uUevxHfH1hr754XMIIlc6sY8u6jWKae+Hzd4zZ+KGjawhoQ7v0RNC7GvrHjmwmUOW+6kT98th9S5q
	o/NOzRtZ712DP2fxygcYxXTaz+ss326ceRtNDvh7x/Ceju5lg4xSx/3uxsylC6pFN0ymr2vAeBx1K
	CVFO3tddwqZcp3WdcDpqG9yK11Of234BEwSQ+Inx4P1ggpR9I4+cjdIat7jsB4cEh+uVHTXCr6UKP
	kf9RK08A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsxMp-006pPR-2v;
	Sat, 06 Apr 2024 04:09:24 +0000
Date: Sat, 6 Apr 2024 05:09:23 +0100
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
Message-ID: <20240406040923.GX538574@ZenIV>
References: <00000000000098f75506153551a1@google.com>
 <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV>
 <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:

> We do not (anymore) lock ovl inode in ovl_llseek(), see:
> b1f9d3858f72 ovl: use ovl_inode_lock in ovl_llseek()
> but ovl inode is held in operations (e.g. ovl_rename)
> which trigger copy up and call vfs_llseek() on the lower file.

OK, but why do we bother with ovl_inode_lock() there?
Note that serialization on struct file level is provided
on syscall level - see call of fdget_pos() in there.
IOW, which object are you protecting?  If it's struct file
passed your way, you should already have the serialization.
If it's underlying file on disk, that's up to vfs_llseek().
Exclusion with copyup by a different operation?

I'm not saying it's wrong - it's just that the thing is
tricky enough, so some clarification might be a good idea.

