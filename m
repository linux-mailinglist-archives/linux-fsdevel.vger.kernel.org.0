Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55302629358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiKOIgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiKOIgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:36:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6AD11172;
        Tue, 15 Nov 2022 00:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ofdUZ4A2AMsG1LdCXFeLxjKXuGYg+2TqZFjoaMm5yLs=; b=mb2FQT5XvPVrs7TxIhRncs2BuL
        ez4+ia7sJIJngCGeb/6mDK46MLr7jLnDQxwE92v7i+WnAq58a66XN5WJikV1Jjcw56RNhHZ4xmE4j
        ZQi6thdcKGJ+FIt6nbox6skEpUj9dvdGCUwLiKYX+FPnww1N3O5tMjV2Bq4zmVvAlGvhQjrRoIa1x
        Xz7CNXUxJvNvmeoTj0s1NuI0/Zms7oiy2hzaGWwvxwHgOsIf+FstuIv5guRCPKYSvTbvsM5bRIQ6l
        JXGF49oIaINVGAXs/lmN8jzkUmsN1ErnjDODPAPArEOgqkUYQvlrTnIbYqbtMUWn7BtmBtadCocQ5
        37hYvqXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourQc-008yPO-CU; Tue, 15 Nov 2022 08:36:22 +0000
Date:   Tue, 15 Nov 2022 00:36:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH 08/14] iomap: pass iter to ->iomap_begin implementations
Message-ID: <Y3NPhkLNX6Y/+96A@infradead.org>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
 <166801778962.3992140.13451716594530581376.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166801778962.3992140.13451716594530581376.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:16:29AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Clean up the ->iomap_begin call sites by passing a pointer to the iter
> structure into the iomap_begin functions.  This will be needed to clean
> up the xfs race condition fixes in the next patch, and will hopefully
> reduce register pressure as well.

So if we go back to the iomap_iter idea from willy it did something
similar, but replaced ->iomap_begin and ->iomap_end with a single
iter callback that basically implemented all of iomap_iter().

Depending on your view point this patch gets us closer to that
or is pointless churn :)

Technicaly the changes look fine to me.
