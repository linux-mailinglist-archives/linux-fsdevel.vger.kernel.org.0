Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93B50F5ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345790AbiDZIw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 04:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbiDZIvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705121586FC;
        Tue, 26 Apr 2022 01:39:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC7460C35;
        Tue, 26 Apr 2022 08:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C03FC385AF;
        Tue, 26 Apr 2022 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650962384;
        bh=9T2ffXqjCfcNpUZk7gYL7RRo2izhSgNhF3sPB0NOowQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyWKKAciiS0ZgoTQNZKTCio6tapex5vzvaFYG1DB0ze94bfdA8/54uJsrL6nfGB/O
         /ZQHyvlpM2ae4HkvfHhnIREWWmGozZG3O8vVhoo40cxk1/ooiRdYJzVyD4o2s+Td8c
         Y3Wp0SSOOm8bH2nbsFxItQfVYNBoFUTgOoe2X2xB0+3qxonBXKgbdsm1Pv08YLfspb
         P2mAG5e04m6y8EuyJ7xt+aU8NlaY8wwFRhW8XwLZI8Od0i4jW6qYfqaDUgJ0D4iPGp
         41dVdUoW2G+ZeksH0KwxYmsj02las1JQsnnPCJWh6AR80WbtXLJ9Xn49Ty9iT40uNm
         +A6afqr3fA19w==
Date:   Tue, 26 Apr 2022 10:39:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v7 1/4] fs: move sgid stripping operation from
 inode_init_owner into mode_strip_sgid
Message-ID: <20220426083933.74jjezusejrpsi6z@wittgenstein>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426070648.3k6dahljcjhpggur@wittgenstein>
 <6267B003.3050602@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6267B003.3050602@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:39:07AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/26 15:06, Christian Brauner wrote:
> > On Tue, Apr 26, 2022 at 12:19:49PM +0800, Yang Xu wrote:
> >> This has no functional change. Just create and export mode_strip_sgid
> >> api for the subsequent patch. This function is used to strip S_ISGID mode
> >> when init a new inode.
> >>
> >> Reviewed-by: Darrick J. Wong<djwong@kernel.org>
> >> Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >
> > Since this is a very sensitive patch series I think we need to be
> > annoyingly pedantic about the commit messages. This is really only
> > necessary because of the nature of these changes so you'll forgive me
> > for being really annoying about this. Here's what I'd change the commit
> > message to:
> >
> > fs: add mode_strip_sgid() helper
> >
> > Add a dedicated helper to handle the setgid bit when creating a new file
> > in a setgid directory. This is a preparatory patch for moving setgid
> > stripping into the vfs. The patch contains no functional changes.
> >
> > Currently the setgid stripping logic is open-coded directly in
> > inode_init_owner() and the individual filesystems are responsible for
> > handling setgid inheritance. Since this has proven to be brittle as
> > evidenced by old issues we uncovered over the last months (see [1] to
> > [3] below) we will try to move this logic into the vfs.
> >
> > Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes" [1]
> > Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
> > Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
> 
> This seems better, thanks.
> 
> ps: Sorry, forgive my poor ability for write this.

This really isn't any comment on your ability to write this! I tried to
make this clear but I obviously failed.

It is really just that this has an associated non-zero regression risk
and we need to make sure to highlight this and be very clear about the
motivation for this change. So it's equal parts pedantry and trying to
keep our own heads off the guillotine.
