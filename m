Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3031DB98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 15:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhBQOmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 09:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbhBQOl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:41:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289ABC061756;
        Wed, 17 Feb 2021 06:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uJRZukZKTB1/t3AhLEukXUDMiWzotol6PNLuxIJhLjw=; b=vt0B6CJ+cv5hyXhpJ3rjuVqRc5
        Ybpjy9Ks0s9nQRJ8X4Ug2H5rK4zOPCXAez8aSZP5BUdrmN/Gbz59pGE6RLThVfAmaamAcVtoPGVwd
        dT+55cMI/ediIayQpKyTLyUhRWP4k8iPmtTmay8sjaJ2V0ACsqpHPP14RWa8RNvE9vbIY6BXoSGSY
        il8Uo+/b5grD2EzGbanTbdGms88mc+0AlI3rZgk6QGHG2e+4LMPSUPres4qbyDPrDHwOhrtx2JbGK
        4coLlsEx1PuIlK8EvJU6jbjzpkj1u+v/5aTahemlf0P5t+u6Jjk2xRIIWhI7ZqZPX7ADmmYzzlau9
        GFr1O+cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCNyj-000ZXQ-Pp; Wed, 17 Feb 2021 14:39:54 +0000
Date:   Wed, 17 Feb 2021 14:38:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, idryomov@gmail.com, xiubli@redhat.com,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ceph: rework PageFsCache handling
Message-ID: <20210217143857.GK2858050@casper.infradead.org>
References: <20210217125845.10319-1-jlayton@kernel.org>
 <20210217125845.10319-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217125845.10319-3-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 07:58:41AM -0500, Jeff Layton wrote:
> -static int ceph_releasepage(struct page *page, gfp_t g)
> +static int ceph_releasepage(struct page *page, gfp_t gfp_flags)
>  {
>  	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
>  	     page, page->index, PageDirty(page) ? "" : "not ");
>  
> +	if (PageFsCache(page)) {
> +		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))

If you called it 'gfp' instead of 'gfp_flags', you wouldn't go over 80
columns ;-)

		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))

