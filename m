Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1857AA01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiGSWqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 18:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiGSWqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:46:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516CC4F184
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 15:46:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v185so13030193ioe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jul 2022 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lnuskSEx1rWRFyExO7VDAIyPqC7rs15nNdWPt5ojSJo=;
        b=MjL9o3vEOb0cC/AOC29+FJHaYEDdp3YF4uPnUKdH2MSDVyDrF7ODr3Ke0Wcy4ilYzf
         BzCFwxsZ/XHiEHTOzXcQJv3vCytelIwqMbSVQy/FRLtlMuURP6ov3NWCIw8RZPLahcDd
         C48SeV+unpKZ2XPeGrdmEDCsa6LF6ZASoymNm+TqHMtWQYybbebrFT/9bV5YYeMDLZ4x
         oaPJRoZ/aZAKBfaZ9E6cpvtaiAhFYSDi9LC7qcvIPN12naTuSVOg+/o2fA2e6EiO7Fa0
         xHvsR1NLSDdqKv1q7gdh+mZLQNyp7KE54xFUiOdTzB8i+cvo8dMLbT1d0lXkvAObz4G2
         IAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnuskSEx1rWRFyExO7VDAIyPqC7rs15nNdWPt5ojSJo=;
        b=fRZI5pWU0o2t3SmXUxoZp5j41JITKVXm8a3HYPbf8+bCEqBZ0aA23qQo2u+X/VIE6b
         1texmLJ9WCNvTlnbMKkR6uv5LjuJ3y4mAnsvL68RZGW53zQNN1vcRdbnuKkj3eos9YAg
         a6iaFLjw0O9GOKIh1p+74hP2R/v280IY0e10aFmVVviSFyafR0wN3cTrd+TNY33GWr3J
         4tQtUUuGNAPXnO9ihFV6Z645LwvOasN0A9JGBLhCK//yqOrYsp9d6e+zVmoQK8QuNnOK
         8Pzbs9R0QRrMrLyrfjRb0654RbE3Jj1udcIKNBqBXuerQW4x1ps1Fkrkc6SUY8QBplUe
         /kyA==
X-Gm-Message-State: AJIora+8caghEcqAPdMewJ0jkR/F2TEOQ86We1TqJ763zEjJQqvKBnde
        HbP/hsq/RjjuGy2z9/j8I83Oo1GakvhloViq/CYeZg==
X-Google-Smtp-Source: AGRyM1scKsvkgjvOBcySMD8ANT00O0TRABCY2NJ0UUBywdxmH7xhFhuqq83FJ/2EITJFvKlSUEurf8W9R+8SpfjeE5I=
X-Received: by 2002:a05:6602:1644:b0:678:8ba4:8df6 with SMTP id
 y4-20020a056602164400b006788ba48df6mr16243773iow.138.1658270773545; Tue, 19
 Jul 2022 15:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com> <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
In-Reply-To: <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 19 Jul 2022 15:45:37 -0700
Message-ID: <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 3:32 PM Nadav Amit <namit@vmware.com> wrote:
>
> On Jul 19, 2022, at 12:56 PM, Axel Rasmussen <axelrasmussen@google.com> w=
rote:
>
> > Historically, it has been shown that intercepting kernel faults with
> > userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
> > of time) can be exploited, or at least can make some kinds of exploits
> > easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
> > changed things so, in order for kernel faults to be handled by
> > userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
> > must be configured so that any unprivileged user can do it.
> >
> > In a typical implementation of a hypervisor with live migration (take
> > QEMU/KVM as one such example), we do indeed need to be able to handle
> > kernel faults. But, both options above are less than ideal:
> >
> > - Toggling the sysctl increases attack surface by allowing any
> >  unprivileged user to do it.
> >
> > - Granting the live migration process CAP_SYS_PTRACE gives it this
> >  ability, but *also* the ability to "observe and control the
> >  execution of another process [...], and examine and change [its]
> >  memory and registers" (from ptrace(2)). This isn't something we need
> >  or want to be able to do, so granting this permission violates the
> >  "principle of least privilege".
> >
> > This is all a long winded way to say: we want a more fine-grained way t=
o
> > grant access to userfaultfd, without granting other additional
> > permissions at the same time.
> >
> > To achieve this, add a /dev/userfaultfd misc device. This device
> > provides an alternative to the userfaultfd(2) syscall for the creation
> > of new userfaultfds. The idea is, any userfaultfds created this way wil=
l
> > be able to handle kernel faults, without the caller having any special
> > capabilities. Access to this mechanism is instead restricted using e.g.
> > standard filesystem permissions.
>
> Are there any other =E2=80=9Cdevices" that when opened by different proce=
sses
> provide such isolated interfaces in each process? I.e., devices that if y=
ou
> read from them in different processes you get completely unrelated data?
> (putting aside namespaces).
>
> It all sounds so wrong to me, that I am going to try again to pushback
> (sorry).

No need to be sorry. :)

>
> From a semantic point of view - userfaultfd is process specific. It is
> therefore similar to /proc/[pid]/mem (or /proc/[pid]/pagemap and so on).
>
> So why can=E2=80=99t we put it there? I saw that you argued against it in=
 your
> cover-letter, and I think that your argument is you would need
> CAP_SYS_PTRACE if you want to access userfaultfd of other processes. But
> this is EXACTLY the way opening /proc/[pid]/mem is performed - see
> proc_mem_open().
>
> So instead of having some strange device that behaves differently in the
> context of each process, you can just have /proc/[pid]/userfaultfd and th=
en
> use mm_access() to check if you have permissions to access userfaultfd (j=
ust
> like proc_mem_open() does). This would be more intuitive for users as it =
is
> similar to other /proc/[pid]/X, and would cover both local and remote
> use-cases.

Ah, so actually I find this argument much more compelling.

I don't find it persuasive that we should put it in /proc for the
purpose of supporting cross-process memory manipulation, because I
think the syscall works better for that, and in that case we don't
mind depending on CAP_SYS_PTRACE.

But, what you've argued here I do find persuasive. :) You are right, I
can't think of any other example of a device node in /dev that works
like this, where it is completely independent on a per-process basis.
The closest I could come up with was /dev/zero or /dev/null or
similar. You won't affect any other process by touching these, but I
don't think these are good examples.

I'll send a v5 which does this. I do worry that cross-process support
is probably complex to get right, so I might leave that out and only
allow a process to open its own device for now.

>
