Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254EC161D07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBQWDI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 17:03:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55849 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBQWDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:03:07 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <stgraber@ubuntu.com>)
        id 1j3oTp-0006Xg-IM
        for linux-fsdevel@vger.kernel.org; Mon, 17 Feb 2020 22:03:05 +0000
Received: by mail-lf1-f44.google.com with SMTP id n25so12976314lfl.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 14:03:05 -0800 (PST)
X-Gm-Message-State: APjAAAU0N7qbH0cw2U5PWTZ6BStShyW7t91sIyeHRFIdYOThl4hVbRUj
        FeFJhMhyjKGG49sJZUZyNwrFJS/ei9zh/+7sMMvKVA==
X-Google-Smtp-Source: APXvYqxfzaNIrWsnxmQ/xqv/hlxasa72H1Nm3nfqgJQmPhBMHU82ojwvN6/kjkL7pS2rQUVLpiWQ8R4IEbGQPJ6GeNk=
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr8894012lfp.96.1581976984864;
 Mon, 17 Feb 2020 14:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <1581973919.24289.12.camel@HansenPartnership.com> <CA+enf=vwd-dxzve87t7Mw1Z35RZqdLzVaKq=fZ4EGOpnES0f5w@mail.gmail.com>
In-Reply-To: <CA+enf=vwd-dxzve87t7Mw1Z35RZqdLzVaKq=fZ4EGOpnES0f5w@mail.gmail.com>
From:   =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Date:   Mon, 17 Feb 2020 17:02:52 -0500
X-Gmail-Original-Message-ID: <CA+enf=uhST2pSVK2oFWyP9nCoQOkJwRtLw4D_3FSwz9hyHqPcQ@mail.gmail.com>
Message-ID: <CA+enf=uhST2pSVK2oFWyP9nCoQOkJwRtLw4D_3FSwz9hyHqPcQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And re-sending, this time hopefully actually in plain text mode.
Sorry about that, my e-mail client isn't behaving today...

Stéphane

On Mon, Feb 17, 2020 at 4:57 PM Stéphane Graber <stgraber@ubuntu.com> wrote:
>
> On Mon, Feb 17, 2020 at 4:12 PM James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
>>
>> On Fri, 2020-02-14 at 19:35 +0100, Christian Brauner wrote:
>> [...]
>> > With this patch series we simply introduce the ability to create fsid
>> > mappings that are different from the id mappings of a user namespace.
>> > The whole feature set is placed under a config option that defaults
>> > to false.
>> >
>> > In the usual case of running an unprivileged container we will have
>> > setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
>> > correspond to this id mapping, i.e. all files which we want to appear
>> > as 0:0 inside the user namespace will be chowned to 100000:100000 on
>> > the host. This works, because whenever the kernel needs to do a
>> > filesystem access it will lookup the corresponding uid and gid in the
>> > idmapping tables of the container.
>> > Now think about the case where we want to have an id mapping of 0
>> > 100000 100000 but an on-disk mapping of 0 300000 100000 which is
>> > needed to e.g. share a single on-disk mapping with multiple
>> > containers that all have different id mappings.
>> > This will be problematic. Whenever a filesystem access is requested,
>> > the kernel will now try to lookup a mapping for 300000 in the id
>> > mapping tables of the user namespace but since there is none the
>> > files will appear to be owned by the overflow id, i.e. usually
>> > 65534:65534 or nobody:nogroup.
>> >
>> > With fsid mappings we can solve this by writing an id mapping of 0
>> > 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
>> > access the kernel will now lookup the mapping for 300000 in the fsid
>> > mapping tables of the user namespace. And since such a mapping
>> > exists, the corresponding files will have correct ownership.
>>
>> How do we parametrise this new fsid shift for the unprivileged use
>> case?  For newuidmap/newgidmap, it's easy because each user gets a
>> dedicated range and everything "just works (tm)".  However, for the
>> fsid mapping, assuming some newfsuid/newfsgid tool to help, that tool
>> has to know not only your allocated uid/gid chunk, but also the offset
>> map of the image.  The former is easy, but the latter is going to vary
>> by the actual image ... well unless we standardise some accepted shift
>> for images and it simply becomes a known static offset.
>
>
> For unprivileged runtimes, I would expect images to be unshifted and be
> unpacked from within a userns. So your unprivileged user would be allowed
> a uid/gid range through /etc/subuid and /etc/subgid and allowed to use
> them through newuidmap/newgidmap.In that namespace, you can then pull
> and unpack any images/layers you may want and the resulting fs tree will
> look correct from within that namespace.
>
> All that is possible today and is how for example unprivileged LXC works
> right now.
>
> What this patchset then allows is for containers to have differing
> uid/gid maps while still being based off the same image or layers.
> In this scenario, you would carve a subset of your main uid/gid map for
> each container you run and run them in a child user namespace while
> setting up a fsuid/fsgid map such that their filesystem access do not
> follow their uid/gid map. This then results in proper isolation for
> processes, networks, ... as everything runs as different kuid/kgid but
> the VFS view will be the same in all containers.
>
> Shared storage between those otherwise isolated containers would also
> work just fine by simply bind-mounting the same path into two or more
> containers.
>
>
> Now one additional thing that would be safe for a setuid wrapper to
> allow would be for arbitrary mapping of any of the uid/gid that the user
> owns to be used within the fsuid/fsgid map. One potential use for this
> would be to create any number of user namespaces, each with their own
> mapping for uid 0 while still having all VFS access be mapped to the
> user that spawned them (say uid=1000, gid=1000).
>
>
> Note that in our case, the intended use for this is from a privileged runtime
> where our images would be unshifted as would be the container storage
> and any shared storage for containers. The security model effectively relying
> on properly configured filesystem permissions and mount namespaces such
> that the content of those paths can never be seen by anyone but root outside
> of those containers (and therefore avoids all the issues around setuid/setgid/fscaps).
>
> We will then be able to allocate distinct, random, ranges of 65536 uids/gids (or more)
> for each container without ever having to do any uid/gid shifting at the filesystem layer
> or run into issues when having to setup shared storage between containers or attaching
> external storage volumes to those containers.
>
>> James
>
>
> Stéphane
