Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E484B5E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 00:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiBNXcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 18:32:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiBNXcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:32:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3C10AEFF
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWlSu+1yEMZxgs6DAl2lTEtG63DuTn18CmEDUAxtQ2g=; b=vsUo4kKE0QMDlOtG2OD2St7Kc6
        VIUNnhjac+vNRtA/M8hHCy39wOsHMCXd921sh1f1haptuacJ8902FVXt6pO0aHcJvJ0M7Zi/0RXCY
        4n6hKXtpLnRjKK49F8UEA95M4XysidrRXwhJgpaixAWMj+FLTEEmF6TlSakb1lxyegZMtBTP3ZhXi
        Q1rpFW0MM+a0j9ATpPlyH8vhf4CrgBZ79ApFcABwxiIGyQ9FXecWTXLqkZppXB7cida9Rz8+yi74f
        WLP/j7s99hJ6gPYxIU4u3ERstZ8dOzchYCS5pXGDyiUpjeh5vFYROVOirlvGqj2qHktyumkC4Bt7k
        bznXFMiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJkpj-00DLRD-0T; Mon, 14 Feb 2022 23:32:39 +0000
Date:   Mon, 14 Feb 2022 23:32:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page()
 into its one caller
Message-ID: <YgrmllRrkImmBL/g@casper.infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
 <f711b39b-aea9-b514-1483-76fb128a2319@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f711b39b-aea9-b514-1483-76fb128a2319@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 03:09:09PM -0800, John Hubbard wrote:
> > @@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)
> 
> It would be nice to retain some of the original comments. May I suggest
> this (it has an additional paragraph) for an updated version of comments
> above invalidate_inode_page():
> 
> /*
>  * Safely invalidate one page from its pagecache mapping.
>  * It only drops clean, unused pages. The page must be locked.
>  *
>  * This function can be called at any time, and is not supposed to throw away
>  * dirty pages.  But pages can be marked dirty at any time too, so use
>  * remove_mapping(), which safely discards clean, unused pages.
>  *
>  * Returns 1 if the page is successfully invalidated, otherwise 0.
>  */

By the end of this series, it becomes:

/**
 * invalidate_inode_page() - Remove an unused page from the pagecache.
 * @page: The page to remove.
 *
 * Safely invalidate one page from its pagecache mapping.
 * It only drops clean, unused pages.
 *
 * Context: Page must be locked.
 * Return: The number of pages successfully removed.
 */

> Also, as long as you're there, a newline after the mapping declaration
> would bring this routine into compliance with that convention.

Again, by the end, we're at:

        struct folio *folio = page_folio(page);
        struct address_space *mapping = folio_mapping(folio);

        /* The page may have been truncated before it was locked */
        if (!mapping)
                return 0;
        return mapping_shrink_folio(mapping, folio);

> hmmm, now I wonder why this isn't a boolean function. And I think the
> reason is that it's quite old.

We could make this return a bool and have the one user that cares
call folio_nr_pages().  I don't have a strong preference.

> Either way, looks good:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks!
