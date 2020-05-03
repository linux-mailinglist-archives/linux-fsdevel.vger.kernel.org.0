Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A941C2CDB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgECNqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 09:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728077AbgECNqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 09:46:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA7C061A0C;
        Sun,  3 May 2020 06:46:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVEwo-0005Dd-UG; Sun, 03 May 2020 13:46:23 +0000
Date:   Sun, 3 May 2020 14:46:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] eventfd: convert to f_op->read_iter()
Message-ID: <20200503134622.GS23230@ZenIV.linux.org.uk>
References: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
 <20200501231231.GR23230@ZenIV.linux.org.uk>
 <03867cf3-d5e7-cc29-37d2-1a417a58af45@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03867cf3-d5e7-cc29-37d2-1a417a58af45@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 05:54:09PM -0600, Jens Axboe wrote:
> On 5/1/20 5:12 PM, Al Viro wrote:
> > On Fri, May 01, 2020 at 01:11:09PM -0600, Jens Axboe wrote:
> >> +	flags &= EFD_SHARED_FCNTL_FLAGS;
> >> +	flags |= O_RDWR;
> >> +	fd = get_unused_fd_flags(flags);
> >>  	if (fd < 0)
> >> -		eventfd_free_ctx(ctx);
> >> +		goto err;
> >> +
> >> +	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
> >> +	if (IS_ERR(file)) {
> >> +		put_unused_fd(fd);
> >> +		fd = PTR_ERR(file);
> >> +		goto err;
> >> +	}
> >>  
> >> +	file->f_mode |= FMODE_NOWAIT;
> >> +	fd_install(fd, file);
> >> +	return fd;
> >> +err:
> >> +	eventfd_free_ctx(ctx);
> >>  	return fd;
> >>  }
> > 
> > Looks sane...  I can take it via vfs.git, or leave it for you if you
> > have other stuff in the same area...
> 
> Would be great if you can queue it up in vfs.git, thanks! Don't have
> anything else that'd conflict with this.

Applied; BTW, what happens if
        ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
fails?  Quitely succeed with BS value (-ENOSPC/-ENOMEM) shown by
eventfd_show_fdinfo()?
