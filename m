Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398C69C553
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 07:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBTGWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 01:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBTGWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:22:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF2A19A;
        Sun, 19 Feb 2023 22:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PjGqOFkewjC0CZ1yTAotKtr4Ls11ZNfjfPyNmwANIWE=; b=B74PeRAgkSYp72j3zhP9mpm+Tl
        eJwnw7yA7CtIjA+j631FOPk18TdB1eoO8LzO4bw4a2s+2rc2OUmjTR52Khy8bGpIGRm2Ik5753ANn
        gZvwwZ86tqhw2amv5rZX3o5clmQ9AiYuoXR+7XKsZ+tRoxPvxzOvKTDW/SnVTagKbZ4l0UUMzPa3s
        rhp1/YsD4BUBtkwQUQAtRE1ZyA0ywydj9K3K8vYg9/eCCzmVHVSQmbJ+qb9VOj8QOhqkY3fplv8mO
        X5Nt6Soj32REW4NDdnRo2PgQutt6XXnSjp0y5PIzOJg0LQdyyyXMa/95sSiGYklywNMWUyU42Fe2w
        e4guHmVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTzZI-0038Qy-M0; Mon, 20 Feb 2023 06:22:32 +0000
Date:   Sun, 19 Feb 2023 22:22:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <Y/MRqLbA2g7I0xgp@infradead.org>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
 <20230215045952.GF2825702@dread.disaster.area>
 <Y+x6oQkLex8PbfgL@infradead.org>
 <20230216123316.vkmtucazg33vidzg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216123316.vkmtucazg33vidzg@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:33:16PM +0100, Jan Kara wrote:
> I'm a bit skeptical we can reasonably assess that (as much as I would love
> to just not write these pages and be done with it) because a lot of
> FOLL_LONGTERM users just pin passed userspace address range, then allow
> userspace to manipulate it with other operations, and finally unpin it with
> another call. Who knows whether shared pagecache pages are passed in and
> what userspace is doing with them while they are pinned? 

True.

So what other sensible thing could we do at a higher level?

Treat MAP_SHARED buffers that are long term registered as MAP_PRIVATE
while registered, and just do writeback using in-kernel O_DIRECT on
fsync?
