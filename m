Return-Path: <linux-fsdevel+bounces-8011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E889D82E2A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAFF1F22EFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F01B7F7;
	Mon, 15 Jan 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WTCWb7xK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE011B7F0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Q4hE4Qv7zc2aYCorHxI0dFn13IcifzbDiKJuVFbUqQ=; b=WTCWb7xKE/Hc0riqHCKZ5cy10j
	IlKj350Ss7H2W5GgJ/ZHMuGPfoZz0fyWxRrJQ3bdo3rX2yDbcYwX714hUlCOMXv/iFebWPCEwycuy
	BlDsRZCHW3uA8+IDLL2yhwKPqyzhMrWogK7IwOAtyOgMs89yC07B7qrY2RIWTUKN3324tZZzhpnyx
	UKd1AFldoDAI5k1nhxtWQTAPjX1SYnxbgk1aFDewe5FANtpZPpN57q9CLdnfGvreDvEfhoeZuNiuT
	zD4wqSATqiXcWJu5fEN3lY789hFlSNuu5cneljAugF/4NfboTLon1UDuOQuq2neFTVZGj+W6nMSaw
	Kr4hOg4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPVVs-003Wb5-2K;
	Mon, 15 Jan 2024 22:33:00 +0000
Date: Mon, 15 Jan 2024 22:33:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bruno Haible <bruno@clisp.org>
Cc: Evgeniy Dushistov <dushistov@mail.ru>, linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Message-ID: <20240115223300.GI1674809@ZenIV>
References: <4014963.3daJWjYHZt@nimes>
 <20240115222220.GH1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115222220.GH1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 15, 2024 at 10:22:20PM +0000, Al Viro wrote:
> On Mon, Jan 15, 2024 at 11:05:51PM +0100, Bruno Haible wrote:
> 
> > Whereas this partition can be mounted fine on FreeBSD, NetBSD, OpenBSD.
> > FreeBSD 11:
> > # mount -r -t ufs /dev/ada1s2 /mnt
> > NetBSD 9.3:
> > # mount -r -t ffs /dev/wd1a /mnt
> > OpenBSD 7.4:
> > # mount -r -t ffs /dev/wd1j /mnt
> > 
> > The source code line which emits the
> >   ufs: ufs_fill_super(): fragment size 8192 is too large
> > error is obviously linux/fs/ufs/super.c:1083.
> 
> Lovely...  Does it really have 8Kb fragments?  That would be painful
> to deal with - a plenty of places in there assume that fragment fits
> into a page...

FWIW, theoretically it might be possible to make that comparison with
PAGE_SIZE instead of 4096 and require 16K or 64K pages for the kernel
in question; that ought to work, modulo bugs in completely untested
cases ;-/

Support with 4K pages is a different story - that would take much
more surgery in fs/ufs.

Constraints:
	* fragment and block sizes are powers of 2.
	* block:fragment is 1, 2, 4 or 8.
Violating those is not an option for any kernel.
	* fragment fits into page.
Could be worked around, but not easily.

BTW, can NetBSD/i386 mount the same image?

