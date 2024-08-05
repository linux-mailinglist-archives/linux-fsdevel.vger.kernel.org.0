Return-Path: <linux-fsdevel+bounces-25031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227039481AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C191D1F21B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E3E1607BD;
	Mon,  5 Aug 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s15ayPDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA001494DA;
	Mon,  5 Aug 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882839; cv=none; b=Kxgo++Qme73ANSeKAWUdx7+QHlWeXdBBtL5odzg4WXjnDnNDx4V7nC+6HhWKL5lZeDw5KJlSplqXZ+WZV0p380XfoUDixRs1uLgC0WiP07yS8SO9bwUvQpC2LtQRyCiwxm27W+EttNAtnQMrMm4XKasdQ5btjK2DnE26HcySgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882839; c=relaxed/simple;
	bh=DdWRiHzipkVrkpObHK9CyGrVfzm4MWuYbZ6TMtgqTOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFJVDU55W8pkuO5Cii1MLQnLkOvgcrQuGj+QK4E3hZi8b7JRwc1+2hkep9aYyejJ9fMOMmqizf48jiGLZiBY7YrjDJvTTyVq85qK89M4QtfjrVD2ZqyWqdrTAdMZ4Pl/xGFMhr72Qn7PaOWVeJuoF4XIAtd1BPscw0mFd8C09uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s15ayPDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD40C32782;
	Mon,  5 Aug 2024 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722882838;
	bh=DdWRiHzipkVrkpObHK9CyGrVfzm4MWuYbZ6TMtgqTOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s15ayPDCsnzx05XmrSpy5fG4SEHlyhps5yZSXdSkFfmwYJesV0g8ZdWUXZsWJYnum
	 X989B7XAy4CcfrUqc1bInKkhuSwGi7IpSSvEi+jXqci4DVMrvnhjFjVdX6m+NDTD0Y
	 DJMZCIGhFMyNRxGJtenqVZ/g8eE90MsjAHB5JHTc=
Date: Mon, 5 Aug 2024 20:33:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, maple-tree@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
Message-ID: <2024080532-camera-desktop-92bf@gregkh>
References: <20240805100109.14367-1-rgbi3307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805100109.14367-1-rgbi3307@gmail.com>

On Mon, Aug 05, 2024 at 07:01:09PM +0900, JaeJoon Jung wrote:
> Implementation of new Hash Tree [PATCH v2]
> ------------------------------------------
> Add spinlock.h and rcupdate.h in the include/linux/htree.h
> Add htree_root structue to interface locking.
> htree_root.ht_lock is spinlock_t to run spin_lock.
> htree_root.ht_first is __rcu type to access rcu API.
> Access the kernel standard API using macros.
> 
> full source:
> ------------
> https://github.com/kernel-bz/htree.git
> 
> Manual(PDF):
> ------------
> https://github.com/kernel-bz/htree/blob/main/docs/htree-20240802.pdf
> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  include/linux/htree.h | 117 ++++++++++++++++++++++++++-
>  lib/htree-test.c      | 182 ++++++++++++++++++++++--------------------
>  lib/htree.c           |  29 ++++++-
>  3 files changed, 238 insertions(+), 90 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

