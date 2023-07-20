Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2475A533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 06:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGTEse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 00:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGTEsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:48:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B191FD2;
        Wed, 19 Jul 2023 21:48:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17D4667373; Thu, 20 Jul 2023 06:48:28 +0200 (CEST)
Date:   Thu, 20 Jul 2023 06:48:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: small writeback fixes
Message-ID: <20230720044827.GA1689@lst.de>
References: <20230713130431.4798-1-hch@lst.de> <20230718171744.GA843162@perftesting> <20230719053901.GA3241@lst.de> <20230719115010.GA15617@lst.de> <20230719214255.GA994357@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719214255.GA994357@perftesting>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:42:55PM -0400, Josef Bacik wrote:
> More investigation, what's happening is dmsetup suspend is stuck because it's
> waiting for outstanding io to finish, so these other IO's are stuck in the
> deffered list for the linear mapping.  I'm still getting to why the outstanding
> IO's aren't going, I'll figure that out in the morning, but seems like this may
> not be a btrfs problem.  Thanks,

I tried to bisect it based on my earlier observation that 6.5-rc2 wasn't
affect, but at that point could not reproduce the hang any more.
Overall the conditions seems very non-deterministic and might depend
on the state and thus latency of the SSD or something like that.

Instead of seen a bunch of unmount failures and then busy devices which
clear up with another re-run..
