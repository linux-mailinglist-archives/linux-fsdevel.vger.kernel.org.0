Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED245A2367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245240AbiHZIoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZIoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:44:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68571BCA;
        Fri, 26 Aug 2022 01:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA338B82FD1;
        Fri, 26 Aug 2022 08:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF97C433C1;
        Fri, 26 Aug 2022 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661503442;
        bh=z7osIVMCZGHnhKyN58oHu67Y/RB1Ot0NWuUJ6fLjt8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6LT/tQXSx5w904Rk9hYPigO3ibTXKSgYmW2U/NOrHFeb/uZHu7eaqZt7b7NumMzf
         79eygsMrVXNLuQoCKXZJ4rKOS1EK4BfL9qE6eBbPDhW24vOu5A/CEfgH2MYykbw2++
         ZXCY5knoUOsuq/g7B6KSxfZmpDRtmOCdbELaaUtEbKRN4Fs5AQdm++7Rg56vxp8ZBn
         psYw+UZJhupV0Cg5CxwGEANvBATJ1EPjmX35xCpzwq2aL+KklGIJP+k27sfW+Jya2O
         iOBrLNsQmoJ2RqvQT0BN5LJE+V04fDqt3WCE7keP3+aLvxBD+ktVSb8GAUYsa+MWDo
         6GIJGqqz4UUmQ==
Date:   Fri, 26 Aug 2022 10:43:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
Message-ID: <20220826084354.a2jrrvni6mf7zzyw@wittgenstein>
References: <20220708093451.472870-1-omosnace@redhat.com>
 <CAHC9VhSFUJ6J4_wt1SKAoLourNGVkxu0Tbd9NPDbYqjjrs-qoQ@mail.gmail.com>
 <CAHC9VhRtLEg-xR5q33bVNOBi=54uJuix2QCZuCiKX2Qm6CaLzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRtLEg-xR5q33bVNOBi=54uJuix2QCZuCiKX2Qm6CaLzw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:50:57PM -0400, Paul Moore wrote:
> On Tue, Aug 16, 2022 at 6:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jul 8, 2022 at 5:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Since userfaultfd doesn't implement a write operation, it is more
> > > appropriate to open it read-only.
> > >
> > > When userfaultfds are opened read-write like it is now, and such fd is
> > > passed from one process to another, SELinux will check both read and
> > > write permissions for the target process, even though it can't actually
> > > do any write operation on the fd later.
> > >
> > > Inspired by the following bug report, which has hit the SELinux scenario
> > > described above:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> > >
> > > Reported-by: Robert O'Callahan <roc@ocallahan.org>
> > > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > Resending as the last submission was ignored for over a year...
> > >
> > > https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/
> > >
> > > I marked this as RFC, because I'm not sure if this has any unwanted side
> > > effects. I only ran this patch through selinux-testsuite, which has a
> > > simple userfaultfd subtest, and a reproducer from the Bugzilla report.
> > >
> > > Please tell me whether this makes sense and/or if it passes any
> > > userfaultfd tests you guys might have.
> > >
> > >  fs/userfaultfd.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > VFS folks, any objection to this patch?  It seems reasonable to me and
> > I'd really prefer this to go in via the vfs tree, but I'm not above
> > merging this via the lsm/next tree to get someone in vfs land to pay
> > attention to this ...
> 
> Okay, final warning, if I don't see any objections to this when I make
> my patch sweep next week I'm going to go ahead and merge this via the
> LSM tree.

Makes sense,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
