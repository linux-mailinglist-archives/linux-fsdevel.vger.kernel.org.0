Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D252B8C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiERLWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 07:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiERLWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 07:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4115E4BD
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 04:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD02F60B8C
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 11:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29879C385AA;
        Wed, 18 May 2022 11:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652872954;
        bh=/WLg9q3p2pdyfIPRcQEdZAc74GzEIvzJEUJoRgxHpUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruMPFie6Yj/+bPsV6rVbaP8MWzTajfvY9Rp1Nn3/lhnLcqTzaNx+cWPAtIfVSqsok
         C99mq10VDc6iTsUvojtCGyZiWXnMpiw8a13Ahd0Qxl5aW8c8mp7VAhyzy16zbUwcAn
         121gdKZl4zKQ2E4zVbUQGpAgN1psKsqsIaT8Hsc93DZ5JLNYCMuoUi3iyfzwBWt+PM
         VbCJRJj+wgEi32eWBnKnzO7fzz7ZsNwEgX9jgAe7yiHP4okUVmy9Dht2Vi7PVxxk51
         QZl39sAfMnvaMakTTd/jcvqgc6ce9xwyz6Z54o98EtoDVU8VuaxYcYcpuyX6Zd/a88
         /HY/4KOV0pnQw==
Date:   Wed, 18 May 2022 13:22:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
Message-ID: <20220518112229.s5nalbyd523nxxru@wittgenstein>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
 <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6f632bc-c321-488d-f50e-749d641786d6@fb.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 12:50:32PM -0400, Dave Marchevsky wrote:
> On 11/15/21 10:28 AM, Miklos Szeredi wrote:   
> > On Sat, 13 Nov 2021 at 00:29, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > 
> >>> If your tracing daemon runs in init_user_ns with CAP_SYS_ADMIN why can't
> >>> it simply use a helper process/thread to
> >>> setns(userns_fd/pidfd, CLONE_NEWUSER)
> >>> to the target userns? This way we don't need to special-case
> >>> init_user_ns at all.
> >>
> >> helper process + setns could work for my usecase. But the fact that there's no
> >> way to say "I know what I am about to do is potentially stupid and dangerous,
> >> but I am root so let me do it", without spawning a helper process in this case,
> >> feels like it'll result in special-case userspace workarounds for anyone doing
> >> symbolication of backtraces.
> > 
> > Note: any mechanism that grants filesystem access to users that have
> > higher privileges than the daemon serving the filesystem will
> > potentially open DoS attacks against the higher privilege task.  This
> > would be somewhat mitigated if the filesystem is only mounted in a
> > private mount namespace, but AFAICS that's not guaranteed.
> > 
> > The above obviously applies to your original patch but it also applies
> > to any other mechanism where the high privilege user doesn't
> > explicitly acknowledge and accept the consequences.   IOW granting the
> > exception has to be initiated by the high privleged user.
> > 
> > Thanks,
> > Miklos
> > 
> 
> Sorry to ressurect this old thread. My proposed alternate approach of "special
> ioctl to grant exception to descendant userns check" proved unnecessarily
> complex: ioctls also go through fuse_allow_current_process check, so a special
> carve-out would be necessary for in both ioctl and fuse_permission check in
> order to make it possible for non-descendant-userns user to opt in to exception.
> 
> How about a version of this patch with CAP_DAC_READ_SEARCH check? This way 
> there's more of a clear opt-in vs CAP_SYS_ADMIN.

I still think this isn't needed given that especially for the use-cases
listed here you have a workable userspace solution to this problem.

If the CAP_SYS_ADMIN/CAP_DAC_READ_SEARCH check were really just about
giving a privileged task access then it'd be fine imho. But given that
this means the privileged task is open to a DoS attack it seems we're
building a trap into the fuse code.

The setns() model has the advantage that this forces the task to assume
the correct privileges and also serves as an explicit opt-in. Just my 2
cents here.

> 
> FWIW we've been running CAP_SYS_ADMIN version of this patch internally and
> can confirm it fixes tracing tools' ability to symbolicate binaries in FUSE.
> 
> > 
> >>
> >> e.g. perf will have to add some logic: "did I fail
> >> to grab this exe that some process had mapped? Is it in a FUSE mounted by some
> >> descendant userns? let's fork a helper process..." Not the end of the world,
> >> but unnecessary complexity nonetheless.
> >>
> >> That being said, I agree that this patch's special-casing of init_user_ns is
> >> hacky. What do you think about a more explicit and general "let me do this
> >> stupid and dangerous thing" mechanism - perhaps a new struct fuse_conn field
> >> containing a set of exception userns', populated with ioctl or similar.
> > 
> > 
> > 
> >>
> >>>
> >>>>
> >>>> Note: I was unsure whether CAP_SYS_ADMIN or CAP_SYS_PTRACE was the best
> >>>> choice of capability here. Went with the former as it's checked
> >>>> elsewhere in fs/fuse while CAP_SYS_PTRACE isn't.
> >>>>
> >>>>  fs/fuse/dir.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> >>>> index 0654bfedcbb0..2524eeb0f35d 100644
> >>>> --- a/fs/fuse/dir.c
> >>>> +++ b/fs/fuse/dir.c
> >>>> @@ -1134,7 +1134,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
> >>>>      const struct cred *cred;
> >>>>
> >>>>      if (fc->allow_other)
> >>>> -            return current_in_userns(fc->user_ns);
> >>>> +            return current_in_userns(fc->user_ns) || capable(CAP_SYS_ADMIN);
> >>>>
> >>>>      cred = current_cred();
> >>>>      if (uid_eq(cred->euid, fc->user_id) &&
> >>>> --
> >>>> 2.30.2
> >>>>
> >>>>
> >>
