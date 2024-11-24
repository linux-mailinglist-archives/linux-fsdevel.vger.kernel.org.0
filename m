Return-Path: <linux-fsdevel+bounces-35723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750F9D780B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 21:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12AD281C96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974B15B153;
	Sun, 24 Nov 2024 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cgshNQNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4496BFC0;
	Sun, 24 Nov 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732479014; cv=none; b=K3EOdHP+Ir09Np6D6mMAnO7fl7Uk7aPmlA5sB5gyExioyuTXHplutdb8vMvTbp89VMmJImgpvKzYZwtIKJ2MG/T5tBXveatSOn7mTMEdd/u5DIuyyQNNxg9FTTiCu5ApM7vQoZFrcsZS6pUTWS6UfuFek4OD+lradb8jJr+jOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732479014; c=relaxed/simple;
	bh=F+w6E6sADExv5PPjYeuObBuqU8GXRguGq1mKJ6VgiFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGdJMciK9c7KA6ymOMytLiT3ghxNUktf8yTfow4VenOtxWeqrdQDm+1RhbNxTMgk72KtMush4x4jjVQKtAjpeho/lNoh/UTihJHqRTK+cXmjvjzrrXb7b4RBxzkh98cN7wwFAteimph7GnRQ2h50y5Z4YdkZ/oIb/NzPt7kAnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cgshNQNk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WeK35y26KiRXZkt5U28Bn3VU+EoF0tbBmY9ObTCM/xI=; b=cgshNQNkB64Dod4nZFaSUZyl0l
	gCXhILA6ut0rTbWJTmCt8TeVwrtW5jiV8LbecbAe5WQnUckBixeT10n0oR1McSBDXOdEoOrSHP37Z
	1bbVHvgd3ePkT9o58PTnhVylMaxZlBzMzdlhZx+kxWMYIa8v+3XxHvOlQYdrD79kAQ2QEVq23ZC/I
	JsrcDgqr5/+gpQeR1Ys6D45El7WX64fXpH8aVUpuIMqlCQGVD/cm/Yb7cvmXbXpALHKFRDqq/7/q/
	JWmtWP6ZC9v6u1OmXB3OT8Evl3MXZxQ7QJ3lX8CKmWRD7a+y3+YrBS9z5AM6XeVCpZMuDuA7WvwoZ
	t6FmEdmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFIvp-00000001Ipd-1rdz;
	Sun, 24 Nov 2024 20:10:09 +0000
Date: Sun, 24 Nov 2024 20:10:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
Message-ID: <20241124201009.GZ3387508@ZenIV>
References: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
 <6743814d.050a0220.1cc393.0049.GAE@google.com>
 <20241124194701.GY3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124194701.GY3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 07:47:01PM +0000, Al Viro wrote:
> On Sun, Nov 24, 2024 at 11:41:01AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > WARNING in minix_unlink
> 
> Predictably, since the warning has nothing to do with marking an unchanged
> buffer dirty...
> 
> What happens there is that on a badly corrupt image we have an on-disk
> inode with link count below the actual number of links.  And after
> unlinks remove enough of those to drive the link count to 0, inode
> is freed.  After that point, all remaining links are pointing to a freed
> on-disk inode, which is discovered when they need to decrement of link
> count that is already 0.  Which does deserve a warning, probably without
> a stack trace.
> 
> There's nothing the kernel can do about that, short of scanning the entire
> filesystem at mount time and verifying that link counts are accurate...

Theoretically we could check if there's an associated dentry at the time of
decrement-to-0 and refuse to do that decrement in such case, marking the
in-core inode so that no extra dentries would be associated with it
from that point on.  Not sure if that'd make for a good mitigation strategy,
though - and it wouldn't help in case of extra links we hadn't seen by
that point; they would become dangling pointers and reuse of on-disk inode
would still be possible...

