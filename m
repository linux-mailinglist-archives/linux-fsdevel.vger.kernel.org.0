Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E153C72424E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbjFFMhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 08:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFFMhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:37:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144ECE5D;
        Tue,  6 Jun 2023 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ouy6gnlWNylx76NAF9LYqXxycIJBo6Aw1VmTuVi2jVg=; b=GGl4/YUrWzbs3Tiv2Zs5rHdFd2
        c2ef9UfFQtGXGSzmkIi8xJijXKxBMnMdkT43PQ6zy94P6p8f44xP0Fx+8KkZpZ7b9eRpnQPMWV/OM
        XQleRzcGYfBUb4HtaVU9JhFrg3W9pe9QEN9KP2bmARZEdHN4IK1juMh+Jw5FHMPQo/pTpKhu31Yhp
        kY6eyNbB/XHF8kl13Oi5BAwAHJTfr7D6mKstxIYJHcnzItp+fny8MqLgLL1QQm+Bp8UVNHGIWYcUu
        IEw8UNqjT5cf29ypiJDPFIdMebHC1W4kKvlvajMoP6q8WsHSqklsKIeOgaXiR2wEunb4eZeb4gf04
        ufZq3oEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Vwa-00D8oT-8b; Tue, 06 Jun 2023 12:37:48 +0000
Date:   Tue, 6 Jun 2023 13:37:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv8 0/5] iomap: Add support for per-block dirty state to
 improve write performance
Message-ID: <ZH8onIAH8xcrWKE+@casper.infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686050333.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:13:47PM +0530, Ritesh Harjani (IBM) wrote:
> Hello All,
> 
> Please find PATCHv8 which adds per-block dirty tracking to iomap.
> As discussed earlier this is required to improve write performance and reduce
> write amplification for cases where either blocksize is less than pagesize (such
> as Power platform with 64k pagesize) or when we have a large folio (such as xfs
> which currently supports large folio).

You're moving too fast.  Please, allow at least a few hours between
getting review comments and sending a new version.

> v7 -> v8
> ==========
> 1. Renamed iomap_page -> iomap_folio & iop -> iof in Patch-1 itself.

I don't think iomap_folio is the right name.  Indeed, I did not believe
that iomap_page was the right name.  As I said on #xfs recently ...

<willy> i'm still not crazy about iomap_page as the name of that
   data structure.  and calling the variable 'iop' just seems doomed
   to be trouble.  how do people feel about either iomap_block_state or
   folio_block_state ... or even just calling it block_state since it's
   local to iomap/buffered-io.c
<willy> we'd then call the variable either ibs or fbs, both of which
   have some collisions in the kernel, but none in filesystems
<dchinner> willy - sounds reasonable

