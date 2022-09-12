Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02605B5C98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 16:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiILOrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiILOrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:47:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424223BC1;
        Mon, 12 Sep 2022 07:47:31 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CFBAA1C5A; Mon, 12 Sep 2022 10:47:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CFBAA1C5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662994050;
        bh=KrCKV+nSm550BbWCcA/q//1uO/LeSXqDHyHCbzO1WJk=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Dfx5+C/kD+osKxTq13Gb2GCFlVdcialgctzJi05n2pAIbusLp1G06ffaXC3Eac1yY
         H7CWy0N5muuBjXNSIiooqAQzv7jet1zI4xWjxBmZys9o1JABAQIakYevKUN79sli9L
         81iLAHBR1MuyfGYXr065a8FUKIoL1YQtZ2Xs+16o=
Date:   Mon, 12 Sep 2022 10:47:30 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220912144730.GD9304@fieldses.org>
References: <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
 <20220910145600.GA347@fieldses.org>
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
 <87a67423la.fsf@oldenburg.str.redhat.com>
 <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
 <20220912135131.GC9304@fieldses.org>
 <1abae98579030d437224ae24f73fffaabb3f64c1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1abae98579030d437224ae24f73fffaabb3f64c1.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:02:27AM -0400, Jeff Layton wrote:
> On Mon, 2022-09-12 at 09:51 -0400, J. Bruce Fields wrote:
> > On Mon, Sep 12, 2022 at 08:55:04AM -0400, Jeff Layton wrote:
> > > Because of the "seen" flag, we have a 63 bit counter to play with. Could
> > > we use a similar scheme to the one we use to handle when "jiffies"
> > > wraps? Assume that we'd never compare two values that were more than
> > > 2^62 apart? We could add i_version_before/i_version_after macros to make
> > > it simple to handle this.
> > 
> > As far as I recall the protocol just assumes it can never wrap.  I guess
> > you could add a new change_attr_type that works the way you describe.
> > But without some new protocol clients aren't going to know what to do
> > with a change attribute that wraps.
> > 
> 
> Right, I think that's the case now, and with contemporary hardware that
> shouldn't ever happen, but in 10 years when we're looking at femtosecond
> latencies, could this be different? I don't know.

That doesn't sound likely.  We probably need not just 2^63 writes to a
single file, but a dependent sequence of 2^63 interspersed writes and
change attribute reads.

Then there's the question of how many crashes and remounts are possible
for a single filesystem in the worst case.

> 
> > I think this just needs to be designed so that wrapping is impossible in
> > any realistic scenario.  I feel like that's doable?
> > 
> > If we feel we have to catch that case, the only 100% correct behavior
> > would probably be to make the filesystem readonly.
> 
> What would be the recourse at that point? Rebuild the fs from scratch, I
> guess?

I guess.

--b.
