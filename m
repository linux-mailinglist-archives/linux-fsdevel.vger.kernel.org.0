Return-Path: <linux-fsdevel+bounces-24965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868094731D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3380280F00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834A13CA93;
	Mon,  5 Aug 2024 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N/9uDO0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0614A85;
	Mon,  5 Aug 2024 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822043; cv=none; b=AfejpUVYVDubBC7kifsEFKDbzlAIz1uA/xDG3L0Jp8NIa2CeAt53A3iJKNHyhUOLt2IOAY0Q+t6YmdaauslKSDqLIsXUG3xjxCq4U7gj/TLATBE3Vl3QDybZM2V1o30LJUoYO5dYNNV092xs4uUM2Fmglapm5xq8quhe7uZKF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822043; c=relaxed/simple;
	bh=mSErUR+yF4uoVvAL8xKjzJm95ZTKfTbM8MW3lW+XO00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqI1GzljBze3KdlzCaQw+paNfqTyyh8nNY12W3oif7cLviUa/nR4Q+XSLgGZNkYnxPF1Sm0/LkiPFmsqjUz/ZmL50uflK/20Jif4KoFvmH2A+ggIP0OVX6Oyhp8Y7zq4YXglKxAWYk1K2T8fuaB9lPMFN/FpOrSdm2hPebLbrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=N/9uDO0A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SortgjABZXVBjsjzqE1PB73sA2UpLdRikGGWkayE3aY=; b=N/9uDO0AkIAIx6QjM4OEvQcLpx
	o4GppXXwlwGUodUh+wp43+zC/KUZgmhIaAnrbXTwsUNxP0vVczSXr9wnzPRoAwrolZ++LJH8/dgfp
	wdI7sgiuE4mu/yWaRXiJQ72vaNuycfScLEbYWr3WUurUUPgwzQTeeyrIq7b1c/hlS/R4R3PO3cTVk
	XhDA3ll3335QGEWoLfkb6+OzaxlaiBOPvy4wh8FvgchCo6HOb5fKKcr/unGXos9q3p/4dHXDBfkT9
	MgH3vKF3VJnNXK13dmHZ3XdSZCdwN4rJORalmLhWotB9nVGuwPisaS8X9rUf9iRnhLAW1o9P8+KWV
	RepS6Pww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1samiD-00000001cST-3Swz;
	Mon, 05 Aug 2024 01:40:37 +0000
Date: Mon, 5 Aug 2024 02:40:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Message-ID: <20240805014037.GF5334@ZenIV>
References: <20240804212034.GE5334@ZenIV>
 <20240805010231.1197391-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805010231.1197391-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 05, 2024 at 09:02:31AM +0800, Lizhi Xu wrote:
> On Sun, 4 Aug 2024 22:20:34 +0100, Al Viro wrote:
> > Alternatively, just check ->i_size after assignment.  loff_t is
> > always a 64bit signed; le32_to_cpu() returns 32bit unsigned.
> > Conversion from u32 to s64 is always going to yield a non-negative
> > result; comparison with PAGE_SIZE is all you need there.

> It is int overflow, not others. 

Excuse me, what?

> Please see my V7 patch,
> Link: https://lore.kernel.org/all/20240803074349.3599957-1-lizhi.xu@windriver.com/

I have seen your patch.  Integer overflow has nothing to do with
the problem here.

Please, show me an unsigned int value N such that

_Bool mismatch(unsigned int N)
{
	u32 v32 = N;
	loff_t v64 = N;

	return (v32 > PAGE_SIZE) != (v64 > PAGE_SIZE);
}

would yield true if passed that value as an argument.

Note that assignment of le32_to_cpu() result to inode->i_size
does conversion from unsigned 32bit integer type to a signed 64bit
integer type.  Since the range of the former fits into the range of the
latter, conversion preserves value.  In other words, possible values
of inode->i_size after such assignment are from 0 to (loff_t)0xfffffff
and (inode->i_size > PAGE_SIZE) is true in exactly the same cases when
(symlink_size > PAGE_SIZE) is true with your patch.

Again, on all architectures inode->i_size is capable of representing
all values in range 0..4G-1 (for rather obvious reasons - we want the
kernel to be able to work with files larger than 4Gb).  There is
no wraparound of any kind on that assignment.

See https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf,
in particular sections 6.5.16.1[2] and 6.3.1.3[1]

