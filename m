Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AB655CB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Dec 2022 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiLYJMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Dec 2022 04:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYJMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Dec 2022 04:12:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500D63FB;
        Sun, 25 Dec 2022 01:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FdSkeieNG1bC63s9lF5RGovWFIFuWTP7A8qZ4msnCck=; b=kRioCjen6r4Gx5uOcnzc6GLfVr
        0L7M5+Tg+mDuhNniPlKIc44Ukt23hCXtPGmvIzW/wvFd/ZZe9mSG/E7V6vtU+QxuTbiUsX66roQ2E
        2XL3CAcz05Tsx0Gj9EXoc8DZ9+K34rUmR2OFG2Km7/+i0mJBtLVkJCNc2TXDCrJX+D7xqJiAaN5nW
        q+24UC+pr8KM/iUSdAVcPU00hdCKaXXih/ntR2ZLc2ibkQEmKmgDEmQQCBnePc++EKGNJ8w+wV+ez
        1wRQtbfScJc7TshbPAMiBzQZrzjJKANA6BbMKCRmERUNPP422+IU+z4fhZAcLO5Qi3QuWUHrfD64T
        7BAhgnLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p9N3a-005rKQ-22; Sun, 25 Dec 2022 09:12:34 +0000
Date:   Sun, 25 Dec 2022 09:12:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 4/7] iomap: Add iomap_folio_prepare helper
Message-ID: <Y6gUAtg4MZC2ZG6v@casper.infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-5-agruenba@redhat.com>
 <Y6XDhb2IkNOdaT/t@infradead.org>
 <CAHpGcMLzTrn3ZUB4S8gjpz+aGj+R1hAu38m-PL5rVj-W-0G2ZA@mail.gmail.com>
 <Y6ao9tiimcg/DFGl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6ao9tiimcg/DFGl@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:23:34PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 10:05:05PM +0100, Andreas Grünbacher wrote:
> > > I'd name this __iomap_get_folio to match __filemap_get_folio.
> > 
> > I was looking at it from the filesystem point of view: this helper is
> > meant to be used in ->folio_prepare() handlers, so
> > iomap_folio_prepare() seemed to be a better name than
> > __iomap_get_folio().
> 
> Well, I think the right name for the methods that gets a folio is
> probably ->folio_get anyway.

For the a_ops, the convention I've been following is:

folio_mark_dirty()
 -> aops->dirty_folio()
   -> iomap_dirty_folio()

ie VERB_folio() as the name of the operation, and MODULE_VERB_folio()
as the implementation.  Seems to work pretty well.

