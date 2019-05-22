Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FB266AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfEVPKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 11:10:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbfEVPJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 11:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FEpLTp6t9Bj8cEZnHYwVHtekMHW40hqnqkWrqhgRy+w=; b=QEF+xA3x6vvUPujuP05sXLntB
        0qvtE9Bn/WTayOl8HqiYAfphd/jJWWP6QKE4USd2xYeKvHr6Le15YeRKNcFL3uJzvIs6WGZn//JRY
        gLKB3mBWGGOX3jaREH1K5eGZuh7PjnWIC5qtY7HQwwHR7yP6YXNdoQWG8jtR5z7vwZvy6gij8LEez
        q3b8aeHNn0hnobvFBvVaDwYJukRnXn21FwfvhSCe3tF+QPqkpYA2DDWZui9PUmGAyf69QU1fVfhyA
        z25C8ODYNMWQaPQndCv19GIigt28GmabipvGE28egqs5SMCZ2CzEQU7vvPKPalvnYkg+2AgQtCvh3
        Me2W2fjlw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTSsQ-00058J-7f; Wed, 22 May 2019 15:09:58 +0000
Date:   Wed, 22 May 2019 08:09:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com
Subject: Re: [PATCH v4 1/1] f2fs: ioctl for removing a range from F2FS
Message-ID: <20190522150958.GC6738@bombadil.infradead.org>
References: <20190522040530.37886-1-sunqiuyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522040530.37886-1-sunqiuyang@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 12:05:30PM +0800, sunqiuyang wrote:
> +static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
> +	__u64 block_count;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +
> +	if (copy_from_user(&block_count, (__u64 __user *)arg, sizeof(__u64)))
> +		return -EFAULT;

You can just call get_user() here.

