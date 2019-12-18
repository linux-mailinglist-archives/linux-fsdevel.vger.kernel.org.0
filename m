Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C01251BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 20:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLRTVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 14:21:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfLRTVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WeW+VRLeMZJzYni3rjboMFgKf7w4L/Z6i8nVtxefrWQ=; b=igYrT7pkArJInRCn2HvudFpeQ
        4/Y7nWsP/q4E6FIbmdEk9z42j0nBzQL58sT3RxKWiM+4Mfe8XfTHyujpdq2OPJ1DGDGUnTlH0/j+y
        xaD21T5ZNtH5dEiFNAkmc6OeEvHN4w7ufKmttR9NCHAnejfMePx79c1FgWlzrmBoxP9cDjjixWuiN
        T8sxYZjvema0JpzXyWcftkKu6eS3v6EMqpPg404NTsQvXNOQ++CzO3jeSDIp/4ATRSoec/iviYsAO
        xKhTKKHM3ZvRS0sgTZxJFFDAo3TkYjVP7QIHFU1Ercgsr6Ydnj7/FIIBkei+hXzZWygrYTCvThFkj
        T+/2P2+Rg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihetE-0006ZI-A3; Wed, 18 Dec 2019 19:21:44 +0000
Date:   Wed, 18 Dec 2019 11:21:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] fs: Fix page_mkwrite off-by-one errors
Message-ID: <20191218192144.GF32169@bombadil.infradead.org>
References: <20191218130935.32402-1-agruenba@redhat.com>
 <20191218185216.GA7497@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218185216.GA7497@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:52:16AM -0800, Darrick J. Wong wrote:
> > @@ -9016,13 +9016,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
> >  	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
> >  again:
> >  	lock_page(page);
> > -	size = i_size_read(inode);
> >  
> > -	if ((page->mapping != inode->i_mapping) ||
> > -	    (page_start >= size)) {
> > -		/* page got truncated out from underneath us */
> > +	ret2 = page_mkwrite_check_truncate(page, inode);
> > +	if (ret2 < 0)
> >  		goto out_unlock;
> 
> ...here we try to return -EFAULT as vm_fault_t.  Notice how btrfs returns
> VM_FAULT_* values directly and never calls block_page_mkwrite_return?  I
> know dsterba acked this, but I cannot see how this is correct?

I think you misread it.  'ret2' is never returned; we'll end up returning
VM_FAULT_NOPAGE here.  Arguably it should be SIGBUS or something, but
I think retrying the fault will also end up giving a SIGBUS.
