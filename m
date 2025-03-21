Return-Path: <linux-fsdevel+bounces-44688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF9A6B637
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A888462A84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B871EFFB0;
	Fri, 21 Mar 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvl1KLvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BF1DDA39;
	Fri, 21 Mar 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546797; cv=none; b=JMI9kd+mynKhqJv7+XBklU9Ewk2G5mBtTsS9LR6Csiu7nwJw2dW4h2BQIhpcwvhzsxbaf59QeWw6dHm5NxufB7ORaWfHcGFFcxmt+5Z06Ws1G+volfDAf8xhu807g4zWbgtttR7n0GiszVSA31CpYkj3j7o8jxpVT9097qrnIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546797; c=relaxed/simple;
	bh=SnjraZ75Q0RAHyyel2IKi19BojWhsBkxupdgGmBv0JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx65kaJtiG5dq5W5H+TQmup/C3jZM/fKo/D4NC3xUD7pnI8ME3XtPcIgkqlXNO9JqEndlbbSDyrVDLMOXwG9jiBc04hp7Kmicp0t8v8DOobgODpoFjL/GBclCgy/b26aDjYwnBfT7bg3vmLc8ErpWikX+HOW1ThR9/IP/6kFfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvl1KLvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003C7C4CEE3;
	Fri, 21 Mar 2025 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742546796;
	bh=SnjraZ75Q0RAHyyel2IKi19BojWhsBkxupdgGmBv0JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xvl1KLvHNlMZmSFbyjWoQ2cdB82HP7ohRZgTnbNhsF6AOqjl2sBfl97gh3zlMI+Gz
	 luA06xKvI8CFzJjQJhh+YXf8WOro3Ys73PPhdWYk6B7ryTOZznjSzHN/eGBBkG43Mq
	 6uDd6AqCdxUPrOzxuSW+3/gQRwdVvhu1rTpmWa3xSXXk/SDjGpxuaDsKfFJSXX5gco
	 DuAr5bYNpScQCHS/Yf09Yz7c41u5Awc7OufBvs52Ws693baeUOoNvmk9ZYONhBofkR
	 Yp05M/aRmgNz/crnguV8QWFc6ZcwiNgXrf5J7lVNsmSHyMuIETIDgYTmF+x5zj4bwI
	 LtHT4nvTfFuGQ==
Date: Fri, 21 Mar 2025 09:46:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: julian.stecklina@cyberus-technology.de, Christoph Hellwig <hch@lst.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250321-komprimieren-dachgeschoss-75bc46d824d0@brauner>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
 <20250321020826.GB2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321020826.GB2023217@ZenIV>

On Fri, Mar 21, 2025 at 02:08:26AM +0000, Al Viro wrote:
> On Thu, Mar 20, 2025 at 08:28:23PM +0100, Julian Stecklina via B4 Relay wrote:
> > From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> > 
> > Add erofs detection to the initrd mount code. This allows systems to
> > boot from an erofs-based initrd in the same way as they can boot from
> > a squashfs initrd.
> > 
> > Just as squashfs initrds, erofs images as initrds are a good option
> > for systems that are memory-constrained.
> > 
> > Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> >  #include "do_mounts.h"
> >  #include "../fs/squashfs/squashfs_fs.h"
> > +#include "../fs/erofs/erofs_fs.h"
> 
> This is getting really unpleasant...
> 
> Folks, could we do something similar to initcalls - add a section
> (.init.text.rd_detect?) with array of pointers to __init functions
> that would be called by that thing in turn?  With filesystems that
> want to add that kind of stuff being about to do something like
> 
> static int __init detect_minix(struct file *file, void *buf, loff_t *pos, int start_block)
> {
> 	struct minix_super_block *minixsb = buf;
> 	initrd_fill_buffer(file, buf, pos, (start_block + 1) * BLOCK_SIZE);
> 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
> 	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
> 		printk(KERN_NOTICE
> 			"RAMDISK: Minix filesystem found at block %d\n",
> 			start_block);
> 		return minixsb->s_nzones << minixsb->s_log_zone_size;
> 	}
> 	return -1;
> }
> 
> initrd_detect(detect_minix);
> 
> with the latter emitting a pointer to detect_minix into that new
> section?
> 
> initrd_fill_buffer() would be something along the lines of
> 
> 	if (*pos != wanted) {
> 		*pos = wanted;
> 		kernel_read(file, buf, 512, pos);
> 	}
> 
> I mean, we can keep adding those pieces there, but...

Very much agreed.

