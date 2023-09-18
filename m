Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0BB7A5210
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjIRScM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIRScK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:32:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E48510E;
        Mon, 18 Sep 2023 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WkxIxcrv5KR63l2iFq63ZYJDZ9UFo77/A7z8e401fPg=; b=RDkff3uhKkYNHYOWdvjzK4sARi
        /3V34pnCl1JdyIgQ7ddhD+CJhlxQ1K/9gCOsGmU9ziFE35fstfG38xFMRSJEeNOSPdWC4QRnKPMvT
        9lVnRsz0KxvBOfAkX+hEoOR22D+1OSeDVeQEQyGTrKaZv7dLcSDR6PJOl+EX6Z2ZpMW5KD3k3WfC3
        yS15ppfiu96aSzbhWBpx+XDjIsgudZmVEEUAxvnjrjf+AkY8srNx0LX/8hO+s10sKs8XI3FvPVU/D
        qbFN0uQcBZnjbkdGWSpaR4TCnVX6OgsFb6lx7bP2dZ6vqaKqHarqhJrfzPyWLdKvCiFRS6zFyrzz4
        m71zt2wQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiJ2R-00G5VN-2g;
        Mon, 18 Sep 2023 18:32:03 +0000
Date:   Mon, 18 Sep 2023 11:32:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com
Subject: Re: [RFC 07/23] filemap: align the index to mapping_min_order in
 __filemap_add_folio()
Message-ID: <ZQiXo3WcBJ6xEZLA@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-8-kernel@pankajraghav.com>
 <ZQS1GyfwqJXstRQA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQS1GyfwqJXstRQA@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:48:43PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:32PM +0200, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Align the index to the mapping_min_order number of pages while setting
> > the XA_STATE and xas_set_order().
> 
> Not sure why this one's necessary either.  The index should already be
> aligned to folio_order.

Oh, it was not obvious, would a VM_BUG_ON_FOLIO() be OK then?

> Some bits of it are clearly needed, like checking that folio_order() >=
> min_order.

Thanks,

  Luis
