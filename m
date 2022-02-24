Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9D4C23AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiBXFmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiBXFmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:42:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF7B0D34;
        Wed, 23 Feb 2022 21:42:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBB951F3A1;
        Thu, 24 Feb 2022 05:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645681327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKmtUS8Iww56ZG9AedqwAoOu6e9VunJUN5pEfmlFqFg=;
        b=oacCq8DpEx+HDVYUG2DsF2wuspiuS5qhOaHg1qyYd+T9C2DteAD78mmee61D0FUkZI1YLt
        89gaqCC57biyg1VI4eWpjZIyZz5bUCc+qIzPagHkvNRbHUbMXkbpK1X9DZdFRD07Aas5HD
        lAXZBPvJQXlq+oS7kaTZ3tDK1PH657o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645681327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKmtUS8Iww56ZG9AedqwAoOu6e9VunJUN5pEfmlFqFg=;
        b=MEMewd7NbYPArVPBoXiNu4N+Gd4+gUbLnYQ+eJp9sW2uduqkIYyCem3t9SIAJPZbOtxf7E
        cjDOc2g76XCgQcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFB7B13322;
        Thu, 24 Feb 2022 05:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id spy1IqgaF2JJDwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 24 Feb 2022 05:42:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Jan Kara" <jack@suse.cz>, "Wu Fengguang" <fengguang.wu@intel.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Philipp Reisner" <philipp.reisner@linbit.com>,
        "Lars Ellenberg" <lars.ellenberg@linbit.com>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Jens Axboe" <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] ceph: remove reliance on bdi congestion
In-reply-to: <ccc81eb5c23f933137c5da8d5050540cc54e58f0.camel@kernel.org>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>,
 <164549983739.9187.14895675781408171186.stgit@noble.brown>,
 <ccc81eb5c23f933137c5da8d5050540cc54e58f0.camel@kernel.org>
Date:   Thu, 24 Feb 2022 16:41:56 +1100
Message-id: <164568131640.25116.884631856219777713@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Feb 2022, Jeff Layton wrote:
> On Tue, 2022-02-22 at 14:17 +1100, NeilBrown wrote:
> > The bdi congestion tracking in not widely used and will be removed.
> > 
> > CEPHfs is one of a small number of filesystems that uses it, setting
> > just the async (write) congestion flags at what it determines are
> > appropriate times.
> > 
> > The only remaining effect of the async flag is to cause (some)
> > WB_SYNC_NONE writes to be skipped.
> > 
> > So instead of setting the flag, set an internal flag and change:
> >  - .writepages to do nothing if WB_SYNC_NONE and the flag is set
> >  - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
> >     and the flag is set.
> > 
> > The writepages change causes a behavioural change in that pageout() can
> > now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
> > be called on the page which (I think) wil further delay the next attempt
> > at writeout.  This might be a good thing.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Maybe. I have to wonder whether all of this is really useful.
> 
> When things are congested we'll avoid trying to issue new writeback
> requests. Note that we don't prevent new pages from being dirtied here -
> - only their being written back.
> 
> This also doesn't do anything in the DIO or sync_write cases, so if we
> lose caps or are doing DIO, we'll just keep churning out "unlimited"
> writes in those cases anyway.

I think the point of congestion tracking is to differentiate between
sync and async IO.  Or maybe "required" and "optional".
Eventually the "optional" IO will become required, but if we can delay
it until a time when there is less "required" io, then maybe we can
improve perceived latency.

"optional" IO here is write-back and read-ahead.  If the load of
"required" IO is bursty, and if we can shuffle that optional stuff into
the quiet periods, we might win.

Whether this is a real need is an important question that I don't have an
answer for.  And whether it is better to leave delayed requests in the
page cache, or in the low-level queue with sync requests able to
over-take them - I don't know.  If you have multiple low-level queue as
you say you can with ceph, then lower might be better.

The block layer has REQ_RAHEAD ..  maybe those request get should get a
lower priority ... though I don't think they do.
NFS has a 3 level priority queue, with write-back going at a lower
priority ... I think... for NFSv3 at least.

Sometimes I suspect that as all our transports have become faster, we
have been able to ignore the extra latency caused by poor scheduling of
optional requests.  But at other times when my recently upgraded desktop
is struggling to view a web page while compiling a kernel ...  I wonder
if maybe we don't have the balance right any more.

So maybe you are right - maybe we can rip all this stuff out.

Or maybe not.

Thanks,
NeilBrown
