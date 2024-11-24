Return-Path: <linux-fsdevel+bounces-35722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1DD9D7805
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EEE281C45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E215573A;
	Sun, 24 Nov 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cOrZ0QxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A522500A0;
	Sun, 24 Nov 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732477626; cv=none; b=PcAiw2+LQ7hD1/y/VhL85VmvIoQFpta53cFAqZGCB4wR0pIKCSGRG0ZAbTBf2HFv5FhfZPXtwTAukwD4gAvWl/p4u2+TwAfz5e8sdAKU3Wwps7ip7gU/Z+X6BJvitgc8v4Bc1Hj9ptVq7G8bm2jJm8fpM4H66+ocolpYz5Qs74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732477626; c=relaxed/simple;
	bh=V+EtD5AFgjUn1Hh0hSk/ZUvhWf/V0hP09gwjOxmHp8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0ueUkf4F1625KlxRzXYyGb+PPxcdLBlw+9/Mb5hnfmGNe7YUsaZyiwUhYtsBImKBbq6LuFS90xNVwhTPCf5mDD0glXrFXCSA+bc3fvp4vLI7VN+BIoI8Yl33Z8/dxuekqyVBg1BwKU7dUXo6rHRLZIGxMaolAGoXfnxKnTHKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cOrZ0QxI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N8Ughgy84J+TxL5bBLTSQ7toDLa8snkul2Vje56+ZEA=; b=cOrZ0QxIscJxcejq6UnesPC3ZH
	OJygjFvte/VS+UbymsT1q0RCbgVtzHz91x7pJMuj2jPQpx1FkFK7eQuGGqVtY/X7ykS5ZDf+eG41C
	XBBav+Hz3NYYg+OO32mqc82uDmqu0hbCDw8JG8lAJGlO3rsD0mRQEGz+5lqx3ZgsSGltoTOOOBfhN
	QdPhVUe97ugMaQ/REHVmD/N5vud9PM5FGChGbgoN3CMeNwOKOTBXtmdsAVqT3FoYhj/BiHA6mKxId
	x+NxzH/qKtqllkXYU0LVLS6QIDIBKl+cK1SFZRr+kNdnrLCkeYvn1I+FZm2+U8lHNGE+GGjUFNQUU
	JyDwnC5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFIZR-00000001IYK-3YAk;
	Sun, 24 Nov 2024 19:47:01 +0000
Date: Sun, 24 Nov 2024 19:47:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
Message-ID: <20241124194701.GY3387508@ZenIV>
References: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
 <6743814d.050a0220.1cc393.0049.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6743814d.050a0220.1cc393.0049.GAE@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 11:41:01AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in minix_unlink

Predictably, since the warning has nothing to do with marking an unchanged
buffer dirty...

What happens there is that on a badly corrupt image we have an on-disk
inode with link count below the actual number of links.  And after
unlinks remove enough of those to drive the link count to 0, inode
is freed.  After that point, all remaining links are pointing to a freed
on-disk inode, which is discovered when they need to decrement of link
count that is already 0.  Which does deserve a warning, probably without
a stack trace.

There's nothing the kernel can do about that, short of scanning the entire
filesystem at mount time and verifying that link counts are accurate...

