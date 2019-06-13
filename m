Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FE043ED7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbfFMPxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:53:21 -0400
Received: from foss.arm.com ([217.140.110.172]:36722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbfFMJDQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:03:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B92367;
        Thu, 13 Jun 2019 02:03:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22DCB3F694;
        Thu, 13 Jun 2019 02:03:15 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:03:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fsmount: add missing mntget()
Message-ID: <20190613090305.GA40885@lakrids.cambridge.arm.com>
References: <20190610183031.GE63833@gmail.com>
 <20190612184313.143456-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612184313.143456-1-ebiggers@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:43:13AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> sys_fsmount() needs to take a reference to the new mount when adding it
> to the anonymous mount namespace.  Otherwise the filesystem can be
> unmounted while it's still in use, as found by syzkaller.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: syzbot+99de05d099a170867f22@syzkaller.appspotmail.com
> Reported-by: syzbot+7008b8b8ba7df475fdc8@syzkaller.appspotmail.com
> Fixes: 93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

With this patch applied, my reproducer from [1] no longer triggers the
issue. I polled /proc/meminfo, and don't see any leak. FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks for fixing this!

Mark.

[1] https://lore.kernel.org/lkml/20190605135401.GB30925@lakrids.cambridge.arm.com/

> ---
>  fs/namespace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b26778bdc236e..5dc137a22d406 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3445,6 +3445,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	ns->root = mnt;
>  	ns->mounts = 1;
>  	list_add(&mnt->mnt_list, &ns->list);
> +	mntget(newmount.mnt);
>  
>  	/* Attach to an apparent O_PATH fd with a note that we need to unmount
>  	 * it, not just simply put it.
> -- 
> 2.22.0.rc2.383.gf4fbbf30c2-goog
> 
