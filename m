Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F9579CB2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjILJKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjILJKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:10:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA25170D;
        Tue, 12 Sep 2023 02:10:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78C631F8BB;
        Tue, 12 Sep 2023 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694509816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oLDSU6uCjV2EGNSBLy3F9T0vfZ0SK9re4WrGsuLP6M=;
        b=eRc4pkVX1Xuk+m9HY8aLPjdArqPBS48IVGMP8UDnzWt/fFR7/5lucUByh6yO6ZKyhSr48Q
        g4EdMmJxkhzTVKPPB4YIPChhEUtYprvXMp7JbxDgoKzDUoOst+ULXJQWx8LZa0x+Bn9U55
        HgjY3FXR69kyZcdbDl41aBSEzkMjdD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694509816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oLDSU6uCjV2EGNSBLy3F9T0vfZ0SK9re4WrGsuLP6M=;
        b=Q66xZuMue4b0tjWb5cdtDq7oNyACOCx0ezKhABsCHaCzgrIrZV/fJ3z+LvbjU0xs30Io+4
        HL4YUkek/lNP35BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66F6F139DB;
        Tue, 12 Sep 2023 09:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xGD0GPgqAGWkMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 12 Sep 2023 09:10:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EF43AA077E; Tue, 12 Sep 2023 11:10:15 +0200 (CEST)
Date:   Tue, 12 Sep 2023 11:10:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zdenek Kabelac <zkabelac@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230912091015.n37x6gx52jmuwmx7@quack3>
References: <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
 <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
 <20230908102014.xgtcf5wth2l2cwup@quack3>
 <15c62097-d58f-4e66-bdf5-e0edb1306b2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15c62097-d58f-4e66-bdf5-e0edb1306b2f@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-09-23 12:51:03, Zdenek Kabelac wrote:
> Dne 08. 09. 23 v 12:20 Jan Kara napsal(a):
> > On Fri 08-09-23 11:29:40, Zdenek Kabelac wrote:
> > > Dne 08. 09. 23 v 9:32 Jan Kara napsal(a):
> > > > On Thu 07-09-23 14:04:51, Mikulas Patocka wrote:
> > > > > On Thu, 7 Sep 2023, Christian Brauner wrote:
> > > > > 
> > > > > > > I think we've got too deep down into "how to fix things" but I'm not 100%
> > > > > > We did.
> > > > > > 
> > > > > > > sure what the "bug" actually is. In the initial posting Mikulas writes "the
> > > > > > > kernel writes to the filesystem after unmount successfully returned" - is
> > > > > > > that really such a big issue?
> > > > > I think it's an issue if the administrator writes a script that unmounts a
> > > > > filesystem and then copies the underyling block device somewhere. Or a
> > > > > script that unmounts a filesystem and runs fsck afterwards. Or a script
> > > > > that unmounts a filesystem and runs mkfs on the same block device.
> > > > Well, e.g. e2fsprogs use O_EXCL open so they will detect that the filesystem
> > > > hasn't been unmounted properly and complain. Which is exactly what should
> > > > IMHO happen.
> > > I'd likely propose in this particular state of unmounting of a frozen
> > > filesystem to just proceed - and drop the frozen state together with release
> > > filesystem and never issue any ioctl from such filelsystem to the device
> > > below - so it would not be a 100% valid unmount - but since the freeze
> > > should be nearly equivalent of having a proper 'unmount' being done -  it
> > > shoudn't be causing any harm either - and  all resources associated could
> > > be 'released.  IMHO it's correct to 'drop' frozen state for filesystem
> > > that is not going to exist anymore  (assuming it's the last  such user)
> > This option was also discussed in the past and it has nasty consequences as
> > well. Cleanly shutting down a filesystem usually needs to write to the
> > underlying device so either you allow the filesystem to write to the device
> > on umount breaking assumptions of the user who froze the fs or you'd have
> > to implement a special handling for this case for every filesystem to avoid
> > the writes (and put up with the fact that the filesystem will appear as
> > uncleanly shutdown on the next mount). Not particularly nice either...
> 
> 
> I'd say there are several options and we should aim towards the variant
> which is most usable by normal users.
> 
> Making hyper complex  unmount rule logic that basically no user-space tools
> around Gnome/KDE... are able to handle well and getting it to the position
> where only the core kernel developer have all the 'wisdom' to detect and
> decode system state and then 'know what's going on'  isn't the favourite
> goal here.

I don't think we are really making forward progress in the argument which
behavior is more or less correct or useful. But maybe when we cannot agree
on the general solution we could still improve the situation that
practically matters? E.g. disputing Gnome apps telling you you can safely
remove the USB stick when you actually cannot because the filesystem on it
is frozen is actually kind of weak argument because users that freeze
filesystem on their USB stick are practically non-existent. So is there a
usecase where users are hitting these problems in practice? Maybe some user
report that triggered original Mikulas' patch? Or was that mostly a
theoretical concern?

> Freeze should be getting the filesystem into 'consistent' state - filesystem
> should  be able to 'easily' recover and finish all the ongoing  'unfinished'
> process with the next mount without requiring full 'fsck' - otherwise it
> would be useless for i.e. snapshot.

More or less yes but e.g. grub2 isn't able to reliably read images of just
frozen filesystem because it ignores journal contents. So if this was root
filesystem this could result in unbootable system.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
