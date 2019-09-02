Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C448A5BC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfIBRQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 13:16:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfIBRQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+0oscjXmRLZoSva+RI4oxO2YXk5t5V7oUXwjCDh/M9c=; b=LLAPg8XOE4WfTJmr+i55wi6NS
        RTE5zAlQzCM9nJKxIlB12JrN4N85JuysmktgIyIv5YeePV+AGJH1BQ1IzHX4uHJql3IE6umkCI+KA
        h+mrH9zUu/+I4WLDpbASW/f+7gxDp1EiZnP/5VrtHsW7JCpsSxnFrI1274DJpOWl4bLcx6pLDWbyY
        hTvpI7NFA2UPCz0jI5jPeAVm6SOUlLWiT81/r/v7J09nJQiZrSeKisM3Ajws6CYFQ8BXLSFtlHM/n
        CxT7qt63Ztk43nsSEkSNo/5GFvCIKdVq8z78jPkzsedCrsnsY+icOzkfkWFmjgqKVOTyiSA6bDfCS
        k4yN1Hf0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4pwU-00065D-09; Mon, 02 Sep 2019 17:16:38 +0000
Date:   Mon, 2 Sep 2019 10:16:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Damien.LeMoal@wdc.com,
        agruenba@redhat.com
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Message-ID: <20190902171637.GA10893@infradead.org>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
 <20190816065229.GA28744@infradead.org>
 <20190817014633.GE752159@magnolia>
 <20190901073440.GB13954@infradead.org>
 <20190901204400.GQ5354@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901204400.GQ5354@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:44:00PM -0700, Darrick J. Wong wrote:
> Would you mind rebasing the remaining patches against iomap-for-next and
> sending that out?  I'll try to get to it before I go on vacation 6 - 15
> Sept.

Ok.  Testing right now, but the rebase was trivial.

> Admittedly I think the controversial questions are still "How much
> writeback code are we outsourcing to iomap anyway?" and "Do we want to
> do the added stress of keeping that going without breaking everyone
> else"?  IOWs, more philosophical than just the mechanics of porting code
> around.

At least as far as I'm concerned the more code that is common the
better so that I don't have to fix up 4 badly maintained half-assed
forks of the same code (hello mpage, ext4 and f2fs..).

> I still want a CONFIG_IOMAP_DEBUG which turns on stricter checking of
> the iomap(s) that ->begin_iomap pass to the actor, if you have the time;
> I for one am starting to forget exactly what are the valid combinations
> of iomap flag inputs that ->begin_iomap has to handle for a given actor
> and what are the valid imaps for each actor that it can pass back.  :)

I was actually thinking of killing the input IOMAP_ types entirely,
as that "flags" model just doesn't scale, and instead have more
iomap_ops instances in the callers.  But that is just a vague idea
at the moment.  I'll need some more time to think about it.
