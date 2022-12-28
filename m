Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22DA657EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Dec 2022 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiL1P4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Dec 2022 10:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiL1Pzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:55:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A844BCA1;
        Wed, 28 Dec 2022 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6wGBkXWPpYjazxvcUxjswCd89wx6pPvJfoOTyM3QCW0=; b=On4SKrzV9Wx6r81NZbva4k9nEo
        pr6uIv9hdLfqf6V2Xa/YbVIDBgvKq6gqmrhuTuQIkSkSsbGosBms+BWiHbN1IkQnJlheOs31HHNOw
        QRWhQzin2Acs8stxmKvgqFSEqqeVFJerctSHUEc6NrKPeYwF9iotOmVNTKuRwyvqKyxR3i0XpYY/T
        tOjw7E7kKjKXIQeHBzXT4SuxVxr6Qan5D5Tn/5rmp0UYiHMPq8Xw58Hg5KECDd5wZgGi43AyFxFdN
        jWhkQs1cF+HcT6/7KoR5N8MKZuy9A7Bk7hATnR32nrmDEnDRXOMBSxYSTUsilcX/m5XDAaeR//Aqu
        FjXDU/ZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAYmM-0067SQ-6j; Wed, 28 Dec 2022 15:55:42 +0000
Date:   Wed, 28 Dec 2022 07:55:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 4/7] iomap: Add iomap_folio_prepare helper
Message-ID: <Y6xm/sJXHaMxO1HI@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-5-agruenba@redhat.com>
 <Y6XDhb2IkNOdaT/t@infradead.org>
 <CAHpGcMLzTrn3ZUB4S8gjpz+aGj+R1hAu38m-PL5rVj-W-0G2ZA@mail.gmail.com>
 <Y6ao9tiimcg/DFGl@infradead.org>
 <Y6gUAtg4MZC2ZG6v@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6gUAtg4MZC2ZG6v@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 25, 2022 at 09:12:34AM +0000, Matthew Wilcox wrote:
> > > I was looking at it from the filesystem point of view: this helper is
> > > meant to be used in ->folio_prepare() handlers, so
> > > iomap_folio_prepare() seemed to be a better name than
> > > __iomap_get_folio().
> > 
> > Well, I think the right name for the methods that gets a folio is
> > probably ->folio_get anyway.
> 
> For the a_ops, the convention I've been following is:
> 
> folio_mark_dirty()
>  -> aops->dirty_folio()
>    -> iomap_dirty_folio()
> 
> ie VERB_folio() as the name of the operation, and MODULE_VERB_folio()
> as the implementation.  Seems to work pretty well.

Yeay, ->get_folio sounds fine if not even better as it matches
filemap_get_folio.
