Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB302990C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783427AbgJZPOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 11:14:07 -0400
Received: from casper.infradead.org ([90.155.50.34]:43400 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782628AbgJZPOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iICEMVCklXyInNXAOHIV8DlgInKlT7ePi5vRkZnW1+A=; b=uC0zXt6dBptf6uJ7TBJmI0X0h/
        yAIBE/ztgC4wYgMXQz+Bhxh4zTY6P+R84pt6Ojb1YjT/DlXW8S93oEMID6ZEvQQhi1rE6qxpD+mDd
        /lmdyrzxqrkWJkuswIkd2QlGbSrAk0j3dvvuZSmT9y4OtbjL2Zr4JMgG6E3BTgx9nnzTo22QwoOQO
        vUVo93czMxfvyo7AvW7UyXiSLeVBg/I+VwbA7zOlAOlzmXsA3MFAKSL6820cCGcrR2an/4FbMBP3z
        kUk40EsJnvD06jwjBc+XUaLNb84tLM92aW6qCBpV9xW6/1G5wNwNAZxFMKq91Uy4sPzWgTdKjwohB
        Yxy6zbSA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4CC-0005y5-Ol; Mon, 26 Oct 2020 15:14:05 +0000
Date:   Mon, 26 Oct 2020 15:14:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Strange SEEK_HOLE / SEEK_DATA behavior
Message-ID: <20201026151404.GR20115@casper.infradead.org>
References: <20201026145710.GF28769@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145710.GF28769@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:57:10PM +0100, Jan Kara wrote:
> Hello!
> 
> When reviewing Matthew's THP patches I've noticed one odd behavior which
> got copied from current iomap seek hole/data helpers. Currently we have:
> 
> # fallocate -l 4096 testfile
> # xfs_io -x -c "seek -h 0" testfile
> Whence	Result
> HOLE	0
> # dd if=testfile bs=4096 count=1 of=/dev/null
> # xfs_io -x -c "seek -h 0" testfile
> Whence	Result
> HOLE	4096
> 
> So once we read from an unwritten extent, the areas with cached pages
> suddently become treated as data. Later when pages get evicted, they become
> treated as holes again. Strictly speaking I wouldn't say this is a bug
> since nobody promises we won't treat holes as data but it looks weird.
> Shouldn't we treat clean pages over unwritten extents still as holes and
> only once the page becomes dirty treat is as data? What do other people
> think?

I think we actually discussed this recently.  Unless I misunderstood
one or both messages:

https://lore.kernel.org/linux-fsdevel/20201014223743.GD7391@dread.disaster.area/

I agree it's not great, but I'm not sure it's worth getting it "right"
by tracking whether a page contains only zeroes.

I have been vaguely thinking about optimising for read-mostly workloads
on sparse files by storing a magic entry that means "use the zero
page" in the page cache instead of a page, like DAX does (only better).
It hasn't risen to the top of my list yet.  Does anyone have a workload
that would benefit from it?

(I don't mean "can anybody construct one"; that's trivially possible.
I mean, do any customers care about the performance of that workload?)
