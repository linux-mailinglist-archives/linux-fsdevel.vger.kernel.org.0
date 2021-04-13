Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB0035E0B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDMN4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 09:56:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDMN4x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:56:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BA89AFC4;
        Tue, 13 Apr 2021 13:56:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 471041E37A2; Tue, 13 Apr 2021 15:56:32 +0200 (CEST)
Date:   Tue, 13 Apr 2021 15:56:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210413135632.GD15752@quack2.suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
 <20210413125746.GB1366579@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413125746.GB1366579@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-04-21 13:57:46, Christoph Hellwig wrote:
> >  	if (error == AOP_TRUNCATED_PAGE)
> >  		put_page(page);
> > +	up_read(&mapping->host->i_mapping_sem);
> >  	return error;
> 
> Please add an unlock_mapping label above this up_read and consolidate
> most of the other unlocks by jumping there (put_and_wait_on_page_locked
> probablt can't use it).

Yeah, I've actually simplified the labels even a bit more like:

...
        error = filemap_read_page(iocb->ki_filp, mapping, page);
        goto unlock_mapping;
unlock:
        unlock_page(page);
unlock_mapping:
        up_read(&mapping->host->i_mapping_sem);
        if (error == AOP_TRUNCATED_PAGE)
                put_page(page);
        return error;

and everything now jumps to either unlock or unlock_mapping (except for
put_and_wait_on_page_locked() case).

> >  truncated:
> >  	unlock_page(page);
> > @@ -2309,6 +2324,7 @@ static int filemap_update_page(struct kiocb *iocb,
> >  	return AOP_TRUNCATED_PAGE;
> 
> The trunated case actually seems to miss the unlock.
> 
> Similarly I think filemap_fault would benefit from a common
> unlock path.

Right, thanks for catching that!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
