Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD45358780
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDHOvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:51:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30640C061760;
        Thu,  8 Apr 2021 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+cewsqIjy3KyilGPYnpep4bhBTgpsrNatr9SSgJPp+A=; b=Xq6rS14iEtk33sZT1twqc2gQB0
        jTafc881dELFdZxc453Afl84KSiCv9BlDNWFMmnJqrJ7+pawRB2ciuCtRFt6kKI+67dnyH1Vd/aA7
        7recD+wKVjyEya+hf36HVxPE0dSKP9CBNHdVCkNzZWKcJpH/ZJ2zX25TtfW/6NVV1IjRtxvZ+Y3Kf
        /g0OXDI4v3N1ArJHE3LwyaVlOjJjpbQQ8+YtWS2daRZRHbFa6TRRt+0A3Y+zpZh/i8glAZMVgyLPP
        PhwAcASqyaMDlSOzGFxhq/JZ5fYkxv2Mq+XkfA5VgxX/Xx+g4UBo2NUNNibb8nZFuAboaixfLddhj
        uGQILrJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUVzl-00GNO2-Ap; Thu, 08 Apr 2021 14:51:03 +0000
Date:   Thu, 8 Apr 2021 15:50:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/30] mm: Add set/end/wait functions for PG_private_2
Message-ID: <20210408145057.GN2531743@casper.infradead.org>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
 <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161789066013.6155.9816857201817288382.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:04:20PM +0100, David Howells wrote:
> +static inline void set_page_private_2(struct page *page)
> +{
> +	get_page(page);
> +	SetPagePrivate2(page);

PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)

So we can set Private2 on any tail page ...

> +void end_page_private_2(struct page *page)
> +{
> +	page = compound_head(page);
> +	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
> +	clear_bit_unlock(PG_private_2, &page->flags);
> +	wake_up_page_bit(page, PG_private_2);

... but when we try to end on a tail, we actually wake up the head ...

> +void wait_on_page_private_2(struct page *page)
> +{
> +	while (PagePrivate2(page))
> +		wait_on_page_bit(page, PG_private_2);

... although if we were waiting on a tail, the wake up won't find us ...

if only we had a way to ensure this kind of bug can't happen *cough,
lend your support to the page folio patches*.
