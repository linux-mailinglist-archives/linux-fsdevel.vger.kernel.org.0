Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3215B47B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 08:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGAGI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 02:08:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfGAGI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d/gh8lqkrefSCrMG3bBxXF8+kzNE+XYnMB2g9FmjLWw=; b=i7b/qo/q1Zhxn6y6Y1im+Cscq
        hcRsrn67T1SpzauEcpVLwpmiXbkzAQi4QRhFEGmtbEksOYVoLaSsgYkZSxMx/rL0Sg7o9Pa66obHl
        3Len6PDspLyQcX3+Ol8SFjLCv8eYSCfYnfeNfOwHy/ADn7aOm0XEVLmXMH0yEMa1GizPhrmYgLGTy
        N7l5feC1ysI2ap8pZ0gjEbdIL+wACkzzRJxTd14DwfcwIvPTXsLay5dg8NstANs/z5/53rqYvnGVN
        JSTS/bmf8idEbv1toaBK3Um8zpPgtlPkAkv5SinBKorOOeVHeWVOBEn9hFjrNsrF8QI4evDAN5vFn
        SiQvPzsTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpUd-0006Wj-SW; Mon, 01 Jul 2019 06:08:47 +0000
Date:   Sun, 30 Jun 2019 23:08:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Chao Yu <yuchao0@huawei.com>, hch@infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gaoxiang25@huawei.com, chao@kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH RFC] iomap: introduce IOMAP_TAIL
Message-ID: <20190701060847.GA24797@infradead.org>
References: <20190629073020.22759-1-yuchao0@huawei.com>
 <20190630231932.GI1404256@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630231932.GI1404256@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 30, 2019 at 04:19:32PM -0700, Darrick J. Wong wrote:
> On Sat, Jun 29, 2019 at 03:30:20PM +0800, Chao Yu wrote:
> > Some filesystems like erofs/reiserfs have the ability to pack tail
> > data into metadata, however iomap framework can only support mapping
> > inline data with IOMAP_INLINE type, it restricts that:
> > - inline data should be locating at page #0.
> > - inline size should equal to .i_size
> 
> Wouldn't it be easier simply to fix the meaning of IOMAP_INLINE so that
> it can be used at something other than offset 0 and length == isize?
> IOWs, make it mean "use the *inline_data pointer to read/write data
> as a direct memory access"?

Yes.  I vaguely remember Andreas pointed out some issues with a
general scheme, which is why we put the limits in.  If that is not just
me making things up we'll need to address them.  Either way just copy
and pasting code isn't very helpful.
