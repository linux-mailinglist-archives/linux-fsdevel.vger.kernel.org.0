Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD757798343
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbjIHHcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:32:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CDB1990;
        Fri,  8 Sep 2023 00:32:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8339E1F45A;
        Fri,  8 Sep 2023 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694158365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euHz7ZVLAcuf6vq3WgxuP8PbER62bbJ+haG60jiVoXQ=;
        b=rY1GyH5M0uyeFrpo4O4jbubAo105Y0uosB8VbpEh6rrWxNTEhozMrRD5iIA986KleUsV1i
        DjNdPiGY76ykBsylWHqWynnBhIEoZvwo8Dww+BO5TUGVhgoiBixN/ifEf+OHPoBclt/mr9
        6n8WgsSU7c5qVbcdVRnldA8kxZlQ+Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694158365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euHz7ZVLAcuf6vq3WgxuP8PbER62bbJ+haG60jiVoXQ=;
        b=0gxAGbRhTSg8Dz/aDc3wLYdXL6zeCjHgT8wkalayH/X6gdRHrohmdscBS1AKmsaTVDDqJM
        bcO8V+U15rjUJjCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66765132F2;
        Fri,  8 Sep 2023 07:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n5D2GB3O+mRBEQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 07:32:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DBF11A0774; Fri,  8 Sep 2023 09:32:44 +0200 (CEST)
Date:   Fri, 8 Sep 2023 09:32:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230908073244.wyriwwxahd3im2rw@quack3>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-09-23 14:04:51, Mikulas Patocka wrote:
> 
> 
> On Thu, 7 Sep 2023, Christian Brauner wrote:
> 
> > > I think we've got too deep down into "how to fix things" but I'm not 100%
> > 
> > We did.
> > 
> > > sure what the "bug" actually is. In the initial posting Mikulas writes "the
> > > kernel writes to the filesystem after unmount successfully returned" - is
> > > that really such a big issue?
> 
> I think it's an issue if the administrator writes a script that unmounts a 
> filesystem and then copies the underyling block device somewhere. Or a 
> script that unmounts a filesystem and runs fsck afterwards. Or a script 
> that unmounts a filesystem and runs mkfs on the same block device.

Well, e.g. e2fsprogs use O_EXCL open so they will detect that the filesystem
hasn't been unmounted properly and complain. Which is exactly what should
IMHO happen.

> > > Anybody else can open the device and write to it as well. Or even 
> > > mount the device again. So userspace that relies on this is kind of 
> > > flaky anyway (and always has been).
> 
> It's admin's responsibility to make sure that the filesystem is not 
> mounted multiple times when he touches the underlying block device after 
> unmount.

What I wanted to suggest is that we should provide means how to make sure
block device is not being modified and educate admins and tool authors
about them. Because just doing "umount /dev/sda1" and thinking this means
that /dev/sda1 is unused now simply is not enough in today's world for
multiple reasons and we cannot solve it just in the kernel.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
