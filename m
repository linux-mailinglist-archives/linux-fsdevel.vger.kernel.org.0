Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA62DB955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 03:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLPCn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 21:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLPCn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:43:58 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89910C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 18:43:18 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpMmZ-001Z6l-J6; Wed, 16 Dec 2020 02:43:15 +0000
Date:   Wed, 16 Dec 2020 02:43:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201216024315.GJ3579531@ZenIV.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191323.173773-3-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
> @@ -3140,6 +3149,12 @@ static const char *open_last_lookups(struct nameidata *nd,
>  			return ERR_CAST(dentry);
>  		if (likely(dentry))
>  			goto finish_lookup;
> +		/*
> +		 * We can't guarantee nonblocking semantics beyond this, if
> +		 * the fast lookup fails.
> +		 */
> +		if (nd->flags & LOOKUP_NONBLOCK)
> +			return ERR_PTR(-EAGAIN);
>  
>  		BUG_ON(nd->flags & LOOKUP_RCU);

That can't be right - we already must have removed LOOKUP_RCU here
(see BUG_ON() right after that point).  What is that test supposed
to catch?

What am I missing here?
