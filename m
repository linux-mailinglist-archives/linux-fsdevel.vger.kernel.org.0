Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5FB5B6420
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 01:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiILXaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 19:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiILXaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:30:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2934BBC97;
        Mon, 12 Sep 2022 16:30:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A13F7208C3;
        Mon, 12 Sep 2022 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663025400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chwUdvs9l/Qn9313sU3WPPTkKnQkm+BRMdGTZfPVfFw=;
        b=gIodfHH5tfFut4vP+C5qhTCEgaIeDU2NmjGyYENVDMO6DM0eeeQVOU2AvIREIuxqm/nV7f
        I8dC33xVpDaD3/t9/RwFObPisPxRODGbH/kNg0ckXFlFbmKpUbQ7F+5cyXtGoMdhZ/cxWi
        AIPtIZmYwLICNYyA4DeLzj3resYbv14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663025400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chwUdvs9l/Qn9313sU3WPPTkKnQkm+BRMdGTZfPVfFw=;
        b=lF6U9ojxc1rLQ0VwjZPCj7b36QCi9kk294/oZNli1+v4WO0UcJ7mgVVGcenB6USxcZiON+
        PD0eZ/oqWT33voCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81CFB139C8;
        Mon, 12 Sep 2022 23:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PLAaDvHAH2M6cgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 12 Sep 2022 23:29:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <2e34a7d4e1a3474d80ee0402ed3bc0f18792443a.camel@kernel.org>
References: <20220907111606.18831-1-jlayton@kernel.org>,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <166267775728.30452.17640919701924887771@noble.neil.brown.name>,
 <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>,
 <166268467103.30452.1687952324107257676@noble.neil.brown.name>,
 <166268566751.30452.13562507405746100242@noble.neil.brown.name>,
 <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>,
 <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>,
 <166270570118.30452.16939807179630112340@noble.neil.brown.name>,
 <33d058be862ccc0ccaf959f2841a7e506e51fd1f.camel@kernel.org>,
 <166285038617.30452.11636397081493278357@noble.neil.brown.name>,
 <2e34a7d4e1a3474d80ee0402ed3bc0f18792443a.camel@kernel.org>
Date:   Tue, 13 Sep 2022 09:29:48 +1000
Message-id: <166302538820.30452.7783524836504548113@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Sep 2022, Jeff Layton wrote:
> On Sun, 2022-09-11 at 08:53 +1000, NeilBrown wrote:
> > This could be expensive.
> > 
> > There is not currently any locking around O_DIRECT writes.  You cannot
> > synchronise with them.
> > 
> 
> AFAICT, DIO write() implementations in btrfs, ext4, and xfs all hold
> inode_lock_shared across the I/O. That was why patch #8 takes the
> inode_lock (exclusive) across the getattr.

Looking at ext4_dio_write_iter() it certain does take
inode_lock_shared() before starting the write and in some cases it
requests, using IOMAP_DIO_FORCE_WAIT, that imap_dio_rw() should wait for
the write to complete.  But not in all cases.
So I don't think it always holds the shared lock across all direct IO.

> 
> > The best you can do is update the i_version immediately after all the
> > O_DIRECT writes in a single request complete.
> > 
> > > 
> > > To summarize, there are two main uses for the change attr in NFSv4:
> > > 
> > > 1/ to provide change_info4 for directory morphing operations (CREATE,
> > > LINK, OPEN, REMOVE, and RENAME). It turns out that this is already
> > > atomic in the current nfsd code (AFAICT) by virtue of the fact that we
> > > hold the i_rwsem exclusively over these operations. The change attr is
> > > also queried pre and post while the lock is held, so that should ensure
> > > that we get true atomicity for this.
> > 
> > Yes, directory ops are relatively easy.
> > 
> > > 
> > > 2/ as an adjunct for the ctime when fetching attributes to validate
> > > caches. We don't expect perfect consistency between read (and readlike)
> > > operations and GETATTR, even when they're in the same compound.
> > > 
> > > IOW, a READ+GETATTR compound can legally give you a short (or zero-
> > > length) read, and then the getattr indicates a size that is larger than
> > > where the READ data stops, due to a write or truncate racing in after
> > > the read.
> > 
> > I agree that atomicity is neither necessary nor practical.  Ordering is
> > important though.  I don't think a truncate(0) racing with a READ can
> > credibly result in a non-zero size AFTER a zero-length read.  A truncate
> > that extends the size could have that effect though.
> > 
> > > 
> > > Ideally, the attributes in the GETATTR reply should be consistent
> > > between themselves though. IOW, all of the attrs should accurately
> > > represent the state of the file at a single point in time.
> > > change+size+times+etc. should all be consistent with one another.
> > > 
> > > I think we get all of this by taking the inode_lock around the
> > > vfs_getattr call in nfsd4_encode_fattr. It may not be the most elegant
> > > solution, but it should give us the atomicity we need, and it doesn't
> > > require adding extra operations or locking to the write codepaths.
> > 
> > Explicit attribute changes (chown/chmod/utimes/truncate etc) are always
> > done under the inode lock.  Implicit changes via inode_update_time() are
> > not (though xfs does take the lock, ext4 doesn't, haven't checked
> > others).  So taking the inode lock won't ensure those are internally
> > consistent.
> > 
> > I think using inode_lock_shared() is acceptable.  It doesn't promise
> > perfect atomicity, but it is probably good enough.
> > 
> > We'd need a good reason to want perfect atomicity to go further, and I
> > cannot think of one.
> > 
> > 
> 
> Taking inode_lock_shared is sufficient to block out buffered and DAX
> writes. DIO writes sometimes only take the shared lock (e.g. when the
> data is already properly aligned). If we want to ensure the getattr
> doesn't run while _any_ writes are running, we'd need the exclusive
> lock.

But the exclusive lock is bad for scalability.

> 
> Maybe that's overkill, though it seems like we could have a race like
> this without taking inode_lock across the getattr:
> 
> reader				writer
> -----------------------------------------------------------------
> 				i_version++
> getattr
> read
> 				DIO write to backing store
> 

This is why I keep saying that the i_version increment must be after the
write, not before it.

> 
> Given that we can't fully exclude mmap writes, maybe we can just
> document that mixing DIO or mmap writes on the server + NFS may not be
> fully cache coherent.

"fully cache coherent" is really more than anyone needs.
The i_version must be seen to change no earlier than the related change
becomes visible, and no later than the request which initiated that
change is acknowledged as complete.

NeilBrown
