Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998F7254D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjFGGy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 02:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbjFGGyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:54:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC01BF1;
        Tue,  6 Jun 2023 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zb4XsuYrDK3rGsxvTHJ+p/fFFNShynQWN+DaAQYkHlg=; b=DblJwRPKNX62gpoUi1KHr3e5Np
        UWBn02Xy7ekBvWQyzbXjA0uS4rUxWXbSP1AWXTnaG2rMm6hSzukeVf+w9/f5ZkuJWKpCjb/ux2O6L
        AmNmTCC1CujlZQ0seALcU1ftceyUr1kVeCsqz9ihrJq9XKK41c8VHBRm8d10K/D6Oou6W/7zisONr
        uXqTxuBCoDi5659XeeRe/s1K9O1FjGuyX2TwGRqlbEyKqxu5tz7TAkPWPilz5I5yxE/GER88kiuCZ
        1QwyFJGGbB2K4NZ9G7tANS9TegfzLD9lIZQ5Bna1fETjyfjdL//TrTytnQnMcy2UVyR+C4LEJWued
        KhNZKZsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6n3g-004dEw-0Y;
        Wed, 07 Jun 2023 06:54:16 +0000
Date:   Tue, 6 Jun 2023 23:54:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 0/5] iomap: Add support for per-block dirty state to
 improve write performance
Message-ID: <ZIApmPnosZuiJzc4@infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <ZH8onIAH8xcrWKE+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8onIAH8xcrWKE+@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:37:48PM +0100, Matthew Wilcox wrote:
> > 1. Renamed iomap_page -> iomap_folio & iop -> iof in Patch-1 itself.
> 
> I don't think iomap_folio is the right name.  Indeed, I did not believe
> that iomap_page was the right name.  As I said on #xfs recently ...
> 
> <willy> i'm still not crazy about iomap_page as the name of that
>    data structure.  and calling the variable 'iop' just seems doomed
>    to be trouble.  how do people feel about either iomap_block_state or
>    folio_block_state ... or even just calling it block_state since it's
>    local to iomap/buffered-io.c
> <willy> we'd then call the variable either ibs or fbs, both of which
>    have some collisions in the kernel, but none in filesystems
> <dchinner> willy - sounds reasonable

I'd keep an iomap prefix, but block_state looks fine to me.  So
iomap_block_state would be my preference.

