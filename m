Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4D77A4CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 05:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHMDJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 23:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHMDJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 23:09:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175E10FB;
        Sat, 12 Aug 2023 20:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BEzokEGDV8Z/KhPlVETBC4Xu08qiNAIU3oQjqwzGpSo=; b=CPH0By8KvU3QAQSOoC5aoHHBao
        +atYp8bN33Y1sXIIu6UxrMr4Vz9LCJeWwKGRBwRQrJwrHOGe2fyDiIs6HCFwz34qN01EP1gOHLnwv
        Y9MzZzm6MbYvg3+KumE2ROSB1CT19chq7afRjgpyHL9xLAkVYKYedLeIUPsAg4XcKnmM/z51bgRsh
        CguhIdziP4UdNH40BUq1es42KhEazO2fU7jGzyf0XihcTp/YcUhetwz1lC0Hiv180ctWe3NZtqETz
        HQXGWBBZgESQsTvufIIL3JZ35BqNhVXVOhQZQjDWUpJHkj+h0YfnIVowf2VCplRyQbAGfDaIV0Y+G
        5zvxXrEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qV1TO-00B6TH-Lq; Sun, 13 Aug 2023 03:08:58 +0000
Date:   Sun, 13 Aug 2023 04:08:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jaegeuk@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 01/10] fs: Expose helper to check if a directory needs
 casefolding
Message-ID: <ZNhJSlaLEExcoIiT@casper.infradead.org>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-2-krisman@suse.de>
 <20230812015915.GA971@sol.localdomain>
 <20230812230647.GB2247938@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812230647.GB2247938@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 07:06:47PM -0400, Theodore Ts'o wrote:
> One could say that this is an insane threat model, but the syzbot team
> thinks that this can be used to break out of a kernel lockdown after a
> UEFI secure boot.  Which is fine, except I don't think I've been able
> to get any company (including Google) to pay for headcount to fix
> problems like this, and the unremitting stream of these sorts of
> syzbot reports have already caused one major file system developer to
> burn out and step down.
> 
> So problems like this get fixed on my own time, and when I have some
> free time.  And if we "simplify" the code, it will inevitably cause
> more syzbot reports, which I will then have to ignore, and the syzbot
> team will write more "kernel security disaster" slide deck
> presentations to senior VP's, although I'll note this has never
> resulted in my getting any additional SWE's to help me fix the
> problem...
> 
> > So just __ext4_iget() needs to be fixed.  I think we should consider doing that
> > before further entrenching all the extra ->s_encoding checks.
> 
> If we can get an upstream kernel consensus that syzbot reports caused
> by writing to a mounted file system aren't important, and we can
> publish this somewhere where hopefully the syzbot team will pay
> attention to it, sure...

What the syzbot team don't seem to understand is that more bug reports
aren't better.  I used to investigate one most days, but the onslaught is
relentless and I just ignore syzbot reports now.  I appreciate maintainers
don't necessarily get that privilege.

They seem motivated to find new and exciting ways to break the kernel
without realising that they're sapping the will to work on the bugs that
we already have.

Hm.  Maybe this is a topic for kernel-summit?
