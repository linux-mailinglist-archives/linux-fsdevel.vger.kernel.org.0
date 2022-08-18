Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF79598A6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbiHRRXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbiHRRXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:23:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823E32EDD
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 10:23:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r141so1591846iod.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Bd32rmK/FOJLR3DhtOUdTvKf+a9Teo/sBKjuQ/ElSZg=;
        b=XlCrOgXemDYs5Gm1ZIOksFTqGZKJJh1hGJ5FiZ/gBNvZlCJoKWIFIhrOP6jcsNcZg8
         nsUv5cuyppKGA9pojhWsrVbxqQNk9M+rs6BsIhJvbCKfFS7En6R216VnbucNPbV6UqJu
         gFhqNjW0Z3wyX/v6unNEZXn/nYFuw58v1FdugaIM8korrBWM0ULmCWalgxkcsTvstTYF
         2dpqn3K+xtvSW+ChNPAlFgqvqaJcQR1TiMmUcWlah6pmdFqo7CJY1Lhcjc2my+dwuDFF
         He4LDfJIcqaWnuQBMW0MitXidT3AJ0yuvz4ZsinCZ3Oz4svSW745OwxEYBDWuSYgJjBb
         0gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Bd32rmK/FOJLR3DhtOUdTvKf+a9Teo/sBKjuQ/ElSZg=;
        b=AwgwWJVS9U/7qRgIiLwsBKGNPBttXRVhPsKIB1uShJI/9Ro7baX6Ca9l13NJP1Fj54
         wmhN9UZIRoCyWuATEWt2g/FJgcczNa1dtG/scCandOiNfug7Pjo5alFrTI6/HPbJL+li
         NLXAiJZuR+19pL7OYQfOpV7RpIcg6vysJiASOzDH4cfzdTW43RnAOzCtITEe9JyG0x2p
         HPVQ/9+jHfuk6NbxzGMn1BWxU+xNEquAhwYUrNDrSwrHPQ3OlfBZSPtsseZHxrRRyBar
         c2Soav5DvAtilTqo1S7HoeBfve5e75JDsC68yp6Pg3FwzSdoCYAYLZGe0apoooSEy5rE
         EsQQ==
X-Gm-Message-State: ACgBeo3ILXHiHmQLxk+4oq62OP4VhlgNTit/oBdVgziCAfI+DKqVHtks
        lVtOJMJkKPG8XwD2Zal6p7mQWbI1vL2dGfV0azWNBQ==
X-Google-Smtp-Source: AA6agR7BxSEK9TZMmEIhvaOX697zBF3ihw3R6j2eoMtnNit2ewt69TP6LFyP0vkczM3B3jRpPt3WlelDN3UHLFuji6A=
X-Received: by 2002:a05:6602:2f03:b0:678:9c7c:97a5 with SMTP id
 q3-20020a0566022f0300b006789c7c97a5mr1830797iow.32.1660843383117; Thu, 18 Aug
 2022 10:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220817214728.489904-1-axelrasmussen@google.com>
 <20220817214728.489904-3-axelrasmussen@google.com> <Yv3bnouKb7242Ama@kroah.com>
 <Yv3c9jYkyWfe2zMM@kroah.com>
In-Reply-To: <Yv3c9jYkyWfe2zMM@kroah.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 18 Aug 2022 10:22:27 -0700
Message-ID: <CAJHvVcjSjk15TVRTi9x+CMjrWoNeUJBiZiH1boQvQzwd-pdOtQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 18, 2022 at 08:26:38AM +0200, Greg KH wrote:
> > On Wed, Aug 17, 2022 at 02:47:25PM -0700, Axel Rasmussen wrote:
> > > +static int userfaultfd_dev_open(struct inode *inode, struct file *file)
> > > +{
> > > +   return 0;
> >
> > If your open does nothing, no need to list it here at all, right?
> >
> > > +}
> > > +
> > > +static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
> > > +{
> > > +   if (cmd != USERFAULTFD_IOC_NEW)
> > > +           return -EINVAL;
> > > +
> > > +   return new_userfaultfd(flags);
> > > +}
> > > +
> > > +static const struct file_operations userfaultfd_dev_fops = {
> > > +   .open = userfaultfd_dev_open,
> > > +   .unlocked_ioctl = userfaultfd_dev_ioctl,
> > > +   .compat_ioctl = userfaultfd_dev_ioctl,
> >
> > Why do you need to set compat_ioctl?  Shouldn't it just default to the
> > existing one?
> >
> > And why is this a device node at all?  Shouldn't the syscall handle all
> > of this (to be honest, I didn't read anything but the misc code, sorry.)
>
> Ah, read the documentation now.  Seems you want to make it easier for
> people to get permissions on a system.  Doesn't seem wise, but hey, it's
> not my feature...

Thanks for taking a look Greg!

WIth the syscall, the only way to get access to this feature is to
have CAP_SYS_PTRACE. Which gives you access to this, *plus* a bunch
more stuff.

My basic goal is to grant access to just this feature by itself, not
really just to make it easier to access. I think a device node is the
simplest way to achieve that (see the cover letter for considered
alternatives).

The other feedback looks like good simplification to me - I'll send
another version with those changes. I have to admit this is the first
time I've messed with misc device nodes, so apologies for being overly
explicit. :)

>
> thanks,
>
> greg k-h
