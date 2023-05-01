Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52E6F3673
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEATCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjEATCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 15:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A86110F8
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 12:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE2D61EB6
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 19:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C11C433D2
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682967734;
        bh=9QPEkjebC4OaH1v6v+RGKCi2h6hrTwDOyzCb/vnJn5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4LOzGRL1mrQlQrZscoCvoVjxeshoZzoRSTj02giG8+P7TZrJbYs6vV3ZikRwjQWw
         m3TgWWHcCWuhFVvva5I1ksVvQ8GFK+ddPO0K2nmYZSd9P9cvhZwJRKgIviuBemi2nl
         i9FtIuyDq5edtLMfLjVkIvi071hO6twem7cnkOQtXdw8Fy8LJW1XZiH2i7zo0J4BbM
         TfcEXy9J9/TYMWr3idHC8nqd2vZJQOZRuvg++dcpih9FhBTF00zouPwmpXnPTKv0QS
         2n6hSweoc7pxn99WlwS2emcO/BKtPtHah1387Wc2TocdoRTWObFk2caxd4LLJE76/g
         Sibsf6I5Bb9PA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so1185187a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 12:02:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDyYvq8oZdS2IIcunPweYek+ZHnqUq2NBNyp9wUAeYmDpSGnpAfD
        YprRdLarqFK4beeJGibfnebxrO2VRDn4ChQz5ifO8w==
X-Google-Smtp-Source: ACHHUZ6zV6tmNwgGbZSj/tAPjzw/u56lqCpK3jfeQIEg5ZZJCP33LO2ERSqQLQEQ5Q10BpG1mtr6OX/twGNMC1UT2O0=
X-Received: by 2002:aa7:c3d9:0:b0:4fe:19cb:4788 with SMTP id
 l25-20020aa7c3d9000000b004fe19cb4788mr5988608edr.42.1682967732371; Mon, 01
 May 2023 12:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682890156.git.lstoakes@gmail.com> <6f3aea05c9cc46094b029cbd1138d163c1ae7f9d.1682890156.git.lstoakes@gmail.com>
In-Reply-To: <6f3aea05c9cc46094b029cbd1138d163c1ae7f9d.1682890156.git.lstoakes@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 May 2023 12:02:00 -0700
X-Gmail-Original-Message-ID: <CALCETrV1QWSjZR_PQgQdyS8rrg4hhrs1u+FyJh43H-gA7CzkFg@mail.gmail.com>
Message-ID: <CALCETrV1QWSjZR_PQgQdyS8rrg4hhrs1u+FyJh43H-gA7CzkFg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: perform the mapping_map_writable() check after call_mmap()
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 30, 2023 at 3:26=E2=80=AFPM Lorenzo Stoakes <lstoakes@gmail.com=
> wrote:
>
> In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity t=
o
> clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap=
()
> handler to do so. We would otherwise fail the mapping_map_writable() chec=
k
> before we had the opportunity to avoid it.

Is there any reason this can't go before patch 3?

If I'm understanding correctly, a comment like the following might
make this a lot more comprehensible:

>
> This patch moves this check after the call_mmap() invocation. Only memfd
> actively denies write access causing a potential failure here (in
> memfd_add_seals()), so there should be no impact on non-memfd cases.
>
> This patch makes the userland-visible change that MAP_SHARED, PROT_READ
> mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217238
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 646e34e95a37..1608d7f5a293 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2642,17 +2642,17 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>         vma->vm_pgoff =3D pgoff;
>
>         if (file) {
> -               if (is_shared_maywrite(vm_flags)) {
> -                       error =3D mapping_map_writable(file->f_mapping);
> -                       if (error)
> -                               goto free_vma;
> -               }
> -
>                 vma->vm_file =3D get_file(file);
>                 error =3D call_mmap(file, vma);
>                 if (error)
>                         goto unmap_and_free_vma;
>

/* vm_ops->mmap() may have changed vma->flags.  Check for writability now. =
*/

> +               if (vma_is_shared_maywrite(vma)) {
> +                       error =3D mapping_map_writable(file->f_mapping);
> +                       if (error)
> +                               goto close_and_free_vma;
> +               }
> +

Alternatively, if anyone is nervous about the change in ordering here,
there could be a whole new vm_op like adjust_vma_flags() that happens
before any of this.

--Andy
