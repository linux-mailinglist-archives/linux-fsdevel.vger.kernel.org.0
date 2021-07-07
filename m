Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E13BE9C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 16:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhGGOb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhGGOb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:31:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D682C061574;
        Wed,  7 Jul 2021 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ElAZGzl0/MDX8G1+DWfrYuLHP347xi96guZn4kTpqPs=; b=OCkcSwo/TnnYGpr59pmXZQ/R3p
        VpwS6grLJVlUAVnqzOwEHikU5UqgogC9SUlkYZ5Hv1nOxffJXzYsYB/00LDWRILl1yuQMwit8jaMc
        Dq5GkbbNZm2TskPHJSLTB/THcG4bZHWw3CiH4o0umb+5Tb14cVcn3mzQgVwsJc5ufd+EnPlKw0fVc
        +wBQDPVdLCnWvw5sTkdp7WIWFvwZpIG3TyCVrpJ9kkkjBWA+4QhjmltmjzAeV5AOIWJ1SFKBXuQRo
        yc3oWDapaOuo6bzjQistFKxyc6HyJmQcWGXkSDJOJKa3Q4pMtD3atQ5IeHXx5JVM25GnmBWJ4IIKF
        G6IbsBLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m18Xf-00CTqL-G4; Wed, 07 Jul 2021 14:28:50 +0000
Date:   Wed, 7 Jul 2021 15:28:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v3 2/3] iomap: Don't create iomap_page objects for inline
 files
Message-ID: <YOW6Hz0/FgQkQDgm@casper.infradead.org>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707115524.2242151-3-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:55:23PM +0200, Andreas Gruenbacher wrote:
> @@ -252,6 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	}
>  
>  	/* zero post-eof blocks as the page may be mapped */
> +	iop = iomap_page_create(inode, page);
>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;

I /think/ a subsequent patch would look like this:

+	/* No need to create an iop if the page is within an extent */
+	loff_t page_pos = page_offset(page);
+	if (pos > page_pos || pos + length < page_pos + page_size(page))
+		iop = iomap_page_create(inode, page);

but that might miss some other reasons to create an iop.
