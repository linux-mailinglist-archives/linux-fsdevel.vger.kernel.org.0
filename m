Return-Path: <linux-fsdevel+bounces-61278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3983B56F59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 06:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9337AD066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181AE242D86;
	Mon, 15 Sep 2025 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLP4wKtp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F353BB5A;
	Mon, 15 Sep 2025 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757910702; cv=none; b=MeUktmbz65DHTTWrY/5TjAkGwpTaxMb+ARQi17ht++QSXb7rXjStOu5Y3PEihcKBrpAlruL5qR3JzT/ArcxZU7WvnMKOAybCQIQJK15r/phhOtDMRvi+nrwdUiIhZTlpOjYA5W7kIvrRTBJfvfuv+FK9oLxiLIDV05Z9XSqwnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757910702; c=relaxed/simple;
	bh=xP6zp3/Pr+eHxqg433MpAAhI0+LPDNYnD4nbSWKrrBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHzANExHYCqqnjw8xCWiqNUbrPebMvle5PI4KBxadMaPr3HrfW5ay+hrVxXrlPYok7z/i+qQPmrP+Tu+HxI2A0uWd6gx8P9+V15HOaUnr1FtTxDMuWgjFQHAfsX2w8BL2LfeJF9lfCl2KeS6XQe1kIEH+ad0y/be7e6bD8mjJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLP4wKtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D81C4CEF1;
	Mon, 15 Sep 2025 04:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757910702;
	bh=xP6zp3/Pr+eHxqg433MpAAhI0+LPDNYnD4nbSWKrrBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLP4wKtpg4nps/ZeYNqIbRgQRVryyJbZbuEtyTBtPNgB5q4UAMLmytoTCWXbBx2gq
	 OyYlvk3EdfgrtHLFDJxVNYgDyd/nLmrrmuSBJhQ/02hxdLa853YURiJax6WSy4HABY
	 5aQlCqawqMIcNu+EX+rrQmwgg9y2UA+pMBaflKlqjqPdUjJ7aIGpbiGSUb6LBmHF0C
	 KptH/AhAdgQHzzTU7rFJdveZaEad7zXgFf+BR2vHnTYPySrRke7j0OsPrNXWsZX758
	 2aYBy2ww9H072AkppW7pJAte3tcXXWyEdmLhUosqixH5scgtm7lOU96tQ+2EawIzYA
	 KSkd5dMPsPSMg==
Date: Sun, 14 Sep 2025 21:31:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: Fix logged Minix/Ext2 block numbers in
 identify_ramdisk_image()
Message-ID: <20250915043141.GM1587915@frogsfrogsfrogs>
References: <20250913103959.1788193-1-thorsten.blum@linux.dev>
 <20250915122146.56f66eb2.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915122146.56f66eb2.ddiss@suse.de>

On Mon, Sep 15, 2025 at 12:21:46PM +1000, David Disseldorp wrote:
> Hi Thorsten,
> 
> On Sat, 13 Sep 2025 12:39:54 +0200, Thorsten Blum wrote:
> 
> > Both Minix and Ext2 filesystems are located at 'start_block + 1'. Update
> > the log messages to report the correct block numbers.
> 
> I don't think this change is worthwhile. The offset of the superblock
> within the filesystem image is an implementation detail.

...and even if logging the detail is useful, for ext* the superblock is
always at byte offset 1024, no matter which block (0 or 1) that is.

--D

> > Replace printk(KERN_NOTICE) with pr_notice() to avoid checkpatch
> > warnings.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Nothing is being fixed here.
> 

