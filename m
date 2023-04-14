Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCA6E22F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDNMSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDNMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96D4ED5;
        Fri, 14 Apr 2023 05:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F4B62B8E;
        Fri, 14 Apr 2023 12:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85FBC433EF;
        Fri, 14 Apr 2023 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681474694;
        bh=UJRnRwMDdJKyFpfs9zZImk+FikHL46ZZUZRTklxw/v8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hy5B+Oz1ZW3mRlo8qhrzy85WhdiN+gjLCUUk4dUY/i1RnydMBsSpOOQ3itCCtrYF8
         nSVis2GMcakgIS45HdFsAyfmQNtu00PNVlPHHBq1vom2neGPzoOK9s0pDTr4C599uw
         dpbSOyTuUonBN1IM2qlqKJKPq8n2IJ5NEGlbWk/1AG8WnextAA452nn3p7xqoRySYY
         /g00/QZjgKx37Czy67YoXs9wIC6qcFJ6vqlb7SYpR6fwXnM11lg5YS4IYZUVOyDUJ3
         0M7YI4yXGtm0bdDKRlMBWR0T4yUJrLMpCO2jA0b2TgwXpkafEh/uJ2y0bF+I5gnAQ1
         NEwbXoS/Srvaw==
Date:   Fri, 14 Apr 2023 14:18:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Message-ID: <20230414-insignien-fordern-07551443dccd@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <20230414023211.GE3390869@ZenIV>
 <8d2c619d2a91f3ac925fbc8e4fc467c6b137ab14.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d2c619d2a91f3ac925fbc8e4fc467c6b137ab14.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:01:59AM -0400, Jeff Layton wrote:
> On Fri, 2023-04-14 at 03:32 +0100, Al Viro wrote:
> > On Thu, Apr 13, 2023 at 06:00:42PM -0400, Jeff Layton wrote:
> > 
> > > It describes a situation where there are nested NFS mounts on a client,
> > > and one of the intermediate mounts ends up being unexported from the
> > > server. In a situation like this, we end up being unable to pathwalk
> > > down to the child mount of these unreachable dentries and can't unmount
> > > anything, even as root.
> > 
> > So umount -l the stuck sucker.  What's the problem with that?
> > 
> 
> You mean lazy umount the parent that is stuck? What happens to the child
> mount in that case? Is it also eventually cleaned up?

I hope it's ok I barge in to answer this but due to the mount beneath
patches I was working on I did spend even more time in that code then I
already did. So this is good chance to get yelled at if I analyzed these
codepaths wrong.

The child mount would be unmounted in that case. umount_tree() is what
you want to be looking at.

If you perform a regular umount _without_ MNT_DETACH you can see that
umount_tree() is effectively guarded by a call to propagate_mount_busy().
It checks wether the direct umount target has any child mounts and if so
refuses the umount with EBUSY:

        mkdir -p /mnt/a/b /mnt/c /mnt/d

	# Create parent mount of a@c
        mount --bind /mnt/a /mnt/c

	# create child d@b which as child mount of a@c
        mount --bind /mnt/d /mnt/c/b

If you call umount /mnt/c it will fail because a@c has child mounts.
If you do a lazy umount via MNT_DETACH through umount -l /mnt/c then it
will also unmount all children of a@c. In fact it will even include
children of children...

	mkdir /mnt/c/b/e
	mount --bind /mnt/a/b/ /mnt/c/b/e
	umount -l /mnt/c

That's basically what the next_mnt() loop at the beginning of
umount_tree() is doing where it collects all direct targets to umount.

However, if mount propagation is in play things get a lot nastier as you
can fail a non-MNT_DETACH umount because of it as well (Note that umount
propagation is always triggered if the parent mount of your direct
umount target is a shared mount. IOW, you can't easily opt out of it
unless you make the parent mount of your immediate umount target a
non-shared mount.).

A trivial reason that comes to mind where you would fail the umount due
to mount propagation would where a propagated mount is kept busy and not
the original mount. So similar to above on the host do:

        mkdir -p /mnt/a/b /mnt/c /mnt/d
        mount --bind /mnt/a /mnt/c
        umount /mnt/c

and you would expect the umount /mnt/c to work. But you realize it fails
with EBUSY but noone is referencing that mount anymore at least not in
an obvious way.

But assume someone had a mount namespace open that receives mount
propagation from /. In that case the a@c mount would have propagated
into that mount namespace. So someone could've cd /mnt/c into that
propagated mount and the umount /mnt/c would fail.

In that case propagate_mount_busy() would detect the increased refcount
when it tries to check whether the umount could be propagated and give
you EBUSY. So here you also need a lazy umount to get rid of that
mount... And there are other nice scenarios where that's hard to figure
out.
