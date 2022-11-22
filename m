Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3028633CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiKVMvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 07:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiKVMvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:51:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EA61525;
        Tue, 22 Nov 2022 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kqed8cf0rF+7M2izq/OCegTtCpnXXbVi+7tx8ySuLzQ=; b=wz/sjoR41PLdlCr51Yyiba68/j
        xYoBna2Wc0GaLJtCDl6BcuOXjzr5BEVDrXhYD/8DjCuBVdIT7y2PV2oruOVKxNbw4a93C9onW6LBp
        n6b+7z+opdNF9I0kFuh1xUi5pPldnv8f560Q4NLILIWlu4u0PfkpS+2IWbK3bBNiFIac+LdKU8N+y
        LcKBdYNAJt8nJ/ne6FDRMuVUqMoIJpzYUdi/aT7qqqpnPfknzsTGaeBgJFDCyn2AcuvwL8IcdEYsx
        MkQczJt4XI74ggYWkCbAGp0FDmORi6mjtR1YFV10KEyitirG9xuys6MX/smrOz6pSPCTyxMcQ9rYN
        8OWYrT1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxSkH-009PqL-Ci; Tue, 22 Nov 2022 12:51:25 +0000
Date:   Tue, 22 Nov 2022 04:51:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <Y3zFzdWnWlEJ8X8/@infradead.org>
References: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
 <166869689451.3723671.18242195992447653092.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166869689451.3723671.18242195992447653092.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:54:54PM +0000, David Howells wrote:
> An additional function, iov_iter_extract_mode() is also provided so that the
> mode of retention that will be employed for an iterator can be queried - and
> therefore how the caller should dispose of the pages later.

Any reason to not just add an out paramter to the main function and
return this directly instead of an extra helper?

> +EXPORT_SYMBOL(iov_iter_extract_pages);

get_user_pages_fast, pin_user_pages_fast are very intentionally
EXPORT_SYMBOL_GPL, which should not be bypassed by an iov_* wrapper.
