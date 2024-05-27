Return-Path: <linux-fsdevel+bounces-20258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E68D08A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269001C23222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0973469;
	Mon, 27 May 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hsooxw4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC47347D;
	Mon, 27 May 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827484; cv=none; b=PkpBA27OaJpFLszFOqtgMKJSmjiIz/sOb89DFQTDWarr1Z4txMp73IyLldVGIRU4ePx3XPJdj3Abxbrm8Rn/1SnPVy7rh3OwyLzuNWmAISsG0VuFM4DHtGvI1pIscPwJVxJENJyjNxDrXnNb0qAJPC+iAqZ66p/qq3/I+Atbt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827484; c=relaxed/simple;
	bh=UHzdji3b5jtbCYVY1FtiERZjN+yzMm4hP5v6zc+XiWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE/Hk9iqTgo+PpRTXARgV1gFjnELWpB3FKMPwqtEE84h7vTGwnfA7UuiCkEGOcizy4z8tC8cE1ssSvJ1NyOJFI48hZq8FUpM/PikAhxbd2L4X2PQV8p4CjQE7bvP9Ig9HT8j1XnqTMj0JqT63281qmHd0BlBnTqhZoQ4nWLigUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hsooxw4X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x5hSgktQC4VekqZNvnHHeOTEWH8AryjJrdKbAnEOFp8=; b=hsooxw4X1wEt53LXSYt/42FL6N
	xCUdpx8KVh/3S2lTEQ63zWmx+pTkZr/+CzKvaXs3Fpb9pbLHUOHC4z9G0aF/3DiZ2d+X6MGf5diNd
	+QxXsD16EnrA8odJKZ7HFqhqproNi1rcVtsPoQ/U8wjMdptoWbrGZrDeT3vn0qZ4HUylL6qT9MuQN
	rrwOtAwkfzYQYfBVRq/4MPpX6J6G/+5phQxmX+LAZuJ3ZW4gSZLK99N62jyYDz10Jsw8Djzybqtw0
	LCIe6NjS+bXi/HVMBa0XZYbKrsI7O5/v1wFv32zdYHMKN15PBcSzdS0rVDu7CYNzbLSUYg3oHVBWv
	bP63xZEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sBdFk-00DoOO-36;
	Mon, 27 May 2024 16:31:17 +0000
Date: Mon, 27 May 2024 17:31:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight
 fdget/fdput (resend)
Message-ID: <20240527163116.GD2118490@ZenIV>
References: <20240526034506.GZ2118490@ZenIV>
 <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV>
 <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526231641.GB2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 27, 2024 at 12:16:41AM +0100, Al Viro wrote:
> > What would make more sense is if you make the "fd_empty()" test be
> > about the _flags_, and then both the fp_empty() test and the test
> > inside fdput() would be testing the same things.
> 
> Umm...  What encoding would you use?

FWIW, _if_ we go for replacement of struct fd with struct-wrapped
unsigned long and actually steal another bit from pointer, we could
actually use that to encode errors as well...

If bit 0 is clear for file reference and set for an error, we could
use bit 1 to represent borrowed vs. cloned and bit 2 for need to
unlock...

overlayfs would be happier that way - we could have those functions
return struct fd directly, and pass the error value that way.
fdget() would report EBADF explicitly on empty slot - not a big
deal.  Hmm...

Let me play with that a bit and see if I can come up with something
tolerable.

We could add that in parallel to existing struct fd; we'd need a name
for replacement, though - anything like "rawfd" is asking for confusion
around fdget_raw(), and we'd need replacements for fdget() et.al.
that would yield those.

Alternatively, with a sane set of helpers we could actually _replace_
struct fd definition without a huge flagday commit - start with adding
#define fd_file(fd) ((fd).file)
#define fd_valid(fd) (fd_file(fd) != NULL)
convert the current users, one by one (fairly mechanical patches),
then change the definition of struct fd.  The last step would affect
	* definitions of helpers
	* adding fd-constructing macros (ERR_FD, etc.)
	* converting the few places that really construct those
suckers (fdget() et.al., overlayfs, a couple of explicit
initializers to {NULL, 0}).

It's not a huge amount of work and the flagday step would be fairly
small, but we'd probably need to split that over a couple of cycles -
helpers in one, along with renaming fd.file to e.g.
fd.__file_use_the_damn_helpers, then in the next cycle do the
switchover.

Hell knows; let me play with that a bit and let's see what falls out...

