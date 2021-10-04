Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A74213AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhJDQLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhJDQLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:11:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4997AC061745
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 09:09:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so7499213edj.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tpqz/Ca4HuJ9FtsBRGM9SdVp/XgKo9Jug8kOLuk5hKg=;
        b=O70hyt7Xl0bnnrj6nAifypb7wEAuJQni0CGlgG7NLCu06xAA2esXdS+thh8AcqehaI
         GicPPtfggsrRwB5D1zuNfRvU9nDjNSdIDFOJWg7vhh53t9ItbUkzwObnIif36Bt37MAv
         zmxQ9tIplT4h8DRi7QR+30wX7h/8zwaisNqj81DMX/5pUIsEbvKXxtHmziTv9FrSuEI/
         dx3yr7p7KecwY3sa4dQRH3NYP5A0pFsuqNo+6m9pKek2Mt96/JOk3cFD419YLmFS96+n
         r5h5pQjV1K5fuu9U0DV4EhCVobXWpP7D4GcKkOIEHHKZAFZ0+mW5zvY1yxiQ/orhp8+2
         NKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tpqz/Ca4HuJ9FtsBRGM9SdVp/XgKo9Jug8kOLuk5hKg=;
        b=IID/wIM3vz7hgIGoPSBqH21Ft2nz9Kd1stup3US+7JuiIFaSpGTMKFOQ6DsMtyNgcg
         8JfQxABW8LOF5lQ4RrQ6ybGnMU/sbeWAupqoqnHu8SKUViPemCH/n8nrxOUEwI5DTffm
         E+6pMaRPNGjJIhuxz+w4xDBCG+2LL//5FUhM0O4S+tL7Dr2Ag0kKCuHujWj9aS8rm4TF
         3xUwf4VIsYCSmlg6oX6r04jPhvbYONZIguQ13P++7SHc4GFHSAIDIg+irU//mLDtzipk
         K+vmzVCBenOXVhNxAXSGPjdeXM39tzqYml+NQcwAakYQG8msGxcIKjonb5EoAgj/TDR3
         iaBg==
X-Gm-Message-State: AOAM531axc7x81wnw1PkRum+ZbVm+T4JFPVHrX4IZpdtws6TntN2DsJe
        6rlEWFfS+Q0Wzs+Vh6kAAA3wcWKSStn8DLPf6BsW
X-Google-Smtp-Source: ABdhPJyQWd8s7ZVAM+qsDTeNBAYyTuV1VVaLtBP5AloPlNs44bjqzHBoSEvyI6ROO70W1s6zXpKrBI93lmDFoNSB1tk=
X-Received: by 2002:a17:906:12d8:: with SMTP id l24mr17506722ejb.126.1633363694172;
 Mon, 04 Oct 2021 09:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
In-Reply-To: <d23fbb89186754487850367224b060e26f9b7181.1621363275.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Oct 2021 12:08:03 -0400
Message-ID: <CAHC9VhQdzdpwUZEKxeV6VuMJpmGJHf-kXtYP8WMKLBhfLXL9xg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] audit: add OPENAT2 record to list how
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 4:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Since the openat2(2) syscall uses a struct open_how pointer to communicat=
e
> its parameters they are not usefully recorded by the audit SYSCALL record=
's
> four existing arguments.
>
> Add a new audit record type OPENAT2 that reports the parameters in its
> third argument, struct open_how with fields oflag, mode and resolve.
>
> The new record in the context of an event would look like:
> time->Wed Mar 17 16:28:53 2021
> type=3DPROCTITLE msg=3Daudit(1616012933.531:184): proctitle=3D73797363616=
C6C735F66696C652F6F70656E617432002F746D702F61756469742D7465737473756974652D=
737641440066696C652D6F70656E617432
> type=3DPATH msg=3Daudit(1616012933.531:184): item=3D1 name=3D"file-openat=
2" inode=3D29 dev=3D00:1f mode=3D0100600 ouid=3D0 ogid=3D0 rdev=3D00:00 obj=
=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DCREATE cap_fp=3D0 cap_fi=
=3D0 cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> type=3DPATH msg=3Daudit(1616012933.531:184): item=3D0 name=3D"/root/rgb/g=
it/audit-testsuite/tests" inode=3D25 dev=3D00:1f mode=3D040700 ouid=3D0 ogi=
d=3D0 rdev=3D00:00 obj=3Dunconfined_u:object_r:user_tmp_t:s0 nametype=3DPAR=
ENT cap_fp=3D0 cap_fi=3D0 cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> type=3DCWD msg=3Daudit(1616012933.531:184): cwd=3D"/root/rgb/git/audit-te=
stsuite/tests"
> type=3DOPENAT2 msg=3Daudit(1616012933.531:184): oflag=3D0100302 mode=3D06=
00 resolve=3D0xa
> type=3DSYSCALL msg=3Daudit(1616012933.531:184): arch=3Dc000003e syscall=
=3D437 success=3Dyes exit=3D4 a0=3D3 a1=3D7ffe315f1c53 a2=3D7ffe315f1550 a3=
=3D18 items=3D2 ppid=3D528 pid=3D540 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=
=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3DttyS0 ses=3D1 comm=3D"open=
at2" exe=3D"/root/rgb/git/audit-testsuite/tests/syscalls_file/openat2" subj=
=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D"testsuite-1=
616012933-bjAUcEPO"
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/d23fbb89186754487850367224b060e26f9b7181.=
1621363275.git.rgb@redhat.com
> ---
>  fs/open.c                  |  2 ++
>  include/linux/audit.h      | 10 ++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.h             |  2 ++
>  kernel/auditsc.c           | 18 +++++++++++++++++-
>  5 files changed, 32 insertions(+), 1 deletion(-)

...

> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index cd2d8279a5e4..67aea2370c6d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -118,6 +118,7 @@
>  #define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
>  #define AUDIT_BPF              1334    /* BPF subsystem */
>  #define AUDIT_EVENT_LISTENER   1335    /* Task joined multicast read soc=
ket */
> +#define AUDIT_OPENAT2          1336    /* Record showing openat2 how arg=
s */

As a heads-up, I had to change the AUDIT_OPENAT2 value to 1337 as the
1336 value is already in use by AUDIT_URINGOP.  It wasn't caught
during my initial build test as the LSM/audit io_uring patches are in
selinux/next and not audit/next, it wasn't until the kernel-secnext
build was merging everything for its test run that the collision
occurred.  I'll be updating the audit/next tree with the new value
shortly.

--=20
paul moore
www.paul-moore.com
