Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A71429BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 12:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgATLmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 06:42:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:56526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgATLmP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:42:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 372D1AD5C;
        Mon, 20 Jan 2020 11:42:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5CD301E0CF1; Mon, 20 Jan 2020 12:42:07 +0100 (CET)
Date:   Mon, 20 Jan 2020 12:42:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200120114207.GE19861@quack2.suse.cz>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200116153206.GF8446@quack2.suse.cz>
 <ce4bc2f3-a23e-f6ba-0ef1-66231cd1057d@huawei.com>
 <20200117110536.GE17141@quack2.suse.cz>
 <976d09e1-e3b5-a6a6-d159-9bdac3a7dc84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <976d09e1-e3b5-a6a6-d159-9bdac3a7dc84@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 19-01-20 09:17:00, yukuai (C) wrote:
> 
> 
> On 2020/1/17 19:05, Jan Kara wrote:
> > provide
> > allocation for each page separately
> 
> Thank you for your response!
> 
> I do understand there will be additional CPU overhead. But page is allocated
> in __do_page_cache_readahead(), which is called before
> iomap_begin(). And I did not change that.

Sorry, I didn't express myself clearly. In "...one of the big points of iomap
infrastructure is that you call filesystem once to give you large extent
instead of calling it to provide allocation for each page separately." I
meant that with your patch, you call into filesystem to provide "block
allocation information" for each page separately. And it seems we both
agree this is going to cause additional CPU usage in the common case to
improve mostly unsupported corner case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
