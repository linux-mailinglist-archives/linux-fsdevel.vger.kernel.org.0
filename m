Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6449A5B29DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIHXBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIHXBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:01:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4B82D07;
        Thu,  8 Sep 2022 16:01:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0A3D336AE;
        Thu,  8 Sep 2022 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662678087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xy/c6DrfacbSWG6gKyZHom3flbC+WLVPqFWDGXwmFQw=;
        b=IeUqcmcN2pH1qmadf0Pchq9/88nnlj0PxSIlEX2iIxcVgzyqofXNRW4tFrA7RcpXSot6xS
        0k5Zq69AnsyFOMA+k+sUEkRzgWv0k7z6NNtsubduewv57ktYqrzRWk4HPHfF5AIwX0o9dc
        vdHAgxJ6HhoUyoufPpa7bKSIf+2J8fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662678087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xy/c6DrfacbSWG6gKyZHom3flbC+WLVPqFWDGXwmFQw=;
        b=ygJFcjmFtUS7tcIiTptD8Wumi8jQDvwi/mc1uB+J7WNwXp5qeZcsDUxFASW0jiKo/3xInC
        IourZPWz6WE6vJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AD2B13A6D;
        Thu,  8 Sep 2022 23:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQFoAEB0GmNwEQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 08 Sep 2022 23:01:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
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
In-reply-to: <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>,
 <20220907125211.GB17729@fieldses.org>,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>,
 <20220907135153.qvgibskeuz427abw@quack3>,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <20220908155605.GD8951@fieldses.org>,
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>,
 <20220908182252.GA18939@fieldses.org>,
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
Date:   Fri, 09 Sep 2022 09:01:16 +1000
Message-id: <166267807678.30452.18035749642786839300@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 09 Sep 2022, Jeff Layton wrote:
> On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
> > On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> > > Yeah, ok. That does make some sense. So we would mix this into the
> > > i_version instead of the ctime when it was available. Preferably, we'd
> > > mix that in when we store the i_version rather than adding it afterward.
> > > 
> > > Ted, how would we access this? Maybe we could just add a new (generic)
> > > super_block field for this that ext4 (and other filesystems) could
> > > populate at mount time?
> > 
> > Couldn't the filesystem just return an ino_version that already includes
> > it?
> > 
> 
> Yes. That's simple if we want to just fold it in during getattr. If we
> want to fold that into the values stored on disk, then I'm a little less
> clear on how that will work.
> 
> Maybe I need a concrete example of how that will work:
> 
> Suppose we have an i_version value X with the previous crash counter
> already factored in that makes it to disk. We hand out a newer version
> X+1 to a client, but that value never makes it to disk.

As I understand it, the crash counter would NEVER appear in the on-disk
i_version.
The crash counter is stable while a filesystem is mounted so is the same
when loading an inode from disk and when writing it back.

When loading, add crash counter to on-disk i_version to provide
in-memory i_version.
when storing, subtract crash counter from in-memory i_version to provide
on-disk i_version.

"add" and "subtract" could be any reversible hash, and its inverse.  I
would probably shift the crash counter up 16 and add/subtract.

NeilBrown


> 
> The machine crashes and comes back up, and we get a query for i_version
> and it comes back as X. Fine, it's an old version. Now there is a write.
> What do we do to ensure that the new value doesn't collide with X+1? 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
