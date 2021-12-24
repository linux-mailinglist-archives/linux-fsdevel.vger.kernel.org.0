Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC5547EBFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351492AbhLXGO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbhLXGOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:14:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8919C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 22:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WUkLTn/WpLXgwb+kcxpzWPSSTcTX45kVNzTV9/wI4Ao=; b=LSupGGxGeGDAKTQkM7bYQdWNvl
        YNShVJrf+3j7/jShaDkJRCKPrA194/KVrenqyuPHscwBnr+CW8Xu9PzTggVNYfA5+rlX7UUdyecZW
        0B3IjBqInlkXhaGTgyzlPs2GBFCRdMgYIeGb0tUDH23DRIi2yYZRQSI61NdzijzkPImrz20gPlnue
        YZsHzqg3HLmKFg1oZnizwc4XabL11kKgjdBSu+uLk3rOBQ5nVMXww99sUgJpJOnt6YIVuAqTcT/D3
        oZKCfP0djMxqy0sMcmPunrsO4hmq8OW4eLqlLN+ljndne73aiwCSjqemGdJCkCe//dIKgX4Inx2Cj
        PvXlF9Lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dqP-00Dmjx-40; Fri, 24 Dec 2021 06:14:21 +0000
Date:   Thu, 23 Dec 2021 22:14:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/48] iov_iter: Convert iter_xarray to use folios
Message-ID: <YcVlPdbN69zYCEg0@infradead.org>
References: <YcQd2Fw7atXoU3Dn@infradead.org>
 <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-8-willy@infradead.org>
 <800800.1640273061@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800800.1640273061@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021 at 03:24:21PM +0000, David Howells wrote:
> > > +		while (offset < folio_size(folio)) {		\
> > 
> > Nit: I'd be tempted to use a for loop on offset here.
> 
> A while-loop makes more sense here.  The adjustment you need for offset
> (ie. len) is overwritten after offset is altered at the end of the loop:
> 
> > +			offset += len;				\
> > +			len = PAGE_SIZE;			\
> >  		}						\
> 
> So you'd have to move both of these into the for-incrementor expression, in
> addition to moving in the initialiser expression, making the thing less
> readable.

Ok.
