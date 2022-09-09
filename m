Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55265B40E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiIIUo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 16:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIIUou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:44:50 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 13:44:35 PDT
Received: from mail.stoffel.org (li1843-175.members.linode.com [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD518E3C;
        Fri,  9 Sep 2022 13:44:28 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 7A8FB270B5;
        Fri,  9 Sep 2022 16:34:14 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 2733AA7E79; Fri,  9 Sep 2022 16:34:14 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25371.41798.87576.861659@quad.stoffel.home>
Date:   Fri, 9 Sep 2022 16:34:14 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-Reply-To: <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
References: <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
        <20220907125211.GB17729@fieldses.org>
        <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
        <20220907135153.qvgibskeuz427abw@quack3>
        <166259786233.30452.5417306132987966849@noble.neil.brown.name>
        <20220908083326.3xsanzk7hy3ff4qs@quack3>
        <YxoIjV50xXKiLdL9@mit.edu>
        <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
        <20220908155605.GD8951@fieldses.org>
        <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
        <20220908182252.GA18939@fieldses.org>
        <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "Jeff" == Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
>> On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
>> > Yeah, ok. That does make some sense. So we would mix this into the
>> > i_version instead of the ctime when it was available. Preferably, we'd
>> > mix that in when we store the i_version rather than adding it afterward.
>> > 
>> > Ted, how would we access this? Maybe we could just add a new (generic)
>> > super_block field for this that ext4 (and other filesystems) could
>> > populate at mount time?
>> 
>> Couldn't the filesystem just return an ino_version that already includes
>> it?
>> 

> Yes. That's simple if we want to just fold it in during getattr. If we
> want to fold that into the values stored on disk, then I'm a little less
> clear on how that will work.

I wonder if this series should also include some updates to the
various xfstests to hopefully document in code what this statx() call
will do in various situations.  Or at least document how to test it in
some manner?  Especially since it's layers on top of layers to make
this work. 

My assumption is that if the underlying filesystem doesn't support the
new values, it just returns 0 or c_time?

John
