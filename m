Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB65B5B9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiILNve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILNvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:51:32 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C334183B5;
        Mon, 12 Sep 2022 06:51:32 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 823D96033; Mon, 12 Sep 2022 09:51:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 823D96033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662990691;
        bh=BCcOHKvxAW1IzfNYZs7R5fcMpz0xyKVDSP5+bCNB2vY=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=BNivq+2dffYxGwFrbIbzNTMDyqxbKJBuwJ19P++KVeq84Zmv4FAGo+4AqY/2H5tBR
         zQQsDppJzaNDjrg6QGdsJ/T4xX4EyK7b/b6uGm9Z0aIvcMsO6amE/CIiqSaxGxLuso
         DbeTGFEV6tEVIqhhEH6eBM3dKpln+kjwpt1atzn8=
Date:   Mon, 12 Sep 2022 09:51:31 -0400
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
Message-ID: <20220912135131.GC9304@fieldses.org>
References: <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
 <20220910145600.GA347@fieldses.org>
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
 <87a67423la.fsf@oldenburg.str.redhat.com>
 <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c71050e139a479e08ab7cf95e9e47da19a30687.camel@kernel.org>
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

On Mon, Sep 12, 2022 at 08:55:04AM -0400, Jeff Layton wrote:
> Because of the "seen" flag, we have a 63 bit counter to play with. Could
> we use a similar scheme to the one we use to handle when "jiffies"
> wraps? Assume that we'd never compare two values that were more than
> 2^62 apart? We could add i_version_before/i_version_after macros to make
> it simple to handle this.

As far as I recall the protocol just assumes it can never wrap.  I guess
you could add a new change_attr_type that works the way you describe.
But without some new protocol clients aren't going to know what to do
with a change attribute that wraps.

I think this just needs to be designed so that wrapping is impossible in
any realistic scenario.  I feel like that's doable?

If we feel we have to catch that case, the only 100% correct behavior
would probably be to make the filesystem readonly.

--b.
