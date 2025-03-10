Return-Path: <linux-fsdevel+bounces-43676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5887A5B04E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 00:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001F816F812
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 23:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38212222C4;
	Mon, 10 Mar 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZXxaa+B0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CE1CAA8D;
	Mon, 10 Mar 2025 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651116; cv=none; b=n4Mz7Q7JcdyzxcI5QsI0qkQn7/wtyOAl06rX9Y1auRCyMs2to5/hoTyboKPfHoXPC+1KP2oO2xkZZQ2BCtBxYcEfrY4XbDJCLp3eBhfy8o6soyOibSgDRE43FW3I9JF0Q6TyZGme4pVLPv1kvDcyi0Vcg3Q6EE+0PtrtJ5NCFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651116; c=relaxed/simple;
	bh=HRL9dvhLGHgZ+t15fYgJdlkg9n7P/vSyCsVNBTwdSM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAVv2NsR3jyVnje4oR7i+VCjG+nZHZSuBdEsDrjz4HMbXL8DUmDCb8Srj7hOlkegfbTTvBEbTim9SDwgYv/Xr9WPHzcGExYFP2oPb9e8+uPt6GyGcy6zaMAHEDiwDIuZfEWEMyCpXnkSquvrHHxFrjKxFVeHoGfOrRTUWWHtJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZXxaa+B0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O6tK3nGR9KVemkXaRkWRrwdgE+3x50H2PRIQcPyhrvo=; b=ZXxaa+B0/9a66QMHGuH2l4nkZ2
	M4zkg/q7zAYTmX6PBs1NOhDVV6YH91BM48dIe4VSD6vLIQ4BMiDJgbTRms6c0OvFw1QlTWUIKJLbM
	xiY4VaLuqMKlllfgRQZDb15WXl8F5xxQ/K9ZboE+Bi+xUJwLS34oO5zB/iyMEq28JuxyJRQ4WpxI2
	kF5PL6n8epgUirusUxs8k7l8ZFihWvRomDR6yZ/jS2nPXjkyhLBda2N6/NFc7tUx/cYkt2o4H6pEw
	XGSotvNcz1AuuKVjtdNYGafNGjTxHRxEtzrPBJAX5b5T83GSMBdrOcuOVP6FoFnQqBUe5qUKhllfm
	Xto2AsOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1trn0x-00000002rRM-0zDw;
	Mon, 10 Mar 2025 23:58:31 +0000
Date: Mon, 10 Mar 2025 23:58:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>,
	jk@ozlabs.org, linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
Message-ID: <20250310235831.GL2023217@ZenIV>
References: <67cd0276.050a0220.14db68.006c.GAE@google.com>
 <8cf7d7efdc069772d69f913b02e5f67feadce18e.camel@HansenPartnership.com>
 <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH0Myy3bV-hFNWnoUk6ZAa6MAd1zFTM-X6dXiJPx==w0A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 10, 2025 at 07:21:53PM +0100, Ard Biesheuvel wrote:

> The repro log also has
> 
> program crashed: BUG: unable to handle kernel paging request in
> efivarfs_pm_notify
> 
> preceding the other log output regarding the locks, so the deadlock
> might be a symptom of another problem.

This:
        struct path path = { .mnt = NULL, .dentry = sfi->sb->s_root, };

_What_ .mnt = NULL?  That's already a bug.  There is no such thing
as mountless open file; how would the kernel know not to shut the
damn thing down right under you?

