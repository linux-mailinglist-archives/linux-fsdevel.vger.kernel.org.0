Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DB85B045D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIGMw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIGMwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:52:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D8BB69A;
        Wed,  7 Sep 2022 05:52:12 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5936C6023; Wed,  7 Sep 2022 08:52:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5936C6023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662555131;
        bh=P3lBuJJGteBG86RAZAucfIziaQwt7ERXU7IpxeYykcE=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=lr8RCW8m5JayBSGG9RnfCwfbBC67SLxg4/J94yTsCxlQcdBAXKpWffJf40z50vF0B
         LaUy0qid957lECGK2TVd/9vKJPbvblTLN1bXxkdTANhJFBJdEjkQ/50CERJv1vcIq9
         GMfJeZUWshHbaOtrvdWd2bxbYi2ihJyvy4xW/oa4=
Date:   Wed, 7 Sep 2022 08:52:11 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, tytso@mit.edu, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220907125211.GB17729@fieldses.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
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

On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > +The change to \fIstatx.stx_ino_version\fP is not atomic with respect to the
> > > +other changes in the inode. On a write, for instance, the i_version it usually
> > > +incremented before the data is copied into the pagecache. Therefore it is
> > > +possible to see a new i_version value while a read still shows the old data.
> > 
> > Doesn't that make the value useless?
> > 
> 
> No, I don't think so. It's only really useful for comparing to an older
> sample anyway. If you do "statx; read; statx" and the value hasn't
> changed, then you know that things are stable. 

I don't see how that helps.  It's still possible to get:

		reader		writer
		------		------
				i_version++
		statx
		read
		statx
				update page cache

right?

--b.

> 
> > Surely the change number must
> > change no sooner than the change itself is visible, otherwise stale data
> > could be cached indefinitely.
> > 
> > If currently implementations behave this way, surely they are broken.
> 
> It's certainly not ideal but we've never been able to offer truly atomic
> behavior here given that Linux is a general-purpose OS. The behavior is
> a little inconsistent too:
> 
> The c/mtime update and i_version bump on directories (mostly) occur
> after the operation. c/mtime updates for files however are mostly driven
> by calls to file_update_time, which happens before data is copied to the
> pagecache.
> 
> It's not clear to me why it's done this way. Maybe to ensure that the
> metadata is up to date in the event that a statx comes in? Improving
> this would be nice, but I don't see a way to do that without regressing
> performance.
> -- 
> Jeff Layton <jlayton@kernel.org>
