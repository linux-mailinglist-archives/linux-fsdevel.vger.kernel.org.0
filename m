Return-Path: <linux-fsdevel+bounces-54190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EE0AFBE4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456E01AA5E1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401E2874F4;
	Mon,  7 Jul 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AzVLWT1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B01CAA6C;
	Mon,  7 Jul 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927876; cv=none; b=p5upO0A9FG2OOd7uBTswBX9N1kmqseRrExio787G06FgNzLAfxjPRsEHYlK0FcC/OXXyOhxor/9XI/cNZ0ciEgBzovuY4zui530GjFWoYKFc1K6TPJV4EHZYl6zDDiuT+bDU+35JXQjX4q6uJNVhPwzQY8Eixwplx3I436mx/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927876; c=relaxed/simple;
	bh=atdk8fWbV64hkjK9szSi1AMQvUvRXwSBPlCWir75L/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlNbSc4t65JzbejTpPUCmy52l+dUL7mmZp2/1FBz4r5CJcheg9pE3h7n1T9JQCPTrUUXGEHCgjO/3ObDgWlHI9ApOr9Lwk3Ic+6a07Ya+A9iA9iXJ+MWD+CNaSSbskPyhWwMJsGU1JsG+ja7ayXtFKUTMBhdpeIOcGSGkhcRs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AzVLWT1l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=RUXuA6EiiV8xWgB0NUOWGzh4EMnPKummfsPh8UGafxw=; b=AzVLWT1ll8uQCEhntiuAq6kcSu
	l/u8q6KH71fgmaNUtVHuaCp82eEFwoCixSVMROh6d3vN7h0Pdz7jtofbvufM0cLjlaPitPSyoWAAF
	zUn+NKcJXSVNPDyiqCwqkAe3jkFCXA731fIdbyUQB0u7TjkndTWFDLApmL6hp3XO/3GoJbcz29wyC
	BG+oQ0BUPclrnlfuIIBXnZJY62Dbz7letE8NaXoeMzLCkJ8ydfcIutCG4Fpz6bv3sxPCBjCBl+2a1
	fDClv/eD4kEC3HBXdZYVuNyzpFB4FCCNFmpXif5WFpYP08p4PNL9u44owGvgrpcjp4JDGXtmRwr4/
	vpD7raJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYuTB-00000004MGP-0kCB;
	Mon, 07 Jul 2025 22:37:53 +0000
Date: Mon, 7 Jul 2025 23:37:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707223753.GQ1880847@ZenIV>
References: <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
 <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV>
 <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
 <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV>
 <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
 <20250707221917.GO1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707221917.GO1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 11:19:17PM +0100, Al Viro wrote:
> On Mon, Jul 07, 2025 at 11:47:04PM +0200, Max Kellermann wrote:
> > On Mon, Jul 7, 2025 at 11:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > The second d_walk() does not have the if (!data.found) break; after it.
> > > So if your point is that we should ignore these and bail out as soon as we
> > > reach that state, we are not getting any closer to it.
> > 
> > Not quite. My point is that you shouldn't be busy-waiting. And
> > whatever it is that leads to busy-waiting, it should be fixed
> > 
> > I don't know how the dcache works, and whatever solution I suggest,
> > it's not well-founded. I still don't even know why you added that "<0"
> > check.
> 
> Take a look at shrink_dcache_for_umount().  We really should not progress
> past it in such situation.  And dentry can be in a shrink list *WITHOUT*
> the need to pin the superblock it belongs to.

... and the same goes for memory pressure, BTW.

Suppose you have a tree with everything in it having refcounts equal to number
of their children.  _Nothing_ is busy, nothing is getting evicted at the moment.

You are asked to evict everything evictable in there.  It would be rather odd
if you ended up with some dentries sticking around (_still_ with refcounts
equal to the number of their surviving children) just because in the middle
of your work a memory pressure had been applied and started evicting one of
the leaves in that tree (none of them busy, all leaves have refcount 0, so
all of them are evictable).

