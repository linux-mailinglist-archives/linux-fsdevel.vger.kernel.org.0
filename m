Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E936E70A5C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 07:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjETFw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 01:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjETFw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 01:52:58 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8502418C
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 22:52:57 -0700 (PDT)
Date:   Sat, 20 May 2023 01:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684561975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfOMCDO+EpRcce+Y4fCgA+EpfItFwpyan/mWDxkdEYM=;
        b=DUhavanyxeEQh7S9NTewgrT1L3zfybzlnHNbBSEOS/ABVyFaKwC1oOAF/twoAVoC+F0NCp
        ysKIs8YCQ2e00ythSeGADQjy9yl5qShN8KW5uS3tuX3hMMu0TPXaSeeoTNl16xOW2lliSd
        sl7iTb7QuUAiRxL3URwO7jI8rl0SHZE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <ZGhgMnx6W4272Jiv@moria.home.lan>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-30-dhowells@redhat.com>
 <ZGghr0/lFRKmaoAX@moria.home.lan>
 <ZGhFCCBdlSWWcG1G@infradead.org>
 <ZGhI/V573cMDhII5@moria.home.lan>
 <ZGhJ526fahFHi4WA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGhJ526fahFHi4WA@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 09:17:43PM -0700, Christoph Hellwig wrote:
> On Sat, May 20, 2023 at 12:13:49AM -0400, Kent Overstreet wrote:
> > I suppose this way setting it can be done in bio_iov_iter_get_pages() -
> > ok yeah, that makes sense.
> > 
> > But it seems like it should be set in bio_iov_iter_get_pages() though,
> > and I'm not seeing that?
> 
> It is set in bio_iov_iter_get_pages in this patch.  The later gets
> replaced with the pinned flag when we bio_iov_iter_get_pages is
> changed to pin pages instead.

Whoops, missed it.

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
