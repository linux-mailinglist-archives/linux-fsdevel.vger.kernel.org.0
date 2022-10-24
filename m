Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26660AEA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJXPLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJXPKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6159AF187
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 06:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E598C61280
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 13:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B623C433C1;
        Mon, 24 Oct 2022 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666619069;
        bh=4Is8mqkb8UAx9edc/nC79pta6DLdQ0LGYNhlIjWDs3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prH5vMvMaURl6toLQVR+n0bmkEYkASsMWD8rJPz83HG+AuVWIt53iR2SmZJBZMxr9
         SXFYvjWkterPkEV8GeUsoxL9asTDOHbKtvFfjhgHX+T9MiPS/09897HmdtuFElX6WT
         9jIjqt6yIxYFcJybQHM5y6pAr6llppvsKMAsO2QfisLb/dfohKxbwmya64Ad9Vyv2V
         I58lCmVhSnyTXSDKJH4sRPYK1Qzwj6ru6OyrCmqBpmnHgQGiE/2RPoOJn/AyvhPaga
         u7zISsDfCNOLxIZvvj58bpK5OM0UtIp0eZvKhHcxXcITKYOlvR2cOq5pgHAaHPqmXQ
         H3jpMY3a6sjlA==
Date:   Mon, 24 Oct 2022 08:44:28 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
Message-ID: <Y1aWvBYi+DFl3HOi@do-x1extreme>
References: <20221020201409.1815316-1-davemarchevsky@fb.com>
 <CAEf4BzZi4jnyXi1OAVrQ+k0qTJdRViU6-T+oeUUeTZXTF8V5bA@mail.gmail.com>
 <20221022132213.p7nr2b7whgivl3f5@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022132213.p7nr2b7whgivl3f5@wittgenstein>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 22, 2022 at 03:22:13PM +0200, Christian Brauner wrote:
> On Fri, Oct 21, 2022 at 09:05:26AM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 20, 2022 at 1:14 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >
> > > This is a followup to a previous commit of mine [0], which added the
> > > allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> > > rearranges the order of checks in fuse_allow_current_process without
> > > changing functionality.
> > >
> > > [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> > > beginning of the function, with the reasoning that
> > > allow_sys_admin_access should be an 'escape hatch' for users with
> > > CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
> > >
> > > However, placing this new check first results in many capable() calls when
> > > allow_sys_admin_access is set, where another check would've also
> > > returned 1. This can be problematic when a BPF program is tracing
> > > capable() calls.
> > >
> > > At Meta we ran into such a scenario recently. On a host where
> > > allow_sys_admin_access is set but most of the FUSE access is from
> > > processes which would pass other checks - i.e. they don't need
> > > CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> > > call for each fs op. We also have a daemon tracing capable() with BPF and
> > > doing some data collection, so tracing these extraneous capable() calls
> > > has the potential to regress performance for an application doing many
> > > FUSE ops.
> > >
> > > So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> > > hatch' is checked last. Previously, if allow_other is set on the
> > > fuse_conn, uid/gid checking doesn't happen as current_in_userns result
> > > is returned. It's necessary to add a 'goto' here to skip past uid/gid
> > > check to maintain those semantics here.
> > >
> > >   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
> > >
> > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > ---
> > 
> > LGTM!
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > 
> > But I would also be curious to hear from Miklos or others whether
> > skipping uid/gid check if fc->allow_other is true wa an intentional
> > logic, oversight, or just doesn't matter. Because doing:
> 
> Originally, setting fc->allow_other granted access to everyone skipping
> all further permission checks.
> 
> When Seth (Cced) made it possible to mount fuse in userns
> fc->allow_other needed to be restricted to callers who are in the
> superblock's userns or a descendant of it. The reason is that an
> unprivileged user can mount a fuse filesystem with fc->allow_other
> turned on. But then the user could mess with processes outside its
> userns when they access the filesystem.
> 
> Without fc->allow_other it doesn't matter what userns the filesystem is
> accessed from as long as the uidgid is permissible. This could e.g.,
> happen if you unshare a userns but dont set{g,u}id.
> 
> In general, I see two obvious permission models. In the first model we
> restrict access to the owner of the mount by uidgid but also require
> callers to be within the userns hierarchy. If allow_other is specified
> the requirement would be relaxed to only require the caller to be within
> the userns hierarchy. That would make the permission checking
> consistent.
> 
> The second permission model would only require permissible uidgid by
> default and for allow other either permissible uidgid or for the caller
> to be within the userns hierarchy (Which is what you're asking about
> afaiu.).
> 
> I don't see any obvious reasons why this wouldn't work from a security
> perspective; maybe Seth has additional insights. The problem however is
> that it would be a non-trivial change for containers to lift the
> restriction now. It is quite useful to be able to mount a fuse
> filesystem with allow_other and not have it accessible by anything
> outside your userns hierarchy. So I wouldn't like to see that changed.

I think both of these are defensible models from a security perspective.
But I don't have a good idea of what container runtimes have come to
expect. Either of these would represent a change which could potentially
break assumptions of something in userspace.

Seth

> If so we should probably make it yet another fuse module option or sm.
> But in any case that should be a separate patch with a proper
> justification why this semantic change is needed other than that it
> simplifies the logic.
> 
