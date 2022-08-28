Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936C5A3A96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiH1AMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 20:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiH1AMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86931AD83;
        Sat, 27 Aug 2022 17:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F66160EFF;
        Sun, 28 Aug 2022 00:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E9FC433C1;
        Sun, 28 Aug 2022 00:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661645541;
        bh=pKUoaQ9EcjJggSkeqY7Olvpsm3d5dLwR/wl/BB+U5g8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TMpAOVjbK9E3fz0ooSfvWL268lrlX3TxQoLp4an1G52borowaZOgsBN4HTAMzlSZh
         n/go2Bd+b/Q7boVjtKX7sXTsnaPBkr/ToNRad4gXMu3cYY9wSWwQXUZhWqQKOjm5Zr
         f0vMAg/QZlaEUyt8kktBXmYn5/Sp4RnqSXTXzcwA=
Date:   Sat, 27 Aug 2022 17:12:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] block: add dio_w_*() wrappers for pin, unpin user
 pages
Message-Id: <20220827171220.fa2f21f6b22c6d3047857381@linux-foundation.org>
In-Reply-To: <4c6903d4-0612-5097-0005-4a9420890826@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
        <20220827083607.2345453-3-jhubbard@nvidia.com>
        <20220827152745.3dcd05e98b3a4383af650a72@linux-foundation.org>
        <4c6903d4-0612-5097-0005-4a9420890826@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022 16:59:32 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> Anyway, I'll change my patch locally for now, to this:
> 
> static inline void dio_w_unpin_user_pages(struct page **pages,
> 					  unsigned long npages)
> {
> 	/* Careful, release_pages() uses a smaller integer type for npages: */
> 	if (WARN_ON_ONCE(npages > (unsigned long)INT_MAX))
> 		return;
> 
> 	release_pages(pages, (int)npages);
> }

Well, it might be slower.  release_pages() has a ton of fluff.

As mentioned, the above might be faster if the pages tend
to have page_count()==1??
