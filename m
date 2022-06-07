Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448A54028C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbiFGPeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 11:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344221AbiFGPeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:34:09 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF464C50AC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mjtQ0zwo1EXIFg/4iIQFnmSTidJQnindZd3Hks1pTtM=; b=U9cfQdtFk71bFP7u2d6DpmZSde
        EgTGwn5AnK/VC6jSUuE8+kipdNX3nTGwZw5C6yuGiPJleLZNvVFjQzd75yid7wDgDKXXBg1wEUVdA
        gexa4asOCweF8ED26CqUyok80NvmP0xLg68BpqsarkAthWAwyZidy9SAdH6rb0SMinNOJThnNcep6
        eAfrB9+wefqj+vdUhq20kdTSfLNZRx8TqVSaFeVwFhuthvFQ5FCq2d1QacxMqYnepjiX/vD2/fwWH
        RZwD8v4XKyxXi+YCROkdk6GTd2pQExfkouV/0/cYmhRSrbSgdVZnFaKezgDxz9E3goPTjhuUaOqQ1
        298pNUYg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nybDZ-004m4l-Dd; Tue, 07 Jun 2022 15:34:05 +0000
Date:   Tue, 7 Jun 2022 15:34:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 4/9] iocb: delay evaluation of IS_SYNC(...) until we want
 to check IOCB_DSYNC
Message-ID: <Yp9v7ZXJCLoceaTw@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7P2htu+wZsZ7mc@zeniv-ca.linux.org.uk>
 <20220607103450.qmkgtt2brbzvx4fu@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607103450.qmkgtt2brbzvx4fu@quack3.lan>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:34:50PM +0200, Jan Kara wrote:
> On Tue 07-06-22 04:11:06, Al Viro wrote:
> > New helper to be used instead of direct checks for IOCB_DSYNC:
> > iocb_is_dsync(iocb).  Checks converted, which allows to avoid
> > the IS_SYNC(iocb->ki_filp->f_mapping->host) part (4 cache lines)
> > from iocb_flags() - it's checked in iocb_is_dsync() instead
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Does it really matter that much when we have io_is_direct() just two lines
> above which does: IS_DAX(filp->f_mapping->host)?
> 
> Also presumably even if we got rid of the IS_DAX check, we'll need to do
> file->f_mapping->host traversal sooner rather than later anyway so it is
> not clear to me how much it helps performance to defer this traversal to a
> bit later.

... which would be out of the part of codepath that is shared with e.g.
reads and writes on pipes.

> Finally it seems a bit error prone to be checking some IOCB_ flags directly
> while IOCB_DSYNC needs to be checked with iocb_is_dsync() instead. I think
> we'll grow some place mistakenly checking IOCB_DSYNC sooner rather than
> later. So maybe at least rename IOCB_DSYNC to __IOCB_DSYNC to make it more
> obvious in the name that something unusual is going on?

That might make sense...
