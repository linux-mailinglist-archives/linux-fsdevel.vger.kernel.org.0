Return-Path: <linux-fsdevel+bounces-68948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A0C6A319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E2CB12D02E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1C363C70;
	Tue, 18 Nov 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bIA2cuiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F833624B2;
	Tue, 18 Nov 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478005; cv=none; b=RYWBDJfZ9p71L+R/BYXefrygQVvlwYx7tgvXWkpiULuAOg7QqpoVQ311XRubVVpiX6XbOMg6Ci0dxb0vqb5nENB1rLd/c6gZE2MmB+QMvEW6iIe/Gm82HN3bOjexeFzy/YTl9pWDYHsZgQ0G4KNKXlxlNwrt3RfR8m2panLi2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478005; c=relaxed/simple;
	bh=3tC/7RGBTLAz6SX00JnXVxOOzBzpTg9gCtsy6n2iSAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6QpFd9I4a4DVBfk+NgCLLm0Rxw5NlKScd0kvVTJi1EuRtKMlopsBFW5V5KHAemPkBMn7pYep6TqTA2TOUEKhLj4cHw4DsIwyNxEVrn5wnsFsiekmALdk9h2RcQneii+RjclnrvjKUPGJi8MoMn/DbNkgSmTGTgcP75Nmbo77dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bIA2cuiL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y9XALeKfiEwQpLNtrIYQtwh2NhbNt1WeeA0fPDhNUO8=; b=bIA2cuiLTuGAw1R3PEQz/pYIC2
	qBCCwuijAQ6cKvzeMGBJ+NyF8sk4ZxWsfMDfMn4NfDOpY5OwIu/CZocxTBXLrxZBCGX1N1f6vKEnw
	vWhr+xbOrLCgO1s9EbdIOJRw3ZTjrLof2N+yew8uL2lsXjI+ViqSBgXf0uJmEWTuUuAkuL8XIT00B
	LiQAoQtFjdi80MPxMiloqqTob+o2fpXxa5WilP585rB/2yQlnce8u5DDcx0Yyrbzr6Z14imM2qBcw
	M8/6c8CWWIW3dwFaI5gb2O+qb9dgeSkd/3vIeqt9r8+lUJjZp5GcD/sHyk9Fzaz2gqnn3tE49b6tR
	h0UkFfvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLNBV-00000008sEd-3aUE;
	Tue, 18 Nov 2025 14:59:57 +0000
Date: Tue, 18 Nov 2025 14:59:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz,
	syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com,
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
Message-ID: <20251118145957.GD2441659@ZenIV>
References: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 14, 2025 at 05:52:27PM +0100, Mehdi Ben Hadj Khelifa wrote:
> Failure in setup_bdev_super() triggers an error path where
> fc->s_fs_info ownership has already been transferred to the superblock via
> sget_fc() call in get_tree_bdev_flags() and calling put_fs_context() in
> do_new_mount() to free the s_fs_info for the specific filesystem gets
> passed in a NULL pointer.
> 
> Pass back the ownership of the s_fs_info pointer to the filesystem context
> once the error path has been triggered to be cleaned up gracefully in
> put_fs_context().
> 
> Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> Note:This patch might need some more testing as I only did run selftests 
> with no regression, check dmesg output for no regression, run reproducer 
> with no bug.

Almost certainly bogus; quite a few fill_super() callbacks seriously count
upon "->kill_sb() will take care care of cleanup if we return an error".

