Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2F545324
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 19:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbiFIRkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiFIRkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:40:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4E155319;
        Thu,  9 Jun 2022 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=50LH8Dogtui4JOE7bz/ojMzo0HRhZGWl5FgghUdbsso=; b=H80hSPNqGiAd5chM6yyxpXe7GI
        v16rR9GPk1lsBvZCxGkkfPwwIt580VMmgSt7/ZwfufekJhmrwARChvfRps5Isb2jo31hImz/J8zhg
        3Gqid/DHTzlBHrEnpsHq7tbmdB6lizbSwvMg1psBh47cB986OJv32t09q9JTTsGSl5f5sM+mUmbDC
        kBxIqffET9U+LDZy+bNXjBWIq4ozQI6dP3A/jTcDrHF2DBz9xSzltFjBNcK5NRZczIeDZyfqJ8lJf
        qfewZREEYM3aHIjRrfEfYKtBKEBJRQ6UywKBfP0QJhwiV/qPmGd6+tb1EV1S0HSjXDX6WidFPIyNN
        +S04cl5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzM8y-00DjCy-V3; Thu, 09 Jun 2022 17:40:28 +0000
Date:   Thu, 9 Jun 2022 18:40:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/19] btrfs: Convert btrfs_migratepage to
 migrate_folio
Message-ID: <YqIwjEO1a0Sbxbym@casper.infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-13-willy@infradead.org>
 <20220609163323.GV20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609163323.GV20633@twin.jikos.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 06:33:23PM +0200, David Sterba wrote:
> On Wed, Jun 08, 2022 at 04:02:42PM +0100, Matthew Wilcox (Oracle) wrote:
> > Use filemap_migrate_folio() to do the bulk of the work, and then copy
> > the ordered flag across if needed.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> > +static int btrfs_migrate_folio(struct address_space *mapping,
> > +			     struct folio *dst, struct folio *src,
> >  			     enum migrate_mode mode)
> >  {
> > -	int ret;
> > +	int ret = filemap_migrate_folio(mapping, dst, src, mode);
> >  
> > -	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
> >  	if (ret != MIGRATEPAGE_SUCCESS)
> >  		return ret;
> >  
> > -	if (page_has_private(page))
> > -		attach_page_private(newpage, detach_page_private(page));
> 
> If I'm reading it correctly, the private pointer does not need to be set
> like that anymore because it's done somewhere during the
> filemap_migrate_folio() call.

That's correct.  Everything except moving the ordered flag across is
done for you, and I'm kind of tempted to modify folio_migrate_flags()
to copy the ordered flag across as well.  Then you could just use
filemap_migrate_folio() directly.

> > -
> > -	if (PageOrdered(page)) {
> > -		ClearPageOrdered(page);
> > -		SetPageOrdered(newpage);
> > +	if (folio_test_ordered(src)) {
> > +		folio_clear_ordered(src);
> > +		folio_set_ordered(dst);
> >  	}
