Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407DB16608B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgBTPKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:10:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgBTPKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G2o7/2wQz4I2bSTa23Jz+2T7ehA7+Qh/DABLcJ7++Gg=; b=rNJKV58kH2Hi3xhQxkLMMzx8lV
        RipoN223ZmXSatYqltHsRF6idpZbBmyf0GL9X+CH+Ks6Wc6k43+EjLitqhF4xF2b133YQH9ZG5EHi
        9S2PEh7TBE1weivsELdxeyxuCZbNPOZ2MqqDqE2ZOhY+EIiIxbWx+hcdKp9lxQ0cgIgNcZkczih6K
        9FdryOmrnuCo9AOOf+joSEfiifv0Cop4iRUq+zKJAofsbwZLBBoyX6i8M/2kx+6/2vGI/vLfIxQw1
        2Ucmc3/Mow9vozyw390izexHNWNfoWyIucqRv+4NiQ+0nLq6AIcDZr0SBA/Y13JQUbUW+KN6Xz/8C
        FKW5FgEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4nTU-00007F-C8; Thu, 20 Feb 2020 15:10:48 +0000
Date:   Thu, 20 Feb 2020 07:10:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 10/24] mm: Add readahead address space operation
Message-ID: <20200220151048.GW24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-11-willy@infradead.org>
 <5D7CE6BD-FABD-4901-AEF0-E0F10FC00EB1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D7CE6BD-FABD-4901-AEF0-E0F10FC00EB1@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:00:30AM -0500, Zi Yan wrote:
> > +/* The index of the first page in this readahead block */
> > +static inline unsigned int readahead_index(struct readahead_control *rac)
> > +{
> > +	return rac->_index;
> > +}
> 
> rac->_index is pgoff_t, so readahead_index() should return the same type, right?
> BTW, pgoff_t is unsigned long.

Oh my goodness!  Thank you for spotting that.  Fortunately, it's only
currently used by tracepoints, so it wasn't causing any trouble, but
that's a nasty landmine to leave lying around.  Fixed:

static inline pgoff_t readahead_index(struct readahead_control *rac)

