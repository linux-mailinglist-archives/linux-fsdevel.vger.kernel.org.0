Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA08826B7D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIONru convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:47:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgIONpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:45:41 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N1whr-1kTI1d3eQL-012DRo; Tue, 15 Sep 2020 15:32:29 +0200
Received: by mail-qt1-f170.google.com with SMTP id v54so3115865qtj.7;
        Tue, 15 Sep 2020 06:32:28 -0700 (PDT)
X-Gm-Message-State: AOAM530SItU2P7qoSTCT7UVCHRW9byUo0tCmq+/cq66XoTHX6QSgPQ/n
        e5Z0LKxfxTNHFIbZsXM0+658b2GA2tA7Y+WuAsQ=
X-Google-Smtp-Source: ABdhPJxxLmMCN4A/oxqNJBXyjnHh2EThJJR2LF/8Sz6ABSTqKRD1ROg//n2YBFK6xkQVViDw3D8KsqM5aPAmkXBsQb0=
X-Received: by 2002:aed:2ce5:: with SMTP id g92mr5576894qtd.204.1600176747244;
 Tue, 15 Sep 2020 06:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200910164612.114215-1-mic@digikod.net> <20200910164612.114215-3-mic@digikod.net>
In-Reply-To: <20200910164612.114215-3-mic@digikod.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Sep 2020 15:32:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bhKp8pHYP1nDg__pgPoNssVUkLo3y6bFiGjCKv-c0cA@mail.gmail.com>
Message-ID: <CAK8P3a2bhKp8pHYP1nDg__pgPoNssVUkLo3y6bFiGjCKv-c0cA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 2/3] arch: Wire up introspect_access(2)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:CK476NVovWPJ8+inQF3omOMsQlGdPbubct6+uilUnLxRtV3MCqb
 ivXBFVdJYMUlQt6XhTgFkleJyx6mVTBSEpmlRol2enIZJ3CU+hxZ8TG4yEOXDyADeYdS2cH
 R0sVNOEkDFueSeLd67GLD/YKWpDnnX1KcdkgrFtWRAs3grG8XRZ85E8Fh0390UujdxEk4Ra
 LwsZGdZoRi6H/y20iZ3ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XwP+wphoa1w=:PIFFfXMYmjLcKw3c5lsBUn
 7GYapSOe/3c4HtF+NydsTSX6gqO9sYQGC0LnV60gS+EORzQIWRMBldCUy5xngsI8Xph3Jnslv
 RiuazdbDFmxRMPPDatwtQkJt+R/kX41D8MlOgINrh8NTWAYRDrv0b1sfzYga1lO4MHzCHu4ke
 QHfU0xWsrxqE3575AGJhd1gCzqbY7R1g6pzVOymv8UeCtVl9dGw9rIWZ6ZWi0pt/s/JHAzQHA
 E6V1sc/0wz2jeE0hkqkw9O8XTuPW0JvTSj/FcBEFkreF37S9bXw4aS0QPJXQ7veHdggR6HZDw
 aKnjtPi3IuLoVdaTOyHBxSfNQT+qBAzb5E4mFrztv/DxSzHeJnOVyFV3Kh18VDye+KgtN+iHp
 IV7ZHHLO9onSO6Kt5ghErVjgGmQGl3tvKPbQjUvMyssif7a/1JBYAsh1e7wtXccJ52VIkTvNU
 puqVM5L3IjWZ+dmCk+FB6eW+am5w2gIBpQbEKhyvvN67OOgHFWWcDaxUdtAfBcju1vB9bOhV5
 bPCZA2g61VDWV0Oo+W1UC8jUM71meOh0MNDQ4Z/zQ2gt5BNztRrndJVyEnRRyFGpZ2ozzG0Pr
 1rDg43iN/X86oGRMyYcokc4YDlhRBN7EsQgxJDwIzBxcunTy9pslr/8izFSeLh/VNjHF61Xmh
 ZzBOnVEXdoTwIeP7xJbNa/VRGQeXhhEJaYyhO/WHZQC4URc8+WO2PUSto1VlDjkTgLtH668lt
 j7AjK77HwW7ZmpIGA5dWswBQbH8s124lYIFOSHbrpyMUXqzwWp6pRm23VITJPPckxhi2JLXlG
 cOSqRPuqS30qLLkl16HCmrlit631wIwqr0xTsAY3Yz10fsW+msANFW+ZlvmXf08H19F0IYZST
 jXhFSeQXHCpzf6n1MKbgpQVESQLsN21ckX/RHkpHQhY52JoYki6nhKguWCzlb8Nkamuis4xqi
 L4lnssYJFnCZw/O3Nec/Z86HNyQo9CjfN0SmL+j4naoXpbdfupqPX
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 6:46 PM Mickaël Salaün <mic@digikod.net> wrote:
>
> From: Mickaël Salaün <mic@linux.microsoft.com>
>
> Wire up access_interpreted(2) for all architectures.
>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> ---
>
> Changes since v7:
> * New patch for the new syscall.
> * Increase syscall numbers by 2 to leave space for new ones (in
>   linux-next): watch_mount(2) and process_madvise(2).

I checked that the syscall calling conventions are sane and that
it is wired up correctly on all architectures in this patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>

I did not look at the system call implementation or its purpose though,
as that is not my area.
