Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011AF406798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhIJH1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhIJH13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:27:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FAC061574;
        Fri, 10 Sep 2021 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=087+0CiZqvP07DsW5DSevAPmxX0P+Bu6ZoYX2WEyOJQ=; b=Ik/NbsR162FqLJapnUR/sS8UKy
        nZsQzTiixipnJnpCTwF1/o3Py4Phj2l/15kz31oxyk0L5dXx6orfQv3hChQpUN5b8GDK3671W7vUO
        acBpWMQb6GNywBqMIpk84LeLKYiMYjr8Yt4QQ5iRQpktx6mFnEA5lzoOyUje88bqRP3wAZWFZSsxk
        tLxmEvjTbAFm3GEtoV6AT6euR3S6XjLvRYtcqvH3B2H8ig6IO5dmbxnpvnhei0pPVcekr5pQ14r5v
        y7Sx/MUn+A3UalVcwDOGV80URjJOxnRosjSO1YHOQB4Z9OJy1MK8JTqi6xEGHe6gs2gT/b45Wxi2E
        aCK0Wcmg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOatG-00AmTN-Ld; Fri, 10 Sep 2021 07:24:19 +0000
Date:   Fri, 10 Sep 2021 08:24:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 17/19] gup: Introduce FOLL_NOFAULT flag to disable
 page faults
Message-ID: <YTsIEqoJqRUVneHq@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-18-agruenba@redhat.com>
 <YTnxruxm/xA/BBmQ@infradead.org>
 <CAHk-=wj4RER3XeG34nLH2PgvuRuj_NRgDx=wLTKv=jYaQnFe+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4RER3XeG34nLH2PgvuRuj_NRgDx=wLTKv=jYaQnFe+Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:17:14AM -0700, Linus Torvalds wrote:
> So I think we should treat FOLL_FAST_ONLY as a special "internal to
> gup.c" flag, and perhaps not really compare it to the new
> FOLL_NOFAULT.
> 
> In fact, maybe we could even just make FOLL_FAST_ONLY be the high bit,
> and not expose it in <linux/mm.h> and make it entirely private as a
> name in gup.c.

There are quite a few bits like that.  I've been wanting to make them
private for 5.16.
