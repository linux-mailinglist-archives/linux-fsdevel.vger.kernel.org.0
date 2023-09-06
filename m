Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1E7941DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbjIFRJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjIFRJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:09:24 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1FE70;
        Wed,  6 Sep 2023 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FWpTCScDc2IJPu/rDmaKRD0AarJbVA3tXHEgvVajiw8=; b=n/uj6GHth4cEC9GY4xgf5OJGbG
        TjRMmR2pg+2zx4CHFVi8+xhcCt12eeOXshBChESCaSkMQysn5OJ71LSBb/Vin1JsdVjIDpJm20Hvr
        z03tpCgC/bLKfqAFHmq7MIaO2in43DarR0HhTccEeNnILMXC6XSee6ZTQLO1C1Af0wayfe5EEOuIp
        LXCNco1EGVIJB7dZkMABbiALBVqUhApjm9T4jAOHcNGYX3PhkImf/nFYa2mLlGHOxnWhalX/aLPs7
        1X7DttFFaPn9JBLrjLp3bux1CDtDji1Buu68DfqByfJd7F47xRnAHPxYzO0/A7s4czcomjBwqjL0u
        EZkuLQeA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qdw1Q-0040ad-0I;
        Wed, 06 Sep 2023 17:08:56 +0000
Date:   Wed, 6 Sep 2023 18:08:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <20230906170856.GA800259@ZenIV>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:03:34PM +0200, Mikulas Patocka wrote:

> > IOW, you'd also hang on any umount of a bind-mount. IOW, every
> > single container making use of this filesystems via bind-mounts would
> > hang on umount and shutdown.
> 
> bind-mount doesn't modify "s->s_writers.frozen", so the patch does nothing 
> in this case. I tried unmounting bind-mounts and there was no deadlock.

You are making *any* mount destruction hang if the sucker is frozen.
Which includes the things like exit(2) of the last process within
a namespace, etc.

And it does include the things like mount --bind /usr/bin/gcc /tmp/cc; umount /tmp/cc
if /usr happened to be frozen at the moment.

This is really not an option.

> BTW. what do you think that unmount of a frozen filesystem should properly 
> do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount it? Or 
> something else?

It's not just umount(2).  It's exit(2).  And close(2).  And AF_UNIX garbage
collector taking out an undeliverable SCM_RIGHTS datagram that happens to
contain a reference to the last opened file on lazy-umounted fs, etc.
