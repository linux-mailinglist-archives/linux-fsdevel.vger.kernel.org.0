Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9917848D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 22:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgCCVGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 16:06:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgCCVGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r8BD7PDvNtyj7rApxVf93dDwSISVOUC1PGpaU2/FE/8=; b=eHiytz6XTjdrIw6LB6wROAZf/N
        VM5R41zbAXp2ZO6UcEVb0oYbjhiQTjiDWdEHjFMnVqIz1Mokv1zy21/3QNYOzIFBn7qXptR8p39i9
        GwVH6m1mKCwX/CbvNysb4Ug7ZWGrrlJOIpuf1gl5wQZmd8c4LaAmajRVpNheNn6s08lhU+5NjCfnQ
        ZyK47p8WKXQ1xW9mWTfKg7E8KZLVCvld8tTgJRzKORgzoV2du4OfdvAQEz2P+x86pN04Rx/OG0x8B
        g1U1vA3vY9RowCfkm1Ys9EG+mtuBRgAcnT57FH0byMQccCgJNqtRvNQ8jCcmLTX0Fpx1JyI5wKgZt
        esdZvzyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Ejn-0007Q7-JQ; Tue, 03 Mar 2020 21:05:59 +0000
Date:   Tue, 3 Mar 2020 13:05:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] proc: Use ppos instead of m->version
Message-ID: <20200303210559.GV29971@bombadil.infradead.org>
References: <20200229165910.24605-1-willy@infradead.org>
 <20200229165910.24605-4-willy@infradead.org>
 <20200303195529.GA17768@avx2>
 <20200303202923.GT29971@bombadil.infradead.org>
 <20200303205303.GA10772@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303205303.GA10772@avx2>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:53:03PM +0300, Alexey Dobriyan wrote:
> On Tue, Mar 03, 2020 at 12:29:23PM -0800, Matthew Wilcox wrote:
> > On Tue, Mar 03, 2020 at 10:55:29PM +0300, Alexey Dobriyan wrote:
> > > On Sat, Feb 29, 2020 at 08:59:08AM -0800, Matthew Wilcox wrote:
> > > > -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> > > > +static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> > > 
> > > This looks like hungarian notation.
> > 
> > It's the standard naming convention used throughout the VFS.  loff_t is
> > pos, loff_t * is ppos.
> > 
> > $ git grep 'loff_t \*' fs/*.c |wc
> >      77     556    5233
> > $ git grep 'loff_t \*ppos' fs/*.c |wc
> >      43     309    2974
> > $ git grep 'loff_t \*pos' fs/*.c |wc
> >      22     168    1524
> 
> Yes, people copy-pasted terrible thing for years!
> Oh well, whatever...

In an environment where we sometimes pass loff_t and sometimes pass
loff_t *, this convention is a great way to catch copy-and-paste mistakes.
If I have 'pos += done' in a function which takes a loff_t pos, and I
copy-and-paste it to a function which takes a 'loff_t *pos', it's going
to create a bug that hits at runtime.  If that function takes an
loff_t *ppos instead, it'll be a compile-time error, and I'll know to
transform it to *ppos += done;

