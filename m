Return-Path: <linux-fsdevel+bounces-7257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82268235F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397E72873C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8A1CFB4;
	Wed,  3 Jan 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C41nZn4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCE1CF94;
	Wed,  3 Jan 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SP0nbnT3AvmqkH3t2fYH0Mm3KoSoMBeL9IG/d+j/s5o=; b=C41nZn4h4ycXV0ug3wUFS8f1lp
	eyGdP3MdWkUv+7im/gYX+nOas2NQCmCRcmMk57LyHtR9/6AkuDBmpTxmMEzBmPonKpm5e63bU9qup
	a3JqPf8kcM9JfiEoAt8PeMM4/R0p77ZdwkVBEo07l5KcUlFLfNIbDuUJ3PaLV/TJxOJn3fQUt12vY
	uSXEzKWS0SAeWfT/h0InIMfing5epQ6vwMj2MHGdabEr9kZB+HuvyMffRBhD6Qiei7K/aDbyxWQiI
	/GFg9YAGwqpf0ubEA+kcoBKg9vAMyV3Kv61WoUq+bSYrqi/if0RM67kI3VqcOVktFbTsY8wuleCm1
	gOtXNcAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rL7JO-000gHq-1E;
	Wed, 03 Jan 2024 19:53:58 +0000
Date: Wed, 3 Jan 2024 19:53:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <20240103195358.GK1674809@ZenIV>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
 <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com>
 <ZZWhQGkl0xPiBD5/@casper.infradead.org>
 <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqo1v8MYFdmyHfLfiuPAHFWEw80pL7WmEfgXweqKfofp4Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 03, 2024 at 04:04:26PM -0300, Wedson Almeida Filho wrote:

> > Either stick to the object orientation we've already defined (ie
> > separate aops, iops, fops, ... with substantially similar arguments)
> > or propose changes to the ones we have in C.  Dealing only with toy
> > filesystems is leading you to bad architecture.
> 
> I'm trying to understand the argument here. Are saying that Rust
> cannot have different APIs with the same performance characteristics
> as C's, unless we also fix the C apis?

Different expressive power, not performance characteristics.

It's *NOT* about C vs Rust; we have an existing system of objects and
properties of such.  Independent from the language being used to work
with them.

If we have to keep a separate system for your language, feel free to fork
the kernel and do whatever you want with it.  Just don't expect anybody
else to play with your toy.

In case it's not entirely obvious - your arguments about not needing
something or other for the instances you have tried to work with so far
do not hold water.  At all.

The only acceptable way to use Rust in that space is to treat the existing
set of objects and operations as externally given; we *can* change those,
with good enough reasons, but "the instances in Rust-using filesystems 
don't need this and that" doesn't cut it.

Changes do happen in that area.  Often enough.  And the cost of figuring
out whether they break things shouldn't be doubled because Rust folks
want a universe of their own - the benefits of Rust are not worth that
kind of bother.

