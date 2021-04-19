Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD6363E7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhDSJaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhDSJaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:30:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47BC06174A;
        Mon, 19 Apr 2021 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aOsr0PrOwnfD3TDOKZ6BC+krPtm53sXeyFnBIAmB5o=; b=dlxuJSx74ojN6u2Cspw4sbyZBO
        9m5osR+tXN1F9D2uMZozBeEkZ4MMcNCOPxCKoUyDXwaLoqiAm7VCtGRfluX5kw/ZtBzbxvpjFJBIV
        /Zof+qyjZPyk3+YUS+VqCwOMpgQNSaWNiBGx69mR7gC73d7qn1DGovpFArIHQp4g+ySK6sHCe/kO2
        c0kem+FjGoDxzpGghmMe6FzIOZqhSZ/5ws/Gr5solihRG7qkAZF3RMNY/NrOey0EljxSkQUMLfdrT
        65Nj+vMd0kqZDmygxvpE5HMY3SAXDAKkvrAq30rnObRAEEaMWzepVl2mvkN7IM1/snzMdSTlt1kI3
        odEbSJGw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYQD9-00DWee-NI; Mon, 19 Apr 2021 09:29:02 +0000
Date:   Mon, 19 Apr 2021 10:28:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Damien Le Moal <damien.lemoal@wdc.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Message-ID: <20210419092855.GA3223318@infradead.org>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416161720.GA7604@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 06:17:21PM +0200, David Sterba wrote:
> On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > For zoned btrfs, zone append is mandatory to write to a sequential write
> > only zone, otherwise parallel writes to the same zone could result in
> > unaligned write errors.
> > 
> > If a zoned block device does not support zone append (e.g. a dm-crypt
> > zoned device using a non-NULL IV cypher), fail to mount.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent
> fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x
> later.

Please don't.  Zone append is a strict requirement for zoned devices,
no need to add cargo cult code like this everywhere.
