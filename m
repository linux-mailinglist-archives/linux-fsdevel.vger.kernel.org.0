Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAE96C142D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCTN7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCTN6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:58:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9807DAC;
        Mon, 20 Mar 2023 06:58:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC1B868AFE; Mon, 20 Mar 2023 14:58:38 +0100 (CET)
Date:   Mon, 20 Mar 2023 14:58:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 4/7] shmem: remove shmem_get_partial_folio
Message-ID: <20230320135838.GA16060@lst.de>
References: <20230307143410.28031-1-hch@lst.de> <20230307143410.28031-5-hch@lst.de> <9d1aaa4-1337-fb81-6f37-74ebc96f9ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1aaa4-1337-fb81-6f37-74ebc96f9ef@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 10:19:21PM -0700, Hugh Dickins wrote:
> I thought this was fine at first, and of course it's good for all the
> usual cases; but not for shmem_get_partial_folio()'s awkward cases.
> 
> Two issues with it.
> 
> One, as you highlight above, the possibility of reading more swap
> unnecessarily.  I do not mind if partial truncation entails reading
> a little unnecessary swap; but I don't like the common case of
> truncation to 0 to entail that; even less eviction; even less
> unmounting, when eviction of all risks reading lots of swap.
> The old code behaved well at i_size 0, the new code not so much.

True.  We could restore that by doing the i_size check for SGP_FIND,
though.

> Replacing shmem_get_partial_folio() by SGP_FIND was a good direction
> to try, but it hasn't worked out.  I tried to get SGPs to work right
> for it before, when shmem_get_partial_page() was introduced; but I
> did not manage to do so.  I think we have to go back to how this was.

Hmm, would be sad to lose this entirely.  One thing I though about
but didn't manage to do, is to rework how the SGP_* flags works.
Right now they are used as en enum, and we actually do numerical
comparisms on them, which is highly confusing.  To be it seems like
having actual flags that can be combined and have useful names
would seem much better.  But I did run out patience for finding good
names and figuring out what would be granular enough behavior
for such flags.

e.g. one would be for limiting to i_size, one for allocating new
folios if none was found, etc.
