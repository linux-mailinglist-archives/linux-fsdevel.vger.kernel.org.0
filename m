Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7772E83D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbjFMQT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 12:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbjFMQTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:19:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54EFE6;
        Tue, 13 Jun 2023 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nh0OpQpLOjjJ1EITsLsgEjmcZSmE2KMb+Z7mQm0QXtc=; b=WOHZDks9XNlrGnAohD1QUoToTr
        ucak1RYheKHQwBD9sAufPz4xLgfdc28s9Qp6WpDvdkUDXd+TL1TgcJUiJzLW0JZC7TiA48W0ya5lv
        Rp3WWfjLbfNu3QBtC8MX1AE5gTWFh6sS9Wgl9knmW6iEk+KoeytgDYR2q2aOZpmvaL8o7i+a7yhLg
        xbmz7tH2ocMua9ENOk+ADczMcrONM4K5NP1i8tMoXtehvfG2cK4Qs/Rg4DAbHWC4lhSUcwc7W1zQ2
        fQCYYI9AGZHUj0XR3J+e5Hgs4dDCR2ShTbwVBQH8HQtpRIPShmBNimkIu79z4DMHVvxpNMyn30GFa
        YQm4pi4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q96jo-0045dg-R8; Tue, 13 Jun 2023 16:19:20 +0000
Date:   Tue, 13 Jun 2023 17:19:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 4/8] iomap: Remove unnecessary test from
 iomap_release_folio()
Message-ID: <ZIiXCPlmrDsOMVqp@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612203910.724378-5-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:39:06PM +0100, Matthew Wilcox (Oracle) wrote:
> The check for the folio being under writeback is unnecessary; the caller
> has checked this and the folio is locked, so the folio cannot be under
> writeback at this point.
> 
> The comment is somewhat misleading in that it talks about one specific
> situation in which we can see a dirty folio.  There are others, so change
> the comment to explain why we can't release the iomap_page.

> +	 * If the folio is dirty, we refuse to release our metadata because
> +	 * it may be partially dirty (FIXME, add a test for that).

Argh, forgot to fix this.

        /*
         * If the folio is dirty, we refuse to release our metadata because
-        * it may be partially dirty (FIXME, add a test for that).
+        * it may be partially dirty.  Once we track per-block dirty state,
+        * we can release the metadata if every block is dirty.
         */

> -	if (folio_test_dirty(folio) || folio_test_writeback(folio))
> +	if (folio_test_dirty(folio))
>  		return false;

Now I'm wondering if we shouldn't also refuse to release the metadata if
the folio is !uptodate.  It's not a correctness issue, it's a performance
issue, and a question of whose priorities are more important.

If we do release the metadata on a partially uptodate folio, we'll
re-read the parts of the folio from storage which had previously been
successfully read.  If we don't release the metadata, we prevent the
MM from splitting the page (eg on truncate).

No obviously right answer here, IMO.

