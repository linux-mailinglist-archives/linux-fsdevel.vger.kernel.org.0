Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBF29C75B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828360AbgJ0Sam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:30:42 -0400
Received: from casper.infradead.org ([90.155.50.34]:52600 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828355AbgJ0Sal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k8YtwpCK7R8pKcTld7F9D1V8h2ZjYCprcpu/NK57ECs=; b=cBFanisPufg0Spq8y+zneyPmtT
        ieTeefLjEP+KHtvqs4l0CJhxPBBxrya3ffRROg0prDYtdiCfL7DwpNPFMG2n+G+79Wfsu42T22FCm
        6CgoyMmvSeO7gb3HERNwTg0l8ZK5T1LFLyQrBdtwQj2qgKUo638gZFYAQJtAgvQcwxSrnGM1zo9Vm
        aLt8yAAvemubRHmJNbxXlFPnWiyQW+R0DEFgy9peCKxc6GPYNbNOmwAQBu90F7ck9T91eELvLOSYh
        OKKAZUCt2aSnvWlo0kYB8TePFQiyxjKpxrlE49Q0swYQ/a6QyfztGCQAP8JPvow4EjT6So9r9oj/K
        rA4LzfHw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXTjz-0002RI-Fy; Tue, 27 Oct 2020 18:30:39 +0000
Date:   Tue, 27 Oct 2020 18:30:39 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 1/6] block: Add blk_completion
Message-ID: <20201027183039.GA7983@infradead.org>
References: <20201022212228.15703-1-willy@infradead.org>
 <20201022212228.15703-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022212228.15703-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:22:23PM +0100, Matthew Wilcox (Oracle) wrote:
> This new data structure allows a task to wait for N things to complete.
> Usually the submitting task will handle cleanup, but if it is killed,
> the last completer will take care of it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/blk-core.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h | 11 ++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 10c08ac50697..2892246f2176 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1900,6 +1900,67 @@ void blk_io_schedule(void)
>  }
>  EXPORT_SYMBOL_GPL(blk_io_schedule);
>  
> +void blk_completion_init(struct blk_completion *cmpl, int n)
> +{
> +	spin_lock_init(&cmpl->cmpl_lock);
> +	cmpl->cmpl_count = n;
> +	cmpl->cmpl_task = current;
> +	cmpl->cmpl_status = BLK_STS_OK;
> +}
> +
> +int blk_completion_sub(struct blk_completion *cmpl, blk_status_t status, int n)

This needs documentation.  e.g. to explain what 'n' is.

> +int blk_completion_wait_killable(struct blk_completion *cmpl)
> +{
> +	int err = 0;
> +
> +	for (;;) {
> +		set_current_state(TASK_KILLABLE);
> +		spin_lock_bh(&cmpl->cmpl_lock);
> +		if (cmpl->cmpl_count == 0)
> +			break;
> +		spin_unlock_bh(&cmpl->cmpl_lock);
> +		blk_io_schedule();
> +		if (fatal_signal_pending(current)) {
> +			spin_lock_bh(&cmpl->cmpl_lock);
> +			cmpl->cmpl_task = NULL;
> +			if (cmpl->cmpl_count != 0) {
> +				spin_unlock_bh(&cmpl->cmpl_lock);
> +				cmpl = NULL;
> +			}
> +			err = -ERESTARTSYS;
> +			break;
> +		}
> +	}
> +	set_current_state(TASK_RUNNING);
> +	if (cmpl) {
> +		spin_unlock_bh(&cmpl->cmpl_lock);
> +		err = blk_status_to_errno(cmpl->cmpl_status);
> +		kfree(cmpl);
> +	}
> +
> +	return err;
> +}

What are the life time rules for cmpl?  Who frees it in the case
of a fatal signal?
