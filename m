Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE8493FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 19:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356784AbiASSaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 13:30:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42518 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356737AbiASSaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:30:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B3D4B81B08;
        Wed, 19 Jan 2022 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C61C340E1;
        Wed, 19 Jan 2022 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642617006;
        bh=dEcBVKy/pTvh9qFsuZNbinacCry4Xc/N2qu1yLmP2Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKScT8liWwzFg7Ff6pkJj5HCt1iUUPHBGlzwSD0IfXchFZYeG1SVPuLpTyl6sVsK2
         FYciVUDS/DfsrGBynx9nz4xJIaXhf322jGb4ySehjGogru4LL0TEQZCUMiOB6gegXx
         DAGkjr4X2tEWa/wMLw7o7aPQC3DBTE98I+4ZnP5qkF77Sen2bpISTRbqgt4DPi59dx
         he8xhPtDBm6dewNR2eW9/m5+mfSrFIg1x250YavQAVD5nie6cwcuq10KN6UvpOYLAm
         So3gg+4pJiWJ2bVzlscOFgLz+X+nZrX8XmGX+kAWcLcu888xPQvaVgtZ9Ci1Bu2rUG
         mq2e0qz93OK+w==
Date:   Wed, 19 Jan 2022 19:30:00 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stephen.s.brennan@oracle.com, cyphar@cyphar.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <20220119183000.agmteejsb46dlkyj@example.org>
References: <YegysyqL3LvljK66@localhost.localdomain>
 <20220119162423.eqbyefywhtzm22tr@wittgenstein>
 <20220119171522.pxmkbt5eu3rs5yik@example.org>
 <20220119173107.tcsrjml4ujrdcqyh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119173107.tcsrjml4ujrdcqyh@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:31:07PM +0100, Christian Brauner wrote:
> On Wed, Jan 19, 2022 at 06:15:22PM +0100, Alexey Gladkov wrote:
> > On Wed, Jan 19, 2022 at 05:24:23PM +0100, Christian Brauner wrote:
> > > On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > > > From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > > > From: Alexey Dobriyan <adobriyan@gmail.com>
> > > > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > > > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > > > 
> > > > Docker implements MaskedPaths configuration option
> > > > 
> > > > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > > > 
> > > > to disable certain /proc files. It overmounts them with /dev/null.
> > > > 
> > > > Implement proper mount option which selectively disables lookup/readdir
> > > > in the top level /proc directory so that MaskedPaths doesn't need
> > > > to be updated as time goes on.
> > > 
> > > I might've missed this when this was sent the last time so maybe it was
> > > clearly explained in an earlier thread: What's the reason this needs to
> > > live in the kernel?
> > > 
> > > The MaskedPaths entry is optional so runtimes aren't required to block
> > > anything by default and this mostly makes sense for workloads that run
> > > privileged.
> > > 
> > > In addition MaskedPaths is a generic option which allows to hide any
> > > existing path, not just proc. Even in the very docker-specific defaults
> > > /sys/firmware is covered.
> > > 
> > > I do see clear value in the subset= and hidepid= options. They are
> > > generally useful independent of opinionated container workloads. I don't
> > > see the same for lookup=.
> > > 
> > > An alternative I find more sensible is to add a new value for subset=
> > > that hides anything(?) that only global root should have read/write
> > > access too.
> > 
> > Or we can allow to change permissions in the procfs only in the direction
> > of decreasing (if some file has 644 then allow to set 640 or 600). In this
> > case, we will not need to constantly check the whitelist.
> 
> I don't fancy any filtering or allowlist approach. I find that rather
> inelegant.

Yep. I also don't find it very convenient if you need to allow more than
one or two files. That's why I didn't do anything like that when I
implemented subset=.

> But if I understand you correctly is that if we were to have
> decreasing permissions we could allow a (namespace) procfs-admin to set
> permissions so that the relevant files are essentially read-only or not
> even readable at all for container workloads. So once you've lowered
> perms you can't raise them which ensures even namespace procfs-admin
> can't raise them again.

Yes. This is what I meant.

> Might work as well. But that implies that we wouldn't need any allowlist
> at all afaict.

Yes, in this case we don't need a list.

-- 
Rgrds, legion

