Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280CB53FADF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiFGKKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 06:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiFGKJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:09:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AB7EACD7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+WsU+ZKa6obaX2pCKNFArRTTWdjvfrD8iovH97WVf2o=; b=NKsfQI2+Ih4toOJxshL/D3Aato
        ibJLC56oXwESFZM/QwkLtiLKOYrCeYk4Lhv51hb2RqlVDVSbFTYHpRgcoeIYcKEv/WyWwHwCkkFOw
        mSwXhdj2BLTKsawvn9zqphDoKMDk4faC0zJCvCK6tj9r9QG4VJOC6jj4caqdgTxjS74I2jQsSIIrL
        hfFZ4EUPjQsyKQlCUBfyKGBUKuCJ4pUb1czrop3FGsOg0ReZRhn2qC93kaMBplFK7QWy7XYreVrvG
        +SnU+R4fNAHuGNqgZhqJCraRYxg5RR7N6WJZTUlwJ1Lgp1KLh4ZAYBmf/3w2Lx61LLoaqEFnV4c6o
        iB8BcsAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyW9f-006XFY-Ky; Tue, 07 Jun 2022 10:09:43 +0000
Date:   Tue, 7 Jun 2022 03:09:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 3/3] zonefs: fix zonefs_iomap_begin() for reads
Message-ID: <Yp8j53irZalw6mlH@infradead.org>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-4-damien.lemoal@opensource.wdc.com>
 <Yp7rox7SRvKcsZPT@infradead.org>
 <48ea1d34-6992-f85d-c763-d817cd32cca4@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ea1d34-6992-f85d-c763-d817cd32cca4@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:53:35PM +0900, Damien Le Moal wrote:
> >> +	else if (offset < isize)
> >>  		length = min(length, isize - offset);
> > 
> > So you still report an IOMAP_UNWRITTEN extent for the whole size of
> > the requst past EOF?  Looking at XFS we do return the whole requested
> > length, but do return it as HOLE.  Maybe we need to clarify the behavior
> > here and document it.
> 
> Yes, I checked xfs and saw that. But in zonefs case, since the file blocks are
> always preallocated, blocks after the write pointer are indeed UNWRITTEN. I did
> check that iomap read processing treats UNWRITTEN and HOLE similarly, that is,
> ignore the value of length and stop issuing IOs when either type is seen. But I
> may have missed something.
> 
> Note that initially I wrote the patch below to fix the problem. But it is very
> large and should probably be a cleanup for the next cycle. It separates the
> begin op for read and write, which makes things easier to understand.

I much prefer this more extensive fix.
