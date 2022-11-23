Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256563687A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 19:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiKWSOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 13:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiKWSNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:13:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1997C4977
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 10:09:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56F56B81FE3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 18:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3390C433D6;
        Wed, 23 Nov 2022 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669226954;
        bh=KBd8fI267T1vn3nZ76sXvQiHkudcuy2Zb8Yj692gH+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLKFpFVky1a8HUSn0L45un7ecWdPMISAWZCPzAV4luxrhPF0sls8Dic+lIbVffPjf
         mHf9m6kZQy8ZPnqMRVsnULiqBGUvB55E224KRxC5GPbYolChrOj5QfikPhOu1/Xlee
         XRuYY2yOdG9NAMg4wSAA33LfW10c4EcbZtYqYufGlD6FCfPbtC3BDzyDs5yWMue9ES
         mutzYpLKYvPA4sujAQytdD5S5cpdmDuCO0h7e51kftejDx/5pZa1aZO+g0tMSkwa04
         yV/BlyssyFtbyjzm8ltXctLYYOSUkb7aPLGxTyFL6tF13a4dbjMQ9Y2yE+BxnR+/Uz
         W3mPgPJmFhx1g==
Date:   Wed, 23 Nov 2022 10:09:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <Y35hyS+QvTmC9a4W@magnolia>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <Y3u54l2CVapQmK/w@magnolia>
 <Y3zHn4egPhwMRcDE@infradead.org>
 <20221122142117.epplqsm4ngwx5eyy@fedora>
 <Y33SqRyAGTXVFBIF@infradead.org>
 <20221123083615.sj26ptongwhk6wcl@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123083615.sj26ptongwhk6wcl@fedora>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:36:15AM +0100, Lukas Czerner wrote:
> On Tue, Nov 22, 2022 at 11:58:33PM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 22, 2022 at 03:21:17PM +0100, Lukas Czerner wrote:
> > > > That seems like a good idea for memory usage, but I think this might
> > > > also make the code much simpler, as that just requires fairly trivial
> > > > quota_read and quota_write methods in the shmem code instead of new
> > > > support for an in-memory quota file.
> > > 
> > > You mean like the implementation in the v1 ?
> > 
> > Having now found it: yes.
> > 
> 
> Jan,
> 
> do you have any argument for this, since it was your suggestion?
> 
> I also think that the implementation is much simpler with in-memory
> dquots because we will avoid all the hassle with creating and
> maintaining quota file in a proper format. It's not just reads and
> writes it's the entire machinery befind it in quota_v2.c and quota_tree.c.
> 
> But it is true that even with only user modified dquots being
> non-reclaimable until unmount it could theoreticaly represent a
> substantial memory consumption. Although I do wonder if this problem
> is even real. How many user/group ids would you expect extremely heavy
> quota user would have the limits set for? 1k, 10k, million, or even
> more? Do you know?

The last time I checked, some of our container schedulers will heap
~1000 containers onto a single host(!!) at a time.  Assuming that a
container with a single container might map ~10 uids from the global
namespace, that's easily 10,000 at a time.  If the container runtime
only reuses global uid namespace when it runs out of namespace (i.e. it
doesn't immediately recycle them) then you could actually get up in the
millions or billions pretty easily.  The dquot counters would drop to
zero so you might still be able to reclaim the old ones, though it
sounds like you'd have to unset any per-dquot limits to get it to do
that.

That said, fsx in fstests will make all sorts of chown/chgrp calls,
which has lead to problems with the XFS quota files reaching their
maximum size (~580M per quota type) and filling up the whole fs.

--D

> -Lukas
> 
