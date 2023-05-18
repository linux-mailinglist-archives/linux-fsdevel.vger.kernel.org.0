Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820B707A35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjERGSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjERGSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 02:18:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A819BD;
        Wed, 17 May 2023 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TgRqJzfRjdhSbNWsQSWlFziGwe8zlARO66NTPhJDOmk=; b=J5hHY9glAWseO82ZSohq3JI15d
        RCQ63bqe2Q2vyKdiojEu9v3ZoE8azx6seERpbrQ9wcE3m0a3qh0WFwM8LGlkCq+VU2QumG3YRleH/
        WPikub0I24ppnEohfpu72KiAycynQh26WrSDBDmvQa3fyLREMQf0S7oIxOhp4VXAtI75QLboo/9eV
        fj91Ob3a6ohkqMGvuy2XwwD7XXDvF9D4P1LmVIssToznR1Ihs64FIoH++tKkOrzlqoRcXP6F/4YoO
        c1VulrC11RgG9gYO+uw9U97zKclPHAisPAVP/pWOzPZXZfeB3yBbwdSVKQS+PC3whef8fRyHls7q6
        hAuei82w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWyJ-00C3Ij-0y;
        Thu, 18 May 2023 06:18:43 +0000
Date:   Wed, 17 May 2023 23:18:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 3/5] iomap: Add iop's uptodate state handling functions
Message-ID: <ZGXDQ4RGslszaIIk@infradead.org>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <5372f29f986052f37b45c368a0eb8eed25eb8fdb.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5372f29f986052f37b45c368a0eb8eed25eb8fdb.1683485700.git.ritesh.list@gmail.com>
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

> + * inline helpers for bitmap operations on iop->state
> + */
> +static inline void iop_set_range(struct iomap_page *iop, unsigned int start_blk,
> +				 unsigned int nr_blks)
> +{
> +	bitmap_set(iop->state, start_blk, nr_blks);
> +}
> +
> +static inline bool iop_test_block(struct iomap_page *iop, unsigned int block)
> +{
> +	return test_bit(block, iop->state);
> +}
> +
> +static inline bool iop_bitmap_full(struct iomap_page *iop,
> +				   unsigned int blks_per_folio)
> +{
> +	return bitmap_full(iop->state, blks_per_folio);
> +}

I don't really see much poin in these helpers, any particular reason
for adding them?

> +/*
> + * iop related helpers for checking uptodate/dirty state of per-block
> + * or range of blocks within a folio
> + */

I'm also not sure this comment adds a whole lot of value.

The rest looks good modulo the WARN_ONs already mentined by Brian.
