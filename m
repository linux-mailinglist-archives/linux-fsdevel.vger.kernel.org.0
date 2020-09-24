Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96672776D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgIXQgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:36:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83230C0613CE;
        Thu, 24 Sep 2020 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jfjkeIZEHhA3nRGodYuDZGJpWjSMB63Yuv7NgD+cErM=; b=WaZgps9xKsu6rbYiNvGx72oTrv
        vVewECLFfimVgWA/2LFj/ydxsOkaeQI1Iym0nCniHXumNWyYBvXeodqg1wwPqcurBDUdCHIKPizYE
        nNSxiq+MjuJhVql+7N87UscvrHzIRWMXFE77X6qxMmBuyl4mCJlBuvYQZgdf0Gv0saEdCIieeFfNQ
        V93KHyAytumfQtyA7bW5M12T6K6PICZyacexU5w7lWmzVYzMoiXRapQtHZ0lyiad+Xp/x6/K/a/sq
        KVNIyrC63edZp903p1YY56aiIf86lT4m85ZrI0eDFM1+IWGhD8FuMlg40ulCWzErXWZf6RMOLKGTe
        BdZHBfAA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLUEV-0005hf-Dd; Thu, 24 Sep 2020 16:36:35 +0000
Date:   Thu, 24 Sep 2020 17:36:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924163635.GZ32101@casper.infradead.org>
References: <20200924125608.31231-1-willy@infradead.org>
 <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
 <20200924151538.GW32101@casper.infradead.org>
 <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org>
 <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 06:19:03PM +0200, Sedat Dilek wrote:
> On Thu, Sep 24, 2020 at 5:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 05:21:00PM +0200, Sedat Dilek wrote:
> > > Great and thanks.
> > >
> > > Can you send out a seperate patch and label it with "PATCH v5.9"?
> > > I run:
> > > $ git format-patch -1 --subject-prefix="PATCH v5.9" --signoff
> > >
> > > Normally, I catch patches from any patchwork URL in mbox format.
> >
> > Maybe wait a few hours for people to decide if they like the approach
> > taken to fix the bug before diving into producing backports?
> 
> That make sense.
> 
> You have a test-case for me?
> I have here Linux-Test-Project and FIO available.

Qian reported preadv203.c could reproduce it easily on POWER and ARM.
They have 64kB pages, so it's easier to hit.  You need to have a
filesystem with block size < page size to hit the problem.

If you want to check that your test case hits the problem, stick a printk
in iomap_page_create().
