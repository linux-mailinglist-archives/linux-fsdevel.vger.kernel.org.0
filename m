Return-Path: <linux-fsdevel+bounces-68990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFA9C6AC33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CACD92CC45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC6365A1F;
	Tue, 18 Nov 2025 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RP38Twwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F72320CA7;
	Tue, 18 Nov 2025 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484959; cv=none; b=eIb0N4PEqyJT8eo0QG3DnRkjc0ai2Sy3t0+1ossoBXSCReRZU8m7ZIk96U+PWTIaiAZJTpZpK2rZF7NTxxHhyr0cTHd6tp9zGAZDFrCaeZVxeucPymahgl7fiavIq8f3keTE+P8QuTtPrzR5iVogIFDb0g72lZ0f7FJ0d2w+IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484959; c=relaxed/simple;
	bh=gNykeiEJ161fBlHb1EROjr/lUEtYva2cO5zEi8KsVK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/FIVKfI546bkgvr/MpLnkn5NMlL8pse9g+WWTUBZDQ4j1jlhSQPqzeXG5cQBwY+iimF8cUw8l62Jt+uU/WB6rF/BEpkVWHVP/wJg8hjGr74f9dBLxmKGAkVIPExFGNjrbBnPSMeUn6aSen1YS3HNHMUGAx9mVozXEWI6mpbCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RP38Twwq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I+7gZeWoCFkE7hp3ZnZaCM9Qui0wtrYwJjYPcSKek/w=; b=RP38Twwq+Z9bCE5LeW5ircQOrz
	ZN+BXnq5Av6aPasz4tpu9oLBm1l2FMt1ocIQQLWfVCf+wkEgbeLUmb74lEhudWyBMt6SpyMaiioE+
	McEgQHywCiJw5iSqCOvMu+H+UVf0g/1cBRvRwZK+R8F8pfdddCueiQNtKjUeLeOPWPt2WZAeyOaPU
	0chxRv++nLTyegkQ179q8M5SBxADSFSUFzKoGQ6f+Gqa+eDrRp4rCd0MIJ78bAJr+/FUnEnsHqhwh
	QyUI6Zq0mP8Eu7ieRoXBdEJuMCrbT457zb1ExA48CV+BMk1RZoF9a49LrBtC03cQW+EUHdgrtzCK7
	Fgn2odKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLOzh-0000000BDbW-3jMc;
	Tue, 18 Nov 2025 16:55:53 +0000
Date: Tue, 18 Nov 2025 16:55:53 +0000
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
Message-ID: <20251118165553.GF2441659@ZenIV>
References: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
 <20251118145957.GD2441659@ZenIV>
 <6c482108-78b8-4e09-814a-67820a5c021e@gmail.com>
 <20251118163509.GE2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118163509.GE2441659@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 18, 2025 at 04:35:09PM +0000, Al Viro wrote:

> For HFS I would expect that hfs_fill_super() would call hfs_mdb_put(sb)
> on all failures and have it called from subsequent ->put_super() if
> we succeed and later unmount the filesystem.  That seems to be where
> ->s_fs_info is taken out of superblock and freed.
> 
> What do you observe getting leaked and in which case does that happen?

AFAICS, the problem is with aca740cecbe5 "fs: open block device after superblock
creation" where you get a failure exit stuck between getting a new superblock
from sget_fc() and calling fill_super().

That is where the gap has been introduced.  I see two possible solutions:
one is to have failure of setup_bdev_super() (and only it) steal ->s_fs_info
back, on the theory that filesystem didn't have a chance to do anything
yet.  Another is to move the call of hfs_mdb_put() from failure exits of
hfs_fill_super() *and* from hfs_put_super() into hfs_kill_sb(), that
would do that:

	generic_shutdown_super(sb);
	hfs_mdb_put(sb);
	if (sb->s_bdev) {
		sync_blockdev(sb->s_bdev);
		bdev_fput(sb->s_bdev_file);
	}

