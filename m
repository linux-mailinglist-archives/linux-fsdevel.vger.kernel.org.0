Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B995A9AE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiIAOuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiIAOuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:50:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298432BAC;
        Thu,  1 Sep 2022 07:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5CF061DE5;
        Thu,  1 Sep 2022 14:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753EBC4314A;
        Thu,  1 Sep 2022 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662043833;
        bh=Eme6Jpl1dpN6KSO3d/NwtB8aYk/1sMq97j6D1VP3rXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDuqUoZqJmDmnf8DgGXRAR3l5RAEaKbXeIimHUIoM8y2hn5Ps3WAgNJKp87I+1KGQ
         MRaelA0wd8mIa05A+94C2vs2vG0R1QLLKRKozoNuk9cWV0Avwy5MPJ8kpYUgRaZdd0
         IbafHfWY64tCPL35xigTonhroAHZ6mRAfeCy8B+vSGxpimwGdxzxXVmKNvSOpsZZSZ
         h5yelfm84qc2JcKSxSmCAY8EKstAAL4AWsVfDoX9nZYGt35V3PwKUZtt3XzTrmBI3G
         nHKZJC5l4LnBZfCW2LOfbmZX95QJZ4zWDId/cz69lAX6VWYz7UQHGvlD3T0KDrzrTe
         ZWudog5ZyEVBw==
Date:   Thu, 1 Sep 2022 16:50:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Jenkins <sethjenkins@google.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Jann Horn <jannh@google.com>,
        Natalie Silvanovich <natashenka@google.com>
Subject: Re: fsconfig parsing bugs
Message-ID: <20220901145028.3lndphzrylsyqx5o@wittgenstein>
References: <CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:12:21PM -0700, Seth Jenkins wrote:
> The codebase-wide refactor efforts to using the latest fs mounting API
> (with support for fsopen/fsconfig/fsmount etc.) have introduced some
> bugs into mount configuration parsing in several parse_param handlers,
> most notably shmem_parse_one() which can be accessed from a userns.
> There are several cases where the following code pattern is used:
> 
> ctx->value = <expression>
> if(ctx->value is invalid)
>    goto fail;
> ctx->seen |= SHMEM_SEEN_X;
> break;
> 
> However, this coding pattern does not work in the case where multiple
> fsconfig calls are made. For example, if I were to call fsconfig with
> the key "nr_blocks" twice, the first time with a valid value, and the
> second time with an invalid value, the invalid value will be persisted
> and used upon creation of the mount for the value of ctx->blocks, and
> consequently for sbinfo->max_blocks.
> 
> This code pattern is used for Opt_nr_blocks, Opt_nr_inodes, Opt_uid,
> Opt_gid and Opt_huge. Probably the proper thing to do is to check for
> validity before assigning the value to the shmem_options struct in the
> fs_context.
> 
> We also see this code pattern replicated throughout other filesystems
> for uid/gid resolution, including hugetlbfs, FUSE, ntfs3 and ffs.
> 
> The other outstanding issue I noticed comes from the fact that
> fsconfig syscalls may occur in a different userns than that which
> called fsopen. That means that resolving the uid/gid via
> current_user_ns() can save a kuid that isn't mapped in the associated
> namespace when the filesystem is finally mounted. This means that it
> is possible for an unprivileged user to create files owned by any
> group in a tmpfs mount (since we can set the SUID bit on the tmpfs
> directory), or a tmpfs that is owned by any user, including the root
> group/user. This is probably outside the original intention of this
> code.
> 
> The fix for this bug is not quite so simple as the others. The options
> that I've assessed are:
> 
> - Resolve the kuid/kgid via the fs_context namespace - this does
> however mean that any task outside the fsopen'ing userns that tries to
> set the uid/gid of a tmpfs will have to know that the uid/gid will be
> resolved by a different namespace than that which the current task is
> in. It also subtly changes the behavior of this specific subsystem in
> a userland visible way.
> - Globally disallow fsconfig calls originating from outside the
> fs_context userns - This is a more robust solution that would prevent
> any similar bugs, but it may impinge on valid mount use-cases. It's
> the best from a security standpoint and if it's determined that it was
> not in the original intention to be juggling user/mount namespaces
> this way, it's probably the ideal solution.
> - Throw EINVAL if the kuid specified cannot be mapped in the mounting
> userns (and/or potentially in the fs_context userns) - This is
> probably the solution that remains most faithful to all potential
> use-cases, but it doesn't reduce the potential for variants in the
> future in other parts of the codebase and it also introduces some
> slight derivative logic bug risk.
> - Don't resolve the uid/gid specified in fsconfig at all, and resolve
> it during mount-time when calling an associated fill_super. This is
> precedented and used in other parts of the codebase, but specificity
> is lost in the final error case since an end-user cannot easily
> attribute a mount failure to an unmappable uid.
> 
> I've also attached a PoC for this bug that demonstrates that an
> unprivileged user can create files/directories with root uid/gid's.
> There is no deadline for this issue as we can't see any obvious way to
> cross a privilege boundary with this.
> 
> Thanks in advance!

I'm involved in 2 large projects that make use of the new mount api LXC
and CRIU. None of them call fsconfig() outside of the target user
namespace. util-linux mount(2) does not yet use the new mount api and so
can't be affected either but will in maybe even the next release.
Additionally, glibc 2.36 is the first glibc with support for the new
mount api which just released. So all users before that users would have
to write their own system call wrappers so I think we have some liberty
here.

I think this is too much of a restriction to require that fsopen() and
fsconfig() userns must match in order to set options. It is pretty handy
to be able to set mount options outside of fc->user_ns. And we'd
definitely want to make use of this in the future.

So ideally, we just switch all filesystems that are mountable in userns
over to use fc->user_ns. There's not really a big regression risk here
because it's not used in userns workloads widely today. Taking a close
look, the affected filesystems are devpts and tmpfs. Having them rely on
fc->user_ns aligns them with how fuse does it today.
