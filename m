Return-Path: <linux-fsdevel+bounces-49001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411AAAB74AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14FA1BA00DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297528850E;
	Wed, 14 May 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="POrI1Rk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73F2882AD;
	Wed, 14 May 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248417; cv=none; b=u4W97xpYNI7qBArQWZulgu88aTyFNn3eBmTJq2io5jkTmUAgrPWWMqOdX3FlR3l6xqV6d/qvgi0kXfQcqs9VAAvrkMvdOB/xdOn8AYxvExL+9JyyPdKGWB149aCDfT+2Rr5DH4/1jC+PUGomVKpiWOpHirLB3dk4gEe4Mz6oDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248417; c=relaxed/simple;
	bh=KQlZ5lQwiRoCUKfotRUhhRrLB1EMUejjK0X4GqELV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJuLz2zrj44fAdO9TMZFcyNwmKcI7j91aiOwfWbrHglhu7fREPpKGcl5M7vOJhpdvsWgHR3dnXYxKeBMkg3+P6yl6ptOomz9RNl2Ega8iIFa6GCcF4xg2C4eKsIQR8xNzsu5Ku0uGw1ezQBLYC6iYl5VUojB0iyy2I/ylVCiLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=POrI1Rk7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XswXjKLPzSvsnGcNe4CcYUQLh/oNtrdDzfkm3+WlEpw=; b=POrI1Rk7xei4mfIgjsndQ9oBsJ
	gGTyfLumVATIU72vu5wxw4UpdExdEt8hhAPJscC3GggxJSKiegHYjgbnd4L103PUJ0+xd7xaxzsQO
	TzHI87elAsI+JZPjWMLHHwTGvNuPfSzayt0HC30XE5au0nTCDNOnJITZT3F/2S5iYRgxyc3ytI/AC
	O/THBeYt7HL3ulFnfgvR7OAxBTOAlsGMdDf1qhkbjlgAJGwLLkaZAw54+z5/173Me/oALb9apJe0a
	+vRAebYdeafq/gpvxCbqBlcjB9mitpP5fi1XpR0B5FeDKqJL6N/yID/QKW1Ghvz3N5/IkpXXpRza/
	+5ToPiyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFH80-00000009Znw-2xX0;
	Wed, 14 May 2025 18:46:52 +0000
Date: Wed, 14 May 2025 19:46:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, cem@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
Message-ID: <20250514184652.GP2023217@ZenIV>
References: <20250514180521.GN2023217@ZenIV>
 <6824dd34.a00a0220.104b28.0013.GAE@google.com>
 <20250514182111.GO2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514182111.GO2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 14, 2025 at 07:21:11PM +0100, Al Viro wrote:
> On Wed, May 14, 2025 at 11:13:08AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot tried to test the proposed patch but the build/boot failed:
> > 
> > failed to checkout kernel repo git://git.kernel.org//pub/scm/linux/kernel/git/viro/vfs.git/fixes: failed to run ["git" "fetch" "--force" "8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04" "fixes"]: exit status 128
> > fatal: remote error: access denied or repository not exported: //pub/scm/linux/kernel/git/viro/vfs.git
> 
> *blink*
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git 8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04
> 
> just in case the cut'n'paste damage (extra slash before 'pub') was not
> the only problem there...

... and that copied the bogus commit id from the error message.  Sigh...

Anyway, actual commit id is cfaefc95bfa7eb92dd837ea9fb38bc84e62d79b5 and
curl 'https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/patch/?id=cfaefc95bfa7eb92dd837ea9fb38bc84e62d79b5'
definitely finds it, so commit is there.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git cfaefc95bfa7eb92dd837ea9fb38bc84e62d79b5

