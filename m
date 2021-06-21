Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD13AF23F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFURru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 13:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbhFURrt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:47:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE6B9611C1;
        Mon, 21 Jun 2021 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624297534;
        bh=ufLADW47Kla0bMU2kjGScNjsS0PlfnaV+9pcp6Xd2U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMf2uSCeO2MEJ2axwrZyXo26fPJNGEQW9PmWTGKv7VEL5LHjAMgdwe4GUBpFojQ4Q
         QljvHF0Nl4Gg0Z4kATKK7EXaCCAgseibvGPkc+GU5xUfC1RX8P8C8UBy9k61c7/i/7
         LwT1F+aSV0ubtagGuBj7AlF516IvDuhMsXgOx4oEdvYB2sESSyFbb66SzhHbpK+iC0
         ZXolVmZEo1L+6yw6plJ9saH3SzLn+iY88nRe+edUPiHJmt/3gL84GAMsoN3vjuHZrO
         0OlVxROxNXteJzSJniHjhxzAr7sUJLTH9tSSd8z4YQm2D1R1Bl1mSCfYPHJRKHDZa9
         FS4Q1mOp6J76A==
Date:   Mon, 21 Jun 2021 10:45:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] what the hell is ->f_mapping->host->i_mapping thing about?
Message-ID: <YNDQPTAn/vpC4gBq@gmail.com>
References: <YM/EcUZqqJ3RRu57@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM/EcUZqqJ3RRu57@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 20, 2021 at 10:42:57PM +0000, Al Viro wrote:
> 	In do_dentry_open() we have the following weirdness:
> 
>         file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
> 
> What is it about?  How and when can ->f_mapping->host->i_mapping be *NOT*
> equal to ->f_mapping?
> 
> It came from
> commit 1c211088833a27daa4512348bcae9890e8cf92d4
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Wed May 26 17:35:42 2004 -0700
> 
>     [PATCH] Fix the setting of file->f_ra on block-special files
> 	
>     We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
>     points at the right thing.  And we need to get it from
>     inode->i_mapping->host->i_mapping too, which represents the underlying device.
> 
>     Also, don't test for null file->f_mapping in the O_DIRECT checks.
> 
> Sure, we need to set ->f_ra after ->open(), since ->f_mapping might be
> changed by ->open().  No arguments here - that call should've been moved.
> But what the hell has the last bit come from?  What am I missing here?
> IDGI...
> 
> And that gift keeps giving -
> fs/nfs/nfs4file.c:388:  file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
> is a copy of that thing.  Equally bogus, AFAICT...

FWIW, I came to the same conclusion that just ->f_mapping would be sufficient:
https://lkml.kernel.org/linux-fsdevel/20170326032128.32721-1-ebiggers3@gmail.com

- Eric
