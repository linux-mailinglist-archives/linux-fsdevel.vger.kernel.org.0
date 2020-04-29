Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD571BDA91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD2L1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2L1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:27:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D8C03C1AD;
        Wed, 29 Apr 2020 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oMyZzcwYB9QX35xXWfMxn1LcoCBA2vSTd5XHHBAVDLs=; b=kg+m6tJ4HaLGqGi7L7gstSvKMs
        YDgkaZ/cGPu6ODEqaVw232Je5GEWjRRYEjHK9uOFWaUO4atRWg2BXWiI1LPIHTLBDFplziRU5H4ox
        iqBXcF7fqWs/xGGbdZMrsFfQNXONb0PeNewAdFs8D8C7gGh8Qd93dcCHhCOj9xSG9KhFSX9vBGFd7
        2E0DlHpiVavu8Rp/hnJ+XjDqt7X64gadEpHZlb6llzDdzmw+boxgIp0pztPc8PbaNz1L9uC+SFjin
        DBqBBaU1br6h3UiT90ARqme+gdqd+rGPrBLkH0pIRMpRSLouPI9xpjg+OoOopTse/EsY+/3NFwI+E
        Mi8PEgcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTkrN-0008GQ-VZ; Wed, 29 Apr 2020 11:26:37 +0000
Date:   Wed, 29 Apr 2020 04:26:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429112637.GD21892@infradead.org>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I can't say I'm a fan of all these long backtraces in commit logs..

> +static struct dentry *blk_debugfs_dir_register(const char *name)
> +{
> +	return debugfs_create_dir(name, blk_debugfs_root);
> +}

I don't think we really need this helper.

> +void blk_part_debugfs_unregister(struct hd_struct *p)
> +{
> +	debugfs_remove_recursive(p->debugfs_dir);
> +	p->debugfs_dir = NULL;
> +}

Why do we need to clear the pointer here?

> +#ifdef CONFIG_DEBUG_FS
> +	/* Currently only used by kernel/trace/blktrace.c */
> +	struct dentry *debugfs_dir;
> +#endif

Does that comment really add value?

> +static struct dentry *blk_trace_debugfs_dir(struct block_device *bdev,
> +					    struct request_queue *q)
>  {
> +	struct hd_struct *p = NULL;
>  
> +	 * Some drivers like scsi-generic use a NULL block device. For
> +	 * other drivers when bdev != bdev->bd_contain we are doing a blktrace
> +	 * on a parition, otherwise we know we are working on the whole
> +	 * disk, and for that the request_queue already has its own debugfs_dir.
> +	 * which we have been using for other things other than blktrace.
> +	 */
> +	if (bdev && bdev != bdev->bd_contains)
> +		p = bdev->bd_part;
>  
> +	if (p)
> +		return p->debugfs_dir;
> +
> +	return q->debugfs_dir;

This could be simplified down to:

	if (bdev && bdev != bdev->bd_contains)
		return bdev->bd_part->debugfs_dir;
	return q->debugfs_dir;

Given that bd_part is in __blkdev_get very near bd_contains.

Also given that this patch completely rewrites blk_trace_debugfs_dir is
there any point in the previous patch?

> @@ -491,6 +500,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	struct dentry *dir = NULL;
>  	int ret;
>  
> +
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  

Spurious whitespace change.
