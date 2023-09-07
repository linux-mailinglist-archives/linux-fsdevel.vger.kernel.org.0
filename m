Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB47979C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbjIGRUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbjIGRUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:20:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352190;
        Thu,  7 Sep 2023 10:20:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E2F71F459;
        Thu,  7 Sep 2023 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694079898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQKrvoRpVQJFQhwOguupeVlEjouTylOwLzLmWuGsjm4=;
        b=yXfYCT//3NYk/IIvJQmLc230SnFy+DGFE6NMTLPUGoKXXmrt6TPdXl2F+YivPZIgKAyW+a
        UVNQkYZ3PCJKmN/SN5B7pOKfVus74F66dP1Fvn2zH0sxaGoH/08TvbyIeeKYNwem1r8gxF
        SW63ivzjn5x/VQY3NQ/nUIK6AwMtSoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694079898;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQKrvoRpVQJFQhwOguupeVlEjouTylOwLzLmWuGsjm4=;
        b=DeUApml2wtvIj0k60NHvdFJR0szgr5vYwRKs3ynUY2tPBffcp+LRThvobbONsq48Zi8hgW
        XOXo8fu/Zh9toCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B15C138F9;
        Thu,  7 Sep 2023 09:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4n+FBpqb+WT+QQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 07 Sep 2023 09:44:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6D8EFA06E5; Thu,  7 Sep 2023 11:44:57 +0200 (CEST)
Date:   Thu, 7 Sep 2023 11:44:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230907094457.vcvmixi23dk3pzqe@quack3>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-09-23 18:52:39, Mikulas Patocka wrote:
> On Wed, 6 Sep 2023, Christian Brauner wrote:
> > On Wed, Sep 06, 2023 at 06:01:06PM +0200, Mikulas Patocka wrote:
> > > > > BTW. what do you think that unmount of a frozen filesystem should properly 
> > > > > do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> > > > > something else?
> > > > 
> > > > In my opinion we should refuse to unmount frozen filesystems and log an
> > > > error that the filesystem is frozen. Waiting forever isn't a good idea
> > > > in my opinion.
> > > 
> > > But lvm may freeze filesystems anytime - so we'd get randomly returned 
> > > errors then.
> > 
> > So? Or you might hang at anytime.
> 
> lvm doesn't keep logical volumes suspended for a prolonged amount of time. 
> It will unfreeze them after it made updates to the dm table and to the 
> metadata. So, it won't hang forever.
> 
> I think it's better to sleep for a short time in umount than to return an 
> error.

I think we've got too deep down into "how to fix things" but I'm not 100%
sure what the "bug" actually is. In the initial posting Mikulas writes "the
kernel writes to the filesystem after unmount successfully returned" - is
that really such a big issue? Anybody else can open the device and write to
it as well. Or even mount the device again. So userspace that relies on
this is kind of flaky anyway (and always has been).

I understand the need for userspace to make sure the device is not being
modified to do its thing - but then it should perhaps freeze the bdev if
it wants to be certain? Or at least open it O_EXCL to make sure it's not
mounted?

WRT the umount behavior for frozen filesystem - as Al writes it's a tricky
issue and we've been discussing that several times over the years and it
never went anywhere because of nasty corner-cases (which current behavior
also has but trading one nasty case for another isn't really a win). Now
that we distinguish between kernel-initiated freeze (with well defined
freeze owner and lifetime) and userspace-initiated freeze, I can image we'd
make last unmount of the superblock wait for the kernel-initiated freeze to
thaw. But as Al writes with lazy unmounts, bind mounts in multiple
namespaces etc. I'm not sure such behavior brings much value...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
