Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC95B03C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 14:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIGMUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGMUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:20:37 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCFA99DE;
        Wed,  7 Sep 2022 05:20:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8364D64ED; Wed,  7 Sep 2022 08:20:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8364D64ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662553233;
        bh=jgQ3ypqmMqdg5Rs3VAqVsTbP8IhjO6urX+brsZDA8TA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rxJdxdTkhBfat40mX4wPdgYVSbyda68gU+CGzEzaQoK8SmVOYcVC/yVojO430oi5P
         JKdqLsThDyKjKS9VaIwQzLYqEfVOlScXn8Liu3a1kSRyN6jYrJsHDS3L6FWdzu86Wa
         whb/IMUrDI/XVix/slW1wthwSLfIMXiq1fdkkhOg=
Date:   Wed, 7 Sep 2022 08:20:33 -0400
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220907122033.GA17729@fieldses.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166255065346.30452.6121947305075322036@noble.neil.brown.name>
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

On Wed, Sep 07, 2022 at 09:37:33PM +1000, NeilBrown wrote:
> On Wed, 07 Sep 2022, Jeff Layton wrote:
> > +The change to \fIstatx.stx_ino_version\fP is not atomic with respect to the
> > +other changes in the inode. On a write, for instance, the i_version it usually
> > +incremented before the data is copied into the pagecache. Therefore it is
> > +possible to see a new i_version value while a read still shows the old data.
> 
> Doesn't that make the value useless?  Surely the change number must
> change no sooner than the change itself is visible, otherwise stale data
> could be cached indefinitely.

For the purposes of NFS close-to-open, I guess all we need is for the
change attribute increment to happen sometime between the open and the
close.

But, yes, it'd seem a lot more useful if it was guaranteed to happen
after.  (Or before and after both--extraneous increments aren't a big
problem here.)

--b.

> 
> If currently implementations behave this way, surely they are broken.
> 
> NeilBrown
