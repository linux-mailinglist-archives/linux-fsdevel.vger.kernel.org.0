Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77FB495057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbiATOhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 09:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiATOht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:37:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CCFC061574;
        Thu, 20 Jan 2022 06:37:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EDAB617C6;
        Thu, 20 Jan 2022 14:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C7AC340E0;
        Thu, 20 Jan 2022 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642689467;
        bh=g+oxM2J81EeSrKkemxOsGMCNcdknSpVI4hLP1FM05Xs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MnZcO5TzvNwS9pEOr4S5gVif6UGpwSNbnSXXJZh6XS93LaIl7LTP62I8ziVCBTyMI
         +COlt3mR5w8dKC1SKfDAX9jqXm4bPbD9AFcHYM0dy4jO+J15kEl7YYCF6ElVuV/hSz
         ikpdf0P27ZIVK6AhiRfOve0DDJfwuGpEqkzdcLHzY/vf4ke09D26D/af1LzBgMJFIV
         I60YCraKJXRkTGaGrXphPq3gFukh+0zhz0Z3sz1DqbsJ7jaO7YSSM8CAk8+a6IKqgE
         hjl4Ba9JZ7o7SBtFgL/B+4oMlame9nnpajA2uKu3ImpOXXYG+dThM3Y01S8GpF1Pzl
         R0L/sMo0ns8mg==
Date:   Thu, 20 Jan 2022 15:37:42 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stephen.s.brennan@oracle.com,
        legion@kernel.org, cyphar@cyphar.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <20220120143742.saz5yh5mlkg43yxl@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YelWXWKZkR//mD8i@localhost.localdomain>
 <YelUKIOjLd7A9XQN@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:32:29PM +0300, Alexey Dobriyan wrote:
> On Wed, Jan 19, 2022 at 05:24:23PM +0100, Christian Brauner wrote:
> > On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > > From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > > From: Alexey Dobriyan <adobriyan@gmail.com>
> > > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > > 
> > > Docker implements MaskedPaths configuration option
> > > 
> > > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > > 
> > > to disable certain /proc files. It overmounts them with /dev/null.
> > > 
> > > Implement proper mount option which selectively disables lookup/readdir
> > > in the top level /proc directory so that MaskedPaths doesn't need
> > > to be updated as time goes on.
> > 
> > I might've missed this when this was sent the last time so maybe it was
> > clearly explained in an earlier thread: What's the reason this needs to
> > live in the kernel?
> 
> The reasons are:
> 	MaskedPaths or equivalents are blacklists, not future proof
> 
> 	MaskedPaths is applied at container creation once,
> 	lookup= is applied at mount time surely but names aren't
> 	required to exist to be filtered (read: some silly ISV module
> 	gets loaded, creates /proc entries, containers get them with all
> 	security holes)
> 
> > The MaskedPaths entry is optional so runtimes aren't required to block
> > anything by default and this mostly makes sense for workloads that run
> > privileged.
> > 
> > In addition MaskedPaths is a generic option which allows to hide any
> > existing path, not just proc. Even in the very docker-specific defaults
> > /sys/firmware is covered.
> 
> Sure, the patch is for /proc only. MaskedPaths can't overmount with
> /dev/null file which doesn't exist yet.
> 
> > I do see clear value in the subset= and hidepid= options. They are
> > generally useful independent of opinionated container workloads. I don't
> > see the same for lookup=.
> > 
> > An alternative I find more sensible is to add a new value for subset=
> > that hides anything(?) that only global root should have read/write
> > access too.

On Thu, Jan 20, 2022 at 03:23:04PM +0300, Alexey Dobriyan wrote:
> On Wed, Jan 19, 2022 at 05:24:23PM +0100, Christian Brauner wrote:
> > On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > > From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > > From: Alexey Dobriyan <adobriyan@gmail.com>
> > > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > > 
> > > Docker implements MaskedPaths configuration option
> > > 
> > > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > > 
> > > to disable certain /proc files. It overmounts them with /dev/null.
> > > 
> > > Implement proper mount option which selectively disables lookup/readdir
> > > in the top level /proc directory so that MaskedPaths doesn't need
> > > to be updated as time goes on.
> > 
> > I might've missed this when this was sent the last time so maybe it was
> > clearly explained in an earlier thread: What's the reason this needs to
> > live in the kernel?
> > 
> > The MaskedPaths entry is optional so runtimes aren't required to block
> > anything by default and this mostly makes sense for workloads that run
> > privileged.
> > 
> > In addition MaskedPaths is a generic option which allows to hide any
> > existing path, not just proc. Even in the very docker-specific defaults
> > /sys/firmware is covered.
> 
> MaskedPaths is not future proof, new entries might pop up and nobody
> will update the MaskedPaths list.
> 
> > I do see clear value in the subset= and hidepid= options. They are
> > generally useful independent of opinionated container workloads. I don't
> > see the same for lookup=.
> 
> The value is if you get /proc/cpuinfo you get everything else
> but you might not want everything else given that "everything else"
> changes over time.
> 
> > An alternative I find more sensible is to add a new value for subset=
> > that hides anything(?) that only global root should have read/write
> > access too.

Thanks for providing some more details.

If we really introduce new proc files in the future that are unsafe for
unprivileged containers then that's a whole bigger problem.

We shouldn't taper over this with a procfs mount option however.
Especially, since it's very likely that such new procfs files that would
be exploitable in unprivileged containers would also be exploitable by
regular users. The argument can't be that in order to protect against
buggy or information leaking future proc files we need to give proc a
special mount option for containers to restrict access to files and
directories.

And for the legacy files that existed before containers were a big thing
MaskedPath in userspace has worked fine with the last changes to update
the list from 2018 for the addition of a rather old directory.

And the same problem exists for sysfs. That's why /sys/firmware is in
there. (In fact, it can be argued that they should restrict sysfs way
more via MaskedPaths than procfs for privileged containers since it
leaks way more system-wide information and provides a way bigger attack
surface which is presumable why the mount is ro but then strangely only
hide /sys/firmware. Anyway, besides the point.)

MaskedPath is mostly a protection mechanism useful for privileged
containers as an unprivileged container can't modify anything that would
allow it to attack the system.

Ultimately, I think the current proposal here is too much modeled after
how a specific tool runs specific workloads and for containers and I
don't think that's a good idea.

We should do a generally useful thing that doesn't require any dynamic
filtering and userspace giving us files that are ok to show.

Alternative proposals to appear later in the thread. I'd be ok to
endorse one of those if you were to implement one of them. But for now
I'm not firmly convinced of lookup=.
