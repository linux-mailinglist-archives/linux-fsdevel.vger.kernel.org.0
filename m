Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3B5B22AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiIHPoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiIHPoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:44:05 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE2798D15;
        Thu,  8 Sep 2022 08:44:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8DB3E3EFC; Thu,  8 Sep 2022 11:44:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8DB3E3EFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662651843;
        bh=Qcv5pi2Bp/D/7jZOgxG4Dy876kj6hLQPFyFq+OdA9V0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=khg/A2Z+/B+YH6cGSHtS3E6HNyXZEN96OqbTFM3bcvhPRlnREpvGXKasZWoBS7KBI
         Yaspmuj47tg+Xa5fALCjHT8oh0Wsr9EZ6qIp7qQ90J7tonJr54+xR7y+G+jo2smafq
         R/aHEFRhv1f5C40Lnw/pL8epCE0e66lwDuLpY5T8=
Date:   Thu, 8 Sep 2022 11:44:03 -0400
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
        Jeff Layton <jlayton@kernel.org>, adilger.kernel@dilger.ca,
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
Message-ID: <20220908154403.GC8951@fieldses.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
 <20220907125211.GB17729@fieldses.org>
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxoIjV50xXKiLdL9@mit.edu>
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

On Thu, Sep 08, 2022 at 11:21:49AM -0400, Theodore Ts'o wrote:
> On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> > It boils down to the fact that we don't want to call mark_inode_dirty()
> > from IOCB_NOWAIT path because for lots of filesystems that means journal
> > operation and there are high chances that may block.
> > 
> > Presumably we could treat inode dirtying after i_version change similarly
> > to how we handle timestamp updates with lazytime mount option (i.e., not
> > dirty the inode immediately but only with a delay) but then the time window
> > for i_version inconsistencies due to a crash would be much larger.
> 
> Perhaps this is a radical suggestion, but there seems to be a lot of
> the problems which are due to the concern "what if the file system
> crashes" (and so we need to worry about making sure that any
> increments to i_version MUST be persisted after it is incremented).
> 
> Well, if we assume that unclean shutdowns are rare, then perhaps we
> shouldn't be optimizing for that case.  So.... what if a file system
> had a counter which got incremented each time its journal is replayed
> representing an unclean shutdown.  That shouldn't happen often, but if
> it does, there might be any number of i_version updates that may have
> gotten lost.  So in that case, the NFS client should invalidate all of
> its caches.
> 
> If the i_version field was large enough, we could just prefix the
> "unclean shutdown counter" with the existing i_version number when it
> is sent over the NFS protocol to the client.  But if that field is too
> small,

The NFSv4 change attribute is 64 bits.  Not sure exactly how to use
that, but I think it should be large enough.

> and if (as I understand things) NFS just needs to know when
> i_version is different, we could just simply hash the "unclean
> shtudown counter" with the inode's "i_version counter", and let that
> be the version which is sent from the NFS client to the server.

Yes, invalidating all caches could be painful, but as you say, also
rare.

We could also consider factoring the "unclean shutdown counter" on
creating (and writing) the new value, instead of on returning it.

That would mean it could go backward after a reboot, but at least it
would never repeat a previously used value.  (Since the new "unclean
shutdown counter" will be factored in on first modification of the file
after restart.)

> If we could do that, then it doesn't become critical that every single
> i_version bump has to be persisted to disk, and we could treat it like
> a lazytime update; it's guaranteed to updated when we do an clean
> unmount of the file system (and when the file system is frozen), but
> on a crash, there is no guaranteee that all i_version bumps will be
> persisted, but we do have this "unclean shutdown" counter to deal with
> that case.
> 
> Would this make life easier for folks?

Anyway, yes, seems helpful to me, and not too complicated.  (I say,
having no idea how to implement the filesystem side.)

--b.
