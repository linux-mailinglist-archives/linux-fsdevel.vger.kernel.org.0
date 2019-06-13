Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6C43B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfFMP2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:28:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfFMP17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vn04L/39CxGmnFvWZbLFG3AukuBPlzgMR3HJ4g3XYMs=; b=tHlQpyqzo7ZQBVB5wRrQJI46t
        aGvrn7sclf7JSvki0K76DhAQ9grt++rr3RsyMukb0ZOE6ao5QkZuVltTGW0kSmf01kovvUtAmSiMC
        FRCnkWcmo+pTrNeUZtpZy52SEQbCrGAv6HRyCq081N6v+J6AluX52Ap/rjGwfAbZNww9f9q25CrJ4
        2/28x8clrMHc5fH8S/5jQZoozJIYzfzvecMqlkikJzXv1MdjRaDtLgMF0+C/+TZhLxUqIdCboLufF
        QARq/0WKMHCQBh07+I4aQgQBCb/hzuiZZD053C7PNwE5NpsajGwqxDMtci1Q9lcRzIGXjOlZwRRQS
        8bRUD+XPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbRdr-0002TD-Ht; Thu, 13 Jun 2019 15:27:55 +0000
Date:   Thu, 13 Jun 2019 08:27:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613152755.GI32656@bombadil.infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613002555.GH14363@dread.disaster.area>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> e.g. Process A has an exclusive layout lease on file F. It does an
> IO to file F. The filesystem IO path checks that Process A owns the
> lease on the file and so skips straight through layout breaking
> because it owns the lease and is allowed to modify the layout. It
> then takes the inode metadata locks to allocate new space and write
> new data.
> 
> Process B now tries to write to file F. The FS checks whether
> Process B owns a layout lease on file F. It doesn't, so then it
> tries to break the layout lease so the IO can proceed. The layout
> breaking code sees that process A has an exclusive layout lease
> granted, and so returns -ETXTBSY to process B - it is not allowed to
> break the lease and so the IO fails with -ETXTBSY.

This description doesn't match the behaviour that RDMA wants either.
Even if Process A has a lease on the file, an IO from Process A which
results in blocks being freed from the file is going to result in the
RDMA device being able to write to blocks which are now freed (and
potentially reallocated to another file).
