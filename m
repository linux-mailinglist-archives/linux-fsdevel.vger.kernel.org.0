Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9325B5B73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiILNmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiILNmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:42:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B62DA86;
        Mon, 12 Sep 2022 06:42:09 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8DDA25EE6; Mon, 12 Sep 2022 09:42:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8DDA25EE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662990128;
        bh=DhkDLlXPZR0F9MmGkcf2mIBmolmTb0ndaY4CENQKI54=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ASTwvUlB1d4Z2ipO3/uSMY1JHmP65mxkxMni86jaNxHuS3r5TG3Litu8I8Rj4zSuR
         HI0+ZQJKv75x2rt9KIzGWJGrLVrYu4zfFbUcErSWM8VTVX0MCF+U3uHrsL/gmnuVUX
         v0AX0JZFM6lwA8/WBDffk/aUsTxJl9VoIdUJAcDA=
Date:   Mon, 12 Sep 2022 09:42:08 -0400
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220912134208.GB9304@fieldses.org>
References: <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <166284799157.30452.4308111193560234334@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166284799157.30452.4308111193560234334@noble.neil.brown.name>
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

On Sun, Sep 11, 2022 at 08:13:11AM +1000, NeilBrown wrote:
> On Fri, 09 Sep 2022, Jeff Layton wrote:
> > 
> > The machine crashes and comes back up, and we get a query for i_version
> > and it comes back as X. Fine, it's an old version. Now there is a write.
> > What do we do to ensure that the new value doesn't collide with X+1? 
> 
> (I missed this bit in my earlier reply..)
> 
> How is it "Fine" to see an old version?
> The file could have changed without the version changing.
> And I thought one of the goals of the crash-count was to be able to
> provide a monotonic change id.

I was still mainly thinking about how to provide reliable close-to-open
semantics between NFS clients.  In the case the writer was an NFS
client, it wasn't done writing (or it would have COMMITted), so those
writes will come in and bump the change attribute soon, and as long as
we avoid the small chance of reusing an old change attribute, we're OK,
and I think it'd even still be OK to advertise
CHANGE_TYPE_IS_MONOTONIC_INCR.

If we're trying to do better than that, I'm just not sure what's right.

--b.
