Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774727276BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 07:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjFHFd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjFHFdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:33:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F926B8;
        Wed,  7 Jun 2023 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=grZMU2vXur0rOn+uMoQQBAunZFp7Hu66pq0e1HfBFT4=; b=Fwwv8hvFc8HxJHocWW/u6PHhNA
        7bEec/Ojg6PSYVrMS+eSbJF6Ni6xksNTCncf9x/+T0XuMqKeQ8yFEiE9K1lq5BNY9kphDmU0uvnLg
        5uhhQyDFXl56CbZdMdGdX5308T35ftzijUQW1mVoAjYWfYRUdpVXu1LcYsjRb+fcKlrBovKhhfqFM
        pIm5tUGgZByBgt31bSnaVqUzH0WQMrByQttPpGqyhU7FSe8KY5VwyKvOVfI5Wspv8mE6L2FFYp6DC
        ellSPw7/wNzO/QTZ5KhjjDJUzN2kta7BKaQvVaHXYOhG3UJ1zZC69rUrK5fCRTCf31xrCvsAzzkts
        l/5ocKOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q78HQ-0089hC-2i;
        Thu, 08 Jun 2023 05:33:52 +0000
Date:   Wed, 7 Jun 2023 22:33:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv8 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZIFoQIugyQLbQnfj@infradead.org>
References: <ZIAsEkURZHRAcxtP@infradead.org>
 <87o7lri8r4.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7lri8r4.fsf@doe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:07:19PM +0530, Ritesh Harjani wrote:
> I think the only remaining piece is the naming of this enum and struct
> iomap_page.
> 
> Ok, so here is what I think my preference would be -
> 
> This enum perfectly qualifies for "iomap_block_state" as it holds the
> state of per-block.
> Then the struct iomap_page (iop) should be renamed to struct
> "iomap_folio_state" (ifs), because that holds the state information of all the
> blocks within a folio.

Fine with me.

> > 	if (!iof)
> > 		return NULL;
> >
> > here and unindent the rest.
> 
> Sure. Is it ok to fold this change in the same patch, right?
> Or does it qualify for a seperate patch?

Either way is fine with me.
