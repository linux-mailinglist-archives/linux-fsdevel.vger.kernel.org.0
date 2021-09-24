Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D19416978
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbhIXBec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbhIXBeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:34:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C25C061574;
        Thu, 23 Sep 2021 18:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PKtymgm/rxLNbr2kgli9zC0XtF7+5z+sxIyEiEIRXc4=; b=njjlVgK733a8eyU1LCtkUuhOsc
        PJQqb38DhPltPPxMKDYzkActT5FpxJwB46YEJOmzyIUHSIGfng94M5u3DWlZpGCxhF9YWp44X0S5L
        y7UajNjkoskF45F5/owk2lWdd06qJhelQhBMyBbFYMAU2paunIDiFixHEX4lHz/hwIfmlQkSnQrPg
        PjfNhGxEO80eBT1DTIw5DK6yf5bpaJrvRTuJDl9OHxrpPT9AQltF9axzFSgAIXerKnSbiq2P80ukM
        nKNvIBTQIHpBaKabwteqWoo61E6fVRbh5waq57mM8vyWnitZz/tSUjZQJUjzddVzf3cgs/87WwZnO
        a+PLLnQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTa3q-006m8D-Fu; Fri, 24 Sep 2021 01:31:48 +0000
Date:   Fri, 24 Sep 2021 02:31:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
Message-ID: <YU0qdpbjK5Hdfk2p@casper.infradead.org>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan>
 <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
 <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
 <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com>
 <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
 <CAHbLzkp__irFweEZMEM-CMF_-XQpJcW1dNDFo=RnqaSTGtdJkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkp__irFweEZMEM-CMF_-XQpJcW1dNDFo=RnqaSTGtdJkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:11:19PM -0700, Yang Shi wrote:
> On Thu, Sep 23, 2021 at 4:49 PM Hugh Dickins <hughd@google.com> wrote:
> > I believe Yang Shi is right insofar as the decision on whether it's worth
> > queuing for deferred split is being done based on those subpage _mapcounts.
> > That is a use I had not considered, and I've given no thought to how
> > important or not it is.
> 
> Anyway deferred split is anon THP specific. We don't have to worry
> about this for file THP. So your suggestion about just counting total
> mapcount seems feasible to me for file THP at least.

But I think we probably *should* do deferred split for file THP.
At the moment, when we truncate to the middle of a shmem THP, we try
a few times to split it and then just give up.  We should probably try
once and then queue it for deferred split.
