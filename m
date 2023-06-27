Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E873F358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjF0E0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjF0E0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:26:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52073A8C;
        Mon, 26 Jun 2023 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X0O5D4A4BzDv3g6F+hWrfTtn7WMWd5+asdpXbkJ+CvU=; b=o9VxntFVUrtjl9KyiH5GLIK63h
        M4ugJRCobRFr7lzpbASn1T7e3WySQofX+YWms0U5z08zQNlL1npMhtv/0yJDDYlxyAjF+1F7F7GcY
        ZCouKPEE8WXQgs6G1pYTN6dYcnm05xBXnkjTJ4VQ0zBuVFE2aSi4dGA2Zy3ZCrfTKP7iiWI8aRxXy
        QxfGPusR+9kNm7+YkRn/n4Nq9TNn76FhWRhiiidhU0vU3WqrQWP+NDXeQzDE6lQitim+d94grbjNF
        VPw/gPz9cQkAgtBfFWK8KhAwQwVXXtOgiOTt2et2IgXUjUHC+08a0t+d+N3umJtARvrtmQrIcLH5P
        U9Vj9E2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0GD-00BghN-0h;
        Tue, 27 Jun 2023 04:25:01 +0000
Date:   Mon, 26 Jun 2023 21:25:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 06/12] writeback: Use the folio_batch queue iterator
Message-ID: <ZJpknTpAoEEaIro0@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:35:15PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of keeping our own local iterator variable, use the one just
> added to folio_batch.

Ok, that's a slightly different twist to what I just suggested.

>  	for (;;) {
> -		struct folio *folio;
> +		struct folio *folio = writeback_get_next(mapping, wbc);
>  
> +		if (!folio)
>  			break;

But as a purely cosmetic nit I still think this would read nicer as:

	while ((folio = writeback_get_next(mapping, wbc))) {

