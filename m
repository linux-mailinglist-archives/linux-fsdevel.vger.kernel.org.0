Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69E5B297C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIHWlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIHWlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:41:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BAAED3BD;
        Thu,  8 Sep 2022 15:41:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5DA7D21EE2;
        Thu,  8 Sep 2022 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662676871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39pzd2H+Q2np9tNPeeLt0hZVac57Ld4M0d4EpbTDzso=;
        b=EVICqEQt1WJTp5oZeW9lXiYAxJDBR8d9kFj/KsgIa2ZQqqj1/1hgX+RhYnaa8RtaQGB8v9
        YFNE0vglYXwK0J64710bHzjyX4Q7iMIiU6EgQTOFb+43nM6kBU4hjywfL5Ww7V1rwDy6hh
        GKewm2g3sQQZnUXz7pgv1U2tUq8Xw7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662676871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39pzd2H+Q2np9tNPeeLt0hZVac57Ld4M0d4EpbTDzso=;
        b=JA1FXNEdw0SSrND/axgRnsiCBodxCRELCCnti65e/mgOESNzYwt4gTvp8SWuivGtScAbON
        uDmCA8c4B1Fr9kDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE9DC1322C;
        Thu,  8 Sep 2022 22:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HARlGH9vGmPiCgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 22:41:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Jan Kara" <jack@suse.cz>, "Jeff Layton" <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>, adilger.kernel@dilger.ca,
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
In-reply-to: <YxoIjV50xXKiLdL9@mit.edu>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>
Date:   Fri, 09 Sep 2022 08:40:51 +1000
Message-id: <166267685105.30452.17324304715046746056@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 09 Sep 2022, Theodore Ts'o wrote:
> On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
> > It boils down to the fact that we don't want to call mark_inode_dirty()
> > from IOCB_NOWAIT path because for lots of filesystems that means journal
> > operation and there are high chances that may block.
> >=20
> > Presumably we could treat inode dirtying after i_version change similarly
> > to how we handle timestamp updates with lazytime mount option (i.e., not
> > dirty the inode immediately but only with a delay) but then the time wind=
ow
> > for i_version inconsistencies due to a crash would be much larger.
>=20
> Perhaps this is a radical suggestion, but there seems to be a lot of
> the problems which are due to the concern "what if the file system
> crashes" (and so we need to worry about making sure that any
> increments to i_version MUST be persisted after it is incremented).
>=20
> Well, if we assume that unclean shutdowns are rare, then perhaps we
> shouldn't be optimizing for that case.  So.... what if a file system
> had a counter which got incremented each time its journal is replayed
> representing an unclean shutdown.  That shouldn't happen often, but if
> it does, there might be any number of i_version updates that may have
> gotten lost.  So in that case, the NFS client should invalidate all of
> its caches.

I was also thinking that the filesystem could help close that gap, but I
didn't like the "whole filesysem is dirty" approach.
I instead imagined a "dirty" bit in the on-disk inode which was set soon
after any open-for-write and cleared when the inode was finally written
after there are no active opens and no unflushed data.
The "soon after" would set a maximum window on possible lost version
updates (which people seem to have comfortable with) without imposing a
sync IO operation on open (for first write).

When loading an inode from disk, if the dirty flag was set then the
difference between current time and on-disk ctime (in nanoseconds) could
be added to the version number.

But maybe that is too complex for the gain.

NeilBrown
