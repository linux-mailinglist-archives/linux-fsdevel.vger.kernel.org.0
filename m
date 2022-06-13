Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2254A227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 00:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiFMWil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMWik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:38:40 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15F6260
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 15:38:38 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h8so7634599iof.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 15:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSfQVDPdSZV7BsUZMX0DMKU36oE62bl8JUEG399LTGQ=;
        b=iOe2c0LZoVW+GY27vdPQ164YNh5IJrimb87nSfQol6K9V2Wjvi7hEXWRmNiYR1bwUQ
         5TpXCahY9UIL2dY5I5t2MiTzSJeqPHWw1Bto/qfAjYn4kJxplc0U01mR//HUbdxvQDGH
         LC1M4Ru3Us/w/yWJb/J6AsoYk4lQ2ihX8s0Q5Vwi6gl6Ecnqp3Ll7kSNctOBXPo0GBq9
         0QlakwT6SIWPHk+3iwnGbYC8THbaSirHeaaduFJiwRI7mJgxtID2V6jIeJmNOgmln4Kn
         nr1bVIcZPbAxgugwhMKLjJyi++xVgjKyQpMomzK+P5O1PiDVc69khAKw2yR2WyI0wcqy
         tq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSfQVDPdSZV7BsUZMX0DMKU36oE62bl8JUEG399LTGQ=;
        b=vf4YG40TBOteJeuZH2bh0i+agd7UP/MTSwCYa5s12Cn6HY4SvfhTG3/m4DTkY/zhfa
         Y5j7weuu4ksg+7s9w7HkELB1FyoIl2s02SEWSBLgCV2Dhp/lUqf7st4f3KOmojMhn0SS
         G19bumhMTrRKmv5gzkfGE/znr4RA+vTrJvydN6Nva13t5m9vKK38PDkF09IRH9PnLo62
         b3a4Nfd6MhYjpLm9+YlipWhwbmaYEM+5omH06sZAlAWXxVfBNuA3rmIhVFlTTyXG92Ur
         8fL0u9C1vUOVeFpCE//h3UqqeajFDdcjKZa4CgL1vzmp9H124mRf9LNHHUDe5ck/Qx4Z
         Qzbw==
X-Gm-Message-State: AOAM533fWgHzQdgRdALe37nk3ipSiIRs2hdFlefETBaPuXnLgk8MYgLs
        RN86CeVzuZwLTwpJBErHXeMpGGNxrwfecagCt0CseQ==
X-Google-Smtp-Source: ABdhPJzj+2L+AFjPv9s2kVu3WHMiTFEhxc4SE7Sug7k/UXLKnkibOKebwzScvc2nvqb2XiNvP2b7nEi2BQSFne2x9hs=
X-Received: by 2002:a02:2305:0:b0:331:a026:b650 with SMTP id
 u5-20020a022305000000b00331a026b650mr1141093jau.314.1655159918049; Mon, 13
 Jun 2022 15:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com> <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
 <Yqe6R+XSH+nFc8se@xz-m1.local>
In-Reply-To: <Yqe6R+XSH+nFc8se@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 13 Jun 2022 15:38:02 -0700
Message-ID: <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 3:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 13, 2022 at 02:55:40PM -0700, Andrew Morton wrote:
> > On Wed,  1 Jun 2022 14:09:47 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > > To achieve this, add a /dev/userfaultfd misc device. This device
> > > provides an alternative to the userfaultfd(2) syscall for the creation
> > > of new userfaultfds. The idea is, any userfaultfds created this way will
> > > be able to handle kernel faults, without the caller having any special
> > > capabilities. Access to this mechanism is instead restricted using e.g.
> > > standard filesystem permissions.
> >
> > The use of a /dev node isn't pretty.  Why can't this be done by
> > tweaking sys_userfaultfd() or by adding a sys_userfaultfd2()?

I think for any approach involving syscalls, we need to be able to
control access to who can call a syscall. Maybe there's another way
I'm not aware of, but I think today the only mechanism to do this is
capabilities. I proposed adding a CAP_USERFAULTFD for this purpose,
but that approach was rejected [1]. So, I'm not sure of another way
besides using a device node.

One thing that could potentially make this cleaner is, as one LWN
commenter pointed out, we could have open() on /dev/userfaultfd just
return a new userfaultfd directly, instead of this multi-step process
of open /dev/userfaultfd, NEW ioctl, then you get a userfaultfd. When
I wrote this originally it wasn't clear to me how to get that to
happen - open() doesn't directly return the result of our custom open
function pointer, as far as I can tell - but it could be investigated.

[1]: https://lore.kernel.org/lkml/686276b9-4530-2045-6bd8-170e5943abe4@schaufler-ca.com/T/

> >
> > Peter, will you be completing review of this patchset?
>
> Sorry to not have reviewed it proactively..
>
> I think it's because I never had a good picture/understanding of what
> should be the best security model for uffd, meanwhile I am (it seems) just
> seeing more and more ways to "provide a safer uffd" by different people
> using different ways.. and I never had time (and probably capability too..)
> to figure out the correct approach if not to accept all options provided.

Agreed, what we have right now is a bit of a mess of different
approaches. I think the reason for this is, there is no "perfect" way
to control access to features like this, so what we now have is
several different approaches with different tradeoffs.

From my perspective, the existing controls were simpler to implement,
but are not ideal because they require us to grant access to UFFD
*plus more stuff too*.

The approach I've proposed is the most granular, so it doesn't require
adding any extra permissions. But, I agree the interface is sort of
overcomplicated. :/ But, from my perspective, security in shared Cloud
computing environments where UFFD is used for live migration is
critical, so I prefer this tradeoff - I'll put up with a slightly
messier interface, if the gain is a very minimal set of privileges.

>
> I think I'll just assume the whole thing is acked already from you
> generally, then I'll read at least the implementation before the end of
> tomorrow.
>
> Thanks,
>
> --
> Peter Xu
>
