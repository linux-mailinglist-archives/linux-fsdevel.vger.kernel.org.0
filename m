Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E26995E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfGOQuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 12:50:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfGOQuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GIfH31yo9w3WoK5TA2mWROknqJW2UOQYGcCKqVwORN4=; b=jZKxjPp53JAgaXRm5f8a6Yo+N
        1UF55TcZ+Po1v4IDpRkeQC/P0Y9aPjipD91OZbRD+lHprVkpBcBG0PZU6V6g2sYQ8M8OfjDzXxgr0
        0kkk4F8oAX5BPTZ+jZajHdmdg4DGWS93AsX+D1bNAC3WTRj/LIA7Fbxj7WX3CFLZqCD1vSCPXQxHS
        N7k/uOqofSfNzxkonwzyfsJt/CApBkDjIUJfmm4oorfZ6imR3qaUTDETx0nj9aAAFwkCy+MnlCN0L
        V+FwC5E+vWZP7E+BdiYLvfH5AsevTtPWQaKKkJviCVRxt58XpNDyAhtvBkxqVKd8e0RBr2BaiUqq3
        xrofWhPRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hn4B3-0002Sa-3t; Mon, 15 Jul 2019 16:50:13 +0000
Date:   Mon, 15 Jul 2019 09:50:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190715165012.GA32624@infradead.org>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
 <20190708184652.GB20670@infradead.org>
 <20190709164952.GT1404256@magnolia>
 <20190709181214.GA31130@infradead.org>
 <20190715164307.GA6176@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715164307.GA6176@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:43:07AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 09, 2019 at 11:12:14AM -0700, Christoph Hellwig wrote:
> > I looked over it and while some of the small files seem very tiny
> > they are reasonably split.
> > 
> > What rather annoys me is the page.c/read.c/write.c split.  All these
> > really belong mostly together, except maybe the super highlevel
> > write code that then either calls into the buffer_head vs iomap_page
> > based code.  By keeping them together we can eliminate most of
> > iomap_internal.h and once the writeback code moves also keep
> > iomap_page private to that bigger read.c file.
> 
> <nod> I think it makes sense to combine them into a single read_write.c
> file or something.

page.c or buffered-io.c seems like sensible names to me.

> >  - some of the copyrights for the small files seem totally wrong.
> >    e.g. all the swapfile code was written by you, so it should not have
> >    my or rh copyright notices on it
> 
> Will fix the swapfile code.

Please also look over the other files, a few of them should probably
be just me (e.g. fiemap) and some have other authors (seek is mostly
Andreas with a few later bits from me).
