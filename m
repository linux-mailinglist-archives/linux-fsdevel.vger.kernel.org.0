Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3167C83B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjAZKQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 05:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjAZKQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF65B75D;
        Thu, 26 Jan 2023 02:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E157CB81D57;
        Thu, 26 Jan 2023 10:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B214C433D2;
        Thu, 26 Jan 2023 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728173;
        bh=ox2ZCY8+PGvbN6EfZtcC+V0cntnRb2OjSdez+qfafks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIzkcWdQaWb0la/QU4Vx4XmurQGQSnyeEOOzWhh8zoM9NdoF628MVo0tEshzAgEpP
         5Equ2e5kmAKPLaiw77x4RUJOBbtsorlfAz1G04I2/kqNrdDyoY+C43WRsJz9rWGByu
         UprOCeHDT4ken9In3mH4QoCnI3X/f21T2C1xQh4digT5hrjjlKpGRXy5MM/GD8S4Py
         5NCPFEVpO3zC8Ql7MvMwKRNpre6bf0B4N+FB4ywj3tujB/gLN8RZeb2UpFbs+ddVml
         cLmsBgzYIyYb9mCGKdd0CVC0kTYPyjOqRVhgNu0IIHigEUmeO2p3qVWm9OaaC3c4HC
         JYy0bhsCah5iw==
Date:   Thu, 26 Jan 2023 11:16:07 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Val Cowan <vcowan@redhat.com>
Subject: Re: [RFC PATCH v1 0/6] proc: Add allowlist for procfs files
Message-ID: <20230126101607.b4de35te7gcf6mkn@wittgenstein>
References: <cover.1674660533.git.legion@kernel.org>
 <20230125153628.43c12cbe05423fef7d44f0dd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230125153628.43c12cbe05423fef7d44f0dd@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:36:28PM -0800, Andrew Morton wrote:
> On Wed, 25 Jan 2023 16:28:47 +0100 Alexey Gladkov <legion@kernel.org> wrote:
> 
> > The patch expands subset= option. If the proc is mounted with the
> > subset=allowlist option, the /proc/allowlist file will appear. This file
> > contains the filenames and directories that are allowed for this
> > mountpoint. By default, /proc/allowlist contains only its own name.
> > Changing the allowlist is possible as long as it is present in the
> > allowlist itself.
> > 
> > This allowlist is applied in lookup/readdir so files that will create
> > modules after mounting will not be visible.
> > 
> > Compared to the previous patches [1][2], I switched to a special virtual
> > file from listing filenames in the mount options.
> > 
> 
> Changlog doesn't explain why you think Linux needs this feature.  The
> [2/6] changelog hints that containers might be involved.  IOW, please
> fully describe the requirement and use-case(s).
> 
> Also, please describe why /proc/allowlist is made available via a mount
> option, rather than being permanently present.
> 
> And why add to subset=, instead of a separate mount option.
> 
> Does /proc/allowlist work in subdirectories?  Like, permit presence of
> /proc/sys/vm/compact_memory?
> 
> I think the whole thing is misnamed, really.  "allowlist" implies
> access permissions.  Some of the test here uses "visibility" and other
> places use "presence", which are better.  "presentlist" and
> /proc/presentlist might be better.  But why not simply /proc/contents?

Currently, a lot of container runtimes - even if they mount a new procfs
instance - overmount various procfs files and directories to ensure that
they're hidden from the container workload. (The motivations for this
are mixed and usually it's only needed for containers that run with the
same privilege level as the host.)

The consequence of overmounting is that we need to refuse mounting
procfs again somewhere else otherwise the procfs instance might reveal
files and directories that were supposed to be hidden.

So this patchset moves the ability to hide entries into the kernel
through an allowlist. This way you can hide files and directories while
being able to mount procfs again because it will inherit the same
allowlist.

I get the motivation. The question is whether this belongs into the
kernel at all. I'm unfortunately not convinced.

This adds a lot of string parsing to procfs and I think we would also
need to decide what a reasonable maximum limit for such allowlists would
be. The data structure likely shouldn't be a linked list but at least an
rbtree especially if the size isn't limited.

But fundamentally I think it moves something that should be and
currently is a userspace policy into the kernel which I think is wrong.
Sure you can't predict what files show up in procfs over time but then
subset=pid is already your friend - even if not as fine-grained.

If this where another simple subset style mount option that allowlists a
bunch of well-known global proc files then sure. But making this
dynamically configurable from userspace doesn't make sense to me. I
mean, users could write /gobble/dy/gook into /proc/allowlist or use it
to stash secrets or hashes or whatever as we have no way of figuring out
whether the entry they allowlist does or will actually ever exist.

In general, such flexibility belongs into userspace imho.

Frankly, if that is really required it would almost make more sense to
be able to attach a new bpf program type to procfs that would allow to
filter procfs entries. Then the filter could be done purely in
userspace. If signed bpf lands one could then even ship signed programs
that are attachable by userns root.
