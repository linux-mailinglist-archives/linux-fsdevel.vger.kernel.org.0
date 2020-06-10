Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B75A1F5757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFJPLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFJPLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:11:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6EC03E96B
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ELO3K9p2oP+b39SvsEYA6AwIoWy9pXqL5MAXsEaLVM=; b=kJOzVqJaf7B1DB1u4Z8nqq5aox
        YbL8yBk4IS86y7849uFkhOcnsczFZJfji0A5vSSSKHvDVp3ribRbLUU5nmRAWCq5UJoghWbevofot
        R+blHnpeGRCK7kJ1EIMDTSDwXlHgSYALRUEdIk0ZXOU6MVwMjsgVE7R/cQ81VfQ2+MNu3o4qPFHeA
        B2UtQS7F6ArdWDp/HNQr8eCkNPb7n5oStk5SoxBtow/Y8h1xovfw1FCGcX+0REzW75pQJ4tUdRYch
        fInPbaBXNWtKKgDN7Hl4B1Eqo+VysImTBJyB2NFtlXN6WwTUKuOZaACU/fQ3kjbHvWeF1R4FPgdHJ
        iagPLUcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj2OD-0000x4-2M; Wed, 10 Jun 2020 15:11:41 +0000
Date:   Wed, 10 Jun 2020 08:11:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Martijn Coenen <maco@android.com>, tj@kernel.org
Subject: Re: [PATCH 3/3] writeback: Drop I_DIRTY_TIME_EXPIRE
Message-ID: <20200610151141.GC21733@infradead.org>
References: <20200601091202.31302-1-jack@suse.cz>
 <20200601091904.4786-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601091904.4786-3-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:18:57AM +0200, Jan Kara wrote:
> The only use of I_DIRTY_TIME_EXPIRE is to detect in
> __writeback_single_inode() that inode got there because flush worker
> decided it's time to writeback the dirty inode time stamps (either
> because we are syncing or because of age). However we can detect this
> directly in __writeback_single_inode() and there's no need for the
> strange propagation with I_DIRTY_TIME_EXPIRE flag.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

One nit below:

>  	if (inode->i_state & I_DIRTY_TIME) {
>  		if ((dirty & I_DIRTY_INODE) ||
> -		    wbc->sync_mode == WB_SYNC_ALL ||
> -		    unlikely(inode->i_state & I_DIRTY_TIME_EXPIRED) ||
> +		    wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
>  		    unlikely(time_after(jiffies,
>  					(inode->dirtied_time_when +
>  					 dirtytime_expire_interval * HZ)))) {
> -			dirty |= I_DIRTY_TIME | I_DIRTY_TIME_EXPIRED;
> +			dirty |= I_DIRTY_TIME;
>  			trace_writeback_lazytime(inode);
>  		}
> -	} else
> -		inode->i_state &= ~I_DIRTY_TIME_EXPIRED;
> +	}

We can also drop some indentation here.  And remove the totally silly
unlikely, something like:

	if ((inode->i_state & I_DIRTY_TIME) &&
	    ((dirty & I_DIRTY_INODE) ||
	     wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
	     time_after(jiffies, inode->dirtied_time_when +
			dirtytime_expire_interval * HZ)))) {
		dirty |= I_DIRTY_TIME;
		trace_writeback_lazytime(inode);
	}
