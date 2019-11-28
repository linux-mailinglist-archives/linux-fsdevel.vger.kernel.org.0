Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4724E10CBFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK1PpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:45:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1PpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Ua9kzhqWdT/XmuB+JkZPQ/zR7CbGzhbDxmS9/PUHRg=; b=lYn5QAbbuOgCVzO0wK72zGcGg
        mQTVtUtKdl4KYiJHp4I5I3FXK/6FWZhfra4tUuTFV7QC78oDUm8NKzHIrgasl+8sbPlrCdG0T67u3
        kgAQ57kaMp3R3h1Z+mwXZn4SMTDknO5FcjPcWJhT6kEGYu4yyJ+8h7G98UfdWJKrqUQljjAF2xpQv
        RhfjlbJLk4dNosXzbNYjYOLiCEP2PZWfBnLjpu5EMP/cgJOBC3HTYk0zTcErIw08z7ffMbdnD/r09
        tSSlveUJqScNNE8ME81M1Rd4A954YOsGafxeRRIk7ktZ64V53SmN+UKMgMG5kfHDds764Ihn7lkwx
        SsNl980Fw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaLym-0005vg-OI; Thu, 28 Nov 2019 15:45:16 +0000
Date:   Thu, 28 Nov 2019 07:45:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] fs: Fix page_mkwrite off-by-one errors
Message-ID: <20191128154516.GA17166@infradead.org>
References: <20191127151811.9229-1-agruenba@redhat.com>
 <20191127154954.GT6219@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127154954.GT6219@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:49:54AM -0800, Darrick J. Wong wrote:
> On Wed, Nov 27, 2019 at 04:18:11PM +0100, Andreas Gruenbacher wrote:
> > Fix a check in block_page_mkwrite meant to determine whether an offset
> > is within the inode size.  This error has spread to several filesystems
> > and to iomap_page_mkwrite, so fix those instances as well.
> 
> Seeing how this has gotten screwed up at least six times in the kernel,
> maybe we need a static inline helper to do this for us?

Yes.  I think we really want a little helper that checks the mapping
and the offset.  That also gives us the opportunity to document the
semantics.

> 
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> 
> The iomap part looks ok,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> (I might just extract the iomap part and put it in the iomap tree if
> someone doesn't merge this one before I get to it...)

I think we should just pull in the helper and conversions through
some tree after all iomap bits are merged.  It might as well be
the iomap tree as that seems to the place for file system read/write
infrastructure these days.
