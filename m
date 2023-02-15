Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1DB697E4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBOOZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOOZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:25:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28382385A;
        Wed, 15 Feb 2023 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9NoGUR70O0zSCDF7awBC8PY/0Nfb60M+m7+9Kbbdg7g=; b=BlpEO19R+dBG07jw5IxBPhz2S2
        Y3fNFYKWHzgpYk1Mpwnx3to/ur0AKtVSruwGS2XeVpLTIFd84jcf59fLHhs4uY/Fd6+CEc8MVtInF
        nPvc8Q2013EBQhuR3k+R+jC6DAY5yg/vsJiFgTo1Kjy0aJ1mQEUS0a2Yqoew1ArW4t0dxVQZad3Cl
        pk563FCHmr3eiNyXPPwtkWkVhCCRAETC4Ct5WjNsvyq9B16FKy0r3IMut6Yeuq9UQV+hnZut0L+M6
        36DQFRuCK8zV9X6btdVnYkkV/EbPjLdcK6asnlai+GgxxrfIALwVONXp3C6ydqDuGOM8BUxEjY59P
        U2s9jG4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSIiM-006CaN-Ru; Wed, 15 Feb 2023 14:24:54 +0000
Date:   Wed, 15 Feb 2023 06:24:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v14 01/12] splice: Fix O_DIRECT file read splice to avoid
 reversion of ITER_PIPE
Message-ID: <Y+zrNiDsC0Mt7JAc@infradead.org>
References: <Y+nzO2H8AizX4lAQ@infradead.org>
 <Y+UJAdnllBw+uxK+@casper.infradead.org>
 <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-2-dhowells@redhat.com>
 <909202.1675959337@warthog.procyon.org.uk>
 <3057147.1676467076@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3057147.1676467076@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:17:56PM +0000, David Howells wrote:
> Probably not, but I don't want to fiddle with that right now.  I can send a
> follow up patch for it.

Honestly, I think this rush for 6.3 inclusion is a really bad idea.

This series fundamentally changes how splice reads work, and has only
been out for about a week.  It hasn't even been Cc'ed to Al and Linus
which generally have a good knowledge of the splice code and an opinion
on it.

I think it is a good change, but I'd feel much more comfortable with
it for the next merge window rather than rushing it.
