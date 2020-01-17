Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42014089C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAQLFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 06:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgAQLFh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:05:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7FF90ADE7;
        Fri, 17 Jan 2020 11:05:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0C1241E0D53; Fri, 17 Jan 2020 12:05:36 +0100 (CET)
Date:   Fri, 17 Jan 2020 12:05:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
Subject: Re: [RFC] iomap: fix race between readahead and direct write
Message-ID: <20200117110536.GE17141@quack2.suse.cz>
References: <20200116063601.39201-1-yukuai3@huawei.com>
 <20200116153206.GF8446@quack2.suse.cz>
 <ce4bc2f3-a23e-f6ba-0ef1-66231cd1057d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4bc2f3-a23e-f6ba-0ef1-66231cd1057d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-01-20 17:39:03, yukuai (C) wrote:
> On 2020/1/16 23:32, Jan Kara wrote:
> > Thanks for the report and the patch. But the data integrity when mixing
> > buffered and direct IO like this is best effort only. We definitely do not
> > want to sacrifice performance of common cases or code complexity to make
> > cases like this work reliably.
> 
> In the patch, the only thing that is diffrent is that iomap_begin() will
> be called for each page. However, it seems the performance in sequential
> read didn't get worse. Is there a specific case that the performance
> will get worse?

Well, one of the big points of iomap infrastructure is that you call
filesystem once to give you large extent instead of calling it to provide
allocation for each page separately. The additional CPU overhead will be
visible if you push the machine hard enough. So IMHO the overhead just is
not worth it for a corner-case like you presented. But that's just my
opinion, Darrick and Christoph are definitive arbiters here...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
