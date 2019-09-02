Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927F2A56B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfIBMxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:53:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfIBMxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7/PnToezagXqwbE0JThYjiZtwfyfOHMmdhe3eq0wzJQ=; b=Ts1URB2bALfk7/nZqBL5ACev6
        d6mytq+WkKmBdI1Wv08vqYRnZWfBrvhlqsGyKr5I4haxAzvi1W0/AiztPOWlODIwH8mprivMNHXAc
        /06Rn4wqK72ipJdREnrX+N2KdwFs0alrXDItr685VeLgZ3ZdyJyTHlhsH34pP3K2yCdVqH8DnTs/j
        vj3YiKH5xkSRPnqzeWZNfNKawQNVoLDPMLBBr5QpqV1hzO5AjsTVVWeY8JPW2d9Hgv32yOgh3txYF
        oA9lsn52rb0jx+KDpVn29SBne/zu8ILFVNgmCDcXXK3YpY12eWYPnQfPLQI15eG/7BOC75MyP0cRr
        CqX5qv0Kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lpg-0004bl-IN; Mon, 02 Sep 2019 12:53:20 +0000
Date:   Mon, 2 Sep 2019 05:53:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190902125320.GA16726@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 05:34:00PM +0800, Gao Xiang wrote:
> > > +	return iget5_locked(sb, hashval, erofs_ilookup_test_actor,
> > > +		erofs_iget_set_actor, &nid);
> > > +#endif
> > 
> > Just use the slightly more complicated 32-bit version everywhere so that
> > you have a single actually tested code path.  And then remove this
> > helper.
> 
> As I said before, 64-bit platforms is common currently,
> I think iget_locked is enough.
> https://lore.kernel.org/r/20190830184606.GA175612@architecture4/

The problem with that is that you now have two entirely different
code paths.  And the 32-bit one will probably get very little testing
and eventually bitrot.  We defintively had problems of that sort in
XFS in the past, so my suggestion is to not go down the root of
separate code for 32-bit vs 64-bit unless it makes a real difference
for a real-life workload.
