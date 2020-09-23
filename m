Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060DE274E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 03:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIWBGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 21:06:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60479 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgIWBGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600823169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWJcac1QdW9dsyQKtkyOkOZ4w1weaZOAZAMFMC95DE4=;
        b=N2TvOk446rHLJcklwl+HxcmkPl84sAUEw0RBFgbjSndHWYIfVMUFfu8L6KUVSjKlYsb7cx
        61zJ8gml0Biw9yRq/4ebsXWSGw8FQ1k/JA4vtpzsc4XjfBzXN64+tPstfTdY5douKr32r0
        f06m9d18SuX3Yc5OLCzjrEEJeMwQW7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-VnKzYDtLOJ6489vL7AfGag-1; Tue, 22 Sep 2020 21:06:07 -0400
X-MC-Unique: VnKzYDtLOJ6489vL7AfGag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4509881CBF1;
        Wed, 23 Sep 2020 01:06:05 +0000 (UTC)
Received: from ovpn-66-35.rdu2.redhat.com (unknown [10.10.67.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2FD17368D;
        Wed, 23 Sep 2020 01:06:03 +0000 (UTC)
Message-ID: <95bd1230f2fcf01f690770eb77696862b8fb607b.camel@redhat.com>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
From:   Qian Cai <cai@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Dave Chinner <dchinner@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Date:   Tue, 22 Sep 2020 21:06:03 -0400
In-Reply-To: <20200922170526.GK32101@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
         <20200910234707.5504-6-willy@infradead.org>
         <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
         <20200922170526.GK32101@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-22 at 18:05 +0100, Matthew Wilcox wrote:
> On Tue, Sep 22, 2020 at 12:23:45PM -0400, Qian Cai wrote:
> > On Fri, 2020-09-11 at 00:47 +0100, Matthew Wilcox (Oracle) wrote:
> > > Size the uptodate array dynamically to support larger pages in the
> > > page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> > > but with a 2MB maximum page size, we'd have to allocate more than 4kB
> > > per page.  Add a few debugging assertions.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Some syscall fuzzing will trigger this on powerpc:
> > 
> > .config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> > 
> > [ 8805.895344][T445431] WARNING: CPU: 61 PID: 445431 at fs/iomap/buffered-
> > io.c:78 iomap_page_release+0x250/0x270
> 
> Well, I'm glad it triggered.  That warning is:
>         WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
>                         PageUptodate(page));
> so there was definitely a problem of some kind.
> 
> truncate_cleanup_page() calls
> do_invalidatepage() calls
> iomap_invalidatepage() calls
> iomap_page_release()
> 
> Is this the first warning?  I'm wondering if maybe there was an I/O error
> earlier which caused PageUptodate to get cleared again.  If it's easy to
> reproduce, perhaps you could try something like this?
> 
> +void dump_iomap_page(struct page *page, const char *reason)
> +{
> +       struct iomap_page *iop = to_iomap_page(page);
> +       unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> +
> +       dump_page(page, reason);
> +       if (iop)
> +               printk("iop:reads %d writes %d uptodate %*pb\n",
> +                               atomic_read(&iop->read_bytes_pending),
> +                               atomic_read(&iop->write_bytes_pending),
> +                               nr_blocks, iop->uptodate);
> +       else
> +               printk("iop:none\n");
> +}
> 
> and then do something like:
> 
> 	if (bitmap_full(iop->uptodate, nr_blocks) != PageUptodate(page))
> 		dump_iomap_page(page, NULL);

This:

[ 1683.158254][T164965] page:000000004a6c16cd refcount:2 mapcount:0 mapping:00000000ea017dc5 index:0x2 pfn:0xc365c
[ 1683.158311][T164965] aops:xfs_address_space_operations ino:417b7e7 dentry name:"trinity-testfile2"
[ 1683.158354][T164965] flags: 0x7fff8000000015(locked|uptodate|lru)
[ 1683.158392][T164965] raw: 007fff8000000015 c00c0000019c4b08 c00c0000019a53c8 c000201c8362c1e8
[ 1683.158430][T164965] raw: 0000000000000002 0000000000000000 00000002ffffffff c000201c54db4000
[ 1683.158470][T164965] page->mem_cgroup:c000201c54db4000
[ 1683.158506][T164965] iop:none


