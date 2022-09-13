Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2755B6622
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIMDb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 23:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIMDbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:31:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4509D2FFF5;
        Mon, 12 Sep 2022 20:31:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B133920F49;
        Tue, 13 Sep 2022 03:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663039870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ndgrk0VyINRbdMDLbO7l+2EY0nnzKQILkdX+lROM4VA=;
        b=D5hQtSVB84872NWPUpgtY00czjq4HsvsBIr9rk8RSxBRplc2NpkS+Hu6+gZUqMDyzVnKik
        LwMboydU+7qPo2tpYbBb9O8GMLzcyPJnC7dWI02jwBBYc99W/PAYQMWWBYZSx0cnuH9jqi
        O2/Ebe7v1cJsj1xELWoQ8i411CizawE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663039870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ndgrk0VyINRbdMDLbO7l+2EY0nnzKQILkdX+lROM4VA=;
        b=N0gs0x3S8B8VEKQKEbSS/O8mzZ4fMxgFLeyBC06RZkXhl9gC6dsEmRE0DjDXS/MiQS8tHs
        OsFNtGuvgyAoUdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8358A13A86;
        Tue, 13 Sep 2022 03:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8tDhDXb5H2OFNQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 13 Sep 2022 03:31:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
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
In-reply-to: <20220913024109.GF3600936@dread.disaster.area>
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
 <20220913024109.GF3600936@dread.disaster.area>
Date:   Tue, 13 Sep 2022 13:30:58 +1000
Message-id: <166303985824.30452.7333958999671590160@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sep 2022, Dave Chinner wrote:
> 
> Indeed, we know there are many systems out there that mount a
> filesystem, preallocate and map the blocks that are allocated to a
> large file, unmount the filesysetm, mmap the ranges of the block
> device and pass them to RDMA hardware, then have sensor arrays rdma
> data directly into the block device. Then when the measurement
> application is done they walk the ondisk metadata to remove the
> unwritten flags on the extents, mount the filesystem again and
> export the file data to a HPC cluster for post-processing.....

And this tool doesn't update the i_version?  Sounds like a bug.

> 
> So how does the filesystem know whether data the storage contains
> for it's files has been modified while it is unmounted and so needs
> to change the salt?

How does it know that no data is modified while it *is* mounted?  Some
assumptions have to be made.

> 
> The short answer is that it can't, and so we cannot make assumptions
> that a unmount/mount cycle has not changed the filesystem in any
> way....

If a mount-count is the best that XFS can do, then that is certainly
what it should use.

Thanks,
NeilBrown
