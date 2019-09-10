Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F43AF2BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfIJV4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 17:56:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53002 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIJV4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 17:56:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i7o7w-000614-Ox; Tue, 10 Sep 2019 21:56:44 +0000
Date:   Tue, 10 Sep 2019 22:56:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, renxudong1@huawei.com
Subject: Re: [PATCH] fs: need to ensure that dentry is initialized before it
 is added to parent dentry
Message-ID: <20190910215644.GI1131@ZenIV.linux.org.uk>
References: <1568135137-106264-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568135137-106264-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 01:05:37AM +0800, zhengbin wrote:
> diff --git a/fs/dcache.c b/fs/dcache.c
> index e88cf05..0a07671 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1767,6 +1767,16 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
>  	struct dentry *dentry = __d_alloc(parent->d_sb, name);
>  	if (!dentry)
>  		return NULL;
> +
> +	/*
> +	 * need to ensure that dentry->d_child.next is initialized
> +	 * (__d_alloc->INIT_LIST_HEAD) before dentry is added to
> +	 * parent->d_subdirs, Otherwise in next_positive(do not have
> +	 * spin_lock), we may visit uninitialized value because of cpu
> +	 * run optimization(first add dentry to parent->d_subdirs).
> +	 */
> +	smp_wmb();
> +
>  	spin_lock(&parent->d_lock);
>  	/*
>  	 * don't need child lock because it is not subject
> --
> 2.7.4

Unfortunately, that's not all - see the reply upthread ;-/
