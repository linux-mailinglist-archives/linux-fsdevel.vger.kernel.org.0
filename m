Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 747461029B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 17:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfKSQsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 11:48:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfKSQsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o6Xorr1YcsQsK3Quwrv71zh+7TkFJFwPNfufKpOpWww=; b=BErkTr/m8+nOTc6ZYIhuAYK4v
        vvcZGb9/osrqj2yO8ze66UdF/0KDwcPjM3K4qRLjLOi/Ph5ce0GbBP2ZONQs23VEWZAvOIKujPmkK
        Hr/ypgbW6J8ExdcLawErnSDO5J2UFnrRPnT0SYFNdFlyRNt7lmnK0XbJVU2/8D6m0SEQOMe4OboMa
        Xqzz/yuVJ2Z5mSx4gQ7dZemYdXejXREbNwHsK7JUs8DQzQ1goIL6V1g6OIIEzIlqnCZy+Ou8CCqA0
        Hva5TN527WebFB6v2nrcnexMtcmVVKcbR7rMZHMNVqBbLUoXwBZjL24Ai5PLFaWRz3x85jC+gEhpj
        7cWM4l7Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iX6gH-0006IA-QP; Tue, 19 Nov 2019 16:48:45 +0000
Date:   Tue, 19 Nov 2019 08:48:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: Splice & iomap dio problems
Message-ID: <20191119164845.GA22763@infradead.org>
References: <20191113180032.GB12013@quack2.suse.cz>
 <20191113184403.GM6235@magnolia>
 <20191119163214.GC2440@quack2.suse.cz>
 <20191119163454.GS6235@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119163454.GS6235@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 08:34:54AM -0800, Darrick J. Wong wrote:
> > The slight concern I have with this is that that would change e.g. the
> > behavior of IOMAP_REPORT. We could specialcase IOMAP_REPORT but then it
> > gets kind of ugly. And it seems kind of fuzzy when do we truncate the
> > extent with i_size and when not... Generally i_size is kind of a side-band
> > thing for block mapping operations so if we could leave it out of
> > ->iomap_begin I'd find that nicer.
> 
> <nod>

Yes.  I'd prefer if the caller deals with any i_size limiting and
not the iomap methods themselves.  For now I'm tempted to just go
with the iov_iter_revert scheme.  Note that I particularly like it,
but it matches the most common direct I/O implementation at least.
