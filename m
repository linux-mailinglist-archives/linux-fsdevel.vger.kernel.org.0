Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5735599160
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 01:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244759AbiHRXno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiHRXnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:43:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F473916;
        Thu, 18 Aug 2022 16:43:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EFC638433;
        Thu, 18 Aug 2022 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660866217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=La9+IW0k9SbssyQfgfBFyxSZDH5EOI6NJimEF+rcYMk=;
        b=vX3q6WiX21XcviJDPXBEHACGrTXJLA5pbGjU2mSnOsBSocXcGtjTXQg0HVS3aOrwx8LREV
        IerXk8ODAbvDvDNAbGDAIw/+34a2ZM9ozdZjK4KK6xOfuLj+3qw5QiGLKftKWvtU+UH6hb
        GUq+FgAoyJEEH1OgyPUkpQJfx0av8ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660866217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=La9+IW0k9SbssyQfgfBFyxSZDH5EOI6NJimEF+rcYMk=;
        b=YZems7YCisDub1qabSd9tzbpqNrLitUK5PgIhgtXA5IeegfB/84GMZvpsEd+6o5oJeQl6F
        GCnrdtT4FVOV+jAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F68F139B7;
        Thu, 18 Aug 2022 23:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y1D4NqbO/mKOPwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Aug 2022 23:43:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
In-reply-to: <ae80e71722385a85bb0949540bb4bd0a796a2e34.camel@kernel.org>
References: <20220816131736.42615-1-jlayton@kernel.org>,
 <Yvu7DHDWl4g1KsI5@magnolia>,
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>,
 <20220816224257.GV3600936@dread.disaster.area>,
 <166078288043.5425.8131814891435481157@noble.neil.brown.name>,
 <ae80e71722385a85bb0949540bb4bd0a796a2e34.camel@kernel.org>
Date:   Fri, 19 Aug 2022 09:43:32 +1000
Message-id: <166086621211.5425.17549139726411291019@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Aug 2022, Jeff Layton wrote:
> On Thu, 2022-08-18 at 10:34 +1000, NeilBrown wrote:
> > On Wed, 17 Aug 2022, Dave Chinner wrote:
> > > 
> > > In XFS, we've defined the on-disk i_version field to mean
> > > "increments with any persistent inode data or metadata change",
> > > regardless of what the high level applications that use i_version
> > > might actually require.
> > > 
> > > That some network filesystem might only need a subset of the
> > > metadata to be covered by i_version is largely irrelevant - if we
> > > don't cover every persistent inode metadata change with i_version,
> > > then applications that *need* stuff like atime change notification
> > > can't be supported.
> > 
> > So what you are saying is that the i_version provided by XFS does not
> > match the changeid semantics required by NFSv4.  Fair enough.  I guess
> > we shouldn't use the one to implement the other then.
> > 
> > Maybe we should just go back to using ctime.  ctime is *exactly* what
> > NFSv4 wants, as long as its granularity is sufficient to catch every
> > single change.  Presumably XFS doesn't try to ensure this.  How hard
> > would it be to get any ctime update to add at least one nanosecond?
> > This would be enabled by a mount option, or possibly be a direct request
> > from nfsd.
> > 
> 
> I think that would be an unfortunate outcome, but if we can't stop xfs
> from bumping the i_version on atime updates, then we may have no choice
> but to do so. I suppose we could add a fetch_iversion for xfs that takes
> it back to using the ctime.

"unfortunate" for who I wonder..

I think Trond's argument about not needing implicit updates to be
reflected i_version is sound - as the effective i_version can be
constructed from stored i_version plus all attributes, if you ever want
an effective i_version that covers all implicit changes to attributes.
However I doubt Dave will be convinced.

> 
> > <rant>NFSv4 changeid is really one of the more horrible parts of the
> > design</rant>
> > 
> 
> Hah! I was telling Tom Talpey yesterday that I thought that the change
> counter was one of the best ideas in NFSv4 and that we should be trying
> to get all filesystems to implement it correctly.
> 
> The part that does suck about the design is that the original specs
> weren't specific enough about its behavior. I think that's been somewhat
> remedied in more recent RFCs though.

That's enough bate for me to expand my rant...
The problem with changeid is that it imposes on the filesystem.  You
CANNOT provide a compliant NFSv4 services on a filesystem which has 1
second resolution of time stamps and no internal i_version.  When you
are designing a protocol - particularly one where interoperability is a
focus - making it impossible to export some common (at the time)
filesystems correctly is crazy.

And not at all necessary.  There is a much better way.

When reporting the ctime of a file, the server could add a Bool which is
true if that time is "now" to within the resolution of the timestamp.
If you see a "now" ctime, then you cannot use timestamps to validate any
cached data.  i.e.  a "now" ctime is different to every other ctime,
even another "now" ctime with the same timestamp.
If the filesystem has high resolution timestamps, it will never say
"now" and you get the same semantics as changeid.  If timestamps are low
resolution, then you cannot cache a file while it is changing (unless
you get a read delegation), but you can accurately cache a file as long
as it doesn't change - which is all that changeid gives you anyway.

NeilBrown


> -- 
> Jeff Layton <jlayton@kernel.org>
> 
