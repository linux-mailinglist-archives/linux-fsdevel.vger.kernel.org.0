Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE04C2AE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiBXLbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 06:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiBXLbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:31:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC5928A113;
        Thu, 24 Feb 2022 03:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75964B82575;
        Thu, 24 Feb 2022 11:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE696C340E9;
        Thu, 24 Feb 2022 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645702235;
        bh=NEiEy8aPQXv4YCvSSvu1CrwZcw8hIl0XdkWsb+8kvdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lzpWsjsxoWJp5qkJ96UqX80NBnU+UC1GaWf56BLmCibrCohLLcjWbwrFK+UFLdIgS
         M3+IVpmCOF1k1d18hfO0Yq0UaOYTv8twIThmyrZyJtS0BaI+IBuZ8GbGCLoCA4Nfky
         uw0HWHltyCjHAtOKREnE0y6956nBervDeobT4ihNlqBT6q1gMuJz1O6ENY8jS1nD30
         C4oS6GqmHNV9tEmM4VTc/rfnlTTnWEqSE78JNNYFLUpVx8tkL5Lpk/To+UfIvaeCaj
         xXDDgEeajWU/EpVj5VTsQF8+WQbltJex+TSRMA276bz7hfF54LMk8fLTqs2VgkV0uj
         ELHbDgvjlTNSA==
Message-ID: <e8ec98a9c4fab9b7aa099001f09ff9b11f0c3f96.camel@kernel.org>
Subject: Re: [PATCH 06/11] ceph: remove reliance on bdi congestion
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Feb 2022 06:30:31 -0500
In-Reply-To: <164568131640.25116.884631856219777713@noble.neil.brown.name>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
        , <164549983739.9187.14895675781408171186.stgit@noble.brown>
        , <ccc81eb5c23f933137c5da8d5050540cc54e58f0.camel@kernel.org>
         <164568131640.25116.884631856219777713@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-02-24 at 16:41 +1100, NeilBrown wrote:
> On Thu, 24 Feb 2022, Jeff Layton wrote:
> > On Tue, 2022-02-22 at 14:17 +1100, NeilBrown wrote:
> > > The bdi congestion tracking in not widely used and will be removed.
> > > 
> > > CEPHfs is one of a small number of filesystems that uses it, setting
> > > just the async (write) congestion flags at what it determines are
> > > appropriate times.
> > > 
> > > The only remaining effect of the async flag is to cause (some)
> > > WB_SYNC_NONE writes to be skipped.
> > > 
> > > So instead of setting the flag, set an internal flag and change:
> > >  - .writepages to do nothing if WB_SYNC_NONE and the flag is set
> > >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> > >     and the flag is set.
> > > 
> > > The writepages change causes a behavioural change in that pageout() can
> > > now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
> > > be called on the page which (I think) wil further delay the next attempt
> > > at writeout.  This might be a good thing.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > 
> > Maybe. I have to wonder whether all of this is really useful.
> > 
> > When things are congested we'll avoid trying to issue new writeback
> > requests. Note that we don't prevent new pages from being dirtied here -
> > - only their being written back.
> > 
> > This also doesn't do anything in the DIO or sync_write cases, so if we
> > lose caps or are doing DIO, we'll just keep churning out "unlimited"
> > writes in those cases anyway.
> 
> I think the point of congestion tracking is to differentiate between
> sync and async IO.  Or maybe "required" and "optional".
> Eventually the "optional" IO will become required, but if we can delay
> it until a time when there is less "required" io, then maybe we can
> improve perceived latency.
> 
> "optional" IO here is write-back and read-ahead.  If the load of
> "required" IO is bursty, and if we can shuffle that optional stuff into
> the quiet periods, we might win.
> 

In that case, maybe we should be counting in-flight reads too and deny
readahead when the count crosses some threshold? It seems a bit silly to
only look at writes when it comes to "congestion".

> Whether this is a real need is an important question that I don't have an
> answer for.  And whether it is better to leave delayed requests in the
> page cache, or in the low-level queue with sync requests able to
> over-take them - I don't know.  If you have multiple low-level queue as
> you say you can with ceph, then lower might be better.
> 
> The block layer has REQ_RAHEAD ..  maybe those request get should get a
> lower priority ... though I don't think they do.
> NFS has a 3 level priority queue, with write-back going at a lower
> priority ... I think... for NFSv3 at least.
> 
> Sometimes I suspect that as all our transports have become faster, we
> have been able to ignore the extra latency caused by poor scheduling of
> optional requests.  But at other times when my recently upgraded desktop
> is struggling to view a web page while compiling a kernel ...  I wonder
> if maybe we don't have the balance right any more.
> 
> So maybe you are right - maybe we can rip all this stuff out.
> 

I lean more toward just removing it. The existing implementation seems a
bit half-baked with the gaps in what's being counted. Granted, the
default congestion threshold is pretty high with modern memory sizes, so
it probably doesn't come into play much in practice, but removing it
would reduce some complexity in the client.

-- 
Jeff Layton <jlayton@kernel.org>
