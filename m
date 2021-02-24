Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEFF324086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhBXPKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 10:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbhBXOvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:51:02 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883CC061A30;
        Wed, 24 Feb 2021 06:44:15 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CC94D2824; Wed, 24 Feb 2021 09:44:14 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CC94D2824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614177854;
        bh=TwbArCQN28JUuA1hpdKxArXzNxTGN/pJ1jRvpci9NgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXI5lEYrKSCfUdw2YkieOLB+EvzfAJLrqElSLaXxmz/VmkWb7skK9YdQ/8EWLMYWC
         clZ9lVjEfeuj9ArPF8rltwvKzKvKVndAaq+uJ8yS0gA05cUUI3DltxqGmCvqjL0uCi
         X12rnQgjpK5vvZFWqHRyC2nNyLOhGmkNsANApJfY=
Date:   Wed, 24 Feb 2021 09:44:14 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Luo Longjun <luolongjun@huawei.com>
Cc:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luchunhua@huawei.com
Subject: Re: [PATCH v2 02/24] fs/locks: print full locks information
Message-ID: <20210224144414.GA11591@fieldses.org>
References: <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
 <20210224083544.750887-1-luolongjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224083544.750887-1-luolongjun@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:35:44AM -0500, Luo Longjun wrote:
> @@ -2912,17 +2922,66 @@ static int locks_show(struct seq_file *f, void *v)
>  	struct file_lock *fl, *bfl;
>  	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
>  
> +	struct list_head root;
> +	struct list_head *tail = &root;
> +	struct list_head *pos, *tmp;
> +	struct locks_traverse_list *node, *node_child;
> +
> +	int ret = 0;
> +
>  	fl = hlist_entry(v, struct file_lock, fl_link);
>  
>  	if (locks_translate_pid(fl, proc_pidns) == 0)
> -		return 0;
> +		return ret;
> +
> +	INIT_LIST_HEAD(&root);
>  
> -	lock_get_status(f, fl, iter->li_pos, "");
> +	node = kmalloc(sizeof(struct locks_traverse_list), GFP_KERNEL);

Is it safe to allocate here?  I thought this was under the
blocked_lock_lock spinlock.

And I still don't think you need a stack.  Have you tried the suggestion
in my previous mail?

--b.
