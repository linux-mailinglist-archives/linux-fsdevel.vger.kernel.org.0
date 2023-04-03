Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF06D454A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjDCNJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjDCNJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B831D1285D
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 06:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 956DF60ADE
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 13:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4FAC433EF;
        Mon,  3 Apr 2023 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680527344;
        bh=8bS1uWrUaV2kO9198fDp+33cnxkYiJWsqxfcZ3cBBMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QA7fJ3S17K0Z6ywWVF/F0gaR6xxdFFfkyaxda3ncksv6VeVVA1Cu73ZMFA0cdENEt
         He0xU+j8lJJTyVxRP7DBOGIOodwq5803gbCbqHB4xbfjSPZswgnQ18kqncfonFX8i6
         h75OXDd0RGJn89ouT5rG11BMZyeuKWEdD1ZCYxCnAvaYCtA0A+P4fdpMUFt3EhRobh
         FljSXCrvRIG+T+9XHu6bJcl/smGj/OCmx5j47NdAgjCQJnNVG0pkPSwCloQP7y1yCl
         cZPSFVXLnQE2dP8KFqL1rGbu7lfzMe3NopKr7zX5Kdcb4bQOeKV8SFE+g1UhRnxAMY
         GAf8w5iu3d+lQ==
Date:   Mon, 3 Apr 2023 15:08:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Karel Zak <kzak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>, Steve Dickson <steved@redhat.com>
Subject: Re: [RFC PATCH] Legacy mount option "sloppy" support
Message-ID: <20230403-disarm-awhile-621819599ecb@brauner>
References: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
 <20230328184815.ycgxqen7difgnjt3@ws.net.home>
 <27b8d5a5-9ab9-c418-ce9c-0faf90677bde@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27b8d5a5-9ab9-c418-ce9c-0faf90677bde@themaw.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:03:51AM +0800, Ian Kent wrote:
> On 29/3/23 02:48, Karel Zak wrote:
> > On Fri, Mar 24, 2023 at 01:39:09PM +0800, Ian Kent wrote:
> > > Karel do you find what I'm saying is accurate?
> > > Do you think we will be able to get rid of the sloppy option over
> > > time with the move to use the mount API?
> > The question is what we're talking about :-)
> > 
> > For mount(8) and libmount, there is nothing like the "sloppy" mount option.
> > 
> > If you use it in your fstab or as "mount -o sloppy" on the command line,
> > then it's used as any other fs-specific mount option; the library copies
> > the string to mount(2) or fsconfig(2) syscall. The library has no clue
> > what the string means (it's the same as "mount -o foobar").
> 
> Which is what the problem really is.
> 
> 
> If anyone uses this option with a file system that has previously
> 
> allowed it then mounts fail if it isn't handled properly. Then the
> 
> intended purpose of it is irrelevant because it causes a fail.
> 
> 
> I guess the notion of ignoring it for fsconfig(), assuming it isn't
> 
> actually needed for the option handling, might not be a viable idea
> 
> ... although I haven't actually added that to fsconfig(), I probably
> 
> should add that to this series.
> 
> 
> But first the question of whether the option is actually needed anymore
> 
> by those that allow it needs to be answered.
> 
> 
> In case anyone has forgotten it was introduced because, at one time
> 
> different OSes supported slightly different options for for the same
> 
> thing and one could not include multiple options for the same thing
> 
> in automount map entries without causing the mount to fail.
> 
> 
> So we also need to answer, is this option conflict still present for
> 
> any of the file systems that allow it, currently nfs, cifs and ntfs
> 
> (I'll need to look up the ntfs maintainer but lets answer this for
> 
> nfs and cifs first).
> 
> 
> If it isn't actually needed ignoring it in fsconfig() (a deprecation
> 
> warning would be in order) and eventually getting rid of it would be
> 
> a good idea, yes?

Yes, I think this is a good idea.
The whole reason for this mount option seems a bit hacky tbh so getting
rid of it would be great.
