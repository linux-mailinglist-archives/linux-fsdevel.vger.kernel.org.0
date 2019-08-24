Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB77F9C0E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2019 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfHXXEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 19:04:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfHXXEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 19:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0JZjTw04Ig3AWY1GYI4xrMBN1fsFmUcT51MVCQtaRzg=; b=PrXaXUrKsi6/uR18KfcbOXun8
        WL93jdmbGYWDmNsqy3FoknFrhZFrt7roT3fZFksEXtMQoGxwVy/dQ14pG5xiNvEPrNKAz0VsnxraZ
        UFkN1pSi6UKZmt4/MPUke3PAf4f63wWz7ycMcmroThEdT6BEucczOobMpfA3X2do1cXoQZa7bU266
        23E7hg5aqqMGpXpY4BNesBZ1efeNMjAidZYS5BOWRdjFTKWrfpsFXKKLyHMfb4vj/h+zRIgVQF++k
        EwpWOFTn83UQTmAv3bZkGUr53TkEYTBOkl6l2P8z5p/BPv8ahq+SEGOCalI45EXq1gcmXucl3z6/5
        cyISZFIwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i1f59-0001QH-Vb; Sat, 24 Aug 2019 23:04:27 +0000
Date:   Sat, 24 Aug 2019 16:04:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190824230427.GA32012@infradead.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
 <20190822120015.GA3330@poseidon.bobrowski.net>
 <20190822141126.70A94A407B@d06av23.portsmouth.uk.ibm.com>
 <20190824031830.GB2174@poseidon.bobrowski.net>
 <20190824035554.GA1037502@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824035554.GA1037502@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 08:55:54PM -0700, Darrick J. Wong wrote:
> I'm probably misunderstanding the ext4 extent cache horribly, but I keep
> wondering why any of this is necessary -- why can't ext4 track the
> unwritten status in the extent records directly?  And why is there all
> this strange "can merge" logic?  If you need to convert blocks X to Y
> to written state because a write to those blocks completed, isn't that
> just manipulation of a bunch of incore records?  And can't you just seek
> back and forth in the extent cache to look for adjacent records to merge
> with? <confuseD>

Same here.  I'm not an ext4 expert, but here is what we do in XFS, which
hopefully works in some form for ext4 a well:

 - when starting a direct I/O we allocate any needed blocks and do so
   as unwritten extent.  The extent tree code will merge them in
   whatever way that seems suitable
 - if the IOMAP_DIO_UNWRITTEN is set on the iomap at ->end_io time we
   call a function that walks the whole range covered by the ioend,
   and convert any unwritten extent to a normal written extent.  Any
   splitting and merging will be done as needed by the low-level
   extent tree code
 - this also means we don't need the xfs_ioen structure (which ext4)
   copied from for direct I/O at all (we used to have it initially,
   though including the time when ext4 copied this code).
 - we don't need the equivalent to the ext4_unwritten_wait call in
   ext4_file_write_iter because we serialize any non-aligned I/O
   instead of trying to optimize for weird corner cases


> (I'd really prefer not to go adding private fields all over the
> place...)

Agreed.
