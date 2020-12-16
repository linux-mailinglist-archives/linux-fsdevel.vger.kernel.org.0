Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B92DB93F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLPCht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 21:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLPCht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:37:49 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E8C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 18:37:08 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpMgd-001Z2q-5Z; Wed, 16 Dec 2020 02:37:07 +0000
Date:   Wed, 16 Dec 2020 02:37:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 3/4] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
Message-ID: <20201216023707.GI3579531@ZenIV.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191323.173773-4-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:13:23PM -0700, Jens Axboe wrote:
> Now that we support non-blocking path resolution internally, expose it
> via openat2() in the struct open_how ->resolve flags. This allows
> applications using openat2() to limit path resolution to the extent that
> it is already cached.
> 
> If the lookup cannot be satisfied in a non-blocking manner, openat2(2)
> will return -1/-EAGAIN.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/open.c                    | 6 ++++++
>  include/linux/fcntl.h        | 2 +-
>  include/uapi/linux/openat2.h | 4 ++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 9af548fb841b..a83434cfe01c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1087,6 +1087,12 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  		lookup_flags |= LOOKUP_BENEATH;
>  	if (how->resolve & RESOLVE_IN_ROOT)
>  		lookup_flags |= LOOKUP_IN_ROOT;
> +	if (how->resolve & RESOLVE_NONBLOCK) {
> +		/* Don't bother even trying for create/truncate open */
> +		if (flags & (O_TRUNC | O_CREAT))
> +			return -EAGAIN;

Why not O_TMPFILE here as well?
