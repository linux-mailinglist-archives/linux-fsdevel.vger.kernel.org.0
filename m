Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA6369486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhDWOXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWOXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:23:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C1C061574;
        Fri, 23 Apr 2021 07:22:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r128so50814669lff.4;
        Fri, 23 Apr 2021 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qa960KFNtDJWzfAsJHjaJz591q3u8hYXWUc5bQSIFZQ=;
        b=E5Q5fzOYxKb7vTg6Z0Fd03DNJhEsqQliuJ/wNn88ZidkxiT97Ho9ZcT9r1RVj71++b
         6ansjU/yJFnR0kwb3WMrDSktUkw/1NyeuVHaf6VRurcOEDJ62JUrBWAb0bTs9kfud8t4
         29Owr5AcXlebNyD6nw5BfKpAMgHYFU/naT1nBnm8wdRoWzdwPDBbu8WzJiWRxhkxzgjY
         vap+1+a7HjNwjerEchtfNfmAuCBSiR1H42fr41xQCTUG3z4VgTrtZMa/uXStHpWuG5cd
         3XnnJxMbvwAriHG64TXI9828OSMcvrpaA4iTlRFImuhq1dogayUYOlsZBci4xlpYi7Ad
         aeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qa960KFNtDJWzfAsJHjaJz591q3u8hYXWUc5bQSIFZQ=;
        b=o7hvgFw/s8YcVUFP82l1Y2CozIrJWZGifqn3UQ5cBB7Ee4GUeXop7sjd9Jjm5bwLJE
         v/k+HeUvKLij0dW9CWrMPFRu07snl0e5A1HlYBAMOjesiqs8NAfey/IOEIRmxQq0BM+2
         bxD3ge2HkzRtCUjX1hNiWXQVSjO6UQsFEeQDB0wGLpjiqw+f3X+y4OMC5PFo1FvqsdBF
         0meJyV76lOR94l1s84msR11G1pff8KUj9s6IUPjN8rTh8ai6ji95KtfTr0Co+McjNPvP
         iDakxdhx+KoOM4GfWFdeOOzMfjXiaV5w3D26wePMHXQ6ORz1Odpur+QzmxjPQCTOSlt/
         nLNA==
X-Gm-Message-State: AOAM5320JpGcPYh9kEbWcgM3GrMTXZ1fPt7zO3VPryf+FbwMabQg3/9Z
        Zyic9lZtVNRVt4o3tezLWbQ9Gp/6vna7Tz8BO2AuZFEX
X-Google-Smtp-Source: ABdhPJw3QpXCLbuutv29r/KI5zf4kroTRX9E1xa5uWDI96RtTPOqa8A16tvHlawGP3l1hrHeyhipL8Br05agVBFZiGY=
X-Received: by 2002:a05:6512:4ca:: with SMTP id w10mr2923982lfq.322.1619187774064;
 Fri, 23 Apr 2021 07:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <20210421171446.785507-3-omosnace@redhat.com>
 <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com> <CAFqZXNv4gKFN5FV_Z8U82cOzauBggaqPE0WZZUdnNRxCQ3PVPw@mail.gmail.com>
In-Reply-To: <CAFqZXNv4gKFN5FV_Z8U82cOzauBggaqPE0WZZUdnNRxCQ3PVPw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 23 Apr 2021 10:22:42 -0400
Message-ID: <CAEjxPJ5iWjcQGzfJy-5CLa+e95C+OmeQ_GAU44s+8ripuMJg9g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: add capability to map anon inode types
 to separate classes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 9:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Apr 22, 2021 at 3:21 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Unfortunately, the approach chosen in commit 29cd6591ab6f ("selinux:
> > > teach SELinux about anonymous inodes") to use a single class for all
> > > anon inodes and let the policy distinguish between them using named
> > > transitions turned out to have a rather unfortunate drawback.
> > >
> > > For example, suppose we have two types of anon inodes, "A" and "B", and
> > > we want to allow a set of domains (represented by an attribute "attr_x")
> > > certain set of permissions on anon inodes of type "A" that were created
> > > by the same domain, but at the same time disallow this set to access
> > > anon inodes of type "B" entirely. Since all inodes share the same class
> > > and we want to distinguish both the inode types and the domains that
> > > created them, we have no choice than to create separate types for the
> > > cartesian product of (domains that belong to attr_x) x ("A", "B") and
> > > add all the necessary allow and transition rules for each domain
> > > individually.
> > >
> > > This makes it very impractical to write sane policies for anon inodes in
> > > the future, as more anon inode types are added. Therefore, this patch
> > > implements an alternative approach that assigns a separate class to each
> > > type of anon inode. This allows the example above to be implemented
> > > without any transition rules and with just a single allow rule:
> > >
> > > allow attr_x self:A { ... };
> > >
> > > In order to not break possible existing users of the already merged
> > > original approach, this patch also adds a new policy capability
> > > "extended_anon_inode_class" that needs to be set by the policy to enable
> > > the new behavior.
> > >
> > > I decided to keep the named transition mechanism in the new variant,
> > > since there might eventually be some extra information in the anon inode
> > > name that could be used in transitions.
> > >
> > > One minor annoyance is that the kernel still expects the policy to
> > > provide both classes (anon_inode and userfaultfd) regardless of the
> > > capability setting and if one of them is not defined in the policy, the
> > > kernel will print a warning when loading the policy. However, it doesn't
> > > seem worth to work around that in the kernel, as the policy can provide
> > > just the definition of the unused class(es) (and permissions) to avoid
> > > this warning. Keeping the legacy anon_inode class with some fallback
> > > rules may also be desirable to keep the policy compatible with kernels
> > > that only support anon_inode.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > NAK.  We do not want to introduce a new security class for every user
> > of anon inodes - that isn't what security classes are for.
> > For things like kvm device inodes, those should ultimately use the
> > inherited context from the related inode (the /dev/kvm inode itself).
> > That was the original intent of supporting the related inode.
>
> Hmm, so are you implying that anon inodes should be thought of the
> same as control /dev nodes? I.e. that even though there may be many
> one-time actual inodes created by different processes, they should be
> thought of as a single "static interface" to the respective kernel
> functionality? That would justify having a common type/label for all
> of them, but I'm not sure if it doesn't open some gap due to the
> possibility to pass the associated file descriptors between processes
> (as AFAIK, these can hold some context)...

That was the original design (and the original patchset that we posted
in parallel with Google's independently developed one). We even had
example policy/controls for /dev/kvm ioctls.
Imagine trying to write policy over /dev/kvm ioctls where you have to
deal with N different classes and/or types and remember which ioctl
commands are exercised on which class or type even though from the
users' perspective they all occurred through the /dev/kvm interface.
It seemed super fragile and difficult to maintain/analyze that way.
Versus writing a single allow rule for all /dev/kvm ioctls.

I guess we could discuss the alternatives but please have a look at
those original patches and examples.  If we go down this road, we need
some way to deal with scaling because we only have a limited number of
discrete classes available to us and potentially unbounded set of
distinct anon inode users (although hopefully in practice only a few
that we care about distinguishing).

> I thought this was supposed to resemble more the way BPF, perf_event,
> etc. support was implemented - the BPF and perf_event fds are also
> anon inodes under the hood, BTW - where each file descriptor is
> considered a separate object that inherits the label of its creator
> and there is some class separation (e.g. bpf vs. perf_event).
