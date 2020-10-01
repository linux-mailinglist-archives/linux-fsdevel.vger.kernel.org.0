Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1ED27F778
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgJABf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 21:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgJABf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:35:56 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E28C061755;
        Wed, 30 Sep 2020 18:35:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNnVg-009YgU-NI; Thu, 01 Oct 2020 01:35:52 +0000
Date:   Thu, 1 Oct 2020 02:35:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe: Fix memory leaks in create_pipe_files()
Message-ID: <20201001013552.GD3421308@ZenIV.linux.org.uk>
References: <20201001005804.25641-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001005804.25641-1-cai@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 08:58:04PM -0400, Qian Cai wrote:

> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Signed-off-by: Qian Cai <cai@redhat.com>
> ---
>  fs/pipe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 60dbee457143..5184972cd9c0 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -920,10 +920,13 @@ int create_pipe_files(struct file **res, int flags)
>  	if (flags & O_NOTIFICATION_PIPE) {
>  #ifdef CONFIG_WATCH_QUEUE
>  		if (watch_queue_init(inode->i_pipe) < 0) {
> +			free_pipe_info(inode->i_pipe);
>  			iput(inode);
>  			return -ENOMEM;
>  		}
>  #else
> +		free_pipe_info(inode->i_pipe);
> +		iput(inode);
>  		return -ENOPKG;
>  #endif
>  	}

yeccchhhh...  This is too ugly to live.

1) get rid of that sodding ifdef; define watch_queue_init() to fail if
CONFIG_WATCH_QUEUE is not defined.

2) do not ignore the return value.
