Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240E85B5A95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 14:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiILMyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiILMyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:54:31 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64378293;
        Mon, 12 Sep 2022 05:54:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 85BBA1C5A; Mon, 12 Sep 2022 08:54:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 85BBA1C5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662987265;
        bh=+dP3CR0pJn+xvcRB32nVYSOBikrkL0fn9mnZyLj/yc0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=hizOueM/RZjFn7wviO3QMF+H+5/tUroul/3qkSgJtfDWZ/gLtRrlb1lbMAac/IMTN
         rqt1OH17KGAuARU8FNY6cCqBGD2s6LBJRuqXcfipxarMAu5N5xlQ2aVfFz/lJbD2lM
         n31oWdToPxRhD+7ks53TSa4bF7zorfGDC9jm1K9o=
Date:   Mon, 12 Sep 2022 08:54:25 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
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
Message-ID: <20220912125425.GA9304@fieldses.org>
References: <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
 <20220910145600.GA347@fieldses.org>
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
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

On Mon, Sep 12, 2022 at 07:42:16AM -0400, Jeff Layton wrote:
> A scheme like that could work. It might be hard to do it without a
> spinlock or something, but maybe that's ok. Thinking more about how we'd
> implement this in the underlying filesystems:
> 
> To do this we'd need 2 64-bit fields in the on-disk and in-memory 
> superblocks for ext4, xfs and btrfs. On the first mount after a crash,
> the filesystem would need to bump s_version_max by the significant
> increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
> to do that.
> 
> Would there be a way to ensure that the new s_version_max value has made
> it to disk? Bumping it by a large value and hoping for the best might be
> ok for most cases, but there are always outliers, so it might be
> worthwhile to make an i_version increment wait on that if necessary. 

I was imagining that when you recognize you're getting close, you kick
off something which writes s_version_max+2^40 to disk, and then updates
s_version_max to that new value on success of the write.

The code that increments i_version checks to make sure it wouldn't
exceed s_version_max.  If it would, something has gone wrong--a write
has failed or taken a long time--so it waits or errors out or something,
depending on desired filesystem behavior in that case.

No locking required in the normal case?

--b.
