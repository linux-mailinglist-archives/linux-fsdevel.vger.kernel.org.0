Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E495679946
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjAXN3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXN3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:29:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDE3250D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BfacEeWSAImHdFlfI2VPW35wN0qxUElSXtXQd3ipPtY=; b=ZwdNFk2Z+l/xqn3wZHYWReOUvr
        tLWHXi1gIg6mRZYrmZM4CUTGmQUjQylGgl9TnkP7t/g0ZnHDd7Mo3/NKhzI67Fh9tWcRVa13BCPXg
        MZUG79FE006E5i4h3iS1AdSL4M1t7s52Db1XhrgVzquBpjHRu44NEc8xw5TClKTd2nBpazC2az0Rr
        pSSaf45mpm29suBJxCPhD7x4YePyM+9tvEGwzq4G4nRUn4MoctfhfdRzof3+HlbFA0SuTxsvgPWsC
        OyEB3xc56L0q9aoKa7ErDlPQHUZnCUJWMnNqj7HjhcUfp2uATbu1a5EIuosLbNG/MVJbDYEpmqFrs
        8eEijcSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKJMr-003zEI-0I; Tue, 24 Jan 2023 13:29:41 +0000
Date:   Tue, 24 Jan 2023 05:29:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/10] udf: Switch udf_adinicb_readpage() to
 kmap_local_page()
Message-ID: <Y8/dRJ6K3YwyrbZx@infradead.org>
References: <20230124120221.31585-1-jack@suse.cz>
 <20230124120628.24449-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120628.24449-10-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:06:21PM +0100, Jan Kara wrote:
> Instead of using kmap_atomic() use kmap_local_page() in
> udf_adinicb_readpage().

Looks good.  Given how often this pattern is repeated I wonder if
we want a memcpy_to_page_and_pad helper, though.

Reviewed-by: Christoph Hellwig <hch@lst.de>
