Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1507932C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 02:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbjIFAAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 20:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbjIFAAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:00:17 -0400
Received: from out-216.mta1.migadu.com (out-216.mta1.migadu.com [IPv6:2001:41d0:203:375::d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F311B7
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 17:00:13 -0700 (PDT)
Date:   Tue, 5 Sep 2023 20:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693958411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8poP0+BOtpoVUDo/ffAuM+DGPWtHYPwwwl3cE296KF4=;
        b=TwcVHaQ5B4SHn6QILjJegzt3LYRXdqCuY2stDxsG792+AswUiElKKQ5MNx5gXNTmzfxd82
        I36nFVkBpfooBTL6xht6UknTMUaQHi0LGgxY/rsK9Ai3QHXYQPa2zzZvVp3iRcNuu13tbO
        5qXSxuA5fICZY5Lm6oA958AsDFPY4CE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <ZPcsHyWOHGJid82J@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPcsHyWOHGJid82J@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 06:24:47AM -0700, Christoph Hellwig wrote:
> Hi Kent,
> 
> I thought you'd follow Christians proposal to actually work with
> people to try to use common APIs (i.e. to use iomap once it's been
> even more iter-like, for which I'm still waiting for suggestions),
> and make your new APIs used more widely if they are a good idea
> (which also requires explaining them better) and aim for 6.7 once
> that is done.

Christoph, I get that iomap is your pet project and you want to make it
better and see it more widely used.

But the reasons bcachefs doesn't use iomap have been discussed at
length, and I've posted and talked about the bcachefs equivalents of
that code. You were AWOL on those discussions; you consistently say
"bcachefs should use iomap" and then walk away, so those discussions
haven't moved forwards.

To recap, besides being more iterator like (passing data structures
around with iterators, vs. indirect function calls into the filesystem),
bcachefs also hangs a bit more state off the pagecache, due to being
multi device and also using the same data structure for tracking disk
reservations (because why make the buffered write paths look that up
separately?).

> But without that, and without being in linux-next and the VFS maintainer
> ACK required for I think this is a very bad idea.

Christain gave his reviewed-by for the dcache patch. Since this patchset
doesn't change existing code maintained by others aside from that one
patch, not sure how linux-next is relevant here...
