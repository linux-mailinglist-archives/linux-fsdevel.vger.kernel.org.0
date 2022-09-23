Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0F5E77C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 11:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiIWJ5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 05:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiIWJ45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:56:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23713073E;
        Fri, 23 Sep 2022 02:56:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0655821A8E;
        Fri, 23 Sep 2022 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663927014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=us+dLjYsj7y69xS3UKuaVga8AZkPesdObHEXPyfea7c=;
        b=CgxV01WFtYUpA/rNfefeudFxFUhoOnJkG0HnO1V8uPJV6xSkn7z6huZF6R/QyGCFIU4LFW
        nLaS8GVaFPjeIepZRkh+yYXVCVHc6p3IUk7v/7W2BW+ptoKZAM5vDzldVqFlXMDJhkwMkj
        xQ+0bvG9JPXm64wVtf0yQcflvm+rYaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663927014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=us+dLjYsj7y69xS3UKuaVga8AZkPesdObHEXPyfea7c=;
        b=KXTNeaDMsUrJxPhK3xNAXOp5p3gQfxpAMM25eFV7D53yDuXmK5zyxRULi3uK1YGDGVOS1x
        vSjXFKMYV27kfYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E584313A00;
        Fri, 23 Sep 2022 09:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oh0FOOWCLWNiMQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 09:56:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 443FDA0685; Fri, 23 Sep 2022 11:56:53 +0200 (CEST)
Date:   Fri, 23 Sep 2022 11:56:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220923095653.5c63i2jgv52j3zqp@quack3>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
 <20220918235344.GH3600936@dread.disaster.area>
 <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
 <20220920001645.GN3600936@dread.disaster.area>
 <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
 <20220921000032.GR3600936@dread.disaster.area>
 <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
 <20220921214124.GS3600936@dread.disaster.area>
 <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>
 <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-09-22 16:18:02, Jeff Layton wrote:
> On Thu, 2022-09-22 at 06:18 -0400, Jeff Layton wrote:
> > On Thu, 2022-09-22 at 07:41 +1000, Dave Chinner wrote:
> > > e.g. The NFS server can track the i_version values when the NFSD
> > > syncs/commits a given inode. The nfsd can sample i_version it when
> > > calls ->commit_metadata or flushed data on the inode, and then when
> > > it peeks at i_version when gathering post-op attrs (or any other
> > > getattr op) it can decide that there is too much in-memory change
> > > (e.g. 10,000 counts since last sync) and sync the inode.
> > > 
> > > i.e. the NFS server can trivially cap the maximum number of
> > > uncommitted NFS change attr bumps it allows to build up in memory.
> > > At that point, the NFS server has a bound "maximum write count" that
> > > can be used in conjunction with the xattr based crash counter to
> > > determine how the change_attr is bumped by the crash counter.
> > 
> > Well, not "trivially". This is the bit where we have to grow struct
> > inode (or the fs-specific inode), as we'll need to know what the latest
> > on-disk value is for the inode.
> > 
> > I'm leaning toward doing this on the query side. Basically, when nfsd
> > goes to query the i_version, it'll check the delta between the current
> > version and the latest one on disk. If it's bigger than X then we'd just
> > return NFS4ERR_DELAY to the client.
> > 
> > If the delta is >X/2, maybe it can kick off a workqueue job or something
> > that calls write_inode with WB_SYNC_ALL to try to get the thing onto the
> > platter ASAP.
> 
> Still looking at this bit too. Probably we can just kick off a
> WB_SYNC_NONE filemap_fdatawrite at that point and hope for the best?

"Hope" is not a great assurance regarding data integrity ;) Anyway, it
depends on how you imagine the "i_version on disk" is going to be
maintained. It could be maintained by NFSD inside commit_inode_metadata() -
fetch current i_version value before asking filesystem for the sync and by the
time commit_metadata() returns we know that value is on disk. If we detect the
current - on_disk is > X/2, we call commit_inode_metadata() and we are
done. It is not even *that* expensive because usually filesystems optimize
away unnecessary IO when the inode didn't change since last time it got
synced.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
