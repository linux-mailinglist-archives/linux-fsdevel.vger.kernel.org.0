Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6D13943A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgAMPCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:02:51 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50661 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPCv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:02:51 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7sM0-1inBU31ZIo-0051YL; Mon, 13 Jan 2020 16:02:49 +0100
Received: by mail-qt1-f182.google.com with SMTP id d18so9307850qtj.10;
        Mon, 13 Jan 2020 07:02:49 -0800 (PST)
X-Gm-Message-State: APjAAAWOGvDVfcGRfdFNDLMAfh646YVfQAVLtj/2GGcYkDqCNKcQi4lz
        hl1jf7gBxX9E6MT0jr8L23hzskrldX6YmgkbtXU=
X-Google-Smtp-Source: APXvYqxsoEYmTq+RE4xAl65+mhorh2I9NE7KRvTRmwGYPXc6DTXOraF2Y1j53/xbkqS1OmdA70RBWtQ5A13Lqfh9Scc=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr14102091qtr.142.1578927768175;
 Mon, 13 Jan 2020 07:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20200107175927.4558-1-sargun@sargun.me> <20200107175927.4558-2-sargun@sargun.me>
In-Reply-To: <20200107175927.4558-2-sargun@sargun.me>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 16:02:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Mv2+GuV_1DKKMvmS8MzMDaheCiUvRps-h+cATHpPXJA@mail.gmail.com>
Message-ID: <CAK8P3a1Mv2+GuV_1DKKMvmS8MzMDaheCiUvRps-h+cATHpPXJA@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] vfs, fdtable: Add fget_task helper
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EazS39lBXe7l2MXTjvoN3t5fQWhLNgan09i4rpbG1Ror2bq23ZP
 gaK4s9swynMmEhrzadP23qax9Ft4zh4tRox6X3DXu2sB4W7wYUEcUURcDK8FCSlhm70Hp2M
 3Hi5wndJwn9IO3b2a0H5/yL/6LCCbrbdi74YxzI/CiBydYGlklxAeuqtJi8iw9v1fLWxwtK
 L7bkNbOgof36eZzGjegsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DzF3lkCw0C0=:T6j1HF4d6Cj5rxi0G7MhBt
 s6EZ3WerxgZCSYsy2blIJJpGCLjBKypdL9Cl48ryGAUYCXYw+3b85YR/YCNlhQcbqAP8U8fq7
 0KTtSpy4FPf5sdwVRZ6GbitVJwuWlugU7E0Haw3lcfZVU+Vxd9E63ktH8eslFL2dGV73MFANe
 zB1SPq8K7a3/aVFZH2VoB/cmjQKiFRvmlp1Jn8BU9JtKR8j8Z/lBABsnkUSufvmOnPQi5Dn4+
 CU9Smt1rT8+RU9TV8D0qVO23POvvETdkqeWn+IE6Wh78fgq65PnyEzi1TntV7SjIiGa24QtLf
 LJsAHg4ybvzs5wOoYLdyNJGWavtHDvstxhquSirN+8qBofKkdd74tWXK/EQvBpfREmmlpmt0A
 +dTVwvMU8tc5bihkYim3JKxTCB5yAGUPLdtxtmPjSby9YXDrH9zjhOg4wubTmqYFLt4MlCeBT
 /tKChaKgzAxGG0jqRNTWXj88MPyY18uAvFcNE8tW5UDIqxXG5dv6cwcwpJIApSzrpZGFSbJr2
 jahz1MTrCzfm6milvi2Y2wKFuMX+wd2cML5cR9BLn+rbNbDwuwPgOa2MV77gP/uEtxGVbW6BC
 Ig45p94v/PJKA5kYLyprtVzqCqJZxVxKJsFEcSMnKWtN0nuMPJzffS3HgFLA7XEmpXN+Wo71W
 85z8JrBKCBG1O+Dt17yC6TFQnENPsIDYn7Oi9R6HmiMAPrw20eKqT16o5O1da8ZtIP8dZweht
 xpZx0zSPUq7mdL3wlW5JOeYu9VZg0ZvZfL6q9XEtaPKoWNp6bgYtxwEMl/O/g1omCSzTJ89My
 XNOWVTl0X/ysBZpfc2zrl2AiNKvqnyia3oIkveNiHXFTHjr2Z92n3Mpv9dl+uEOfgnVsBanP8
 KlaV45aPLTFupKctzkiw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 6:59 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This introduces a function which can be used to fetch a file, given an
> arbitrary task. As long as the user holds a reference (refcnt) to the
> task_struct it is safe to call, and will either return NULL on failure,
> or a pointer to the file, with a refcnt.
>
> This patch is based on Oleg Nesterov's (cf. [1]) patch from September
> 2018.
>
> [1]: Link: https://lore.kernel.org/r/20180915160423.GA31461@redhat.com
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
