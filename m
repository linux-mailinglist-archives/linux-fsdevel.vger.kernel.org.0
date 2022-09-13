Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DE5B7D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIMXT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 19:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIMXTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:19:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318F186F2;
        Tue, 13 Sep 2022 16:19:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 741A35C801;
        Tue, 13 Sep 2022 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663111191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1RlEFFdnbelVuFieKtPjIj+HKLf20F8SzyjGZ1aWdx4=;
        b=X9dQ1LYCcbxZz/h81Ze848AQlRqUlk2DBvX6vue+qjpMnhib9Hf1fr6QQ6ijSFa8W/cfV1
        0nv6fBSU0w7Rxhanf8Q3ff++rFUaMccSy2W2WV45ScDdlnmLbD4Gf1XQVkWgTwEeNqGPq4
        z4R860kGqnuKVIuIkfcYg0yQfn0/OpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663111191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1RlEFFdnbelVuFieKtPjIj+HKLf20F8SzyjGZ1aWdx4=;
        b=k7J0/dOeQK2ZeGErc6uewU0Y1p8Y5nmjHT1K1/vkJnV2/sBK47PCFpKFhnpwoqQ/Bptpkk
        jcnzrW221lNGvpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6097513AB5;
        Tue, 13 Sep 2022 23:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NpWqBhAQIWPwZAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 13 Sep 2022 23:19:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org,
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
In-reply-to: <20220913190226.GA11958@fieldses.org>
References: <20220908155605.GD8951@fieldses.org>,
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>,
 <20220908182252.GA18939@fieldses.org>,
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>,
 <20220909154506.GB5674@fieldses.org>,
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>,
 <20220910145600.GA347@fieldses.org>,
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>,
 <20220913004146.GD3600936@dread.disaster.area>,
 <166303374350.30452.17386582960615006566@noble.neil.brown.name>,
 <20220913190226.GA11958@fieldses.org>
Date:   Wed, 14 Sep 2022 09:19:22 +1000
Message-id: <166311116291.20483.960025733349761945@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 14 Sep 2022, J. Bruce Fields wrote:
> On Tue, Sep 13, 2022 at 11:49:03AM +1000, NeilBrown wrote:
> > Invalidating the client cache on EVERY unmount/mount could impose
> > unnecessary cost.  Imagine a client that caches a lot of data (several
> > large files) from a server which is expected to fail-over from one
> > cluster node to another from time to time.  Adding extra delays to a
> > fail-over is not likely to be well received.
> > 
> > I don't *know* this cost would be unacceptable, and I *would* like to
> > leave it to the filesystem to decide how to manage its own i_version
> > values.  So maybe XFS can use the LSN for a salt.  If people notice the
> > extra cost, they can complain.
> 
> I'd expect complaints.
> 
> NFS is actually even worse than this: it allows clients to reacquire
> file locks across server restart and unmount/remount, even though
> obviously the kernel will do nothing to prevent someone else from
> locking (or modifying) the file in between.

I don't understand this comment.  You seem to be implying that changing
the i_version during a server restart would stop a client from
reclaiming locks.  Is that correct?
I would have thought that the client would largely ignore i_version
while it has a lock or open or delegation, as these tend to imply some
degree of exclusive access ("open" being least exclusive).

Thanks,
NeilBrown


> 
> Administrators are just supposed to know not to allow other applications
> access to the filesystem until nfsd's started.  It's always been this
> way.
> 
> You can imagine all sorts of measures to prevent that, and if anyone
> wants to work on ways to prevent people from shooting themselves in the
> foot here, great.
> 
> Just taking away the ability to cache or lock across reboots wouldn't
> make people happy, though....
> 
> --b.
> 
