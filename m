Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48E7320BD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhBUQxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 11:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBUQxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 11:53:23 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C51C061574;
        Sun, 21 Feb 2021 08:52:42 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDryD-00Gicm-Qx; Sun, 21 Feb 2021 16:52:33 +0000
Date:   Sun, 21 Feb 2021 16:52:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luo Longjun <luolongjun@huawei.com>
Cc:     jlayton@kernel.org, bfields@fieldses.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luchunhua@huawei.com
Subject: Re: [PATCH] fs/locks: print full locks information
Message-ID: <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
References: <20210220063250.742164-1-luolongjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220063250.742164-1-luolongjun@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:50AM -0500, Luo Longjun wrote:
>  
> @@ -2844,7 +2845,13 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	if (fl->fl_file != NULL)
>  		inode = locks_inode(fl->fl_file);
>  
> -	seq_printf(f, "%lld:%s ", id, pfx);
> +	seq_printf(f, "%lld: ", id);
> +	for (i = 1; i < repeat; i++)
> +		seq_puts(f, " ");
> +
> +	if (repeat)
> +		seq_printf(f, "%s", pfx);

RTFCStandard(printf, %*s), please

> +static int __locks_show(struct seq_file *f, struct file_lock *fl, int level)
> +{
> +	struct locks_iterator *iter = f->private;
> +	struct file_lock *bfl;
> +
> +	lock_get_status(f, fl, iter->li_pos, "-> ", level);
> +
> +	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
> +		__locks_show(f, bfl, level + 1);

Er...  What's the maximal depth, again?  Kernel stack is very much finite...
