Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7D34ED0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhC3QCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 12:02:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55237 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231794AbhC3QBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:01:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12UG0nHa013090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 12:00:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 32C5415C39CD; Tue, 30 Mar 2021 12:00:49 -0400 (EDT)
Date:   Tue, 30 Mar 2021 12:00:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        drosen@google.com, yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v5 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YGNLMRmr+tQb8WQ3@mit.edu>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-5-shreeya.patel@collabora.com>
 <YGKGhxaozX3ND6iB@gmail.com>
 <87v999pequ.fsf@collabora.com>
 <YGK7iNRXcMr/ahsL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGK7iNRXcMr/ahsL@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 10:47:52PM -0700, Eric Biggers wrote:
> > Isn't this a user problem?  If the modules required to boot are on the
> > filesystem itself, you are in trouble.  But, if that is the case, your
> > rootfs is case-insensitive and you gotta have utf8 as built-in or have
> > it in an early userspace.
> 
> We could make it the user's problem, but that seems rather unfriendly.
> Especially because the utf8 module would be needed if the filesystem has the
> casefold feature at all, regardless of whether any casefolded directories are
> needed at boot time or not.  (Unless there is a plan to change that?)

I guess I'm not that worried, since the vast majority of desktop
distribution are using initial ramdisks these days.  And if someone
did build a monolithic kernel that couldn't mount the root file
system, they would figure that out pretty quickly.

The biggest problem they would have with trying to enable encryption
or casefolding on the root file system is that if they are using Grub,
older versions of Grub would see an unknown incompat feature, and
immediately have heartburn, and refuse to touch whatever file system
/boot is located on.  If the distribution has /boot as a stand-alone
partition, that won't be a problem, but if you have a single file
system which includes the location of kernels and initrds' are
located, the moment you try set the encryption or casefold on the file
system, you're immediately hosed --- and if you do this on a laptop
while you are on an airplane, without thinking things through, and
without access to a rescue USB thumb drive, life can
get... interesting.  (Why, yes, I'm speaking from direct experience;
why do you ask?  :-)

So in comparison to making such a mistake, building a kernel that was
missing casefold, and needing to fall back to an older kernel is not
really that bad of a user experience.  You just have to fall back the
distro kernel, which most kernel developers who are dogfooding
bleeding kernels are probably smart enough keep one around.

We *could* teach ext4 to support mounting file systems that have
casefold, without having the unicode module loaded, which would make
things a bit better, but I'm not sure it's worth the effort.  We could
even make the argument that letting the system boot, and then having
access to some directories return ENOTSUPP would actually be a more
confusing user experience than a simple hard failure when we try
mounting the file system.

Cheers,

					- Ted
