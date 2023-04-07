Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA526DAB67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjDGKVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjDGKVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:21:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF749768
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 03:21:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l15so7422958ejq.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680862879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO1ajaNIRSPjols2zAhbsFXjLC+4bF7M3IO4JjE3HbQ=;
        b=nK2k4cMC1wDMjCT5ebZroxOi1/s8YMYQsP08rYWyS/eZNfqXLJIY88sgzEJeXKUB5g
         KDsNbB0fuxxJIbI0/P6g2MOBnNizs4frd9CiIqbal6AKs67CI1Jygv/sMJRbGUKEXdVW
         /cqfR2yH1jcbmR3S94CHaCFz4FT6whKSSt8SClEkUPjfnlOHPaGghVsdox71+KgaSgZF
         gIQItYq8SgXG7bFWutD0S5QE6u6JWzRR+A3bFbXiIixPEJ5h+GvBDcLmI1RF+8RL4iza
         wDR4ofMxGKNlpOfm5vNCntbD+WOum9J2J/GjXBnX2Ul0nVUPTDLSaSFwoWOTDAPVoxv5
         +bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680862879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO1ajaNIRSPjols2zAhbsFXjLC+4bF7M3IO4JjE3HbQ=;
        b=46Iez03a4P7C55UbrbgXFxdiLwdJGMVNPrVGYssrynxt7S5oPNeZgZygvC0AdxwN0z
         E7apguxtaFxrOKmsKQgN6IOwhmGXPzOwf6A1H43jJMnVb+FogXB6Si4OK0IBf9ou28kO
         VtYxWF0FVA+tLov2Tm/e29J9ok4WUeZui6YMfe58eF15v4Uze6/AJjPLlLBxVTq912qc
         sh1HfSExctDutd+y7ugbNRq0fjjh4UIAPIosURj94rB8Krn4Tqa4KmU5589UPUMdhs1n
         ZDLAU5eEcJCZcuO4kdYgS/dw1wdESQIOLzmQDTJXTgk2p9mDsp5pQwHq5lyF2osEcKVm
         IDFA==
X-Gm-Message-State: AAQBX9cCX3BG+XGyQWy6fxzmPjWLkgzrdvEp0EpYogA1UKyfK45i4L+C
        Y81bYEJFqI9NUqxXDHOKJ9bv1GDFHAO/l2tszJnaaA==
X-Google-Smtp-Source: AKy350bvzEIr/SO34y5o+ffSKQZtvqWb/dpv9GQJ1koPxh4EQrX/wAAF+awbIaQ3DzRrBwpjfbxpD2+PY74M10EC75s=
X-Received: by 2002:a17:906:f198:b0:8e5:411d:4d09 with SMTP id
 gs24-20020a170906f19800b008e5411d4d09mr867922ejb.15.1680862878985; Fri, 07
 Apr 2023 03:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
 <b737dceb-a228-7ffe-0758-421505f1a61d@collabora.com> <CABb0KFF+sKSv7jdxBbXpt5A2WO83tKb9viq-kKurXN_e1VcFhQ@mail.gmail.com>
 <c535ce4a-d7da-1ce2-9883-7cefb6dd88a2@collabora.com> <CABb0KFE8pn+VORr8c=HWzKzJ5L5ZBRZMg2Q1dEZGU9gLqGZNLQ@mail.gmail.com>
 <b3e4d688-b96f-7c44-a6be-375d44263c85@collabora.com>
In-Reply-To: <b3e4d688-b96f-7c44-a6be-375d44263c85@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 7 Apr 2023 12:21:07 +0200
Message-ID: <CABb0KFE=zevnsxk7U726efu8gg=9dpGyDLAwL0ShS2ZygQVhMA@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Apr 2023 at 12:15, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 4/7/23 3:04=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Fri, 7 Apr 2023 at 11:35, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >> On 4/7/23 12:23=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> >>> On Thu, 6 Apr 2023 at 23:12, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>> On 4/7/23 1:12=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> >>>>> On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
> >>>>> <usama.anjum@collabora.com> wrote:
> >>>>> [...]
> >>>>>> --- a/fs/proc/task_mmu.c
> >>>>>> +++ b/fs/proc/task_mmu.c
> >>>>> [...]
> >>>>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start=
,
> >>>>>> +                                 unsigned long end, struct mm_wal=
k *walk)
> >>>>>> +{
> >>> [...]
> >>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>>>>> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> >>>>>> +       if (ptl) {
> >>>>> [...]
> >>>>>> +               return ret;
> >>>>>> +       }
> >>>>>> +process_smaller_pages:
> >>>>>> +       if (pmd_trans_unstable(pmd))
> >>>>>> +               return 0;
> >>>>>
> >>>>> Why pmd_trans_unstable() is needed here and not only after split_hu=
ge_pmd()?
> >>>> I'm not entirely sure. But the idea is if THP is unstable, we should
> >>>> return. As it doesn't seem like after splitting THP can be unstable,=
 we
> >>>> should not check it. Do you agree with the following?
> >>>
> >>> The description of pmd_trans_unstable() [1] seems to indicate that it
> >>> is needed only after split_huge_pmd().
> >>>
> >>> [1] https://elixir.bootlin.com/linux/v6.3-rc5/source/include/linux/pg=
table.h#L1394
> >> Sorry, yeah pmd_trans_unstable() is need after split. But it is also n=
eeded
> >> in normal case when ptl is NULL to rule out the case if pmd is unstabl=
e
> >> before performing operation on normal pages:
> >>
> >> ptl =3D pmd_trans_huge_lock(pmd, vma);
> >> if (ptl) {
> >> ...
> >> }
> >> if (pmd_trans_unstable(pmd))
> >>         return 0;
> >>
> >> This file has usage examples of pmd_trans_unstable():
> >>
> >> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L6=
34
> >> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1=
195
> >> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1=
543
> >> https://elixir.bootlin.com/linux/v6.3-rc5/source/fs/proc/task_mmu.c#L1=
887
> >>
> >> So we are good with what we have in this patch.
> >
> > Shouldn't we signal ACTION_AGAIN then in order to call .pte_hole?
> I'm not sure. I've not done research on it if we need to signal
> ACTION_AGAIN as this function pagemap_scan_pmd_entry() mimics how
> pagemap_pmd_range() handles reads to the pagemap file. pagemap_pmd_range(=
)
> isn't doing anything if pmd is unstable. Hence we also not doing anything=
.

Doesn't this mean that if we scan a file-backed vma we would miss
non-present parts of the mapping in the output?

Best Regards
Micha=C5=82 Miros=C5=82aw
