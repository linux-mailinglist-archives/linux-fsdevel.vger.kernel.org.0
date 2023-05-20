Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9909C70A535
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjETEOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 00:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjETEN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 00:13:59 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0E1BD
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 21:13:56 -0700 (PDT)
Date:   Sat, 20 May 2023 00:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684556034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SqsoafzfPV4IjLE2ZLifRoMd5Uqk59FpqAOq5GWnoQM=;
        b=e83hTXYMTjZ/kGkbHdu7QBK20JnL+nV9RtMDsHlg28URjNMcntI70K8uqwcw5eQ3Ld1ydi
        TB7rGni/vKo4lvCEPpV1/beRn7aqjBmnhfTv2E1LfUAP2+rEvrxOgoC/2VlqaZzFM9Ml79
        vcAh3oHBldDEBGbnW9lVw2yfE5x2be8=
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
Message-ID: <ZGhI/V573cMDhII5@moria.home.lan>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-30-dhowells@redhat.com>
 <ZGghr0/lFRKmaoAX@moria.home.lan>
 <ZGhFCCBdlSWWcG1G@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGhFCCBdlSWWcG1G@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:56:56PM -0700, Christoph Hellwig wrote:
> On Fri, May 19, 2023 at 09:26:07PM -0400, Kent Overstreet wrote:
> > On Fri, May 19, 2023 at 08:40:44AM +0100, David Howells wrote:
> > > From: Christoph Hellwig <hch@lst.de>
> > > 
> > > Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> > > meaning is only set when a page reference has been acquired that needs to
> > > be released by bio_release_pages().
> > 
> > What was the motivation for this patch?
> 
> So that is only is set when we need to release a page, instead telling
> code to not release it when it otherwise would, where otherwise would
> is implicit and undocumented and changes in this series.

I suppose this way setting it can be done in bio_iov_iter_get_pages() -
ok yeah, that makes sense.

But it seems like it should be set in bio_iov_iter_get_pages() though,
and I'm not seeing that?
