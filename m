Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81087054BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjEPRKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjEPRKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 13:10:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C45259;
        Tue, 16 May 2023 10:10:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64ac461af60so5602214b3a.3;
        Tue, 16 May 2023 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684257021; x=1686849021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgE20X4RBaYfDUVw67ihMRG3U700BcM/UKdWm0Z+sO8=;
        b=ecQFqE9VbqRMJX11Rj3FBmAIHKeEnDkPiaWEuMso0O8JPcgYtjXKOqBhXH/bnv6pAG
         k9Q+kUiBb/10+BsOy+5JcGb6B4ptKyWDiPAvwfunBh2fV6MLS1vPUQgB1QPC2lI5/u+1
         c03iI5SoEueu+msenwplrghr3QlE48XMQOHAZri4jI5z6Hwtd8mJOnwRBIz2Qx7hb03J
         C9sdwPorooomqVyadmlCgf99tlr4U2C2WAW5pg2QrHqGcIMvQZjkNhrUX0cskI4IoCbJ
         yVmWwTPcHbxtftrq3ifdT80TPzlnHG28FJ6qp/Z5v44blNikVTDU1hYeKjjXlf57QLXL
         WoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684257021; x=1686849021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgE20X4RBaYfDUVw67ihMRG3U700BcM/UKdWm0Z+sO8=;
        b=WnxUktnAv14dtMJv4qnZbs19scAp3DXt0POCgfjNPt3wI+2V2fUcCs7PbAeT2CDJhc
         mKRF7Sm2s4d/0bnSM/gFkjKiWTw5O/uJSKufkKhcKIlhqY8P+/tI6qYK4T+z+/Yk3IEo
         6rSv/ZIk0Zxzfqympb1dlTzdV0wHzG4OVBNAcBZ//2clk+deGxy9b4byhf2BS9n4z/oe
         O/IJs1HVgfft39KTVAj07fukrru1ToelLBt7etr49tVYBscDU446eHV7xAVgIg1gV+me
         1ZtWC2AsqoyjIfpN94bD9J1gqb7haSZbgMHg3tE8reO6cA8SfNb1KkazYTNuzX+jJtcl
         PqUA==
X-Gm-Message-State: AC+VfDy4eG6Zg38agW7s2Qjwm+fEW0A4bdZyReAebZlxYzUZdRkETDiA
        0Vc033PtSWh4IgLDNmrpgHabQ5LnkgyQIdhIloM=
X-Google-Smtp-Source: ACHHUZ7vlz8mf43rNPJc7ba8O6RMkjp8GEDVdsuZfidruHESiONxHR0Ml9yVswvFEFMMmWv5uApPlg6DBnISVmZ2uFY=
X-Received: by 2002:a05:6a00:10ce:b0:63d:24e4:f9c with SMTP id
 d14-20020a056a0010ce00b0063d24e40f9cmr47792889pfu.17.1684257021063; Tue, 16
 May 2023 10:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230515172608.3558391-1-yuanchu@google.com>
In-Reply-To: <20230515172608.3558391-1-yuanchu@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 16 May 2023 10:10:09 -0700
Message-ID: <CAHbLzkpuatys2wyM1+R02gggOGE_6iL_2aoCmn1VDMSnAYBQ0A@mail.gmail.com>
Subject: Re: [PATCH] mm: pagemap: restrict pagewalk to the requested range
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        "Zach O'Keefe" <zokeefe@google.com>, Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 10:26=E2=80=AFAM Yuanchu Xie <yuanchu@google.com> w=
rote:
>
> The pagewalk in pagemap_read reads one PTE past the end of the requested
> range, and stops when the buffer runs out of space. While it produces
> the right result, the extra read is unnecessary and less performant.
>
> I timed the following command before and after this patch:
>         dd count=3D100000 if=3D/proc/self/pagemap of=3D/dev/null
> The results are consistently within 0.001s across 5 runs.
>
> Before:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0763159 s, 671 MB/s
>
> real    0m0.078s
> user    0m0.012s
> sys     0m0.065s
>
> After:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0487928 s, 1.0 GB/s
>
> real    0m0.050s
> user    0m0.011s
> sys     0m0.039s
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  fs/proc/task_mmu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 420510f6a545..6259dd432eeb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1689,23 +1689,23 @@ static ssize_t pagemap_read(struct file *file, ch=
ar __user *buf,
>         /* watch out for wraparound */
>         start_vaddr =3D end_vaddr;
>         if (svpfn <=3D (ULONG_MAX >> PAGE_SHIFT)) {
> +               unsigned long end;
> +
>                 ret =3D mmap_read_lock_killable(mm);
>                 if (ret)
>                         goto out_free;
>                 start_vaddr =3D untagged_addr_remote(mm, svpfn << PAGE_SH=
IFT);
>                 mmap_read_unlock(mm);
> +
> +               end =3D start_vaddr + ((count / PM_ENTRY_BYTES) << PAGE_S=
HIFT);
> +               if (end >=3D start_vaddr && end < mm->task_size)
> +                       end_vaddr =3D end;
>         }
>
>         /* Ensure the address is inside the task */
>         if (start_vaddr > mm->task_size)
>                 start_vaddr =3D end_vaddr;
>
> -       /*
> -        * The odds are that this will stop walking way
> -        * before end_vaddr, because the length of the
> -        * user buffer is tracked in "pm", and the walk
> -        * will stop when we hit the end of the buffer.
> -        */
>         ret =3D 0;
>         while (count && (start_vaddr < end_vaddr)) {
>                 int len;
> --
> 2.40.1.606.ga4b1b128d6-goog
>
