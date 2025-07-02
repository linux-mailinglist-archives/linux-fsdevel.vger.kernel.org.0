Return-Path: <linux-fsdevel+bounces-53713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA41AF618E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7401C28284
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD4315506;
	Wed,  2 Jul 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JSuXjBvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FED30E833;
	Wed,  2 Jul 2025 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481587; cv=none; b=NvJ4eOkpRFnWzTSOGcXmbj5Aod3yiuKK3XQjtCdfsg4slv3bTgIzkjyFSNKafldCMNB23M46tYz6cpiBgQxSh3rgVFWSkJAzNMevGhFkInK5j8B+0BhBEOSpQw8zz7zg1ywHSrKyMgCq3uN0gTXN5ir19Xhgfhl2Kc2yGinTyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481587; c=relaxed/simple;
	bh=6l0RxST3t939kLUPWkhmp6xRxjdBhMganOmB+2ZBcJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEQW6Dxg7BnMS0CwnXTd/95TTVE9sFsV9M05h4w9vHOFUlNH1ViFdxo3nKVB5hjatJfAY5cIg8VEUuGzm8oc1LJBN/qdQUsHLttwm19TAecQVbgwnp2+Y4QIDkyCP8xDR2xROVUsv5GLsfBdS4GTX47CmisBch0AHYwyT6r4Mc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JSuXjBvr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hJI45sJQ3ePvxFVLPLejbi5ubi/MYjabBTxckmO9R3Q=; b=JSuXjBvrOlDRlCFeiwy2SY2SBb
	zunYm1843S1SXBv59ftsWj31nu2mEK9w6KMMFw/v/pvGnjgff3+r+A7xGyfiU37Gsfrueg8KX8j2O
	ZxVmiMVOIT0zHYpNotzOSGlj2hzxemShJScoe8uj7y25qe7YTDfjfNQoZkPJ31Yy9PKYqXu3cKalC
	Dc2pLGeTWyTl+EqF2uzHpXm+6qqb2osoOrP5JmjHr5+Y3KPQ7fQL552vsg14Tu1YgHGVrxrsoykNl
	VO7kFPC3OGxYcnA4QIsjKo973WYc4YW5EK5ZE5NTzx1hruFfv0jIFFKzHZdqRW4FPawT5J0EEtIWe
	vj02klAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX2Mw-0000000DKOb-1q5s;
	Wed, 02 Jul 2025 18:39:42 +0000
Date: Wed, 2 Jul 2025 19:39:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+6d7771315ecb9233f395@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] possible deadlock in __simple_recursive_removal
Message-ID: <20250702183942.GD1880847@ZenIV>
References: <686574b1.a70a0220.2b31f5.0002.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686574b1.a70a0220.2b31f5.0002.GAE@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 02, 2025 at 11:04:33AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=152d348c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=70c16e4e191115d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d7771315ecb9233f395
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106bd770580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b048c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3d4ef6bedc5b/disk-50c8770a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/15b7565dc0ef/vmlinux-50c8770a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3b397342a62b/bzImage-50c8770a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6d7771315ecb9233f395@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.16.0-rc4-next-20250702-syzkaller #0 Not tainted

False positive.  locked_recursive_removal() is called with ->i_rwsem
on the victim's parent.  It will grab and release ->i_rwsem on
descendents of victim and victim itself (never more than one held
simultaneously) and it is used only on filesystems where we never
change the tree topology.  So the normal ordering of ->i_rwsem is
upheld there.

Proper annotations would be to have the lock on parent grabbed with
I_MUTEX_PARENT as class...

