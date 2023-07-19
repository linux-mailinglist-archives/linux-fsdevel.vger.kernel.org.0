Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5822A758D40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 07:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGSFjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 01:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSFjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:39:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B3D2;
        Tue, 18 Jul 2023 22:39:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81A5367373; Wed, 19 Jul 2023 07:39:01 +0200 (CEST)
Date:   Wed, 19 Jul 2023 07:39:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230719053901.GA3241@lst.de>
References: <20230713130431.4798-1-hch@lst.de> <20230718171744.GA843162@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718171744.GA843162@perftesting>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:17:44PM -0400, Josef Bacik wrote:
> Just FYI I've been using these two series to see how the github CI stuff was
> working, and I keep tripping over a hang in generic/475.  It appears to be in
> the fixup worker, here's the sysrq w output

> 
> We appear to be getting hung up because the ENOSPC stuff is flushing and waiting
> on ordered extents, and then the fixup worker is waiting on trying to reserve
> space.  My hunch is the page that's in the fixup worker is attached to an
> ordered extent.
> 
> I can pretty reliably reproduce this in the CI, so if you have trouble
> reproducing it let me know.  I'll dig into it later today, but I may not get to
> it before you do.  Thanks,

My day was already over by the time you sent this, but I looked into
it the first thing this morning.

I can't reproduce the hang, but my first thought was "why the heck do
even end up in the fixup worker" given that there is no GUP-based
dirtying in the thread.

I can reproduce the test case hitting the fixup worker now, while
I can't on misc-next.  Looking into it now, but the rework of the
fixup logic is a hot candidate.
