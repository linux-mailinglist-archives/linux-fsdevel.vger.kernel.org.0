Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60A71C2123
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 01:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgEAXMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 19:12:34 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B122DC061A0C;
        Fri,  1 May 2020 16:12:34 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUepb-00GJ0U-Jn; Fri, 01 May 2020 23:12:31 +0000
Date:   Sat, 2 May 2020 00:12:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] eventfd: convert to f_op->read_iter()
Message-ID: <20200501231231.GR23230@ZenIV.linux.org.uk>
References: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 01:11:09PM -0600, Jens Axboe wrote:
> +	flags &= EFD_SHARED_FCNTL_FLAGS;
> +	flags |= O_RDWR;
> +	fd = get_unused_fd_flags(flags);
>  	if (fd < 0)
> -		eventfd_free_ctx(ctx);
> +		goto err;
> +
> +	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
> +	if (IS_ERR(file)) {
> +		put_unused_fd(fd);
> +		fd = PTR_ERR(file);
> +		goto err;
> +	}
>  
> +	file->f_mode |= FMODE_NOWAIT;
> +	fd_install(fd, file);
> +	return fd;
> +err:
> +	eventfd_free_ctx(ctx);
>  	return fd;
>  }

Looks sane...  I can take it via vfs.git, or leave it for you if you
have other stuff in the same area...
