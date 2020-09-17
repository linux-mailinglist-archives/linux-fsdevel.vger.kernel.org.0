Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9026E7FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIQWLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIQWLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:11:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9E9C06174A;
        Thu, 17 Sep 2020 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NBI0zralRPp5qM9j83BPA0ZseelW+oOID0UWHD+t4og=; b=KzsKzrQOFiNYuo7747mdvgEu+h
        /y6vK+gWvWW+Ft7JHbX6oHBluLZgw5hQerH8P9qpE/Y0pWNBozHaMRsaYKOw0TJ67J3Zh1sME4d4p
        5/WRc93gotekRCP0pM46FHb02uGNiRx0Y9tkqc5ZeWOxA9yw+PZCodQKjLNOKaHE77RMqHrdlr+uz
        ynmSPRuONtTmTjJyr/29IinJFAPemOrmyQcrxlr2aqSd7jacEC3lEnE3RxYzyKjOAKsci9D5rmyL8
        orTRI92pnQbCYFIWEAhtJoJ74RanEG2V+9wwfLvL1YxG/RmNxRGeQwb+oNeqPYCF2TDIoFZVeeIdp
        /eixEdeg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ27X-00048x-M7; Thu, 17 Sep 2020 22:11:15 +0000
Date:   Thu, 17 Sep 2020 23:11:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200917221115.GY5449@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-10-willy@infradead.org>
 <20200917220500.GR7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917220500.GR7955@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:05:00PM -0700, Darrick J. Wong wrote:
> > -static loff_t
> > -iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> > -		void *data, struct iomap *iomap, struct iomap *srcmap)
> > +static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
> > +		loff_t length, void *data, struct iomap *iomap,
> 
> Any reason not to change @length and the return value to s64?

Because it's an actor, passed to iomap_apply, so its types have to match.
I can change that, but it'll be a separate patch series.
