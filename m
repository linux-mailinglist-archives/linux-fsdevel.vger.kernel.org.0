Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E80175BA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 14:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCBNbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 08:31:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgCBNbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KbznAPswHClelMjNWfA7bjoq++3NKITW9yM0deHTCL8=; b=NfbIpzfNvBcHydrxbk9tgBanS7
        DcfczDuC7koH0n08/ebKQMf9c+wJ8d+6IM5W+RyVqbpqYebldd+G1rIsnqPpr71iHAqfjZBNdFUjO
        yeWOVQd8g0abkjXSEsIUfg5AzTDQanDk8FvfczUPYDgroY45bY242W0IExB4QYBIYS6T0cQKnoMnE
        Nb5RxIYs3aHdoacsjpg3AZle06jAuHPzq46h/y3Y+mLW25ByGb5l8j2f2gh9T8Q4/c5DZcklzToGl
        GGLclRoD8ERVj9G/XeLIlnB1R+EjksuLaPQkPc6o0Owlj/RovxFOt+f3SXE0uwyBy4Gv2iCnGMhMV
        QXCQAouA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8lAD-0007rD-5q; Mon, 02 Mar 2020 13:31:17 +0000
Date:   Mon, 2 Mar 2020 05:31:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200302133117.GA24496@infradead.org>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
 <20200225205342.GA12066@infradead.org>
 <20200228194401.o736qvvr4zpklyiz@fiona>
 <20200228195954.GJ29971@bombadil.infradead.org>
 <20200228203538.s52t64zcurna77cu@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228203538.s52t64zcurna77cu@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:35:38PM -0600, Goldwyn Rodrigues wrote:
> 
> Ah, okay. Now I understand what Christoph was saying.
> 
> I suppose it is safe to remove iov_iter_reexpand(). I don't see any
> other goto to this label which will have a non-zero copied value.
> And we have already performed the iov_iter_revert().

I don't really understand the iov_iter complexities either, at least
not without spending sifnificant time with the implementation.  But
the important thing is that you document the changes in behavior and
your findings on why you think it is safe.
