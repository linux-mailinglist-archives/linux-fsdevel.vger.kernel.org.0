Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E83E54AA5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 09:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354007AbiFNHT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353786AbiFNHSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:18:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34353CFE8;
        Tue, 14 Jun 2022 00:18:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3BCCF68AA6; Tue, 14 Jun 2022 09:17:58 +0200 (CEST)
Date:   Tue, 14 Jun 2022 09:17:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] KASAN: use-after-free Read in
 copy_page_from_iter_atomic (2)
Message-ID: <20220614071757.GA1207@lst.de>
References: <0000000000003ce9d105e0db53c8@google.com> <00000000000085068105e112a117@google.com> <20220613193912.GI20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613193912.GI20633@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 09:39:12PM +0200, David Sterba wrote:
> On Fri, Jun 10, 2022 at 12:10:19AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit 4cd4aed63125ccd4efc35162627827491c2a7be7
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Fri May 27 08:43:20 2022 +0000
> > 
> >     btrfs: fold repair_io_failure into btrfs_repair_eb_io_failure
> 
> Josef also reported a crash and found a bug in the patch, now added as
> fixup that'll be in for-next:

The patch looks correct to me.  Two things to note here:

 - I hadn't realized you had queued up the series.  I've actually
   started to merge some of my bio work with the bio split at
   submission time work from Qu and after a few iterations I think
   I would do the repair code a bit differently based on that.
   Can you just drop the series for now?
 - I find it interesting that syzbot hits btrfs metadata repair.
   xfstests seems to have no coverage and I could not come up with
   a good idea how to properly test it.  Does anyone have a good
   idea on how to intentially corrupt metadata in a deterministic
   way?
