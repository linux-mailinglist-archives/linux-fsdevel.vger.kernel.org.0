Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E4F540141
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiFGOYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbiFGOYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:24:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA6C1EC9;
        Tue,  7 Jun 2022 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TMQU2bbtV5kjI1Y7uBOgpmsi6MujvLdf4se1f0ultbQ=; b=T3tONSSZEZI3TnW91MAPGKwqdn
        ynmJAoI6mOfrbbq8Jqf2czJGvi9Q0ukvLmmikcGSI8ZqHSwvRkTwLUTylDBqG6RaX8/3fM9Nvve4c
        VqFvCNQX2J5+bZcWx69Xcxl0FnIF/+ozKW4FHlSZHfTn6FEQTfoWOYo1nVdtg5lJcedIUJr0ygYNv
        BxeGZpOaFU4iqywNAUPFsAq2KhxI0Hbg9OXTdHy26nItEezSSsuIGEVlhH9A3QRH3TI9Fv56fknf8
        0pc9AkwczXake1fj6Qt6cCxOadkgaG3Xkumb8mMGujy60/hhxbEX20y0v48fX/CV/o6oaLLnenmYd
        w0xneMdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nya7z-00BhZy-2Z; Tue, 07 Jun 2022 14:24:15 +0000
Date:   Tue, 7 Jun 2022 15:24:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 15/20] balloon: Convert to migrate_folio
Message-ID: <Yp9fj/Si2qyb61Y3@casper.infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-16-willy@infradead.org>
 <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:36:21AM +0200, David Hildenbrand wrote:
> On 06.06.22 22:40, Matthew Wilcox (Oracle) wrote:
> >  const struct address_space_operations balloon_aops = {
> > -	.migratepage = balloon_page_migrate,
> > +	.migrate_folio = balloon_migrate_folio,
> >  	.isolate_page = balloon_page_isolate,
> >  	.putback_page = balloon_page_putback,
> >  };
> 
> I assume you're working on conversion of the other callbacks as well,
> because otherwise, this ends up looking a bit inconsistent and confusing :)

My intention was to finish converting aops for the next merge window.

However, it seems to me that we goofed back in 2016 by merging
commit bda807d44454.  isolate_page() and putback_page() should
never have been part of address_space_operations.

I'm about to embark on creating a new migrate_operations struct
for drivers to use that contains only isolate/putback/migrate.
No filesystem uses isolate/putback, so those can just be deleted.
Both migrate_operations & address_space_operations will contain a
migrate callback.
