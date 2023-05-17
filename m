Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CDF70632D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQImM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEQImJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 04:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C540EB;
        Wed, 17 May 2023 01:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB5F643DD;
        Wed, 17 May 2023 08:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1A7C4339B;
        Wed, 17 May 2023 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684312926;
        bh=y5rNYTCK24sBOFH/DDM1uE5j7eiHufArqqMrAhBdS9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i//+2zBmrwWxuchxh/oZtXfe8+Xywc7Bzk3cttN85Y2AXEiJU5OHtfSotoRP0jTpc
         +dop2fdw44+QfPHtNAusE9v4UmzgmbApa2brRtSXKJFLXvl9YUmUVpR2bPKrhauSAe
         l5LOsidPnAIVaD//NIvEkDwMOxwa8grQxA59jA52BSvs0F+kVkHzXULfFPYYB8N3Ir
         8rOS6J8fN7gE7Piqg9Y+M+18mXE/oS2L7CPPMmwjshGCvTIzGE+f9jaNeEusNEOnri
         ZdBPU9thAjh3Jo0MYicw2iJ7Py8O47w5cK1ZRE54FKikc0XSH6glI5Ea8GaWqJ4BRO
         Gs8A3yOuQX4zg==
Date:   Wed, 17 May 2023 10:42:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <20230516-kommode-weizen-4c410968c1f6@brauner>
 <20230517073031.GF27026@lst.de>
 <20230517-einreden-dermatologisch-9c6a3327a689@brauner>
 <20230517080613.GA31383@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517080613.GA31383@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 10:06:13AM +0200, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 09:57:55AM +0200, Christian Brauner wrote:
> > BTW, why is there no code to lookup a bdev by O_PATH fd? It seems weird
> > that a lot of ioctls pass the device path to the kernel (btrfs comes to
> > mind). I can see certain things that would make this potentially a bit
> > tricky e.g., you'd not have access to the path/name of the device if you
> > want to show it somewhere such as in mountinfo but nothing that makes it
> > impossible afaict.
> 
> As far as I can tell you should be able to hold a reference to a block
> device file descriptor with an O_PATH fd.   Or did I miss something
> that specifically prohibits that?

So with an O_PATH fd the device wouldn't really be opened at all we'd
just hold a reference to a struct file with f->f_op set to empty_fops.
(See the FMODE_PATH code in fs/open.c:do_dentry_open().)

So blkdev_open() is never called for O_PATH fds. Consequently an O_PATH
fd to a block device would only be useful if the intention is to later
lookup the block device based on inode->i_rdev.

So my earlier question should have been why there's no method to lookup
a block device purely by non-O_PATH fd since that way you do actually
pin the block device which is probably what you almost always want to do.

I'm asking because it would be nice if we could allow callers to specify
the source of a filesystem mount as an fd and not just as a string as
the mount api currently does. That's probably not super straightforward
but might be really worth it.
