Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A153BF31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiFBT7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 15:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiFBT7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:59:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17FED50;
        Thu,  2 Jun 2022 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=L62nkMvOiKkS8r/CgDAH7ZpJ/IR8uvURb01MhrGakZI=; b=aYXlKz8BwlxgFjtshDHk0f2UTt
        ECfJKolERkx9sHVruadkUvDKM8uYZqHeiiPjR7COqLg9HDp+0pzW84tgJEdrwkGB193tLPsGjoUJ/
        DJJvrBvDOtWiGht/iWO7FtKSFw+xHMb+iyX7DDM+w5/JnDUNKbaAdAw0kBTTg/fYtRfFasGKI1ghV
        Erqul2N1NuV1xlQQAb0XUgFW+FOr73CaSOEZoNHV6CqdcF0DoHc9hy8mVtnwmMD00U9G4eLEFJ+Ok
        DWvTL6Xw5BDKZHhUcY0QZxWq4nF4gNP5fIN5NhXQLfpRRetBg+rr+RLZkvZ5ZmQgQ1IlnyQdHteYA
        K8yf3Mew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwqyD-007OIo-Uu; Thu, 02 Jun 2022 19:59:01 +0000
Date:   Thu, 2 Jun 2022 20:59:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Message-ID: <YpkWhZmM1OOqEW4C@casper.infradead.org>
References: <20220601011116.495988-1-clm@fb.com>
 <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area>
 <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <0B09932C-66FB-4ED9-8CF1-006EEC522E6B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0B09932C-66FB-4ED9-8CF1-006EEC522E6B@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 02, 2022 at 07:41:55PM +0000, Chris Mason wrote:
> 
> > On Jun 2, 2022, at 11:32 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > On Thu, Jun 02, 2022 at 04:52:52PM +1000, Dave Chinner wrote:
> >> 
> >> Further, I don't think we need to invalidate the folio, either. If
> >> it's beyond EOF, then it is because a truncate is in progress that
> >> means it is somebody else's problem to clean up. Hence we should
> >> leave it to the truncate to deal with, just like the pre-2013 code
> >> did....
> > 
> > Perfect, that works.
> 
> Ok, I’ll run it through xfstests and resend a v2.  Will this cover all of the subpage blocksize concerns?

I run with:
export MKFS_OPTIONS="-m reflink=1,rmapbt=1 -i sparse=1 -b size=1024"

Dave may have other options he'd like to see.
