Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9331B3593FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhDIEhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhDIEhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:37:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C82EC061760;
        Thu,  8 Apr 2021 21:36:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b14so7595774lfv.8;
        Thu, 08 Apr 2021 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0osMsTsG9V38w3wLAdhcJYVbXLyWrSIGMEFZuDNIbn8=;
        b=PkPxMzmb/9BdhK5Stz1YcuH/cLj79I7As6VtVbgmq/sOupFeVpxU0exqyZWOx4l297
         pdzmMKgffoYGxYvbAEWZ4yLbolz9SHgF0mL+Ggg/v0spSC8XECabZ/ontmqJXScR77pM
         etNBm5MQY8MEPw+bZwiNTJvvaNTcoT4SML11TdQbFz8bvpTR2Jc9ujuMhYVNxXRknOHg
         hbdlUguditRI4TDX6SQ6pGc9xiZZb5eaMdLiY4gbtd00x5n4zqGgCrsHQjZhYf/BGZX8
         o86VV3+IHW7jnVCo2hvrZe6IWi9EQs1XA/3Wndnifz5c7RMHd/OU/DQhMNDvQlnL149Z
         Jn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0osMsTsG9V38w3wLAdhcJYVbXLyWrSIGMEFZuDNIbn8=;
        b=ljG0zYuXap8LXQt9oJ9AWNj6FV16CrQ1fzzl5bcxfZ1zUibB04UPUdUC9M6j4DPXFl
         2uvtxOPajH1QWunfpbocZiMFNf3tD58op07rP3nXgkpHf7A48MChJ3P4/nLrL2SHhUJ7
         1iUsjQr0ieHERHYIZbjLfBEzbEVj8wpGJbKauxXOLlHs9GLoMovwWcnEFMzIWWxDz5RT
         0ackxlUTQ6Kij9xcvDbKqkOMo+FeUKYBOIyK+HGjfKhD3ZIolBohmJXGnf8N2MeTw25A
         8ifoO6JxxnBMdIyEJ3n9pxORiOr243nnqhxZ9wQcEzoiY8ya2cz4IpMY+7FCRlNoVyRm
         ArbQ==
X-Gm-Message-State: AOAM532pZ5G/FVruiBpuoDHTgYv9wrsTLwr/Rq/TaGNg98Ullr1kQz/5
        it8gj9pPg9wsoRlnsHGmiQGuWV1BBJUsh8Xvlwo=
X-Google-Smtp-Source: ABdhPJzVM9lOVeCg1dCH8RIoO6RGsLYQXstbf0w7NWiyf2G+qRc8cqJZrF4T/U71t0Y7x+KsxhXwoBJ7uYub6P/HEJA=
X-Received: by 2002:a19:8c0a:: with SMTP id o10mr9110820lfd.175.1617943008863;
 Thu, 08 Apr 2021 21:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <87k0qoxz7r.fsf@suse.com> <87tupuya6t.fsf@suse.com>
 <CAN05THRV_Tns4MTO-GFNg0reR+HJKa1BCSQ0m23PTSryGNPCeg@mail.gmail.com>
 <181014.1615311429@warthog.procyon.org.uk> <87eegouqo8.fsf@suse.com> <87eegcsj31.fsf@suse.com>
In-Reply-To: <87eegcsj31.fsf@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 8 Apr 2021 23:36:38 -0500
Message-ID: <CAH2r5mve+EXFnkwVzRz2xuhNEMVgdWLZrSNcLFqhZKF4Hsxvug@mail.gmail.com>
Subject: Re: [EXPERIMENT v2] new mount API verbose errors from userspace
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tentatively merged into cifs-2.6.git for-next but would like more
feedback on other's thoughts on this. Getting more verbose error
information back on mount errors (to userspace returning something
more than a primitive small set of return codes, and a message logged
to dmesg) is critical, and this approach seems reasonable at first
glance but if there are better ways ...

On Thu, Mar 18, 2021 at 8:12 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote=
:
>
>
> Since there's no standard VFS way to get the supported mount options
> from userspace, I thought I would do what Ronnie suggested and export
> them from a cifs /proc file.
> That's the only change since v1, in the 4th patch.
>
> David, maybe this can give your arguments for the need for fsinfo() if
> we end up using this in cifs-utils.
>
> I have added some dumb code in userspace to parse it and see if the
> option exists and what type it is. This removes the requirement of
> having to keep cifs-utils and kernel updated at the same time to use new
> options.
>
> Previous intro
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I have some code to use the new mount API from user space.
>
> The kernel changes are just making the code use the fs_context logging
> feature.
>
> The sample userspace prog (fsopen.c attached) is just a PoC showing how
> mounting is done and how the mount errors are read.
>
> If you change the prog to use a wrong version for example (vers=3D4.0) yo=
u
> get this:
>
>     $ gcc -o fsopen fsopen.c
>     $ ./fsopen
>     fsconfig(sfd, FSCONFIG_SET_STRING, "vers", "4.0", 0): Invalid argumen=
t
>     kernel mount errors:
>     e Unknown vers=3D option specified: 4.0
>
> The pros are that we process one option at a time and we can fail early
> with verbose, helpful messages to the user.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)



--=20
Thanks,

Steve
