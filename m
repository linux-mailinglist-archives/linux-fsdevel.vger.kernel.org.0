Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA1493EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356342AbiASRP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 12:15:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38758 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbiASRP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:15:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6D0615D4;
        Wed, 19 Jan 2022 17:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB42CC004E1;
        Wed, 19 Jan 2022 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642612526;
        bh=kCmGFegGU0UXJw0qYj9i8M/LOTJRUthX1RUxcIMfmRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpIB2rKKcRlMbs+T3L5MjMesiEMgkqpstfj8SXlscXPIIHiA334UkJieeWdPMClMd
         1xiJWopadQ0YfHcI/3NR1N8Kjn9PHWG+aGKKssXcfwMp/DYoEmzzK/jNQYPcB7ULvS
         gUXIh0SpL0reB5VjYcQIh0l7NcwWblGzHBqU73AFOpf43QyQ90nqMulGaqhOz+/u2S
         ZRLX2rxKPIbn8UVVdzrz4sV9Rbuz94gSeJTn0/O1nqdc7oOQCGRtbgrCMouS75W5nz
         LZLFc0pjdx4u5dASvHNX0QBT6G9Hr82hiO+BJyAwckRLDmG3xbkdf/m2+uEElTwHT/
         dlsoEWyxYu1Cg==
Date:   Wed, 19 Jan 2022 18:15:22 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stephen.s.brennan@oracle.com, cyphar@cyphar.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <20220119171522.pxmkbt5eu3rs5yik@example.org>
References: <YegysyqL3LvljK66@localhost.localdomain>
 <20220119162423.eqbyefywhtzm22tr@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119162423.eqbyefywhtzm22tr@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:24:23PM +0100, Christian Brauner wrote:
> On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > 
> > Docker implements MaskedPaths configuration option
> > 
> > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > 
> > to disable certain /proc files. It overmounts them with /dev/null.
> > 
> > Implement proper mount option which selectively disables lookup/readdir
> > in the top level /proc directory so that MaskedPaths doesn't need
> > to be updated as time goes on.
> 
> I might've missed this when this was sent the last time so maybe it was
> clearly explained in an earlier thread: What's the reason this needs to
> live in the kernel?
> 
> The MaskedPaths entry is optional so runtimes aren't required to block
> anything by default and this mostly makes sense for workloads that run
> privileged.
> 
> In addition MaskedPaths is a generic option which allows to hide any
> existing path, not just proc. Even in the very docker-specific defaults
> /sys/firmware is covered.
> 
> I do see clear value in the subset= and hidepid= options. They are
> generally useful independent of opinionated container workloads. I don't
> see the same for lookup=.
> 
> An alternative I find more sensible is to add a new value for subset=
> that hides anything(?) that only global root should have read/write
> access too.

Or we can allow to change permissions in the procfs only in the direction
of decreasing (if some file has 644 then allow to set 640 or 600). In this
case, we will not need to constantly check the whitelist.

-- 
Rgrds, legion

