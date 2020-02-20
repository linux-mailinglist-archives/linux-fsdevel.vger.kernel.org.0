Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF95116617D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgBTPyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:54:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgBTPyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D6I8jW+2llttZsSrEwC7oLd5yfRbnmR5fQ3XY07h6/A=; b=PM/AprBicbU39edYsbWTpTc0Na
        emVcq7cb+NHUM6oooQNEoXkG8+bHD9DPrTjjG2z2x3T5qTsF2asVZBk11hr9EbGPUjnd00E3//wQZ
        Ybl+M5Ncbk5X+eqZuv5FQg2IiH2QMSkNvYYPTlkj7xTRE/LwRRrh6jsluV0sdP9tbDuj8LPcnDHs1
        hcDRVlsCikcg/+gbg3xn8+BGR6mA7HS7wgpHnbqj5ErHAFq/eFM9zwR+c5djfNPqtTIEOm8KczQWy
        Y9fVsWdlNqjO9NJrXN3ek4kvMofOELyh95VqWLxea4QhQIGt2c5AYVzLVexEyX6ylz0YB4RkWIKLh
        T/R9auvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4oA8-00077l-7Q; Thu, 20 Feb 2020 15:54:52 +0000
Date:   Thu, 20 Feb 2020 07:54:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 14/24] btrfs: Convert from readpages to readahead
Message-ID: <20200220155452.GX24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154658.GA19577@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > btrfs: Convert from readpages to readahead
> >   
> > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > to optimise fetching a batch of pages at once.
> 
> Shouldn't this readahead_page_batch heper go into a separate patch so
> that it clearly stands out?

I'll move it into 'Put readahead pages in cache earlier' for v8 (the
same patch where we add readahead_page())
