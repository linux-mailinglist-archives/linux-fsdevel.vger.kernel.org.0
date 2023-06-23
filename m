Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD773BB99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjFWPZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjFWPZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8969C2;
        Fri, 23 Jun 2023 08:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5B361989;
        Fri, 23 Jun 2023 15:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AB6C433C9;
        Fri, 23 Jun 2023 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533914;
        bh=SFSehRLZffVmGR34OG8eNSAMnuVw4YtF62hHvlRysxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkNnJT3PNyP2h12Pk+HkbNy0lHsRC0FQxan/XzKcaisA8FhKppMiSo7fBn9rJtBEt
         8xtSh+hN0Fa58eImbUptm8GxgdaqE/HYfZZjlsYrQkAbQegO5mhwZaTd11/IfAjSaA
         s3jzAed0QrykyIr7h19yVqzkqndRH3WpJTMYUcRwhgrsP27oIjaBPDlFwHhaSKCteJ
         CvSX+UMJMFdOX85Pdhwewa0WTttspEu3SggTWWEvjHtLE1ihWHm3AEveC58wPon5Vw
         FqKCyFpZUE97fDfKgHjWIH2Vr1O2Ihlc6tJpHa00vS21y/DJEjPmmo/avjdJkXbmrq
         Ow+goclZJJXSA==
Date:   Fri, 23 Jun 2023 17:25:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/3] fd/locks: allow get the lock owner by F_OFD_GETLK
Message-ID: <20230623-paranoia-reinschauen-329185eac276@brauner>
References: <5f644a24-90b5-a02f-b593-49336e8e0f5a@yandex.ru>
 <2eb8566726e95a01536b61a3b8d0343379092b94.camel@kernel.org>
 <d70b6831-3443-51d0-f64c-6f6996367a85@yandex.ru>
 <d0c18369245db91a3b78017fabdc81417418af67.camel@kernel.org>
 <ddb48e05-ab26-ae5d-86d5-01e47f0f0cd2@yandex.ru>
 <e8c8c7d8bf871a0282f3e629d017c09ed38e2c5e.camel@kernel.org>
 <9c0a7cde-da32-bc09-0724-5b1387909d18@yandex.ru>
 <26dce201000d32fd3ca1ca5b5f8cd4f5ae0b38b2.camel@kernel.org>
 <0188af4b-fc74-df61-8e00-5bc81bbcb1cc@yandex.ru>
 <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7fd8146f9c758a8e16faeb371ca04a701e1a7b8.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 07:05:12AM -0400, Jeff Layton wrote:
> On Wed, 2023-06-21 at 15:42 +0500, stsp wrote:
> > 21.06.2023 15:35, Jeff Layton пишет:
> > > I don't think we can change this at this point.
> > > 
> > > The bottom line (again) is that OFD locks are owned by the file
> > > descriptor (much like with flock()), and since file descriptors can be
> > > shared across multiple process it's impossible to say that some single
> > > process owns it.
> > What's the problem with 2 owners?
> > Can't you get one of them, rather than
> > meaningless -1?
> > Compare this situation with read locks.
> > They can overlap, so when you get an
> > info about a read lock (except for the
> > new F_UNLCK case), you get the info
> > about *some* of the locks in that range.
> > In the case of multiple owners, you
> > likewise get the info about about some
> > owner. If you iteratively send them a
> > "please release this lock" message
> > (eg in a form of SIGKILL), then you
> > traverse all, and end up with the
> > lock-free area.
> > Is there really any problem here?
> 
> Yes. Ambiguous answers are worse than none at all.

I agree.

A few minor observations:

SCM_RIGHTS have already been mentioned multiple times. But I'm not sure
it's been mentioned explicitly but that trivially means it's possible to
send an fd to a completely separate thread-group, then kill off the
sending thread-group by killing their thread-group leader. Bad enough as
the identifier is now useless. But it also means that at some later
point that pid can be recycled. So using that pid for killing sprees is
usually a bad idea and might cause killing a completely separate
thread-group.

pidfd_getfd() can be used to retrieve a file descriptor from another
process; like an inverse dup. Opens up similar problems as SCM_RIGHTS.

Expressing ownership doesn't make sense as this is an inherently shared
concept as Jeff mentioned. So best case is to try and track the creator
similar to SO_PEERCRED for unix sockets.

In any case, this is all made worse by the fact that struct file_lock
stashes raw pid numbers. That means that the kernel itself can't even
detect whether the creator of that lock has died and the pid possibly
been recycled. In essence, it risk reporting as owner a random process
that just happens to have the same pid number as the creator that
might've died.

Even for unix sockets SO_PEERCRED and SCM_CREDS are inherently racy even
though they stash a struct pid instead of a raw pid number and that
makes them problematic in a lot of scenario which is why they will
support pidfds with v6.5.

The situation could probably be improved by stashing a struct pid in
struct file_lock then you could at least somewhat reasonably track the
creator as the kernel would be able to detect whether the creating
process has already been reaped (not exited). For example, I did this
for pidfds where it reports -1 if the process the pidfd refers to has
been reaped.

Btw, is there a way to limit the number of file locks a user might
create? Is that implicitly bound to the maximum number of fds and files
a caller may create because I saw RLIMIT_LOCKS but I didn't see it
checked anywhere.
