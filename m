Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2333B22785D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 07:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGUFyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGUFyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:54:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB8C061794;
        Mon, 20 Jul 2020 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ccOJ6FB795/vobkJf1yBXfmPbnqPVCWQ8goe4E50Er8=; b=wVPar65BnwEgAoFZ9bzL2bJIk5
        X5fXv4u58GsAdmT/QnTNClTUTH+LBXMT0F628t0QcobAh0RwlOkTLDnpJzrFLPhi+0SZK7b0axHJM
        bnoK7jR84F7sK5JC6v3UNgOnogbUKqDiKe13dPtdaA4IbhhRDNxW2dGX9zfLL2ZXRPsiIKZr+hV9i
        jtPCMQ9vkiRgkc3pbercKsO+El/mS+Rui/Iq2qmrD/fv7dKr6UKWUrKCKNo8rA+0PyCq3VZvcfdt7
        iskd3Ca0G7JQWFwXxto3FjmdaPlxXMhyF0FLUQm+YXsnOzeMDHsBNGeOHUHEjPdPAXeB3xnu7OB9W
        ijNB3C4w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxlEA-0004iC-LT; Tue, 21 Jul 2020 05:54:10 +0000
Date:   Tue, 21 Jul 2020 06:54:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Message-ID: <20200721055410.GA18032@infradead.org>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200720134549.GB3342@lst.de>
 <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:
> On 20/07/2020 15:45, Christoph Hellwig wrote:
> > On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:
> >> On a successful completion, the position the data is written to is
> >> returned via AIO's res2 field to the calling application.
> > 
> > That is a major, and except for this changelog, undocumented ABI
> > change.  We had the whole discussion about reporting append results
> > in a few threads and the issues with that in io_uring.  So let's
> > have that discussion there and don't mix it up with how zonefs
> > writes data.  Without that a lot of the boilerplate code should
> > also go away.
> > 
> 
> OK maybe I didn't remember correctly, but wasn't this all around 
> io_uring and how we'd report the location back for raw block device
> access?

Report the write offset.  The author seems to be hell bent on making
it block device specific, but that is a horrible idea as it is just
as useful for normal file systems (or zonefs).
