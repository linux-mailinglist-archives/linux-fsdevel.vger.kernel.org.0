Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CDC7599A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGSPZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 11:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjGSPZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:25:39 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DCB19B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 08:25:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-577497ec6c6so69840747b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689780323; x=1692372323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9cCLj0zM8JjUOyomZEKsWMrdNLR9qOvsZrkfrcN/wI=;
        b=OEkJOsaDK/Sdhd+3KExw0lzHKRrWqkDKbK3EdKZwnico2hN66bMte46sznr3D2q8Ij
         kbEqswBd4Nce8EcmHj//I9ODApZC3L90+sXmFcS3ViqD/041bQU+p1oZEBIpbGHxQdRW
         Bkx5xcshP6g0XlBXSCaQ//9PGUg4t0Ev53G19Jn7Bfe4HXMoys0m8SzehU1V6F7QP7eC
         8lD4s/Cq7UyYFbJ2XhyBKI9zR6lTkAPuQK2Be95WCrVId1mNkjbCaiY+OoJI9U3Jthni
         rSjU8rQv78mbNQMwp1Pir4wiHsocaFkhglAJQrREt1ieUgUGlrDPdPr85ltO3yU7F7at
         iaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780323; x=1692372323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9cCLj0zM8JjUOyomZEKsWMrdNLR9qOvsZrkfrcN/wI=;
        b=YUnzyOvPeuzJS8YL//8yJ/QupHh8yRsNXWH22kj7hiYd8AKrl7PsMm58ZwcyHdGYMH
         WaMu9yTjb7X3AOlIXZNhRBQzrr4qSdN+xUHuAgvIT44KYqnu55ArkB5Horl5sPOmAzPn
         i2x04lpHc/sOoVLZxXp3xyCh2o+JRvDtDWZeaZSObb9BhHkc/kdFfrhZZqCFtjyfL6ms
         +Ci33WpFoENZjba2bpi8VINg6iB/T2ggZ/+6Aum80eiwH9PgQ9zow6GyyusO7eqGz3/t
         HZYl7rMNhZrBHiazjj25Ue8Jzi+UB8aCN9C7EgPAVexuAsE0R91KhDSz12h1+VDnGtqK
         S9qg==
X-Gm-Message-State: ABy/qLbtxmJesjnzuwAhR/8eU/vNcZtsvONyClszl+g4c98YYjrvzwWg
        v3ZNsTZlGT3Sn6bIoZoq2PKZP1BccJx0xv5SfJK1
X-Google-Smtp-Source: APBJJlEKuWkfr0ZOUpBDkgDJSGU1WICL7JKLe65DOhMheQvB+Dy8YyA22pUEoTNZB9gyg+Sk1cUZ7AumngsAXFfSIUo=
X-Received: by 2002:a0d:cb10:0:b0:57a:8de9:29e7 with SMTP id
 n16-20020a0dcb10000000b0057a8de929e7mr18181677ywd.28.1689780323608; Wed, 19
 Jul 2023 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-4-wangkefeng.wang@huawei.com> <CAJ2a_DfGvPeDuN38UBXD4f2928n9GZpHFgdiPo9MoSAY7YXeOg@mail.gmail.com>
 <dc8223db-b4ac-7bee-6f89-63475a7dcaf8@huawei.com>
In-Reply-To: <dc8223db-b4ac-7bee-6f89-63475a7dcaf8@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jul 2023 11:25:12 -0400
Message-ID: <CAHC9VhQzJ3J0kEymDUn3i+dnP_34GMNRjaCHXc4oddUCFb0Ygw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 6:23=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
> On 2023/7/19 17:02, Christian G=C3=B6ttsche wrote:
> > On Wed, 19 Jul 2023 at 09:40, Kefeng Wang <wangkefeng.wang@huawei.com> =
wrote:
> >>
> >> Use the helpers to simplify code.
> >>
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Cc: Eric Paris <eparis@parisplace.org>
> >> Acked-by: Paul Moore <paul@paul-moore.com>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>   security/selinux/hooks.c | 7 ++-----
> >>   1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index d06e350fedee..ee8575540a8e 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_are=
a_struct *vma,
> >>          if (default_noexec &&
> >>              (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> >>                  int rc =3D 0;
> >> -               if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> >> -                   vma->vm_end <=3D vma->vm_mm->brk) {
> >> +               if (vma_is_initial_heap(vma)) {
> >
> > This seems to change the condition from
> >
> >      vma->vm_start >=3D vma->vm_mm->start_brk && vma->vm_end <=3D vma->=
vm_mm->brk
> >
> > to
> >
> >      vma->vm_start <=3D vma->vm_mm->brk && vma->vm_end >=3D vma->vm_mm-=
>start_brk
> >
> > (or AND arguments swapped)
> >
> >      vma->vm_end >=3D vma->vm_mm->start_brk && vma->vm_start <=3D vma->=
vm_mm->brk
> >
> > Is this intended?
>
> The new condition is to check whether there is intersection between
> [startbrk,brk] and [vm_start,vm_end], it contains orignal check, so
> I think it is ok, but for selinux check, I am not sure if there is
> some other problem.

This particular SELinux vma check is see if the vma falls within the
heap; can you confirm that this change preserves this?

--=20
paul-moore.com
