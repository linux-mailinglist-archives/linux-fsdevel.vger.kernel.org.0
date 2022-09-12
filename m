Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9F5B63F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 01:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiILXOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 19:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiILXOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:14:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B6B1E5;
        Mon, 12 Sep 2022 16:14:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B3A620D7E;
        Mon, 12 Sep 2022 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663024486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGsc36i9kOD73ZWzNaxwNDQZ5w1zThYCY/lFJv6Qf/o=;
        b=PTCTiFZz1AwFvPPwx0WlVz/1//EZ3TIV2Dj4idg4LCuDxZz0bpV3P9TAUg5nUe32Lj5+0q
        7uWwHCgCY0hwB/hyiztHv+FUxC2QuC1zwaCElq51YqU3o+1c4NAxsuBOSknhO2j13zWxrY
        Q9hWCjvyjCOZDBT9zCC3eSmsuwxLDWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663024486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGsc36i9kOD73ZWzNaxwNDQZ5w1zThYCY/lFJv6Qf/o=;
        b=JpZoJo3akYzygJZ23V3z21LRW4JeUQhac6dvAmMBbG/80HmXiag7Agdu6gOaFmPBZJXg4j
        OQW606Vwm/ahV7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C48A4139C8;
        Mon, 12 Sep 2022 23:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4UiSHl29H2NAbgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 12 Sep 2022 23:14:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <20220912134208.GB9304@fieldses.org>
References: <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <20220908155605.GD8951@fieldses.org>,
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>,
 <20220908182252.GA18939@fieldses.org>,
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>,
 <166284799157.30452.4308111193560234334@noble.neil.brown.name>,
 <20220912134208.GB9304@fieldses.org>
Date:   Tue, 13 Sep 2022 09:14:32 +1000
Message-id: <166302447257.30452.6751169887085269140@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Sep 2022, J. Bruce Fields wrote:
> On Sun, Sep 11, 2022 at 08:13:11AM +1000, NeilBrown wrote:
> > On Fri, 09 Sep 2022, Jeff Layton wrote:
> > > 
> > > The machine crashes and comes back up, and we get a query for i_version
> > > and it comes back as X. Fine, it's an old version. Now there is a write.
> > > What do we do to ensure that the new value doesn't collide with X+1? 
> > 
> > (I missed this bit in my earlier reply..)
> > 
> > How is it "Fine" to see an old version?
> > The file could have changed without the version changing.
> > And I thought one of the goals of the crash-count was to be able to
> > provide a monotonic change id.
> 
> I was still mainly thinking about how to provide reliable close-to-open
> semantics between NFS clients.  In the case the writer was an NFS
> client, it wasn't done writing (or it would have COMMITted), so those
> writes will come in and bump the change attribute soon, and as long as
> we avoid the small chance of reusing an old change attribute, we're OK,
> and I think it'd even still be OK to advertise
> CHANGE_TYPE_IS_MONOTONIC_INCR.

You seem to be assuming that the client doesn't crash at the same time
as the server (maybe they are both VMs on a host that lost power...)

If client A reads and caches, client B writes, the server crashes after
writing some data (to already allocated space so no inode update needed)
but before writing the new i_version, then client B crashes.
When server comes back the i_version will be unchanged but the data has
changed.  Client A will cache old data indefinitely...



> 
> If we're trying to do better than that, I'm just not sure what's right.

I think we need to require the filesystem to ensure that the i_version
is seen to increase shortly after any change becomes visible in the
file, and no later than the moment when the request that initiated the
change is acknowledged as being complete.  In the case of an unclean
restart, any file that is not known to have been unchanged immediately
before the crash must have i_version increased.

The simplest implementation is to have an unclean-restart counter and to
always included this multiplied by some constant X in the reported
i_version.  The filesystem guarantees to record (e.g.  to journal
at least) the i_version if it comes close to X more than the previous
record.  The filesystem gets to choose X.

A more complex solution would be to record (similar to the way orphans
are recorded) any file which is open for write, and to add X to the
i_version for any "dirty" file still recorded during an unclean restart.
This would avoid bumping the i_version for read-only files.

There may be other solutions, but we should leave that up to the
filesystem.  Each filesystem might choose something different.

NeilBrown
