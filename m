Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9E6F96C8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 06:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEGEHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 00:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEGEHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 00:07:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19F6E93;
        Sat,  6 May 2023 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLqW3A8uvrQKdQ+R/YhjIAPZpVxWxhu3RtWv9DAK988=; b=cXF19qNrhPAS5lhAEG1Eiyl7s6
        T3oTY1ROOpt/4hqPjTYzOMLuEDeYe72pF/F4pB+DDfr4FwDyj1cvSbhrtI+5lUA7OpwxYBL5gJYGu
        wudqpf5sXuM7Yb8G7XIMsDmfzIFSJlmM3OriHXgYPfzrLSbMew4LucT/X84yQ4DsNnXBy9QmtrjaF
        1c2pEH7FO6Jpzy8pKh/lEnlx8OFcn+XUKweDRI8MZdbXssBfszJ+xOzthdNYjoHrSD4Ad7hDO8eOn
        iY/EEYDD7TxlvMC52IxSBnFsyE+CiqBNtI0mLgBeB0NZtLovvs3A4c1DyuGfSVw3dg7C0DvoZpgMJ
        3HHrML2A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvVgS-00F7Q5-0j;
        Sun, 07 May 2023 04:07:40 +0000
Date:   Sat, 6 May 2023 21:07:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     hch@infradead.org, song@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 05/24] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <ZFckDPpgpbvZBFyL@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-6-mcgrof@kernel.org>
 <Y/gqNaP4mrSMaDJo@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/gqNaP4mrSMaDJo@magnolia>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 23, 2023 at 07:08:37PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 13, 2023 at 04:33:50PM -0800, Luis Chamberlain wrote:
> > Add support to automatically handle freezing and thawing filesystems
> > during the kernel's suspend/resume cycle.
> > 
> > This is needed so that we properly really stop IO in flight without
> > races after userspace has been frozen. Without this we rely on
> > kthread freezing and its semantics are loose and error prone.
> > For instance, even though a kthread may use try_to_freeze() and end
> > up being frozen we have no way of being sure that everything that
> > has been spawned asynchronously from it (such as timers) have also
> > been stopped as well.
> > 
> > A long term advantage of also adding filesystem freeze / thawing
> > supporting during suspend / hibernation is that long term we may
> > be able to eventually drop the kernel's thread freezing completely
> > as it was originally added to stop disk IO in flight as we hibernate
> > or suspend.
> 
> Hooray!
> 
> One evil question though --
> 
> Say you have dm devices A and B.  Each has a distinct fs on it.
> If you mount A and then B and initiate a suspend, that should result in
> first B and then A freezing, right?
> 
> After resuming, you then change A's dm-table definition to point it
> at a loop device backed by a file on B.
> 
> What happens now when you initiate a suspend?  B freezes, then A tries
> to flush data to the loop-mounted file on B, but it's too late for that.
> That sounds like a deadlock?
> 
> Though I don't know how much we care about this corner case,

As you suggest this is not the only corner case that one could draw
upon. There was that evil ioctl added years ago to allow flipping an
installed system bootted from a USB or ISO over to the real freshly
installed root mount point. To make this bullet-proof we'll need to
eventually add a simple graph implementation to keep tags on ordering
requirements for the super blocks. I have some C code which tries to
implement a graph Linux style but since these are all corner cases at
this time, I think it's best we fix first suspend for most and later
address a proper graph solution.

> Anyway, just wondering if you'd thought about that kind of doomsday
> scenario that a nutty sysadmin could set up.
> 
> The only way I can think of to solve that kind of thing would be to hook
> filesystems and loop devices into the device model, make fs "device"
> suspend actually freeze, hope the suspend code suspends from the leaves
> inward, and hope I actually understand how the device model works (I
> don't.)

There's probably really odd things one can do, and one thing I think
we can later do is simply annotate those cases and *not* allow auto-freeze
with time for those horrible situations.

A real long term solution I think will involve a graph.

  Luis
